-- How much stock does Hudson have in his investment account?
SELECT s.symbol AS StockSymbol, sh.quantity AS Quantity
FROM StockHolding sh
JOIN Stock s ON sh.stock_id = s.stock_id
JOIN Accounts a ON sh.account_id = a.account_id
WHERE a.name = 'Hudson Investment';

-- How long has the investment account for Hudson been active?
SELECT DATEDIFF(NOW(), date_opened) AS AccountAgeInDays
FROM Accounts
WHERE Accounts.name = 'Hudson Investment';

-- What is the average accounts life. 
SELECT AVG(DATEDIFF(NOW(), date_opened)) AS AverageAccountLifeInDays
FROM Accounts;

-- Which account has Hudson have opened the longest. 
SELECT name AS AccountName, DATEDIFF(NOW(), date_opened) AS AccountAgeInDays
FROM Accounts
WHERE name LIKE '%Hudson%'
ORDER BY AccountAgeInDays DESC
LIMIT 1;

-- Which stock do all customers own the most of?
SELECT Stock.symbol, SUM(StockHolding.quantity) AS TotalQuantity 
FROM StockHolding
JOIN Stock ON StockHolding.stock_id = Stock.stock_id
GROUP BY Stock.symbol
HAVING SUM(StockHolding.quantity) = (
    SELECT MAX(TotalQuantity)
    FROM (
        SELECT Stock.symbol, SUM(StockHolding.quantity) AS TotalQuantity
        FROM StockHolding
        JOIN Stock ON StockHolding.stock_id = Stock.stock_id
        GROUP BY Stock.symbol
    ) AS MaxQuantities
);

-- Which stock had the highest movement on the open over a given 2 week span?
SELECT s.symbol, (MAX(dsm.open_price) - MIN(dsm.open_price)) AS movement_on_open
FROM DailyStockMetric dsm
JOIN Stock s ON dsm.stock_id = s.stock_id
WHERE dsm.date BETWEEN '2024-03-15' AND '2024-04-04'
GROUP BY s.symbol
ORDER BY movement_on_open DESC
LIMIT 1;

-- What is the highest traded stock in the technology industry?
SELECT S.symbol AS stock_symbol, S.company_name AS company_name, MAX(D.volume) AS max_volume
FROM Company AS C
JOIN Stock AS S ON C.company_name = S.company_name
JOIN DailyStockMetric AS D ON S.stock_id = D.stock_id
WHERE C.industry = 'Technology'
GROUP BY S.symbol, S.company_name
ORDER BY max_volume DESC
LIMIT 1;

-- What is the total value of all stocks in all acounts owned by Asterios.
SELECT S.symbol AS stock_symbol, SH.quantity AS share_amount, A.name AS account_name, SH.quantity * (
        SELECT D.close_price 
        FROM DailyStockMetric AS D
        WHERE D.stock_id = S.stock_id 
            AND D.date = '2024-04-11' -- most recent date
    ) AS total_value
FROM Customer AS C
JOIN Accounts AS A ON C.customer_id = A.customer_id
JOIN StockHolding AS SH ON A.account_id = SH.account_id
JOIN Stock AS S ON SH.stock_id = S.stock_id
WHERE C.first_name = 'Asterios';

-- Which stocks had the largest price change between 03-20-2024 and 03-20-2028
SELECT symbol, company_name, ABS(end_metric.close_price - start_metric.open_price) AS price_change
FROM Stock
INNER JOIN DailyStockMetric AS start_metric ON Stock.stock_id = start_metric.stock_id
INNER JOIN DailyStockMetric AS end_metric ON Stock.stock_id = end_metric.stock_id
WHERE start_metric.date = '2024-03-20' AND end_metric.date = '2024-03-28'
ORDER BY price_change DESC;

-- Jaak wants to buy 10 more shares of APPL. 
INSERT INTO Transactions (stock_id, account_id, type, date, stock_price, quantity)
SELECT Stock.stock_id, Accounts.account_id, 'Buy', '2024-04-11', 170.00, 6
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Jaak Investment';  

-- Update the Jaaks new transaction into his stockholding.
INSERT INTO StockHolding (account_id, stock_id, quantity)
SELECT Accounts.account_id, Stock.stock_id, 10
FROM Stock, Accounts
WHERE Stock.symbol = 'AAPL' AND Accounts.name LIKE 'Jaak Investment'
ON DUPLICATE KEY UPDATE quantity = quantity + 10;