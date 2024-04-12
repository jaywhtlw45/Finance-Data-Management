-- Insert test transactions for Hudson
INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-03-27', 171.00, 20
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Hudson Investment';

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Sell', '2024-04-10', 168.00, 5
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Hudson Investment';  

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-03-19', 23.00, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Hudson Investment';    
    
-- Insert test transactions for Asterios
INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-03-19', 230.00, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'COIN' AND Accounts.name LIKE 'Asterios Investment';    

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-03-19', 419.00, 20
FROM Stock, Accounts
WHERE Stock.symbol = 'MSFT' AND Accounts.name LIKE 'Asterios Investment';

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-04-03', 154.00, 15
FROM Stock, Accounts
WHERE Stock.symbol = 'GOOGL' AND Accounts.name LIKE 'Asterios Investment';     

-- Insert test transactions for Jaak
INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-03-15', 141.00, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'GOOGL' AND Accounts.name LIKE 'Jaak Investment';    

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Sell', '2024-03-19', 147.00, 50
FROM Stock, Accounts
WHERE Stock.symbol = 'GOOGL' AND Accounts.name LIKE 'Jaak Investment';

INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-04-11', 22.00, 5
FROM Stock, Accounts
WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Jaak Investment';     

-- Does not work
-- INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
-- SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-04-11', Stock.open_price, 5
-- FROM Stock, Accounts
-- WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Jaak Investment'; 

INSERT INTO Holdings (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 20
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Hudson Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 20;

