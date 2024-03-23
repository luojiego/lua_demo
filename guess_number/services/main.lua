local skynet = require "skynet"
local socket = require "skynet.socket"

local function accept(clientfd, address)
    skynet.newservice("agent", clientfd, address)
end

skynet.start(function()
    local listenfd = socket.listen("0.0.0.0", 8888)
    skynet.uniqueservice("redis")
    skynet.uniqueservice("hall")
    socket.start(listenfd, accept)
end)