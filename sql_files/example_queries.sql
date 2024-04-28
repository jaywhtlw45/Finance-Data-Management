-- How much stock does Hudson have in his investment account?
SELECT 
    SUM(CASE WHEN type = 'Buy' THEN quantity ELSE -quantity END) AS total_stock_quantity
FROM 
    Transactions
WHERE 
    account_id = (
        SELECT account_id 
        FROM Accounts 
        WHERE name = 'Hudson Investment'
    );


-- How long has the investment account for Hudson been active?
SELECT 
    DATEDIFF(NOW(), date_opened) AS AccountAgeInDays
FROM 
    Accounts
WHERE 
    Accounts.name = 'Hudson Investment';

-- What is the average accounts life. 

SELECT AVG(DATEDIFF(NOW(), date_opened)) AS AverageAccountLifeInDays
FROM Accounts;

-- Which account has Hudson have opened the longest. 
SELECT 
    name AS AccountName,
    DATEDIFF(NOW(), date_opened) AS AccountAgeInDays
FROM 
    Accounts
ORDER BY 
    AccountAgeInDays DESC
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

-- What is the most traded stock for all customers?

-- What is the avg cost basis and total cost basis of AAPL for Hudson's investment account?
-- avg cost basis = cost per share that Hudson paid
-- total cost basis = total amount Hudson paid for all shares

-- What is the current value of all Hudson's investment account?

-- What is the largest position in Hudson's investment account?
-- position = value of a stock at the current time multiplied by the quantity of that stock in the account. 
-- 1. Check the most recent price of the stock, then multiply by number of shares in the account.
-- 2. Do this for all stocks and choose the maximum.

-- What percent of the account is each stock for Hudson's investment account?
-- 1. Calculate the position of for each stock in the account. 
-- 2. Use the sum of all positions to calculate the percentage of each stock.

-- What is the total worth of Hudson's investment account (cash position and investment)?

-- Can also include querries about daily metrics------------------------------

-- Which stock has the highest market cap?

-- Which stock had the highest movement on the open over a given 2 week span?
-- This question may be too difficult to answer.

SELECT 
    s.symbol,
    (MAX(dsm.open_price) - MIN(dsm.open_price)) AS movement_on_open
FROM 
    DailyStockMetric dsm
JOIN 
    Stock s ON dsm.stock_id = s.stock_id
WHERE 
    dsm.date BETWEEN '2024-03-15' AND '2024-04-04'
GROUP BY 
    s.symbol
ORDER BY 
    movement_on_open DESC
LIMIT 1;

-- What is the highest traded stock in the technology industry?

SELECT 
    S.symbol AS stock_symbol,
    S.company_name AS company_name,
    MAX(D.volume) AS max_volume
FROM 
    Company AS C
JOIN 
    Stock AS S ON C.company_name = S.company_name
JOIN 
    DailyStockMetric AS D ON S.stock_id = D.stock_id
WHERE 
    C.industry = 'Technology'
GROUP BY 
    S.symbol, S.company_name
ORDER BY 
    max_volume DESC
LIMIT 1;

-- What is the total value of all stocks in all acounts owned by Asterios.
SELECT 
    S.symbol AS stock_symbol,
    SH.quantity AS share_amount,
    A.name AS account_name,
    SH.quantity * (
        SELECT D.close_price 
        FROM DailyStockMetric AS D
        WHERE D.stock_id = S.stock_id 
            AND D.date = '2024-04-11' -- most recent date
    ) AS total_value
FROM 
    Customer AS C
JOIN 
    Accounts AS A ON C.customer_id = A.customer_id
JOIN 
    StockHolding AS SH ON A.account_id = SH.account_id
JOIN 
    Stock AS S ON SH.stock_id = S.stock_id
WHERE 
    C.first_name = 'Asterios';

-- Which stocks had the largest price change between 03-20-2024 and 03-20-2028
SELECT symbol, company_name, ABS(end_metric.close_price - start_metric.open_price) AS price_change
FROM Stock
INNER JOIN DailyStockMetric AS start_metric ON Stock.stock_id = start_metric.stock_id
INNER JOIN DailyStockMetric AS end_metric ON Stock.stock_id = end_metric.stock_id
WHERE start_metric.date = '2024-03-20' AND end_metric.date = '2024-03-28'
ORDER BY price_change DESC;