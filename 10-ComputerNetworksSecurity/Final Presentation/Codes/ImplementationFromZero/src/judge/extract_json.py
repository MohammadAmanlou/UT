import json
import re


def extract_json(raw: str) -> dict:

    raw = raw.strip()

    raw = raw.replace("```json", "")
    raw = raw.replace("```", "")
    raw = raw.strip()

    match = re.search(
        r"\{.*\}",
        raw,
        flags=re.DOTALL,
    )

    if not match:
        raise ValueError("No JSON found")

    return json.loads(match.group(0))