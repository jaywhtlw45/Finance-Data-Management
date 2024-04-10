import yfinance as yf
import pandas as pd

def fetch_stock_data(stock_symbol, start_date, end_date):
    """
    Fetch historical stock data and metrics from Yahoo Finance.

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

        # Fetch additional metrics
        stock_info = yf.Ticker(stock_symbol).info

        # Extract relevant metrics
        market_cap = stock_info.get("marketCap", None)
        pe_ratio = stock_info.get("forwardPE", None)
        ps_ratio = stock_info.get("priceToSalesTrailing12Months", None)

        return stock_data, market_cap, pe_ratio, ps_ratio
    except Exception as e:
        print(f"Error fetching data for {stock_symbol}: {e}")
        return None, None, None, None

def save_to_csv(data, metrics, filename):
    """
    Save stock data and metrics to a CSV file.

    Args:
    - data: Pandas DataFrame containing stock data.
    - metrics: Dictionary containing additional metrics.
    - filename: Name of the CSV file to save the data to.
    """
    try:
        # Combine stock data and metrics into a single DataFrame
        combined_data = pd.concat([data, pd.DataFrame(metrics, index=data.index)], axis=1)

        # Save combined data to CSV file
        combined_data.to_csv(filename)
        print(f"Data saved to {filename}")
    except Exception as e:
        print(f"Error saving data to {filename}: {e}")

if __name__ == "__main__":
    # Set parameters
    stock_symbol = "AAPL"  # Example: Apple Inc.
    start_date = "2021-01-01"
    end_date = "2021-12-31"
    output_file = "apple_data_with_metrics.csv"

    # Fetch stock data and metrics
    stock_data, market_cap, pe_ratio, ps_ratio = fetch_stock_data(stock_symbol, start_date, end_date)

    # Save data and metrics to CSV file
    if stock_data is not None:
        metrics = {
            "MarketCap": market_cap,
            "PE_Ratio": pe_ratio,
            "PS_Ratio": ps_ratio
        }
        save_to_csv(stock_data, metrics, output_file)
