local print, sin = print, math.sin
-- _ENV = nil

print(13)
print(sin(13))
-- print(math.cos(13))
-- lua: env.lua:6: attempt to index a nil value (upvalue '_ENV')

a = 13 
local a = 12 
print(a) -- local
print(_ENV.a)  -- global 

a = 1
local newgt = {}
setmetatable(newgt, {__index = _G})
_ENV = newgt
print(a)

local function factory(_ENV)
    return function ()
        return a
    end
end

local f1 = factory{a = 6}
local f2 = factory{a = 7}
print(f1())
print(f2())