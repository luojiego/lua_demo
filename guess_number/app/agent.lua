local skynet = require "skynet"
local socket = require "skynet.socket"

local tunpack = table.unpack
local tconcat = table.concat
local select = select

local clientfd, addr = ...
clientfd = tonumber(clientfd)

local hall

local function read_table(result)
    local reply = {}
    for i = 1, #result, 2 do 
        reply[result[i]] = result[i+1] 
    end
    return reply
end

-- 读取 redis 的相关信息
local rds = setmetatable({0}, {
    __index = function(t, k)
        if k == "hgetall" then
            t[k] = function (red, ...)
                return read_table(skynet.call(red[1], "lua", k, ...))
            end
        else
            t[k] = function (red, ...)
                return skynet.call(red[1], "lua", k, ...)
            end
        end
        return t[k]
    end
})

local client = { fd = clientfd }
local CMD = {}

local function client_quit ()
    skynet.call(hall, "lua", "offline", client.name)
    if client.isgame and client.isgame > 0 then
        skynet.call(client.isgame, "lua", "offline", client.name)
    end
    skynet.fork(skynet.exit) -- 强制关闭进程，退出
end

-- 发送消息
local function sendto(arg)
    socket.write(client.fd, arg .. "\r\n")
end

-- 用户登录
function CMD.login(name, password)
    if not name and not password then
        sendto("没有设置用户名或者密码")
        client_quit()
        return
    end
    print(("login name: %s"):format(name))

    local ok = rds:exists("role:"..name)
    if not ok then
        local score = 1000
        -- 满足条件唤醒协程，不满足条件挂起协程
        rds:hmset("role:" .. name, tunpack({
            "name", name,
            "password", password,
            "score", score,
            "isgame", 0,
        }))
        client.name = name
        client.password = password
        client.score = score
        client.isgame = 0
        client.agent = skynet.self()
    else
        local dbs = rds:hgetall("role:"..name)
        if dbs.password ~= password then
            sendto("密码错误，请重新输入密码")
            return
        end 

        client = dbs
        client.fd = clientfd
        client.isgame = tonumber(client.isgame) or 0
        client.agent = skynet.self()
    end

    -- 玩家在游戏中
    if client.isgame > 0 then
        -- 但是调用 room 的 online 时失败了，游戏可能正好结束了
        ok = pcall(skynet.call, client.isgame, "lua", "online", client)
        if not ok then
            client.isgame = 0
            sendto("请准备开始游戏……")
        end
    else
        sendto("请准备开始游戏……")
    end
end

function CMD.ready()
    if not client.name then
        sendto("请先登录")
        return
    end

    if client.isgame and client.isgame > 0 then
        sendto("已经在游戏中，不能重复准备")
        return
    end

    -- 发起一个远程调用 
    local ok, msg = skynet.call(hall, "lua", "ready", client)
    if not ok then
        sendto(msg)
        return
    end
    client.isgame = ok
    rds:hset("role:"..client.name, "isgame", ok)
end

function CMD.guess(number)
    if not client.name then
        sendto("请先登录")
        return
    end

    if not client.isgame or client.isgame == 0 then
        sendto("错误：没有在游戏中，请先准备")
        return
    end

    local numb = math.tointeger(number)
    if not numb then
        sendto("错误：猜测时需要提供一个整数而不是："..number)
        return
    end

    -- client.isgame 是服务的地址？？
    skynet.send(client.isgame, "lua", "guess", client.name, numb)
end

local function game_over()
    client.isgame = 0
    rds:hset("role:"..client.name, "isgame", 0)
end

function CMD.help()
    local params = tconcat({
        "*规则*：猜数字游戏，由系统随机生成一个 1-100 的数字，猜中输，未猜中赢。",
        "help：显示所有可输入的命令；",
        "login：登录游戏，需要提供用户名和密码；",
        "ready：准备，加入游戏队列，满员自动开始游戏；",
        "guess：猜数字，只能猜 1-100 的数字；",
        "quit：退出",
    }, "\r\n")
    socket.write(client.fd, params .. "\r\n")
end

function CMD.quit()
    client_quit()
end

-- 处理数据
local function process_socket_events()
    while true do
        local data = socket.readline(clientfd) --
        if not data then
            print("断开网络"..clientfd)
            client_quit()
            return
        end

        local pms = {}
        for pm in string.gmatch(data, "%w+") do
            pms[#pms + 1] = pm
        end

        -- next 用于获取 pms 中的第一个键值对，若返回 nil 则表示 pms 为空
        if not next(pms) then
            sendto("error[format], recv data")
            goto __continue__
        end

        local cmd = pms[1]
        if not CMD[cmd] then
            sendto(cmd.." 该命令不存在")
            CMD.help()
            goto __continue__
        end
        -- 启动一个新的协程
        -- unpack(pms) 返回的是一个数组，select(2, tunpack(pms)) 返回的是除了第一个元素之外的所有元素
        skynet.fork(CMD[cmd], select(2, tunpack(pms)))
::__continue__::
    end
end

-- skynet.start 启动函数
skynet.start(function ()
    print("recv a connection: ", clientfd, addr)
    rds[1] = skynet.uniqueservice("redis")
    hall = skynet.uniqueservice("hall") -- 找到大厅服务
    socket.start(clientfd)
    skynet.fork(process_socket_events)
    skynet.dispatch("lua", function (_, _, cmd, ...)
        if cmd == "game_over" then
            game_over()
        end
    end)
end)