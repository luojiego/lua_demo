local function addOneMonth(date) 
    for k, v in pairs(date) do
        print(k, v)
    end

    date.month = date.month + 1
    return date
end

local r = addOneMonth(os.date("*t"))
print(os.date("%Y-%m-%d", os.time(r)))

local t = os.date("*t")
print(type(t))
print(os.date("%Y-%m-%d %w", os.time(t)))

local function getPassSecondsRespectiveDay(ts)
    local t = os.date("*t", ts)
    -- print(t.hour, t.min, t.sec)
    return t.hour * 3600 + t.min * 60 + t.sec    
end

print(getPassSecondsRespectiveDay(os.time()))

local function getTimeZone()
    local now = os.time()
    local localTime = os.date("*t", now)
    local utcTime = os.date("!*t", now)
    localTime.isdst = false -- 确保不计算夏令时的影响

    local localSeconds = os.time(localTime)
    local utcSeconds = os.time(utcTime)
    local diff = os.difftime(localSeconds, utcSeconds)

    local hourOffset = diff / 3600
    local timeZone = string.format("UTC%s%d", hourOffset >= 0 and "+" or "", hourOffset)
    return timeZone
end

print(getTimeZone())
