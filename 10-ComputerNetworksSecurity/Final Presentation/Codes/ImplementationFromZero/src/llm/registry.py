from typing import Dict, Type, Callable
from .base import LLM


class ModelRegistry:
    """
    Central registry for all LLM implementations
    """

    def __init__(self):
        self._registry: Dict[str, Callable[..., LLM]] = {}

    def register(self, name: str):
        """
        Decorator for registering models
        """

        def wrapper(cls: Type[LLM]):
            self._registry[name] = cls
            return cls

        return wrapper

    def create(self, name: str, **kwargs) -> LLM:
        """
        Factory method
        """

        if name not in self._registry:
            raise ValueError(f"Unknown model: {name}")

        return self._registry[name](**kwargs)

    def list_models(self):
        return list(self._registry.keys())