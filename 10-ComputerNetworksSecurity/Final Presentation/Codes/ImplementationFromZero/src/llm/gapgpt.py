from openai import OpenAI
from .base import LLM

import time


class GapGPTLLM(LLM):

    def __init__(
        self,
        model: str,
        api_key: str,
        base_url: str = "https://api.gapgpt.app/v1",
        max_retries: int = 5,
    ):
        self.model = model
        self.max_retries = max_retries

        self.client = OpenAI(
            api_key=api_key,
            base_url=base_url,
        )

    def generate(
        self,
        prompt: str,
    ) -> str:

        return self.chat(
            [
                {
                    "role": "user",
                    "content": prompt,
                }
            ]
        )

    def chat(
        self,
        messages: list[dict],
    ) -> str:

        last_error = None

        for attempt in range(self.max_retries):

            try:

                response = (
                    self.client.chat.completions.create(
                        model=self.model,
                        messages=messages,
                    )
                )

                return (
                    response.choices[0]
                    .message
                    .content
                    or ""
                )

            except Exception as e:

                last_error = e

                wait_time = 2 ** attempt

                print(
                    f"[{self.model}] "
                    f"attempt={attempt+1}/"
                    f"{self.max_retries} "
                    f"failed: {e}"
                )

                if attempt < self.max_retries - 1:
                    time.sleep(wait_time)

        raise RuntimeError(
            f"Failed after {self.max_retries} retries"
        ) from last_error