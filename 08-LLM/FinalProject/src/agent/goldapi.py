import yfinance as yf
from datetime import date, timedelta
from typing import Optional

GOLD = yf.Ticker("GC=F")

def _get_hist(start: str, end: str):
    df = GOLD.history(start=start, end=end, interval="1d") 
    if df.empty:
        raise ValueError(f"No data returned for {start} to {end}")
    return df

def get_open_close_by_date(date_str: str) -> str:
    next_day = (date.fromisoformat(date_str) + timedelta(days=1)).isoformat()
    df = _get_hist(date_str, next_day)
    o, c = df.loc[date_str, ["Open", "Close"]]
    return f"Gold on {date_str}: Open = {o:.2f} USD, Close = {c:.2f} USD"

def get_open_close_in_range(start_date: str, end_date: str) -> str:

    ex_end = (date.fromisoformat(end_date) + timedelta(days=1)).isoformat()
    df = _get_hist(start_date, ex_end)
    lines = [f"Gold prices from {start_date} to {end_date}:"]
    for dt, row in df.iterrows():
        lines.append(f"  • {dt.date()}: Open = {row['Open']:.2f}, Close = {row['Close']:.2f}")
    return "\n".join(lines)

def get_price_relative(days_ago: int = 0) -> str:

    target = date.today() - timedelta(days=days_ago)
    return get_open_close_by_date(target.isoformat())

def get_range_relative(
    days_ago: Optional[int] = 0
) -> str:

    start = date.today() - timedelta(days=days_ago)
    end = date.today()
    return get_open_close_in_range(start.isoformat(), end.isoformat())

import pandas as pd

def write_price_range_to_csv(start_date: str, end_date: str, filename: str = "gold_prices.csv") -> str:
    """Fetches gold prices in a date range and writes them to a CSV file."""
    ex_end = (date.fromisoformat(end_date) + timedelta(days=1)).isoformat()
    df = _get_hist(start_date, ex_end)

    df_out = df[["Open", "Close"]].copy()
    df_out.index = df_out.index.date
    df_out.reset_index(inplace=True)
    df_out.rename(columns={"index": "Date"}, inplace=True)

    df_out.to_csv(filename, index=False)
    return f"Saved gold prices from {start_date} to {end_date} to {filename}"


def safe_float_format(value, ndigits=2, default='N/A'):
    return f"{float(value):.{ndigits}f}"
    
def get_technical_indicators_in_range_from_csv(start_date: str, end_date: str, csv_path: str) -> str:
    """Reads indicator-enhanced CSV and returns a formatted string of daily strategy signals."""
    df = pd.read_csv(csv_path, parse_dates=["date"])
    mask = (df["date"] >= pd.to_datetime(start_date)) & (df["date"] <= pd.to_datetime(end_date))
    df_filtered = df.loc[mask]

    if df_filtered.empty:
        return f"No technical indicator data found from {start_date} to {end_date}."

    lines = [f"Technical strategy signals from {start_date} to {end_date}:\n"]
    for _, row in df_filtered.iterrows():
        date = row["date"].date()
        line = (
            f"  • {date}: "
            f"open = {row['open']:.2f}, close = {row['close']:.2f}, "
            f"sma_cross = {row['sma_cross']}, "
            f"ema_cross = {row['ema_cross']}, "
            f"rsi_signal = {row['rsi_signal']}, "
            f"macd_signal = {row['macd_signal']}, "
            f"bollinger_signal = {row['bollinger_signal']}, "
            f"stoch_signal = {row['stoch_signal']}, "
            f"williams_signal = {row['williams_signal']}, "
            f"cci_signal = {row['cci_signal']}, "
            f"roc_signal = {row['roc_signal']}, "
            f"adx_trend = {row['adx_trend']}, "
            f"vortex_signal = {row['vortex_signal']}, "
            f"obv_signal = {row['obv_signal']}, "
            f"final_decision = {row['final_decision']}"
        )
        lines.append(line)

    return "\n".join(lines)


def write_ohlcv_range_to_csv(start_date: str, end_date: str, filename: str = "gold_prices_ohlcv.csv") -> str:
    """Fetches gold prices in a date range and writes OHLCV data to a CSV file."""
    ex_end = (date.fromisoformat(end_date) + timedelta(days=1)).isoformat()
    df = _get_hist(start_date, ex_end)

    # Ensure required columns exist
    expected_cols = ["Open", "High", "Low", "Close", "Volume"]
    missing_cols = [col for col in expected_cols if col not in df.columns]
    for col in missing_cols:
        df[col] = None  # Fill with NaN if missing

    df_out = df[expected_cols].copy()
    df_out.index = df_out.index.date
    df_out.reset_index(inplace=True)
    df_out.rename(columns={"index": "Date"}, inplace=True)

    df_out.to_csv(filename, index=False)
    return f"Saved gold OHLCV data from {start_date} to {end_date} to {filename}"


write_ohlcv_range_to_csv("2020-01-01", "2025-08-01","gold_ohlcv_2020_2025.csv")