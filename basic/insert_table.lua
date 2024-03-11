local a = {1,2,3}
local b = {4,5,6}

-- table.move(a, 1, #a, #b + 1, b)


local function insert(a, b, pos)
    table.move(b, 1, #b, #b+1)
    table.move(a, 1, #a, pos, b)
end

insert(a, b, 2)

for k, v in pairs(b) do
    print(k, v)
end