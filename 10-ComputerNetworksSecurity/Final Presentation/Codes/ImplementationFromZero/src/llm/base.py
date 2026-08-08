from abc import ABC, abstractmethod


class LLM(ABC):

    @abstractmethod
    def generate(
        self,
        prompt: str,
    ) -> str:
        pass

    @abstractmethod
    def chat(
        self,
        messages: list[dict],
    ) -> str:
        pass