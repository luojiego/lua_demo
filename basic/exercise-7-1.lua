local lines = {}
-- 如果参数为 0，从标准输入读取，并将输入排序之后，输出
if #arg == 0 then
    for line in io.lines() do
        lines[#lines + 1] = line
    end
    table.sort(lines)
    for _, v in pairs(lines) do
        print(v)
    end
end

-- 如果参数为 1，将参数 1 作为文件读取，并将结果排序之后，输出
if #arg == 1 then
    local f = assert(io.open(arg[1], "r"))
    for line in f:lines() do
        lines[#lines + 1] = line
    end
    table.sort(lines)
    for _, v in pairs(lines) do
        print(v)
    end
end

-- 如果参数为 2，读取第一个文件里面的内容，输出到第二个文件中
if #arg == 2 then
    local f = assert(io.open(arg[1], "r"))
    for line in f:lines() do
        lines[#lines + 1] = line
    end

    table.sort(lines)

    do 
        local f = assert(io.open(arg[2], "r"))
        if f then
            print("文件已经存在，是否覆盖(y/n)?")
            local c = io.read()
            if c ~= 'y' and c ~= 'Y' then
                os.exit(0)
            end
        end
    end

    local w = assert(io.open(arg[2], "w"))

    for _, v in pairs(lines) do
        w:write(v, "\n")
    end

    w:close()
end
