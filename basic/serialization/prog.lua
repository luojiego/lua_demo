local a = 10
local b = 20
print(a+b)

-- luac -o prog.lc prog.lua
-- lua prog.lc
--[[
    luac -l prog.lua 

main <prog.lua:0,0> (8 instructions at 0x139e06930)
0+ params, 4 slots, 1 upvalue, 2 locals, 1 constant, 0 functions
        1       [1]     VARARGPREP      0
        2       [1]     LOADI           0 10
        3       [2]     LOADI           1 20
        4       [3]     GETTABUP        2 0 0   ; _ENV "print"
        5       [3]     ADD             3 0 1
        6       [3]     MMBIN           0 1 6   ; __add
        7       [3]     CALL            2 2 1   ; 1 in 0 out
        8       [3]     RETURN          2 1 1   ; 0 out
]]