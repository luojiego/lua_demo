local function factory(_ENV)
    return function ()
        return a
    end
end

local f1 = factory{a = 6}
local f2 = factory{a = 7}
print(f1()) -- 6
print(f2()) -- 7

-- local M = {}
-- _ENV = M
-- function add(c1, c2)
    -- return new(c1.r + c2.r, c1.i + c2.i)
-- end

-- print(type(M.add))

env = {}
loadfile("config.lua", "t", env)()
for k, v in pairs(env) do
    print(k, v)
end

f = load("b = 10; return a")
env = {a = 20}
debug.setupvalue(f, 1, env)
print(f())
print(env.b)