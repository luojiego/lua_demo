Account = {balance = 0}
function Account.withdraw(v)
    Account.balance = Account.balance - v
end

Account.withdraw(100.00)
print(Account.balance)

-- a, Account = Account, nil
-- a.withdraw(50)

function Account.withdraw1(self, v)
    self.balance = self.balance - v
end

local a1 = Account; Account = nil
a1.withdraw1(a1, 100.00)

-- use colon hide the self parameter
-- function Account:withdraw2(v)
--     self.balance = self.balance - v
-- end

Account = {
    balance = 0,
    withdraw = function(self, v)
        self.balance = self.balance - v
    end
}

function Account:deposit(v)
    self.balance = self.balance + v
end

Account.deposit(Account, 200.00)
Account:withdraw(100.00)

print(Account.balance)

Account:deposit(30)
print(Account.balance)