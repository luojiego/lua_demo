local function lineByLineConcat()
    local buff = ""
    for line in io.lines() do
        buff = buff .. line .. "\n"
    end
    print(string.rep(buff, 100))
end

local function lineByLineTable()
    local t = {}
    for line in io.lines() do
        t[#t + 1] = line .. "\n"
    end
    _ = table.concat(t)
end

local function lineByLineTableWithoutAndNewLine()
    local t = {}
    for line in io.lines() do
        t[#t + 1] = line
    end
    _ = table.concat(t, "\n")
end

print(arg[1])
local start = os.clock()
if arg[1] == "1" then
    lineByLineConcat()
elseif arg[1] == "2" then
    lineByLineTable()
else
    lineByLineTableWithoutAndNewLine()
end
    

local elapsed = os.clock() - start
print(("took %.5f seconds"):format(elapsed))

-- 读取一个 22MB 的文件中内容
-- 方式 1: 逐行读取并拼接 时间超过 5 分钟也没有完成
-- 方式 2: 逐行读取并存入 table：耗时 0.23 秒
-- 方式 3: 逐行读取并存入 table，最后使用 table.concat：耗时 0.15 秒