CREATE DATABASE if not exists FinancialMarket;

CREATE TABLE Company (
    company_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_name VARCHAR(255) UNIQUE,
    industry VARCHAR(255),
    headquarters VARCHAR(255),
    website VARCHAR(255)
);

CREATE TABLE Stock (
    stock_id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol VARCHAR(10) UNIQUE,
    company_name VARCHAR(255),
    stock_exchange VARCHAR(50),
    FOREIGN KEY (company_name) REFERENCES Company(company_name) on update cascade on delete cascade
);

CREATE TABLE DailyStockMetric (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stock_id INT,
    date DATE,
    open_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    volume INT,
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id) on update cascade on delete cascade
);

CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    date_of_birth DATE,
    ssn VARCHAR(11) UNIQUE
);


CREATE TABLE Accounts (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_opened DATE,
    date_closed DATE,
    customer_id INT,
    ptype TEXT CHECK(pType in ('Savings', 'Checking', 'Investment')),
    name VARCHAR(100),
    balance DECIMAL(12, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) on update cascade on delete cascade
);

CREATE TABLE Transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stock_id INT,
    account_id INT,
    ptype TEXT CHECK(pType in ('Buy', 'Sell')),
    date DATE,
    stock_price DECIMAL(10, 2),
    quantity INT,
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id) on update cascade on delete cascade,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade on delete cascade
);

CREATE TABLE StockHolding (
    holding_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INT,
    stock_id INT,
    quantity INT,
    total_cost DECIMAL(10, 2),
    last_updated DATETIME,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) on update cascade on delete cascade,
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id) on update cascade on delete cascade
);
