function serialize(o)
    if type(o) == "number" then
        io.write(tostring(o))
    else
    end
end

print("serialize number: ")
serialize(3.0)

local fmt = {integer = "%d",float = "%a"}
function serialize1(o)
    if type(o) == "number" then
        io.write(string.format(fmt[math.type(o)], o))
    end
end

print("\nserialize number by type: ")
serialize1(3)

function serialize2(o)
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" then
        io.write(string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write(" ", k, " = ")
            serialize2(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

print("\nserialize table: ")
serialize2({a = 12, b = 'lua', key = "another 'one'"})