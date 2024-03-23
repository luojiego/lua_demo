local function search(k, plist)
    for i = 1, #plist do
        local v = plist[i][k]
        if v then return v end
    end
end

function crateClass(...)
    local c = {}
    local parents = {...}

    setmetatable(c, {__index = function(t, k)
        return search(k, parents)
    end})

    c.__index = c

    function c:new(o)
        o = o or {}
        setmetatable(o, c)
        return o
    end

    return c
end

Named = {}

function Named:getname()
    return self.name
end

function Named:setname(n)
    self.name = n
end

local Account = require "account"

NamedAccount = crateClass(Account, Named)
local account = NamedAccount:new{name = "Paul"}
print(account:getname())
print(account.balance)