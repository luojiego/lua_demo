local f = io.popen("ls -l", "r")
-- print(f)
local dir = {}
for entry in f:lines() do
    dir[#dir + 1] = entry
end

for k, v in pairs(dir) do
    print(k, v)
end
