local function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        a[#a + 1] = n
    end

    table.sort(a, f)

    local i = 0
    return function() 
        i = i + 1
        return a[i], t[a[i]]
    end
end

local t = {name="Roger", age=34, phone=15399051111}
for k, v in pairs(t) do
    print(k, v)
end

print("sorted")

for name, line in pairsByKeys(t) do
    print(name, line)
end