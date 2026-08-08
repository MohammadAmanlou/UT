from ..llm.base import LLM

class Summarizer:
    
    def __init__(self, llm: LLM, max_length: int = 2000):
        self.llm = llm
        self.max_length = max_length

    def summarize(self, response: str) -> str:
        if len(response) > 20000:
            response = response[:20000] + "..."
        
        prompt = f"""
Summarize the following response in 1-2 sentences (max 100 words):

RESPONSE:
{response}

SUMMARY:
"""

        try:
            summary = self.llm.generate(prompt).strip()
            if len(summary) > self.max_length:
                summary = summary[:self.max_length] + "..."
            return summary
        except Exception as e:
            print(f"Summarizer error: {e}")
            return response[:100] + "..."
