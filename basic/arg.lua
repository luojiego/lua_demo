print(arg[-3])
print(arg[-2])
print(arg[-1])
print(arg[0])
print(arg[1])
print(arg[2])

--[[
lua -e "sin=math.sin" arg.lua a b
lua
-e
sin=math.sin
arg.lua
a
b
--]]
