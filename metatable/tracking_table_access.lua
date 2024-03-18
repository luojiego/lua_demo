local function track(t)
    local proxy = {}
    local mt = {
        __index = function (_, k)
            print("*access to element " .. tostring(k))
            return t[k]
        end,

        __newindex = function (_, k, v)
            print("*update of element " .. tostring(k) .. " to " .. tostring(v))
            t[k] = v
        end,

        __pairs = function ()
            return function (_, k)
                local nextkey, nextvalue = next(t, k)
                if nextkey ~= nil then
                    print("*traversing element " .. tostring(nextkey))
                end
                return nextkey, nextvalue
            end
        end,

        __len = function ()
            print("*getting the length")
            return #t
        end
    }

    setmetatable(proxy, mt)
    return proxy
end

local t = {}
t = track(t)
t[2] = "hello"
print(t[2])

t = track({10, 20})
print(#t)
for k, v in pairs(t) do
    print(k, v)
end