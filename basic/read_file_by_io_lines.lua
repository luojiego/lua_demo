local count = 0
for line in io.lines() do
    count = count + 1
    io.write(string.format("%d\t", count), line, "\n")
end
