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

-- Does not work !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
-- SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-04-11', Stock.open_price, 5
-- FROM Stock, Accounts
-- WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Jaak Investment'; 
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- Update Hudson's holdings after transactions
-- Buy AAPL
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 20
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Hudson Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 20;

-- Sell AAPL
UPDATE StockHolding
SET quantity = quantity - 5
WHERE account_id = (SELECT account_id FROM Accounts WHERE name LIKE 'Hudson Investment')
AND stock_id = (SELECT stock_id FROM Stock WHERE symbol = 'AAPL');

-- Buy PLTR
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Hudson Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 100;

-- Update Asterios's holdings after transactions
-- Buy COIN
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'COIN' AND Accounts.name LIKE 'Asterios Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 100;

-- Buy MSFT
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 20
FROM Stock, Accounts
WHERE Stock.symbol = 'MSFT' AND Accounts.name LIKE 'Asterios Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 20;

-- Buy GOOGL
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 15
FROM Stock, Accounts
WHERE Stock.symbol = 'GOOGL' AND Accounts.name LIKE 'Asterios Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 15;

-- Update Jaak's holdings after transactions
-- Buy GOOGL
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 100
FROM Stock, Accounts
WHERE Stock.symbol = 'GOOGL' AND Accounts.name LIKE 'Jaak Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 100;

-- Sell GOOGL
UPDATE StockHolding
SET quantity = quantity - 50
WHERE account_id = (SELECT account_id FROM Accounts WHERE name LIKE 'Jaak Investment')
AND stock_id = (SELECT stock_id FROM Stock WHERE symbol = 'GOOGL');

-- Buy PLTR
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 5
FROM Stock, Accounts
WHERE Stock.symbol = 'PLTR' AND Accounts.name LIKE 'Jaak Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 5;

