local function foo0()
    
end

local function foo1()
    return "a"
end

local function foo2()
    return "a", "b"
end

local x, y = foo2()
print(x, y)

local x = foo2()
print(x)

local x, y, z = 10, foo2()
print(x, y, z)

local x, y = foo0()
print(x, y)
local x, y = foo1()
print(x, y)
local x, y, z = foo2()
print(x, y, z)

print(foo0())
print(foo1())
print(foo2())
print(foo2(), 1) --> a 1
print(foo2() .. "x") --> ax


function printTable(t)
    for k, v in pairs(t) do
        print(k, v)
    end
end

print "{foo0(), foo2(), 4}"
printTable {foo0(), foo2(), 4}
print "{foo0()}"
printTable {foo0()}
print("foo1()")
printTable {foo1()}
print "foo2()"
printTable {foo2()}

function foo(i)
    if i == 0 then return foo0()
    elseif i == 1 then return foo1()
    elseif i == 2 then return foo2()
    end
end

print(foo(0))
print(foo(1))
print(foo(2))
print(foo(3))

-- force a call to return exactly one result
print((foo(2)))

function add(...)
    local sum = 0
    for _, v in ipairs{...} do
        sum = sum + v
    end
    return sum
end

print(add(3, 4, 10, 25, 12))

function tryVaridic(...)
    local a, b = ...
    print(a, b)
end

tryVaridic(3, 5, 8)
tryVaridic(300)
tryVaridic()

function trackCalls(...)
    print("calling foo: ", ...)
    return foo(...)
end

trackCalls(0)
trackCalls(99, 100, 120)

function nonils(...)
    -- 不同于 #{...} table.pack 返回包含 n 可以检测到 ... 中的 nil
    local arg = table.pack(...)
    for i = 1, arg.n do
        if arg[i] == nil then 
            return false 
        end
    end
    return true
end

print(nonils(2, 3, nil))
print(nonils(2, 3))
print(nonils())
print(nonils(nil))

print(select(1, "a", "b", "c"))
print(select(2, "a", "b", "c"))
print(select(3, "a", "b", "c"))
print(select("#", "a", "b", "c"))


function add1(...)
    local sum = 0
    for i = 1, select("#", ...) do
        sum = sum + select(i, ...)
    end
    return sum
end

print(add1(3, 4, 10, 25, 12))

function fact(n)
    if n == 0 then
        return 1
    else
        return n * fact(n-1)
    end
end

print(fact(30))

local function printAll(t)
    for k = 1, #t do
        print(t[k])
    end
end

local function printWithoutFirst(...)
    local t = table.pack(...)
    for k = 2, t.n do
        print(t[k])
    end
end

local function printWithoutLast(...)
    print(...)
    local t = table.pack(...)
    -- local t = {...}
    for k = 1, t.n-1 do
        print(t[k])
    end
end

local t = {1, 2, 3, 4, 5}
printAll(t)
printWithoutFirst(1, 2, 3, 4, 5, nil)
printWithoutLast(1, 2, 3, 4, 5, nil)

-- 初始化随机数种子
math.randomseed(os.time())

-- Fisher-Yates(Knuth 洗牌算法) shuffle
local function shuffleList(t)
    local n = #t
    for i = n, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

local list = {1, 2, 3, 4, 5, 6, 7, 8, 9}
list = shuffleList(list)
for i, v in ipairs(list) do
    print(i, v)
end

local function printCombinations(array, m, prefix)
    prefix = prefix or {}
    if m == 0 then
        print(table.concat(prefix, ", "))
        return
    end

    if #array < m then
        return
    end

    for i = 1, #array do
        local next = table.remove(array, 1)
        table.insert(prefix, next)
        printCombinations(array, m-1, prefix)
        table.insert(array, next) -- 插入到最后一个位置
        table.remove(prefix) -- 移除最后一个元素
    end
end

local arr = {1,2,3,4,5,6}
local groupSize = 3
printCombinations(arr, groupSize)