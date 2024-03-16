local t = { 1, "hello", key = "value", [5] = "number 5" }

-- use pairs print table
print("use pairs print table")
for k, v in pairs(t) do
    print(k, v)
end

-- 使用 ipairs 遍历表时，只能访问那些索引为连续正整数的元素。
print("use ipairs print table")
for k, v in ipairs(t) do
    print(k, v)
end

print(t["key"])