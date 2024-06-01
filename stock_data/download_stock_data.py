import yfinance as yf
from datetime import datetime, timedelta

# List of stock symbols
stock_symbols = ['AAPL', 'MSFT', 'COIN', 'PLTR', 'GOOGL']

# Define start and end dates
end_date = datetime.today().strftime('%Y-%m-%d')
start_date = (datetime.today() - timedelta(weeks=4)).strftime('%Y-%m-%d')

# Download data for each stock and save to CSV
for symbol in stock_symbols:
    print(f"Downloading data for {symbol}...")
    stock_data = yf.download(symbol, start=start_date, end=end_date)
    # Selecting relevant columns
    stock_data = stock_data[['Open', 'High', 'Low', 'Close', 'Volume']]
    # Save to CSV
    stock_data.to_csv(f"./stock_data/{symbol}_data.csv")
    print(f"Data downloaded and saved to stock_data/{symbol}_data.csv")

print("Data download complete")

