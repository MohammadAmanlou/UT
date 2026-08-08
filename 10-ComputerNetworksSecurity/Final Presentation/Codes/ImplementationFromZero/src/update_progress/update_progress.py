from ..schema import State, Evaluation


def update_progress(
    state: State,
    evaluation: Evaluation,
) -> None:

    previous_progress = state.best_progress


    state.best_progress = max(
        state.best_progress,
        evaluation.progress,
    )

    if state.best_progress > previous_progress:

        state.no_improvement_rounds = 0

        if state.target_history:
            state.best_turn = (
                state.target_history[-1]
            )

    else:
        state.no_improvement_rounds += 1