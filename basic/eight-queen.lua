-- Programming in Lua 2.1
N = 8

function isplaceok(a, n, c)
    for i = 1, n - 1 do
        if (a[i] == c) or (a[i-1] == c - n) or (a[i] + i == c + n) then
            return false
        end
    end
    return true
end

function printsolution(a)
    print("---- number: " .. number .. "----")
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
    number = number + 1
end

number = 0

function addqueen(a, n)
    -- print("addqueen", n, table.concat(a, ","), #a)
    if n > N then
        printsolution(a)
        -- os.exit()
    else
        for c = 1, N do
            if isplaceok(a, n, c) then
                a[n] = c
                addqueen(a, n + 1)
            end
        end
    end
end

addqueen({}, 1)