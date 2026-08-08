from .gapgpt import GapGPTLLM
from .registry_instance import registry


@registry.register("qwen")
class QwenLLM(GapGPTLLM):

    def __init__(
        self,
        api_key: str,
        model: str = "qwen3-235b-a22b",
    ):
        super().__init__(
            model=model,
            api_key=api_key,
        )