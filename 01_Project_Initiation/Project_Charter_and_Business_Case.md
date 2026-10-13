# Generative AI Customer Support Chatbot
## Project Charter & Business Case

**Project Type:** Business Analysis Portfolio Project  
**Organization:** NovaCart *(Fictional E-commerce Company)*  
**Role:** Business Analyst  
**Methodology:** Agile / Scrum  
**Project Status:** Simulated Portfolio Project

---

# 1. Project Overview

NovaCart is a fictional omnichannel e-commerce company experiencing high volumes of repetitive customer-support interactions.

Customers frequently contact support for simple questions such as order status, delivery information, return policies, cancellations, password assistance, and other frequently asked questions.

These repetitive interactions increase agent workload and customer waiting time, while support agents spend significant time handling queries that could potentially be resolved through self-service.

NovaCart therefore plans to introduce a **Generative AI Customer Support Chatbot** across its website and mobile application.

The chatbot will provide instant assistance for approved Tier-1 queries and will transfer complex or unsupported issues to human support agents.

The Business Analyst's role is to analyze the current support process, identify automation opportunities, gather and document requirements, define chatbot behavior, support Agile delivery, coordinate UAT, and establish KPIs for measuring business outcomes.

---

# 2. Business Problem

NovaCart's customer-support team is handling a significant volume of repetitive Tier-1 queries.

This creates several business challenges:

- High agent workload
- Longer customer response times
- Repetitive manual work
- Limited 24/7 self-service capability
- Increased operational cost
- Reduced availability of agents for complex customer issues

The business needs a scalable solution that can automate suitable customer interactions without compromising customer experience, accuracy, security, or human support.

### Business Question

> **How might NovaCart automate suitable repetitive Tier-1 customer-support interactions using Generative AI while maintaining response accuracy, customer satisfaction, security, and seamless human escalation?**

---

# 3. Project Objectives

The project aims to:

1. Reduce repetitive Tier-1 support workload.
2. Provide faster responses to common customer questions.
3. Enable 24/7 customer self-service.
4. Improve agent productivity by allowing agents to focus on complex cases.
5. Maintain or improve customer satisfaction.
6. Provide accurate, knowledge-grounded responses.
7. Provide seamless escalation to human agents when required.
8. Establish measurable KPIs for chatbot performance.

---

# 4. Success Criteria

The following targets are used as **simulated portfolio targets** for evaluating the proposed solution.

| KPI | Target |
|---|---:|
| Tier-1 Query Deflection | 25–35% |
| Chatbot Resolution Rate | ≥60% |
| Average Standard Response Time | <10 seconds |
| Human Escalation Rate | <30% |
| Chatbot CSAT | ≥80% |
| Knowledge-Grounded Responses for Supported FAQs | ≥95% |
| Availability | 24/7 |

These targets are illustrative and would be validated against actual business baselines during a real implementation.

---

# 5. Business Case

Assume NovaCart receives approximately **100,000 Tier-1 customer-support interactions per month**.

For this simulated business case:

- Average human handling cost = ₹70 per interaction
- Potential automation/deflection = 30%
- Potential automated interactions = 30,000 per month

### Illustrative Operational Value

**30,000 × ₹70 = ₹2.1 million monthly gross operational value**

Annualized:

**₹2.1 million × 12 = ₹25.2 million**

This is an illustrative business-case calculation rather than an actual financial result.

The primary business value is expected to come from:

- Reduced repetitive agent workload
- Faster customer responses
- Increased self-service
- Improved agent capacity for complex interactions
- 24/7 availability

---

# 6. Scope

## In Scope

The chatbot will support suitable Tier-1 customer-service scenarios including:

- Order status
- Delivery status and ETA
- Return and refund policy questions
- Return/refund status
- Cancellation eligibility
- Password-reset guidance
- Basic payment troubleshooting
- Frequently asked questions
- Account-support guidance
- Knowledge-base search
- Clarification questions
- Human-agent escalation
- CRM ticket creation
- Customer feedback
- Chatbot performance analytics

## Out of Scope

The following are outside the initial project scope:

