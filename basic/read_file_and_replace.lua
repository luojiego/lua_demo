t = io.read("a")

t = string.gsub(t, "bad", "good")

io.write(t)

-- usage: lua read_file_and_replace.lua < bad_file.txt
