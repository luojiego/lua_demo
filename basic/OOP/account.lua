Account = {balance = 0}
function Account:withdraw(v)
    if v > self.balance then error "insufficient funds" end
    self.balance = self.balance - v
end

function Account:deposit(v)
    self.balance = self.balance + v
end

function Account:new(o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

return Account

-- local b = Account:new()

-- b.balance = b.balance + 300
-- print(b.balance)

-- SpecialAccount = Account:new()
-- local s = SpecialAccount:new{limit = 1000.00}

-- function SpecialAccount:withdraw(v)
--     if v - self.balance >= self:getLimit() then
--         error "insufficient funds"
--     end
--     self.balance = self.balance - v
-- end

-- function SpecialAccount:getLimit()
--     return self.limit or 0
-- end

-- print(s:getLimit())
-- s:deposit(100)
-- print(s.balance)