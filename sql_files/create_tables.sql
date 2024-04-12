CREATE TABLE Stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) UNIQUE,
    company_name VARCHAR(255),
    stock_exchange VARCHAR(50)
);

CREATE TABLE DailyStockMetrics (
    metric_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT,
    date DATE,
    open_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    volume INT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Transactions(
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT,
    account_id INT,
    transaction_type ENUM('Buy', 'Sell'),
    transaciton_date DATE,
    stock_price DECIMAL(10, 2),
    quantity INT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    date_opened DATE,
    date_closed DATE,
    customer_id INT,
    account_type ENUM('Savings', 'Checking', 'Investment'),
    account_name VARCHAR(100),
    account_balance DECIMAL(12, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE StockHolding (
    holding_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    stock_id INT,
    quantity INT,
    total_cost DECIMAL(10, 2),
    last_updated DATETIME,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    date_of_birth DATE,
    ssn VARCHAR(11) UNIQUE,
);



