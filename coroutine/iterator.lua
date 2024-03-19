function permgen(a, n)
    n = n or #a
    if n <= 1 then
        printResult(a)
    else
        for i = 1, n do
            -- put i-th element as the last one
            a[n], a[i] = a[i], a[n]
            -- generate all permutations of the other elements
            permgen(a, n - 1)
            -- restore i-th element
            a[n], a[i] = a[i], a[n]
        end
    end
end

function printResult(a)
    for i = 1, #a do
        io.write(a[i], " ")
    end
    io.write("\n")
end

permgen({1, 2, 3, 4})

function permgen1(a, n)
    n = n or #a    
    if n <=1 then
        coroutine.yield(a)
    else
        for i = 1, n do
            -- put i-th element as the last one
            a[n], a[i] = a[i], a[n]
            -- generate all permutations of the other elements
            permgen(a, n - 1)
            -- restore i-th element
            a[n], a[i] = a[i], a[n]
        end
    end
end

function permutations(a)
    -- local co = coroutine.create(function () permgen1(a) end)
    -- return function ()
        -- local code, res = coroutine.resume(co)
        -- return res
    -- end

    -- 可以使用 coroutine.wrap 来简化代码
    return coroutine.wrap(function () permgen1(a) end)
end

for p in permutations({'a', 'b', 'c'}) do
    printResult(p)
end