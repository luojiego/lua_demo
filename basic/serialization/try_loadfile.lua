-- load file dese not raise error
-- assert(loadfile("312"))

i = 32

local i = 0

local f = load("i = i + 1; print(i)")

-- g 是一个闭包，全使用外部变量 local i
local g = function ()
    i = i + 1
    print(i)
end

if f ~= nil then
    f()
end

g()

print "enter your expression: "
local line = io.read()
local func = assert(load("return " .. line))
print("the value of your express is " .. func())

for i = 1, 3 do
    x = i -- global 'x'
    print(string.rep("*", func()))
end