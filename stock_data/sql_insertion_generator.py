import csv
import os

# Function to read CSV file and generate SQL insertion commands
def generate_sql_insertions(csv_file):
    stock_symbol = csv_file.split('/')[2].split('_')[0]
    sql_commands = []

    with open(csv_file, 'r') as file:
        reader = csv.reader(file)
        next(reader)  # Skip header row
        for row in reader:
            sql_command = f"INSERT INTO DailyStockMetric (stock_id, date, open_price, close_price, high_price, low_price, volume) SELECT stock_id, '{row[0]}', {row[1]}, {row[4]}, {row[2]}, {row[3]}, {row[5]} FROM Stock WHERE symbol = '{stock_symbol}';"
            sql_commands.append(sql_command)

    return sql_commands

csv_path = "./stock_data/"
csv_files = [
    './stock_data/AAPL_data.csv', 
    './stock_data/MSFT_data.csv', 
    './stock_data/COIN_data.csv', 
    './stock_data/PLTR_data.csv', 
    './stock_data/GOOGL_data.csv']

dest_file = "./sql_files/insert_daily_metrics.sql"

# Ensure the directory exists
dest_directory = os.path.dirname(dest_file)
if not os.path.exists(dest_directory):
    os.makedirs(dest_directory)

# Clear contents of existing SQL file
with open(dest_file, 'w') as sql_file:
    pass

# Generate SQL insertion commands for each CSV file
for file in csv_files:
    sql_insertions = generate_sql_insertions(file)

    with open(dest_file, 'a') as sql_file:
        sql_file.write(f"-- {file}\n")
        sql_file.write('\n'.join(sql_insertions)+'\n')
    print(f"SQL insertion commands generated for {file}")

print("SQL insertion commands generated for all CSV files.")
