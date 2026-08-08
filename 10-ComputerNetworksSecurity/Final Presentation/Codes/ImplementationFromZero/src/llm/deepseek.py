from .gapgpt import GapGPTLLM
from .registry_instance import registry


@registry.register("deepseek")
class DeepSeekLLM(GapGPTLLM):

    def __init__(
        self,
        api_key: str,
        model: str = "deepseek-v4-flash",
    ):
        super().__init__(
            model=model,
            api_key=api_key,
        )