from .gapgpt import GapGPTLLM
from .registry_instance import registry


@registry.register("gemini")
class GeminiLLM(GapGPTLLM):

    def __init__(
        self,
        api_key: str,
        model: str = "gemini-flash-lite-latest",
    ):
        super().__init__(
            model=model,
            api_key=api_key,
        )