# Crescendomation Benchmark Framework

A lightweight research framework for running multi-turn adaptive prompting experiments against multiple Large Language Models (LLMs).

The framework implements a Crescendomation-style interaction loop consisting of:

* Planner
* Target Model
* Summarizer
* Evaluator
* Refusal Judge
* Secondary Judge
* Progress Tracking
* State Persistence

The goal is to evaluate how different models respond over multiple adaptive turns while tracking progress toward a predefined objective.

---

# Features

* Multi-turn adaptive prompting
* Model-agnostic architecture
* OpenAI-compatible API support
* Automatic response summarization
* Progress evaluation
* Refusal detection
* Secondary evaluation review
* State persistence to JSON
* Multi-model benchmarking
* Experiment reproducibility

---

# Supported Models

Current implementations include:

* GPT-4o Mini
* Gemini Flash Lite
* Qwen 3 235B Instruct
* DeepSeek V4 Flash

All models are accessed through a GAPGPT OpenAI-compatible endpoint.

---

# Project Structure

```text
src/
├── judge/
│   ├── evaluator.py
│   ├── refusal.py
│   └── secondary.py
│
├── llm/
│   ├── base.py
│   ├── openai.py
│   ├── gemini.py
│   ├── qwen.py
│   ├── deepseek.py
│   ├── gapgpt.py
│   ├── factory.py
│   └── registry.py
│
├── planner/
│   └── planner.py
│
├── target/
│   └── target.py
│
├── summarize/
│   └── summarize.py
│
├── runner/
│   └── run.py
│
├── save_state/
│   └── save_state.py
│
├── update_progress/
│   └── update_progress.py
│
├── is_finished/
│   └── is_finished.py
│
├── schema.py
└── main.py
```

---

# Installation

Clone the repository:

```bash
git clone <repository-url>
cd <repository>
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate the environment.

Linux / macOS:

```bash
source .venv/bin/activate
```

Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
pip install -r requirements.txt
```

---

# Configuration

Create a `.env` file in the project root:

```env
GAPGPT_API_KEY=your_api_key_here
```

Alternatively configure the environment variable directly.

Linux/macOS:

```bash
export GAPGPT_API_KEY="your_api_key_here"
```

Windows PowerShell:

```powershell
$env:GAPGPT_API_KEY="your_api_key_here"
```

---

# Running Experiments

Execute:

```bash
python -m src.main
```

The framework will:

1. Iterate through all tasks
2. Iterate through all target models
3. Run the adaptive prompting loop
4. Evaluate responses
5. Track progress
6. Save experiment state

---

# Execution Pipeline

```text
Planner
    ↓
Target Model
    ↓
Refusal Judge
    ↓
Summarizer
    ↓
Evaluator
    ↓
Secondary Judge
    ↓
Update Progress
    ↓
State Persistence
```

---

# Components

## Planner

Generates the next prompt based on:

* Objective
* Previous summaries
* Refusal history
* Failure memory
* Progress statistics

---

## Target Model

Receives the generated prompt and conversation history and produces a response.

---

## Summarizer

Compresses responses into short summaries for future planning iterations.

---

## Evaluator

Evaluates:

* Response quality
* Task completion
* Progress toward the objective

Returns:

```json
{
  "score": 0.0,
  "progress": 0.0,
  "success": false,
  "reason": ""
}
```

---

## Refusal Judge

Detects whether the target model refused to answer.

---

## Secondary Judge

Reviews evaluator decisions and corrects potential evaluation mistakes.

---

# Output

Results are stored under:

```text
output/
├── task1/
│   ├── openai.json
│   ├── gemini.json
│   ├── qwen.json
│   └── deepseek.json
│
├── task2/
├── task3/
└── ...
```

Each output file contains:

* Full experiment state
* Conversation history
* Evaluation results
* Progress metrics
* Refusal statistics

---

# Stopping Conditions

Execution terminates when one of the following conditions is met:

* Maximum rounds reached
* Maximum refusals reached
* Progress threshold achieved
* Stagnation limit exceeded

---

# Environment

Tested with:

* Python 3.11+
* OpenAI SDK v1+

---

# License

MIT License
