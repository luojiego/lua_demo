
local mt = {}

local prototype = {x = 0, y = 0, width = 100, height = 100}

local function new(o)
    setmetatable(o, mt)
    -- print("---haha---")
    return o
end

-- mt.__index = function (_, key)
--     print("search key: "..key)
--     return prototype[key]
-- end

-- __index 可以是函数，也可以是 table

mt.__index = prototype

local w = new{x = 10, y = 20}
-- print(w.__index)
print(w.width)

local function setDefault(t, d)
    local mt = {__index = function () return d end}
    setmetatable(t, mt)
end

local tab = { x = 10, y = 20}
print(tab.x, tab.z)

setDefault(tab, 0)
print(tab.x, tab.z)
