# Financial Data Management Project

This project aims to manage financial market data and brokerage firm operations using a relational database system. It includes a database schema and a Python script to download historical stock data for popular stocks.

## Database Schema

The database schema consists of the following tables:

1. **Stocks**: Stores information about individual stocks.
2. **DailyStockMetric**: Records daily metrics for each stock, including open, close, high, low, and volume data.
3. **Transactions**: Tracks transactions involving stocks, including buy/sell actions, prices, and quantities.
4. **Accounts**: Manages customer accounts, including opening and closing dates, account types, and balances.
5. **StockHolding**: Stores information about the stocks held in each account.
6. **Customers**: Stores customer information, including names, emails, dates of birth, and social security numbers.

## Data Download Script

The `/stock_data/download_stock_data.py` script is provided to download historical stock data. The data is saved as CSV files for each stock.

The `/stock_data/sql_insertion_generator.py` script is provided to generate SQL commands to insert the downloaded data into the database.

## Usage

1. Install the required Python packages:
    ```
    pip install yfinance
    ```

2. Run the data download script from the project's home directory (do not navigate to /stock_data):
    ```
    python /stock_data/download_stock_data.py
    ```

3. The script will download historical stock data for the specified stocks and save it as CSV files.

4. Run the sql insertion generator script from the project's home directory (do not naviagte to /stock_data):
    ```
    python /stock_data/sql_insertion_generator.py
    ```
5. The generated sql commands are stored in `/sql_files/insert_daily_metrics.sql`
   

## Contributors

- Jason Whitlow

## License

This project is licensed under the [MIT License](LICENSE).
