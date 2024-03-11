local function isVaildSequence(t)
    local length = #t
    local count = 0
    -- 注意 ipairs 和 pairs 的区别
    -- for k, v in ipairs(t) do
    for k, v in pairs(t) do 
        count = count + 1
        -- print("--" .. k, v)
    end
    
    -- print(length, count)
    if length == count then
        return true
    end
    return false
end

print(isVaildSequence({1, 2, 3}))
local t = {1, 2, 3, ["a"]=5}
for k, v in pairs(t) do 
    print(k, v)
end
print(isVaildSequence(t))