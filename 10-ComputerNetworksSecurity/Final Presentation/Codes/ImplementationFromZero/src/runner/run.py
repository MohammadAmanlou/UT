from ..schema import State, Turn, AttackRecord
from ..is_finished.is_finished import is_finished
from ..update_progress.update_progress import update_progress

from ..schema import (
    State,
    Turn,
    AttackRecord,
)

from ..is_finished.is_finished import is_finished
from ..update_progress.update_progress import update_progress

def run(
    state: State,
    planner,
    target,
    summarizer,
    evaluator,
    refusal_judge,
    secondary_judge,
) -> State:

    print(f"Starting attack with objective: {state.target_task}")
    print(f"Max rounds: {state.max_rounds}\n")

    while not is_finished(state, state.max_rounds):
        print(f"\n--- Round {state.rounds + 1}/{state.max_rounds} ---")

        # ----------------------------------
        # Generate next attack step
        # ----------------------------------
        prompt = planner.generate_next_step(state)
        print(f"Prompt: {prompt}")

        response = target.generate(
            prompt=prompt,
            history=state.target_history,
        )
        print(f"Response length: {len(response)} chars")

        state.latest_response = response

        # ----------------------------------
        # Refusal detection (GROUND TRUTH)
        # ----------------------------------
        refusal = refusal_judge.is_refusal(response)
        print(f"Refusal detected: {refusal}")

        if refusal:
            print("⛔ Refused - skipping evaluation")
            state.refusal_count += 1
            state.failure_memory.append(prompt)

            state.attack_history.append(
                AttackRecord(
                    prompt=prompt,
                    response=response,
                    summary="",
                    progress=0.0,
                    success=False,
                    refused=True,
                    reason="refusal",
                )
            )

            state.rounds += 1
            continue

        # ----------------------------------
        # Evaluation ONLY for non-refusal
        # ----------------------------------
        print("📊 Evaluating response...")
        evaluation = evaluator.evaluate(
            response=response,
            task=state.target_task,
            refusal=False  
        )
        print(f"Primary evaluation: progress={evaluation.progress}, success={evaluation.success}")

        # Secondary review
        print("🔍 Secondary review...")
        evaluation = secondary_judge.review(
            response=response,
            task=state.target_task,
            evaluation=evaluation,
        )
        print(f"Final evaluation: progress={evaluation.progress}, success={evaluation.success}")

        # ----------------------------------
        # Summarize
        # ----------------------------------
        summary = summarizer.summarize(response)
        print(f"Summary: {summary[:100]}..." if len(summary) > 100 else f"Summary: {summary}")

        # ----------------------------------
        # Update state
        # ----------------------------------
        state.attack_history.append(
            AttackRecord(
                prompt=prompt,
                response=response,
                summary=summary,
                progress=evaluation.progress,
                success=evaluation.success,
                refused=False,
                reason=evaluation.reason,
            )
        )

        state.target_history.append(
            Turn(
                prompt=prompt,
                response=response,
                summary=summary,
                evaluation=evaluation,
            )
        )

        state.rounds += 1
        update_progress(state, evaluation)
        
        # Show best progress so far
        print(f"Best progress: {state.best_progress}")

    print(f"\n✅ Attack finished after {state.rounds} rounds")
    print(f"Best progress achieved: {state.best_progress}")
    print(f"Total refusals: {state.refusal_count}")

    return state