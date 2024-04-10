import yfinance as yf
import pandas as pd

def fetch_stock_data(stock_symbol, start_date, end_date):
    """
    Fetch historical stock data from Yahoo Finance.

    Args:
    - stock_symbol: Symbol of the stock to fetch data for (e.g., "AAPL" for Apple Inc.).
    - start_date: Start date of the data range in "YYYY-MM-DD" format.
    - end_date: End date of the data range in "YYYY-MM-DD" format.

    Returns:
    - Pandas DataFrame containing the fetched data.
    """
    try:
        # Fetch historical data from Yahoo Finance
        stock_data = yf.download(stock_symbol, start=start_date, end=end_date)
        return stock_data
    except Exception as e:
        print(f"Error fetching data for {stock_symbol}: {e}")
        return None

def save_to_csv(data, filename):
    """
    Save Pandas DataFrame to a CSV file.

    Args:
    - data: Pandas DataFrame to save.
    - filename: Name of the CSV file to save the data to.
    """
    try:
        data.to_csv(filename)
        print(f"Data saved to {filename}")
    except Exception as e:
        print(f"Error saving data to {filename}: {e}")

if __name__ == "__main__":
    # Set parameters
    stock_symbol = "AAPL"  # Example: Apple Inc.
    start_date = "2021-01-01"
    end_date = "2021-12-31"
    output_file = (f"daily_price_{stock_symbol}.csv")

    # Fetch stock data
    stock_data = fetch_stock_data(stock_symbol, start_date, end_date)

    # Save data to CSV file
    if stock_data is not None:
        save_to_csv(stock_data, output_file)

# Gpt generated file