import os
from langchain_openai import ChatOpenAI
from langgraph.graph import MessagesState, StateGraph, START
from langgraph.prebuilt import tools_condition
from langchain_core.messages import HumanMessage
from typing_extensions import TypedDict
from src.agent.tools import *
from src.agent.goldapi import get_technical_indicators_in_range_from_csv
from pydantic import BaseModel
from typing import List, Literal
import yaml
from langgraph.prebuilt import ToolNode

class TradeStrategy(BaseModel):
    date: str  # e.g., "2025-07-01"
    action: Literal["buy", "sell", "wait"]

class StrategyOutput(BaseModel):
    explanation: str
    strategy: List[TradeStrategy]

REACT_SYS_PROMPT = """
Your task is to trade in a gold stock market.
Your thinking should be thorough and so it's fine if it's very long. You can think step by step before and after each action you decide to take.
You MUST iterate and keep going until the problem is solved.
Only terminate your turn when you are sure that the problem is solved. Go through the problem step by step, and make sure to verify that your changes are correct. NEVER end your turn without having solved the problem, and when you say you are going to make a tool call, make sure you ACTUALLY make the tool call, instead of ending your turn.
THE PROBLEM CAN DEFINITELY BE SOLVED WITHOUT THE INTERNET.
If after using a tool you still need more information use more of the tools provided
On your Final answer give the final sell, buy, and wait state list for just next day after last day gave you
# Workflow

## High-Level Problem Solving Strategy

1. Understand the problem deeply. Carefully read the issue and think critically about what is required.
2. Use all the tools. Try to gather as much data as possible from the state of the market.
3. Use the given tools carefully. They can provide you really good information.
4. On your Final answer give the final sell, buy, and wait for the given range of days to trade in the gold stock market.


# Output Format

When you are ready to provide the final answer, you MUST output it in the following exact JSON format:

{
  "explanation": "A detailed explanation of the strategy and reasoning goes here.",
  "action":Based on the data from all the days provided, determine the action (buy, sell, or wait) for the single day immediately following the last given date
}
GET THE NEWS TOPICS ONLY FOR THE LAST 3 DAYS NOT ALL THE INTERVAL. USE ALL THE TOOLS PROVIDED TO YOU.
The strategy must be a list of actions (buy, sell, or wait) for each day in the given date range. Each action must be mapped to the correct date.
"""

class ConfigSchema(TypedDict):
    news_csv: str

