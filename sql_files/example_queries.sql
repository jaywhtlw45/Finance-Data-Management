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
-- What is the average accounts life. 

-- Which stock do all customers own the most of?
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




