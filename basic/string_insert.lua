local function insert(src, pos, str)
    if pos < 1 or pos > #src+1 then
        error("invalid position")
    end
    local part1 = src:sub(1, pos -1)
    local part2 = src:sub(pos)
    return part1 .. str .. part2
end

print(insert("hello world", 1, "start: "))
print(insert("hello world", 7, "small "))
print(insert("aÇŒo", 5, "!"))