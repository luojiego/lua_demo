local a = {}
for i = 1, 1000 do
    a[i] = 0
end

print(#a)

a = {}
for i = -5, 5 do
    a[i] = 0
end
print(#a)

local squares = {1, 4, 9, 16, 25, 36, 49, 64, 81}
print(#squares)

-- linklist
local list = nil

list = {next = list, value = 3}
list = {next = list, value = 2}
list = {next = list, value = 1}

local l = list
while l do
    print(l.value)
    l = l.next
end

-- double ended queue

local function listNew()
    return {first = 0, last = -1}
end

local function pushFirst (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

local function pushLast(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

local function popFirst(list)
    local first = list.first
    if first > list.last then error("list is empty") end

    local value = list[first]
    list[first] = nil
    list.first = first + 1
    return value
end

-- error 会中止程序的执行
local function popLast(list)
    local last = list.last
    if list.first > last then error("list is empty") end

    local value = list[last]
    list[last] = nil
    list.last = last - 1
    return value
end

local d = listNew()
print("pop empty list: ", popFirst(d))
for k, v in pairs(d) do
    print(k, v)
end

pushFirst(d, 2)
pushFirst(d, 1)
pushLast(d, 3)
pushLast(d, 4)

print("-----")
for k, v in pairs(d) do
    print(k, v)
end

print("popFirst: ", popFirst(d))
print("popLast: ", popLast(d))

print("-----")
for k, v in pairs(d) do
    print(k, v)
end

-- 注意 lua 中的惯例
local function insert(bag, element)
    bag[element] = (bag[element] or 0) + 1
end

local function remove(bag, element)
    local count = bag[element]
    bag[element] = (count and count > 1) and count - 1 or nil
end