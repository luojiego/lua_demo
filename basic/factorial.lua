local function fact(n)
    if n == 0 then
        return 1
    else
        return n * fact(n-1)
    end
end

local exit = false
while exit ~= true do
    print("enter a number: ")
    local a = io.read("*n")
    if math.type(a) ~= "integer" then
        print("not a number")
        io.read()
    else
        if a < 0 then
            print("negative number")
            io.read()
        else
            print(fact(a))
            exit = true
        end
    end
end

--[[
    递归调用时，需要提前定义 fact1
local fact1 = function (n)
    if n == 0 then return 1
    else return n * fact1(n-1)
    end
end
fact1(10)
]]

local fact1
fact1 = function (n)
    if n == 0 then return 1
    else return n * fact1(n-1)
    end
end

print(fact1(5))