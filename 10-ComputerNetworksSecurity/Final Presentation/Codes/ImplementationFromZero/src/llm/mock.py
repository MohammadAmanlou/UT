from .base import LLM
from .registry_instance import registry


@registry.register("mock")
class MockLLM(LLM):

    def generate(
        self,
        prompt: str,
    ) -> str:

        return f"[MOCK] {prompt[:100]}"

    def chat(
        self,
        messages: list[dict],
    ) -> str:

        return "[MOCK CHAT]"