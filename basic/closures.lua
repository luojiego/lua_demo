local names = {"Peter", "Paul", "Mary"}
local grades = {Mary = 10, Paul = 7, Peter = 8}

table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2] -- compare the grades
end)


for i = 1, #names do
    print(names[i])
end

local name2 = {"Peter", "Paul", "Mary"}

local function sortbygrade(names, grades)
    table.sort(names, function (n1, n2)
        return grades[n1] > grades[n2] -- compare the grades
    end)
end

sortbygrade(name2, grades)

for i = 1, #name2 do
    print(name2[i])
end

local function newCounter()
    local count = 0    
    return function ()
        count = count + 1
        return count
    end
end

local c1 = newCounter()
print(c1())
print(c1())

local c2 = newCounter()
print(c2())
print(c1())
print(c2())

local function F (x)
    return {
        set = function (y) x = y end,
        get = function () return x end
    }
end

local o1 = F(10) -- {set function(y) x=y end, get function() return x end}
local o2 = F(20)
print(o1.get(), o2.get()) -- 10 20

o2.set(100)
o1.set(300)
print(o1.get(), o2.get()) -- 300, 100

-- 定义积分函数
-- f: 被积分的函数
-- a: 积分下限
-- b: 积分上限
-- n: 划分区间的数量
function integral(f, a, b, n)
    local delta = (b - a) / n  -- 计算每个小区间的宽度
    local sum = 0
    for i = 1, n do
        local x = a + (i-1) * delta  -- 计算当前小区间的左端点
        sum = sum + f(x) * delta  -- 计算当前小矩形的面积并累加
    end
    return sum
end

-- 示例使用：计算函数 f(x) = x^2 在区间 [0, 1] 上的积分
local function f(x)
    return x^2
end

local result = integral(f, 0, 1, 1000)  -- 使用 1000 个小区间进行积分
print("Integral approximation:", result)
