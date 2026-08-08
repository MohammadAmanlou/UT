from .gapgpt import GapGPTLLM
from .registry_instance import registry


@registry.register("openai")
class OpenAILLM(GapGPTLLM):

    def __init__(
        self,
        api_key: str,
        model: str = "gpt-4o-mini",
    ):
        super().__init__(
            model=model,
            api_key=api_key,
        )