- Fully autonomous complaint resolution
- Legal or medical advice
- Complex fraud investigations
- Autonomous policy exceptions
- High-value refund or replacement approvals
- Voice-based chatbot support
- Outbound customer communications
- Development of a foundation AI model

The chatbot will support human agents rather than completely replace them.

---

# 7. High-Level Solution

The proposed solution will consist of:

**Customer**

↓

**Web / Mobile Chat Interface**

↓

**Generative AI Chatbot**

↓

**Approved Knowledge Base**

**+**

**Order Management System**

**+**

**CRM**

↓

**Human Agent Handoff when Required**

↓

**Analytics & KPI Reporting**

The chatbot will provide approved information, retrieve authorized customer/order information, guide supported processes, ask clarification questions, and escalate unsupported or complex cases.

---

# 8. Key Business Rules

1. The chatbot must use approved business and knowledge-base information.
2. The chatbot must not invent policies or unsupported information.
3. Account-specific information requires appropriate customer verification.
4. Customers must have access to human support when the chatbot cannot appropriately resolve their issue.
5. Conversation history should be available to the human agent during escalation.
6. Complex or high-risk scenarios should remain human-led.
7. Customer data must be protected and only the minimum necessary information should be exposed.
8. System or API failures must result in a controlled fallback experience.

---

# 9. Key Risks

| Risk | Potential Impact |
|---|---|
| Incorrect or hallucinated responses | Customer dissatisfaction |
| Outdated knowledge base | Incorrect information |
| Incorrect customer/order information | Trust and operational risk |
| Poor intent recognition | Incorrect responses |
| API/system failure | Failed self-service |
| Data exposure | Security/privacy risk |
| Excessive escalation | Reduced automation benefit |
| Low customer adoption | Limited business value |

---

# 10. Business Analyst Responsibilities

As the Business Analyst, responsibilities include:

- Understand the business problem and objectives
- Identify and analyze stakeholders
- Analyze the current customer-support process
- Analyze historical support data
- Identify chatbot automation opportunities
- Gather and document business requirements
- Define functional and non-functional requirements
- Define chatbot intents and supported scenarios
- Design conversation and escalation flows
- Document integration requirements
- Create Agile user stories and acceptance criteria
- Maintain requirements traceability
- Support Jira backlog management
- Define UAT scenarios and test cases
- Analyze defects and support validation
- Define business KPIs
- Support rollout and post-launch analysis

---

# 11. Project Approach

The project follows a simplified Agile Business Analysis lifecycle:

**Business Problem**

↓

**Stakeholder Analysis**

↓

**As-Is Process & Data Analysis**

↓

**Requirements**

↓

**Solution Design**

↓

**Agile / Jira Delivery**

↓

**UAT**

↓

**Analytics & KPI Measurement**

↓

**Rollout & Continuous Improvement**

---

# 12. Key Assumptions

- NovaCart has an existing customer-support knowledge base.
- Order information is available through an existing system/API.
- CRM functionality is available for human-agent escalation.
- Historical support interaction data is available for analysis.
- Customers can be authenticated for account-specific requests.
- The project is initially limited to website and mobile-app support.

---

# 13. Project Constraints

- AI responses must remain within approved business knowledge.
- Sensitive customer information must be protected.
- Integration availability may affect chatbot functionality.
- Complex customer issues cannot be fully automated.
- Actual business baselines would need to be validated before production implementation.

---

# 14. Expected Outcome

The expected outcome is a clearly defined, measurable chatbot solution that can:

- Automate suitable Tier-1 support interactions
- Reduce repetitive workload
- Improve response speed
- Provide 24/7 self-service
- Maintain appropriate human escalation
- Improve agent capacity for complex issues
- Provide measurable chatbot performance through KPIs

This project demonstrates an end-to-end **Business Analyst approach to a Generative AI business solution**, rather than AI model development.

---

## Portfolio Disclaimer

This is a **simulated portfolio project created for demonstrating Business Analysis skills**.

Business volumes, financial calculations, KPI targets, stakeholder information, and implementation outcomes are illustrative and should not be represented as actual production results or employment experience.
