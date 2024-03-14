-- 8.1 split by delimiter
local function split(s, d)
    if s == "" then
        return {""}
    end
    local words = {}
    for w in string.gmatch(s, "[^" .. d .."]+") do
        words[#words+1] = w
    end
    return words
end

local r = split("a whole new world", " ")
print(table.concat(r, "@"))
-- for _, v in ipairs(r) do
    -- print(v)
-- end


-- 示例用法
local str = "one,two,three,four"
local chunks = split(str, ",")
-- for _, chunk in ipairs(chunks) do
--     print(chunk)
-- end

print(table.concat(chunks, "@"))
print(table.concat(split("193-8805-2120", "-"), "@"))

print(#split("", "-"))

local function trim(s)
    local s = string.gsub(s, "^%s*(.-)%s*$", "%1") 
    return s
end

trim("  hello world  ")

local function newTrim(s)
    local start = s:find("[^%s]") or 1
    local finish = string.find(s, "[^%s]$", start) or #s
    return s:sub(start, finish)
end

local longString = string.rep(" ", 1000000000) .. "a" .. string.rep(" ", 100000000)
local start = os.clock()
newTrim(longString)
local elapsed = os.clock() - start
print(("trim took %.2f seconds"):format(elapsed))