local function concat(t)
    local result = ""
    for k, v in pairs(t) do
        result = result .. v
    end
    return result
end

local t = {"hello", " ", "world"}
print(concat(t))