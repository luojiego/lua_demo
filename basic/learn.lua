local x = 3
print(x)

local a = 1
local b = 2
local c = a + b
print(c)

print(b+1)
print(-b)

-- lua 中没有 ++，也没有 --, 毕竟 “--” 都用来做注释了
-- 没有 &&，变成了 and
-- 没有 ||，变成了 or
-- 没有 !，变成了 not
-- 没有 !=，变成了 ~=
-- 没有 { 和 }，变成 then 和 end
-- 没有 else if 变成了 elseif
--
local d = 5 
if d ~= nil then
    print(d .. ' not nil' ) 
end

function calculateTax(price)
    return price*0.21
end

print(calculateTax(100))

local i = 0
local count = 0

-- i <= 10 没有任何符号
while i <= 10 do
    count = count + i
    i = i + 1
end

print("count is " .. count)

count = 0
for i=1, 5 do
    count = count + i
end

print("count is " .. count)

-- tables
-- 索引是从 1 开始，而不是 0
local colors = { "red", "green", "blue" }
print(colors[1])
print(colors[2])
print(colors[3])

print("colors lens: " .. #colors)
-- 循环打印 colors
for i = 1, #colors do
    print("index: " .. i .. " value: ".. colors[i])
end

-- tables insert
table.insert(colors, "orange")
print(colors[#colors])

-- insert at index
table.insert(colors, 2, "pink")
for i = 1, #colors do
    print("index: " .. i .. " value: ".. colors[i])
end

-- remove
table.remove(colors, 1)
print("after remove colors index 1")
for i = 1, #colors do
    print("index: " .. i .. " value: ".. colors[i])
end

-- dimensional table
local data = {
    { "billy", 12 },
    { "john", 20 },
    { "andy", 65 }
}

for k=1, #data do
    print(data[k][1] .. " is " .. data[k][2] .. " years old")
end

local teams = {
    ["teamA"] = 12,
    ["teamB"] = 5
}

print(teams["teamA"])

for k, v in pairs(teams) do
    print(k .. " : " .. v)
end

print("after insert teamC")
teams["teamC"] = 100

for k, v in pairs(teams) do
    print(k .. " : " .. v)
end

print("after set teamA = nil")
teams["teamA"] = nil

for k, v in pairs(teams) do
    print(k .. " : " .. v)
end

-- return multiple values from a function
function getTeamScores()
    local scores = {
        ["teamA"] = 12,
        ["teamB"] = 5,
    }
    return scores
end

local scores = getTeamScores()
local total = 0
for k, v in pairs(scores) do
    total = total + v
end
print("total score of all teams: " .. total)

-- math lib
local x = -10
print("x = " .. x)
print("math.abs(x) = " .. math.abs(x))

local y = 1.28
print("y = " .. y)
print("math.ceil(y) = " .. math.ceil(y))
print("math.floor(y) = " .. math.floor(y))
print("math.pi = " .. math.pi)

print("math.random() = " .. math.random())
print("math.random(100) = " .. math.random(100))
print("math.random(20, 100) = " .. math.random(20, 100))

print("math.sqrt(100) = " .. math.sqrt(100))

print("math.sqrt(20) = " .. math.sqrt(20))

require("print_hello")
print_hello()

print("type(print_hello): " .. type(print_hello))
print("type(scores): " .. type(scores))
print("type(false): " .. type(false))
print("type(\"321\"): " .. type("321"))
print("type(321): " .. type(321))
print("math.type(321): " .. math.type(321))
print("type(3.1): " .. type(3.1))
print("math.type(3.1): " .. math.type(3.1))
print("type(nil): " .. type(nil))
print("type(type): " .. type(type))
print("type(io.stdin): " .. type(io.stdin))
print("type({}): " .. type({}))
print("type(type(x)): " .. type(type(x)))

local x3
local y3
print(x3)
x3 = x3 or 9.8

print("x3 is nil, after x3 = x3 or 9.8: " .. x3)
-- nil == nil，返回 true
-- x3 == y3，返回 false
print (x3 == y3) 

x3 = 0
y3 = ""

print("x3: " .. x3)
print("y3: " .. y3)
-- lua 中 0 和 "" 作为条件都是 true
if x3 then 
    print("x3 is true")
else
    print("x3 is false")
end

if y3 then 
    print("y3 is true")
else
    print("y3 is false")
end
