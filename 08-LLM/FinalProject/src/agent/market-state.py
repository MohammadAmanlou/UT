import yfinance as yf
import pandas as pd
from datetime import timedelta
import warnings
warnings.filterwarnings("ignore")

def generate_economics_paragraph(date_str):
    date = pd.to_datetime(date_str)
    prev_date = date - timedelta(days=1)

    assets = [
        {'name': 'Bitcoin', 'ticker': 'BTC-USD', 'price_unit': 'USD', 'volume_unit': 'BTC'},
        {'name': 'Etherium', 'ticker': 'ETH-USD', 'price_unit': 'USD', 'volume_unit': 'ETH'},
        {'name': 'USDT', 'ticker': 'USDT-USD', 'price_unit': 'USD', 'volume_unit': 'USDT'},
        {'name': 'Gold',     'ticker': 'GLD',     'price_unit': 'USD per share',   'volume_unit': 'shares'},
        {'name': 'Oil',      'ticker': 'CL=F',    'price_unit': 'USD per barrel',  'volume_unit': 'contracts'},
        {'name': 'S&P 500',  'ticker': '^GSPC',   'price_unit': 'points',          'volume_unit': 'shares'}
    ]

    paragraph = f"On {date_str}, "

    for asset in assets:
        name = asset['name']
        ticker = asset['ticker']

        data = yf.download(ticker, start=prev_date, end=date + timedelta(days=1))
        print(data)
        if data.shape[0] < 2:
            paragraph += f"{name} data not available for {date_str}. "
            continue

        close_yesterday = float(data["Close"].iloc[0])
        close_today     = float(data["Close"].iloc[-1])
        volume_today    = int(data["Volume"].iloc[-1])
        change = (close_today - close_yesterday) / close_yesterday * 100

        if change > 0:
            direction = "rose"
        elif change < 0:
            direction = "fell"
        else:
            direction = "remained unchanged"

        sentence = (
            f"{name} {direction} by {abs(change):.2f}% to {close_today:.2f} "
            f"{asset['price_unit']}, with a trading volume of {volume_today:,} {asset['volume_unit']}. "
        )
        paragraph += sentence

    return paragraph


def generate_paragraphs_for_dates(dates):
    return [generate_economics_paragraph(date) for date in dates]

# Example usage
print(generate_economics_paragraph('2025-08-01'))
