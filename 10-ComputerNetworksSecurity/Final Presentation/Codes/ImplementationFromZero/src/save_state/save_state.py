import json
import os
import re
from dataclasses import asdict

from ..schema import State


def safe_filename(text: str) -> str:

    text = re.sub(r'[<>:"/\\|?*]', "_", text)

    text = re.sub(r"\s+", "_", text)

    text = text.rstrip(". ")

    if not text:
        text = "task"

    return text[:100]


def save_state(
    state: State,
    task: str,
    model_name: str,
):

    safe_task = safe_filename(task)

    output_dir = os.path.join("output", safe_task)

    os.makedirs(
        output_dir,
        exist_ok=True,
    )

    path = os.path.join(
        output_dir,
        f"{model_name}.json",
    )

    with open(
        path,
        "w",
        encoding="utf-8",
    ) as f:

        json.dump(
            asdict(state),
            f,
            ensure_ascii=False,
            indent=2,
        )