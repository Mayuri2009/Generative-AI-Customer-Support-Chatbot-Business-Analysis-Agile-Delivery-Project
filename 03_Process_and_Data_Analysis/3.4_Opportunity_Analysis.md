# Opportunity Analysis

## 1. Purpose

This analysis translates the synthetic customer-support data into a business recommendation for the Generative AI chatbot MVP.

The goal is to prioritize **high-volume, lower-complexity interactions** while keeping complex or high-risk scenarios human-led.

---

## 2. Analysis Approach

The support interaction data was analyzed using PostgreSQL to:

- Analyze interaction volume by intent
- Compare average handling time (AHT)
- Review escalation rates
- Review CSAT and repeat-contact rates
- Identify high-impact support areas
- Score potential chatbot automation candidates
- Recommend the initial chatbot MVP scope

---

## 3. Key Findings

The analysis was performed on **50,000 synthetic customer-support interactions**.

Key observations:

- **Order Status** is one of the highest-volume customer-support intents.
- High-volume, low-escalation intents represent the strongest initial chatbot opportunities.
- Some intents consume significant agent time because of higher average handling time.
- **Complex Complaint** has a high escalation rate and should remain primarily human-led.
- **Payment Issue** also has relatively high complexity and escalation and should not be a first-phase automation target.
- Simple and repetitive requests such as order status, delivery ETA, return policy and password reset are more suitable for self-service automation.

---

## 4. Automation Opportunity Matrix

| Intent | Volume | Volume % | Avg AHT (min) | Escalation % | Avg CSAT | Automation Score | Recommendation |