class GoldTradingAgent:
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
        self.llm = self.llm.bind_tools([search_web__for_news_topic, get_date_important_news_topics])
            
        def agent_node(state: MessagesState) -> MessagesState:   
            msg_history = state["messages"]
            new_msg = self.llm.invoke([REACT_SYS_PROMPT] + msg_history)
            msg_history.append(new_msg)
            return {"messages": msg_history}

        tools_node = ToolNode(tools=[search_web__for_news_topic, get_date_important_news_topics])

        self.react_builder = StateGraph(MessagesState, config_schema=ConfigSchema)
        self.react_builder.add_node("agent", agent_node)
        self.react_builder.add_node("tools", tools_node)
        self.react_builder.add_edge(START, "agent")
        self.react_builder.add_conditional_edges("agent", tools_condition)
        self.react_builder.add_edge("tools", "agent")

        self.react_graph = self.react_builder.compile()

    def run(self, start_date: str, end_date: str, news_csv: str, numerical_csv: str, inference_type: str) -> StrategyOutput:
        simple_user_prompt = f"""
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
                
                ALWAYS USE ALL THE TOOLS ALSO SEARCH THE WEB FOR GETTING NEWS CONTENT
                USE ONLY THE LAST TWO DAYS NEWS.
                """
        COT_user_prompt = f"""
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

                ### Step-by-step Reasoning Process (Chain of Thought):

                1.  **Evaluate Each Technical Indicator:** Apply each technical analysis strategy provided in the input prompt (e.g., RSI, MACD, Moving Averages). For each indicator, determine its individual signal: Buy, Sell, or Neutral/Wait. Tally the results to establish a preliminary score.

                2.  **Incorporate External Factors:** Search the web for the most relevant gold-related news from the last two days. Analyze the headlines and summaries to gauge market sentiment. Categorize the overall news tone as Bullish (e.g., economic uncertainty, inflation data), Bearish (e.g., strong dollar, rising yields), or Neutral.

                3.  **Integrate All Signals:** Synthesize the technical indicator score with the news sentiment. A strong consensus from indicators can be reinforced or contradicted by news; conflicting indicators require heavier weighting of the news context.

                4.  **Analyze Scenarios with Different Focuses:** Formulate at least three distinct potential decisions by emphasizing different input variables:
                    -   **Technical-Focused Decision:** Prioritize the signals from the majority of indicators, potentially overlooking minor news.
                    -   **News-Driven Decision:** Prioritize the prevailing market sentiment from recent news, potentially overriding mixed technical signals.
                    -   **Risk-Averse Decision:** Favor a "Wait" or neutral stance in cases of strong conflict between technicals and news or high market uncertainty.

                5.  **Make a Final Decision:** Based on the integrated analysis and scenario evaluation, choose the most prudent action:
                    -   `0` for **Sell**
                    -   `1` for **Buy**
                    -   `2` for **Wait**
                    The final reasoning must explicitly reference both the technical indicators and the news sentiment.

                Give your answer in this format:
                {{
                "explanation": "A detailed explanation of how indicators influenced your strategy.",
                "action":Based on the data from all the days provided, determine the action (buy, sell, or wait) for the single day immediately following the last given date
                }}

                Here is the input data:

                {get_technical_indicators_in_range_from_csv(start_date, end_date, numerical_csv)}
                
                ALWAYS USE ALL THE TOOLS ALSO SEARCH THE WEB FOR GETTING NEWS CONTENT
                USE ONLY THE LAST TWO DAYS NEWS.
                """
        
        FEWSHOT_use_prompt = f"""
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

                I give some examples

                • Example 1  
                Input Data:  
                • 2020-01-10: open = 2840.50, close = 2875.20, sma_cross = 1, ema_cross = 1, rsi_signal = 0, macd_signal = 1, bollinger_signal = 0, stoch_signal = 0, williams_signal = 1, cci_signal = 1, roc_signal = 1, adx_trend = 1, vortex_signal = 1, obv_signal = 1, final_decision = 1  
                • 2020-01-13: open = 2870.30, close = 2882.90, sma_cross = 1, ema_cross = 1, rsi_signal = 0, macd_signal = 1, bollinger_signal = 0, stoch_signal = 0, williams_signal = 1, cci_signal = 1, roc_signal = 1, adx_trend = 1, vortex_signal = 1, obv_signal = 1, final_decision = 1  
                News (last two days): Dollar weakens, geopolitical tensions rise.  
                Output:  
                {{
                "explanation": "Most indicators show bullish momentum, and supportive news confirms upside potential.",
                "action": 1
                }}

                • Example 2  
                Input Data:  
                • 2020-01-20: open = 2910.70, close = 2888.40, sma_cross = 0, ema_cross = 0, rsi_signal = 1, macd_signal = 0, bollinger_signal = 1, stoch_signal = 1, williams_signal = 0, cci_signal = 0, roc_signal = 0, adx_trend = 0, vortex_signal = 0, obv_signal = 0, final_decision = 0  
                • 2020-01-21: open = 2887.50, close = 2865.90, sma_cross = 0, ema_cross = 0, rsi_signal = 1, macd_signal = 0, bollinger_signal = 1, stoch_signal = 1, williams_signal = 0, cci_signal = 0, roc_signal = 0, adx_trend = 0, vortex_signal = 0, obv_signal = 0, final_decision = 0  
                News (last two days): Strong US jobs data, Treasury yields higher.  
                Output:  
                {{
                "explanation": "Indicators point to overbought and weakening momentum. News is bearish, confirming a sell bias.",
                "action": 0
                }}

                • Example 3  
                Input Data:  
                • 2020-01-27: open = 2855.00, close = 2860.40, sma_cross = 0, ema_cross = 0, rsi_signal = 2, macd_signal = 2, bollinger_signal = 2, stoch_signal = 2, williams_signal = 2, cci_signal = 2, roc_signal = 2, adx_trend = 2, vortex_signal = 2, obv_signal = 2, final_decision = 2  
                • 2020-01-28: open = 2862.30, close = 2861.10, sma_cross = 0, ema_cross = 0, rsi_signal = 2, macd_signal = 2, bollinger_signal = 2, stoch_signal = 2, williams_signal = 2, cci_signal = 2, roc_signal = 2, adx_trend = 2, vortex_signal = 2, obv_signal = 2, final_decision = 2  
                News (last two days): Mixed signals—Fed minutes neutral, inflation data stable.  
                Output:  
                {{
                "explanation": "Technical indicators are flat/neutral and news offers no strong direction. Waiting is prudent.",
                "action": 2
                }}
                
                ALWAYS USE ALL THE TOOLS ALSO SEARCH THE WEB FOR GETTING NEWS CONTENT
                USE ONLY THE LAST TWO DAYS NEWS.
                """

        if(inference_type == "SIMPLE"):
            user_prompt = simple_user_prompt
        elif(inference_type == "COT"):
            user_prompt = COT_user_prompt
        elif(inference_type == "FEWSHOT"):
            user_prompt = FEWSHOT_use_prompt
        else:
            raise ValueError(f"Inference type '{inference_type}' is not valid. "
                     f"Valid options are: SIMPLE, COT, FEW-SHOT")
        input_msg = HumanMessage(content=user_prompt)
        input_config = {"configurable": {"news_path": news_csv,"client":self.client}}

        response = self.react_graph.invoke(MessagesState(messages=[input_msg]), config=input_config)
        # for msg in response["messages"]:
        #     msg.pretty_print()
        final_response = response["messages"][-1].content
        return final_response
    
if __name__ == "__main__":

    agent = GoldTradingAgent()

    with open("configs/run_pipline.yaml", 'r') as f:
        config = yaml.safe_load(f)
    
    strategy_output = agent.run(
        start_date=config["dates"]["start_date"],
        end_date=config["dates"]["end_date"],
        news_csv=config["paths"]["news"],
        numerical_csv=config["paths"]["evaluation"],
    )

    print("hello")