from ..schema import State


def is_finished(
    state: State,
    max_rounds: int | None = None,
) -> bool:

    max_rounds = max_rounds or state.max_rounds

    if state.rounds >= max_rounds:
        return True

    if state.refusal_count >= state.max_refusals:
        return True

    if state.best_progress >= 0.95:
        return True

    if (
        state.no_improvement_rounds
        >= state.stagnation_limit
    ):
        return True

    return False