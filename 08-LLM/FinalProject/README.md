# 📈 Language Models for Rational, Evidence-Driven Trading

This project explores the use of **Large Language Models (LLMs)** and **machine learning** to build an intelligent, explainable trading agent.  
By combining **textual signals** (from financial news, political speeches, and social media) with **numerical market indicators**, we aim to forecast **XAU-USD** trends with **actionable insights** and **human-readable justifications**.

---

## ✨ Key Features

- 📊 **Multimodal Feature Extraction**  
  - Numerical: OHLCV data + 15+ technical indicators (SMA, EMA, MACD, RSI, Bollinger Bands, OBV, etc.).  
  - Textual: 330K+ financial news articles (2020–2025), clustered into interpretable event categories.

- 🧠 **Hybrid Modeling**  
  - **XGBoost** for structured + textual features.  
  - **ReAct LLM Agent** for reasoning-based decisions.  

- 🗣️ **Explainable Decisions**  
  - **SHAP** values for feature attribution.  
  - LLM-generated natural language explanations aligned with SHAP and textual inputs.  

- 💬 **Multi-role LLM Agents**  
  - Roles: filtering, clustering, predicting, explaining.  

- 📈 **Profitability + Explainability Evaluation**  
  - Metrics: Accuracy, Sharpe Ratio, Cumulative Profit, Per-Trade Profit.  
  - Explanation quality: coverage, fidelity, stability, sentiment alignment.  

---

## 📂 Dataset

- **Numerical Data:**  
  - Daily OHLCV for gold (XAU-USD), oil, and equities.  
  - Technical indicators engineered with leakage-safe lagging.  

- **Textual Data:**  
  - 331,689 financial articles (Financial Post, Yahoo Finance, political speeches).  
  - Clustered via:
    - Transformer embeddings + k-means (scalable).  
    - LLM-based semantic clustering (interpretable).  

---

## ⚙️ Methodology

1. **Profit-Optimal Labeling**  
   - BUY / SELL / HOLD labels derived from utility-maximizing actions with transaction costs.

2. **Hybrid Prediction**  
   - Path A: Accuracy-based XGBoost.  
   - Path B: Utility-weighted (profit-aware) XGBoost.  
   - Convex ensemble + HOLD-threshold for risk control.  

3. **Explainability**  
   - TreeSHAP for local/global attribution.  
   - LLM explanations referencing SHAP features + relevant news.  

4. **ReAct Agent**  
   - LLM agent integrates daily technical indicators + news summaries.  
   - Multi-step reasoning before outputting decision + rationale.  

---

## 🧪 Experiments

- **Models compared:**  
  - XGBoost + LLM explanations.  
  - ReAct LLM agent (with/without CoT and few-shot).  

- **Evaluation metrics:**  
  - Accuracy  
  - Sharpe Ratio  
  - Cumulative Profit  
  - Per-Trade Profit  
  - Explanation quality  

---

## 📌 Discussion

- **XGBoost** outperforms standalone LLMs in profitability and robustness.  
- **Hybrid modeling (XGBoost + LLM)** achieves the best trade-off between accuracy and interpretability.  
- **Textual features** provide unique early signals (e.g., “rate hike,” “inflation fears”) not captured by indicators.  
- **Explanations** are concise, news-aware, and semantically aligned, though ReAct agents sometimes provide more faithful reasoning.  

---

## 🚀 Conclusion

This project demonstrates that **multimodal, explainable AI** can advance algorithmic trading by balancing **accuracy, interpretability, and profitability**.  

Our hybrid framework—combining **XGBoost feature modeling** with **LLM-based reasoning and explanations**—achieves superior financial performance while maintaining human-aligned justifications.  

---
