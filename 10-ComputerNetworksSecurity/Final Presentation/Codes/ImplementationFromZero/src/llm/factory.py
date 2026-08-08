from .registry_instance import registry


def build_llm(name: str, **kwargs):
    return registry.create(name, **kwargs)