import os
import yaml
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from src.agent.goldapi import get_technical_indicators_in_range_from_csv
from pydantic import BaseModel
from typing import List, Literal
import os
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from src.agent.tools import *
from src.agent.goldapi import get_technical_indicators_in_range_from_csv
from pydantic import BaseModel
from typing import List, Literal
import yaml

class TradeStrategy(BaseModel):
    date: str
    action: Literal["buy", "sell", "wait"]

class StrategyOutput(BaseModel):
    explanation: str
    strategy: List[TradeStrategy]

class GoldTradingNumericalLLM:
    def __init__(self):
        from dotenv import load_dotenv
        load_dotenv()
        os.environ["OPENAI_API_KEY"] = os.getenv("AVVALAI_API_KEY")
        self.llm = ChatOpenAI(
            model="gpt-4o-mini",
            base_url='https://api.gapgpt.app/v1',
            temperature=1,
            max_tokens=5000,
        )
        self.client = OpenAI(
            api_key= os.environ["OPENAI_API_KEY"], 
            base_url='https://api.gapgpt.app/v1',
        )
    def run(self, start_date: str, end_date: str, numerical_csv: str) -> StrategyOutput:
        
        user_prompt = f"""
                You are a trading assistant. Based on the daily technical indicators and gold price open/close values, decide whether the strategy for future day is:
                - 1 → Buy
                - 0 → Sell
                - 2 → Neutral (Wait)

                Use these indicators to help you:
                - **SMA & EMA crossover**: Buy if short > long, Sell if short < long.
                - **MACD**: Buy if MACD > Signal, Sell if MACD < Signal.
                - **RSI**: Buy if RSI < 30, Sell if RSI > 70.
                - **Bollinger Bands**: Buy if close < lower band, Sell if close > upper band.
                - **Stochastic Oscillator**: Buy if %K < 20 and rising above %D, Sell if %K > 80 and falling below %D.

                Give your answer in this format:
                {{
                "explanation": "A detailed explanation of how indicators influenced your strategy.",
                "action":Based on the data from all the days provided, determine the action (buy, sell, or wait) for the single day immediately following the last given date
                }}

                Here is the input data:

                {get_technical_indicators_in_range_from_csv(start_date, end_date, numerical_csv)}
                
                """

        input_msg = HumanMessage(content=user_prompt)
        response = self.llm.invoke([input_msg])
        return response.content

if __name__ == "__main__":
    agent = GoldTradingNumericalLLM()

    with open("configs/run_pipline.yaml", 'r') as f:
        config = yaml.safe_load(f)

    strategy_output = agent.run(
        start_date=config["dates"]["start_date"],
        end_date=config["dates"]["end_date"],
        numerical_csv=config["paths"]["evaluation"]
    )

    print(strategy_output)
