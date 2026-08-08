from dataclasses import dataclass, field
from typing import List, Optional


@dataclass
class Evaluation:
    progress: float
    success: bool
    reason: str = ""


@dataclass
class Turn:
    prompt: str
    response: str
    summary: str
    evaluation: Evaluation


@dataclass
class AttackRecord:
    prompt: str

    response: str
    
    summary: str

    progress: float

    success: bool

    refused: bool

    reason: str


@dataclass
class State:

    target_task: str

    # HT
    target_history: List[Turn] = field(
        default_factory=list
    )

    # HA
    attack_history: List[AttackRecord] = field(
        default_factory=list
    )

    failure_memory: List[str] = field(
        default_factory=list
    )

    latest_response: str = ""

    rounds: int = 0

    refusal_count: int = 0

    best_progress: float = 0.0

    best_turn: Optional[Turn] = None

    no_improvement_rounds: int = 0

    max_rounds: int = 50

    max_refusals: int = 20

    stagnation_limit: int = 20
    last_improvement_round: int = 0