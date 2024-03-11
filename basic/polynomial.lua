local function evalPolynomial(coefficients, x)
    local sum = 0
    for i = 1, #coefficients do
        sum = sum + coefficients[i] * x^(i-1)
    end
    return sum
end

local function evalPolynomialHorner(coefficients, x)
    local result = 0
    for i = #coefficients, 1, -1 do
        result = result * x + coefficients[i]
    end
    return result
end

local poly = {1, 2, 3}

local x = 2
print(evalPolynomial(poly, x))

print(evalPolynomialHorner(poly, x))