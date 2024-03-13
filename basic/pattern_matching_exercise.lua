local function escape(binaryString)
    local result = binaryString:gsub(".", function(c)
        return string.format("\\x%02X", string.byte(c))
    end)

    -- 改进版：插入 \z 转义序列折断长行
    local formatted = result:gsub(("."):rep(80), "%0\\z\n")
    return formatted
end

-- 示例用法
print(escape("\0\1hello\200"))

-- 对于较长的字符串示例
local longString = "\0\1hello\200" .. string.rep("A", 100) .. "\255"
print(escape(longString))

local function reverseUTF8(str)
    local utf8 = require("utf8")
    local t = {}
    -- 迭代 UTF-8 字符串中的每个字符
    for _, c in utf8.codes(str) do
        table.insert(t, 1, utf8.char(c))
    end
    return table.concat(t)
end

-- 示例
local str = "안녕하세요, 世界!"
print(reverseUTF8(str))

local function reverseUTF8WithPattern(str)
    local t = {}
    -- 匹配单个 UTF-8 编码的字符
    str:gsub("([\0-\x7F\xC2-\xF4][\x80-\xBF]*)", function(c)
        table.insert(t, 1, c)
    end)
    return table.concat(t)
end

-- 示例
local str = "hello world! こんにちは 世界"
print(reverseUTF8WithPattern(str))
