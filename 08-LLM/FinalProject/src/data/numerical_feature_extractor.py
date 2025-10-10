import pandas as pd
import numpy as np
import yaml
from ta.trend import (
    EMAIndicator, SMAIndicator, MACD, ADXIndicator, CCIIndicator, VortexIndicator
)
from ta.momentum import (
    RSIIndicator, StochasticOscillator, WilliamsRIndicator, ROCIndicator
)
from ta.volatility import BollingerBands, AverageTrueRange, DonchianChannel
from ta.volume import OnBalanceVolumeIndicator
from datetime import datetime

def load_ohlcv(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df['date'] = pd.to_datetime(df['date'])
    df.set_index('date', inplace=True)
    return df


def calculate_returns(df: pd.DataFrame, log=True, simple=True):
    if log:
        df['log_return'] = np.log(df['close'] / df['close'].shift(1))
    if simple:
        df['simple_return'] = df['close'].pct_change()
    return df


def add_sma(df: pd.DataFrame, periods):
    for p in periods:
        df[f'sma_{p}'] = SMAIndicator(close=df['close'], window=p).sma_indicator()
    return df


def add_ema(df: pd.DataFrame, periods):
    for p in periods:
        df[f'ema_{p}'] = EMAIndicator(close=df['close'], window=p).ema_indicator()
    return df


def add_macd(df: pd.DataFrame):
    macd = MACD(close=df['close'])
    df['macd'] = macd.macd()
    df['macd_signal'] = macd.macd_signal()
    df['macd_diff'] = macd.macd_diff()
    return df


def add_rsi(df: pd.DataFrame, period):
    rsi = RSIIndicator(close=df['close'], window=period)
    df['rsi'] = rsi.rsi()
    return df


def add_stochastic(df: pd.DataFrame, k_window, d_window):
    stoch = StochasticOscillator(high=df['high'], low=df['low'], close=df['close'], window=k_window, smooth_window=d_window)
    df['stoch_k'] = stoch.stoch()
    df['stoch_d'] = stoch.stoch_signal()
    return df


def add_williams_r(df: pd.DataFrame, period):
    willr = WilliamsRIndicator(high=df['high'], low=df['low'], close=df['close'], lbp=period)
    df['williams_r'] = willr.williams_r()
    return df


def add_cci(df: pd.DataFrame, period):
    cci = CCIIndicator(high=df['high'], low=df['low'], close=df['close'], window=period)
    df['cci'] = cci.cci()
    return df


def add_roc(df: pd.DataFrame, period):
    roc = ROCIndicator(close=df['close'], window=period)
    df['roc'] = roc.roc()
    return df


def add_atr(df: pd.DataFrame, period):
    atr = AverageTrueRange(high=df['high'], low=df['low'], close=df['close'], window=period)
    df['atr'] = atr.average_true_range()
    return df


def add_bollinger_bands(df: pd.DataFrame, period):
    bb = BollingerBands(close=df['close'], window=period, window_dev=2)
    df['bb_upper'] = bb.bollinger_hband()
    df['bb_middle'] = bb.bollinger_mavg()
    df['bb_lower'] = bb.bollinger_lband()
    return df


def add_donchian(df: pd.DataFrame, period):
    dc = DonchianChannel(high=df['high'], low=df['low'], close=df['close'], window=period)
    df['donchian_upper'] = dc.donchian_channel_hband()
    df['donchian_lower'] = dc.donchian_channel_lband()
    return df


def add_adx(df: pd.DataFrame, period):
    adx = ADXIndicator(high=df['high'], low=df['low'], close=df['close'], window=period)
    df['adx'] = adx.adx()
    return df


def add_vortex(df: pd.DataFrame, period):
    vortex = VortexIndicator(high=df['high'], low=df['low'], close=df['close'], window=period)
    df['vortex_pos'] = vortex.vortex_indicator_pos()
    df['vortex_neg'] = vortex.vortex_indicator_neg()
    return df


def add_obv(df: pd.DataFrame):
    obv = OnBalanceVolumeIndicator(close=df['close'], volume=df['volume'])
    df['obv'] = obv.on_balance_volume()
    return df


def add_time_features(df: pd.DataFrame):
    df['hour_sin'] = np.sin(2 * np.pi * df.index.hour / 24)
    df['hour_cos'] = np.cos(2 * np.pi * df.index.hour / 24)
    df['weekday_sin'] = np.sin(2 * np.pi * df.index.dayofweek / 7)
    df['weekday_cos'] = np.cos(2 * np.pi * df.index.dayofweek / 7)
    return df

def label_by_open_close(df: pd.DataFrame, threshold: float = 0.001) -> pd.DataFrame:
    """
    Labels:
        1 → Buy (close significantly > open)
        0 → Sell (close significantly < open)
        2 → Neutral
    """
    delta = (df['close'] - df['open']) / df['open']
    df['label'] = np.select(
        [delta > threshold, delta < -threshold],
        [1, 0],  # 1: Buy, 0: Sell
        default=2  # 2: Neutral
    )
    return df


def evaluate_all_strategies(df: pd.DataFrame, short_win=10, long_win=30, rsi_thresh=30) -> pd.DataFrame:
    import warnings
    warnings.filterwarnings("ignore", category=RuntimeWarning)  # suppress some warnings for clean output

    def safe_align_compare(s1, s2, op):
        """
        Align two series s1 and s2 on index, convert to float, fill NaNs forward,
        and perform element-wise comparison given by op function (like operator.gt).
        Returns boolean Series or all False if error.
        """
        try:
            s1a, s2a = s1.align(s2, join='inner')
            s1a = s1a.astype(float).fillna(method='ffill').fillna(method='bfill')
            s2a = s2a.astype(float).fillna(method='ffill').fillna(method='bfill')
            return op(s1a, s2a).reindex(df.index, fill_value=False)
        except Exception as e:
            print(f"Warning in safe_align_compare: {e}")
            return pd.Series(False, index=df.index)

    import operator
    strategy_df = pd.DataFrame(index=df.index)

    # --- SMA cross ---
    sma_short_col = f'sma_{short_win}'
    sma_long_col = f'sma_{long_win}'
    if sma_short_col in df.columns and sma_long_col in df.columns:
        prev_short = df[sma_short_col].shift(1)
        prev_long = df[sma_long_col].shift(1)
        curr_short = df[sma_short_col]
        curr_long = df[sma_long_col]
        buy = safe_align_compare(prev_short, prev_long, operator.lt) & safe_align_compare(curr_short, curr_long, operator.gt)
        sell = safe_align_compare(prev_short, prev_long, operator.gt) & safe_align_compare(curr_short, curr_long, operator.lt)
        strategy_df['sma_cross'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['sma_cross'] = 0

    # --- EMA cross ---
    ema_short_col = f'ema_{short_win}'
    ema_long_col = f'ema_{long_win}'
    if ema_short_col in df.columns and ema_long_col in df.columns:
        prev_short = df[ema_short_col].shift(1)
        prev_long = df[ema_long_col].shift(1)
        curr_short = df[ema_short_col]
        curr_long = df[ema_long_col]
        buy = safe_align_compare(prev_short, prev_long, operator.lt) & safe_align_compare(curr_short, curr_long, operator.gt)
        sell = safe_align_compare(prev_short, prev_long, operator.gt) & safe_align_compare(curr_short, curr_long, operator.lt)
        strategy_df['ema_cross'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['ema_cross'] = 0

    # --- RSI ---
    if 'rsi' in df.columns:
        rsi = df['rsi'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = rsi < rsi_thresh
        sell = rsi > 70
        strategy_df['rsi_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['rsi_signal'] = 0

    # --- MACD ---
    if 'macd' in df.columns and 'macd_signal' in df.columns:
        buy = safe_align_compare(df['macd'], df['macd_signal'], operator.gt)
        sell = safe_align_compare(df['macd'], df['macd_signal'], operator.lt)
        strategy_df['macd_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['macd_signal'] = 0

    # --- Bollinger Bands ---
    if 'bb_lower' in df.columns and 'bb_upper' in df.columns:
        close = df['close'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = close < df['bb_lower']
        sell = close > df['bb_upper']
        strategy_df['bollinger_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['bollinger_signal'] = 0

    # --- Stochastic ---
    if 'stoch_k' in df.columns and 'stoch_d' in df.columns:
        stoch_k = df['stoch_k'].astype(float).fillna(method='ffill').fillna(method='bfill')
        stoch_d = df['stoch_d'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = (stoch_k < 20) & (stoch_k > stoch_d)
        sell = (stoch_k > 80) & (stoch_k < stoch_d)
        strategy_df['stoch_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['stoch_signal'] = 0

    # --- Williams %R ---
    if 'williams_r' in df.columns:
        willr = df['williams_r'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = willr < -80
        sell = willr > -20
        strategy_df['williams_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['williams_signal'] = 0

    # --- CCI ---
    if 'cci' in df.columns:
        cci = df['cci'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = cci < -100
        sell = cci > 100
        strategy_df['cci_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['cci_signal'] = 0

    # --- ROC ---
    if 'roc' in df.columns:
        roc = df['roc'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = roc > 0
        sell = roc < 0
        strategy_df['roc_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['roc_signal'] = 0

    # --- ADX ---
    if 'adx' in df.columns:
        adx = df['adx'].astype(float).fillna(method='ffill').fillna(method='bfill')
        trending = adx > 25
        # ADX doesn't indicate direction, so 2 = trending (buy), 0 neutral
        strategy_df['adx_trend'] = np.where(trending, 2, 0)
    else:
        strategy_df['adx_trend'] = 0

    # --- Vortex ---
    if 'vortex_pos' in df.columns and 'vortex_neg' in df.columns:
        vortex_pos = df['vortex_pos'].astype(float).fillna(method='ffill').fillna(method='bfill')
        vortex_neg = df['vortex_neg'].astype(float).fillna(method='ffill').fillna(method='bfill')
        buy = vortex_pos > vortex_neg
        sell = vortex_pos < vortex_neg
        strategy_df['vortex_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['vortex_signal'] = 0

    # --- OBV ---
    if 'obv' in df.columns:
        obv_diff = df['obv'].diff().fillna(0)
        buy = obv_diff > 0
        sell = obv_diff < 0
        strategy_df['obv_signal'] = np.select([buy, sell], [2,1], default=0)
    else:
        strategy_df['obv_signal'] = 0

    # --- Final decision by majority vote ---
    buy_votes = (strategy_df == 2).sum(axis=1)
    sell_votes = (strategy_df == 1).sum(axis=1)

    strategy_df['final_decision'] = np.select(
        [buy_votes > sell_votes, sell_votes > buy_votes],
        [1, 0], default=2
    )

    # strategy_df['open'] = df['open']
    # strategy_df['close'] = df['close']

    return strategy_df


def calc_strategies_features():
    with open("configs/run_pipline.yaml", 'r') as file:
        config = yaml.safe_load(file)

    # Load and filter raw OHLCV data
    df = load_ohlcv(config['paths']['raw_data'])
    df = df.loc[config["dates"]['start_date']:config["dates"]['end_date']]

    features = config.get('numerical_features', {})

    # ➕ Add returns
    df = calculate_returns(df, log=features.get('log_return', False), simple=features.get('simple_return', False))
    
    # ➕ Add technical indicators
    if 'sma' in features:
        df = add_sma(df, features['sma'].get('periods', []))
    if 'ema' in features:
        df = add_ema(df, features['ema'].get('periods', []))
    if features.get('macd', False):
        df = add_macd(df)
    if 'rsi' in features:
        df = add_rsi(df, features['rsi'].get('period', 14))
    if 'stochastic' in features:
        df = add_stochastic(df, features['stochastic']['k'], features['stochastic']['d'])
    if 'williams_r' in features:
        df = add_williams_r(df, features['williams_r'])
    if 'cci' in features:
        df = add_cci(df, features['cci'])
    if 'roc' in features:
        df = add_roc(df, features['roc'])
    if 'atr' in features:
        df = add_atr(df, features['atr'])
    if 'bollinger_bands' in features:
        df = add_bollinger_bands(df, features['bollinger_bands'])
    if 'donchian' in features:
        df = add_donchian(df, features['donchian'])
    if 'adx' in features:
        df = add_adx(df, features['adx'])
    if 'vortex' in features:
        df = add_vortex(df, features['vortex'])
    if features.get('obv', False):
        df = add_obv(df)
    if features.get('time_features', False):
        df = add_time_features(df)

    # Drop missing rows after indicators
    df.dropna(inplace=True)

    # ➕ Add label column based on open/close
    threshold = config.get('labeling', {}).get('threshold', 0.001)
    df = label_by_open_close(df, threshold)

    # ➕ Evaluate strategies
    short_win = config.get('strategy_short_window', 10)
    long_win = config.get('strategy_long_window', 30)
    rsi_thresh = config.get('strategy_rsi_threshold', 30)

    strategy_df = evaluate_all_strategies(df, short_win, long_win, rsi_thresh)

    # ➕ Combine with original df
    df = pd.concat([df, strategy_df], axis=1)

    # ➕ Save to CSV
    df.to_csv(config['paths']['processed_data'])
    print(f"Features and strategies saved to: {config['paths']['processed_data']}")

    return df



def main():
    df = calc_strategies_features()
    with open("configs/run_pipline.yaml", 'r') as file:
        config = yaml.safe_load(file)

    evaluation_df = evaluate_all_strategies(df, short_win=10, long_win=30, rsi_thresh=30)

    evaluation_df['open'] = df['open']
    evaluation_df['close'] = df['close']
    evaluation_df.to_csv(config['paths']['evaluation'])
    print(f"Features and strategies saved to: {config['paths']['evaluation']}")

main()