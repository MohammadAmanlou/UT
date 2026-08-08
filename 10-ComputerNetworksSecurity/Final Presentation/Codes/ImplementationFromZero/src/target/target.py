from typing import List
from ..schema import Turn


class TargetModel:

    def __init__(self, llm):
        self.llm = llm

    def generate(
        self,
        prompt: str,
        history: List[Turn],
    ) -> str:

        messages = []

        for turn in history[-10:]:

            messages.append(
                {
                    "role": "user",
                    "content": turn.prompt,
                }
            )

            messages.append(
                {
                    "role": "assistant",
                    "content": turn.response,
                }
            )

        messages.append(
            {
                "role": "user",
                "content": prompt,
            }
        )

        return self.llm.chat(messages)