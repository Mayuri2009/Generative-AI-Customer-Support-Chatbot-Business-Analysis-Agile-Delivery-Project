# Chatbot Design

## 1. Purpose

This document defines the business and functional design of the NovaCart Generative-AI Customer Support Chatbot.

The chatbot is designed to automate suitable Tier-1 customer support interactions, provide fast self-service, and transfer complex or sensitive cases to human support agents.

The solution design is based on the requirements and opportunity analysis completed in the earlier project stages.

> **Portfolio Note:** NovaCart is a fictional company and this is a simulated Business Analyst project.

---

## 2. Solution Overview

The proposed solution uses a Generative-AI-powered customer support chatbot connected to approved business information sources and selected customer-service systems.

The chatbot should:

- Understand customer intent.
- Ask clarifying questions when required.
- Retrieve information from approved knowledge sources.
- Retrieve authorized customer/order information when required.
- Provide concise and relevant responses.
- Recognize when it cannot safely resolve a request.
- Escalate appropriate cases to a human support agent.
- Capture interaction data for KPI and performance analysis.

### High-Level Solution Flow

**Customer → Chatbot → Intent Identification → Knowledge Base / Business System → Response → Resolution or Human Handoff**

---

## 3. MVP Scope

The chatbot MVP focuses on high-volume, lower-complexity support interactions identified during the Process and Data Analysis stage.

### MVP — Supported Intents

| Intent | Example Customer Query | Primary Source |
|---|---|---|
| Order Status | "Where is my order?" | Order Management System |
| Delivery ETA | "When will my order arrive?" | Order Management System |
| Return Policy | "Can I return this product?" | Knowledge Base |
| Password Reset | "I forgot my password." | Authentication / Help Content |
| Product Information | "What are the features of this product?" | Knowledge Base |

### Phase 2

- Refund Status
- Cancellation
- Account Support

### Human-Led Initially

- Payment Issue
- Complex Complaint

These cases may require additional integrations, investigation, authorization, or human judgment.

---

## 4. Chatbot Behavior

The chatbot should follow a consistent conversation pattern:

1. Greet the customer.
2. Understand the customer's intent.
3. Identify required information or entities.
4. Ask for missing information.
5. Authenticate the customer when account-specific information is required.
6. Retrieve information from the appropriate approved source.
7. Provide a clear response.
8. Confirm whether the customer needs further assistance.
9. Resolve and close the conversation or initiate human handoff.

---

## 5. Conversation Logic

### Step 1 — Customer Message

The customer enters a question or request through the website or mobile application.

### Step 2 — Intent Identification

The chatbot identifies the most likely customer intent.

Example:

> "Where is my package?"

Intent → **Order Status**

### Step 3 — Check Required Information

The chatbot determines whether the information needed to answer the request is available.

Example:

> "Where is my order?"

If the order number is missing:

> "Sure, I can help with that. Please provide your order number."

### Step 4 — Authentication

Authentication is required when the request involves protected or account-specific information.

Examples:

- Order-specific information
- Account information
- Refund information
- Other protected customer data

Only the minimum necessary information should be exposed.

### Step 5 — Information Retrieval

The chatbot retrieves information from the appropriate approved source.

Examples:

- Policy question → Knowledge Base
- Order status → Order Management System
- Password reset → Authentication / approved help content

### Step 6 — Response

The chatbot provides a concise customer-facing response.

Example:

> "Your order is currently in transit and is expected to arrive tomorrow."

### Step 7 — Resolution Check

The chatbot asks whether the customer's issue has been resolved.

If yes:

**Conversation → Close**

If no:

**Conversation → Human Handoff**

---

## 6. Human Handoff Rules

The chatbot should provide a human-support option when:

- The customer explicitly requests an agent.
- The chatbot cannot confidently identify the customer's intent.
- The customer repeatedly provides unclear information.
- The request involves a complex complaint.
- The issue requires human investigation.
- The request involves sensitive or high-risk activity.
- A required business system is unavailable.
- The chatbot cannot provide a reliable answer.
- The customer is dissatisfied with the chatbot response.

### Handoff Information

When transferring the conversation, the system should pass useful context to the agent, including:

- Customer conversation history
- Identified intent
- Relevant order/reference information
- Previous chatbot responses
- Reason for escalation
- Relevant system or error information

This reduces the need for the customer to repeat the issue.

---

## 7. Knowledge Base Behavior

The chatbot should use approved and maintained knowledge sources for policy and FAQ responses.

Examples:

- Return policy
- Delivery policy
- Product information
- Password-reset guidance
- Frequently asked questions

### Knowledge Rules

The chatbot must:

- Use approved knowledge sources.
- Prefer current and maintained information.
- Avoid unsupported claims.
- Avoid inventing policies or product information.
- Escalate when required information is unavailable or uncertain.

---

## 8. AI Guardrails

The chatbot should operate within defined business and safety rules.

### Guardrail 1 — No Unsupported Information

The chatbot must not invent:

- Policies
- Prices
- Delivery commitments
- Refund eligibility
- Order information
- Product specifications

### Guardrail 2 — Customer Data Protection

Protected customer information should only be provided after appropriate verification.

### Guardrail 3 — Human Decision Making

The chatbot should not independently make decisions involving:

- High-value refunds
- Compensation
- Policy exceptions
- Complex fraud investigations
- Complex complaints
- Other high-risk business decisions

### Guardrail 4 — Low Confidence

If the chatbot cannot confidently understand or answer the customer's request, it should:

1. Ask a clarification question.
2. Attempt to understand the request again.
3. Escalate to a human if the issue remains unresolved.

### Guardrail 5 — System Failure

If an integrated system is unavailable, the chatbot should not provide potentially incorrect information.

Instead, it should communicate the limitation and provide an appropriate fallback or human handoff.

---

## 9. Integration Touchpoints

The chatbot may interact with the following business systems:

| System | Purpose |
|---|---|
| Knowledge Base | Policies, FAQs and product information |
| Order Management System | Order status and delivery information |
| Authentication Service | Customer verification |
| CRM / Support Platform | Human handoff and case creation |
| Analytics Platform | Interaction and KPI reporting |

The Business Analyst focuses on defining the business requirement and expected behavior of these integrations rather than designing the underlying technical architecture.

---

## 10. Error and Fallback Handling

| Scenario | Expected Behavior |
|---|---|
| Missing order number | Ask customer for order number |
| Intent unclear | Ask clarification question |
| Intent remains unclear | Offer human support |
| Knowledge not available | Do not guess; escalate or provide fallback |
| Order system unavailable | Inform customer and offer human support |
| Authentication unsuccessful | Do not expose protected information |
| Complex complaint | Escalate to human agent |
| Customer requests agent | Initiate human handoff |
| Customer dissatisfied | Offer human support |

---

## 11. Example Conversations

### Example 1 — Order Status

**Customer:** Where is my order?

**Bot:** I can help you check your order status. Please provide your order number.

**Customer:** NC123456.

**Bot:** Your order is currently in transit and is expected to arrive tomorrow.

**Bot:** Is there anything else I can help you with?

**Customer:** No.

**Bot:** You're all set. Have a great day!

---

### Example 2 — Return Policy

**Customer:** Can I return a product?

**Bot:** Yes. I can help you with NovaCart's return policy. Returns are subject to the conditions listed in our current return policy.

**Bot:** Would you like information about the general return policy or help with a specific order?

If the customer asks about a specific order, the chatbot follows the appropriate authentication and order-specific workflow.

---

### Example 3 — Unclear Intent

**Customer:** My order is wrong.

**Bot:** I can help. Are you asking about an incorrect item, a damaged item, or something else about your order?

If the customer remains unclear:

**Bot:** I want to make sure I get this right. I can connect you with a support agent who can assist further.

→ **Human Handoff**

---

### Example 4 — Complex Complaint

**Customer:** I've received the wrong product three times and I want compensation.

**Bot:** I'm sorry you've had to deal with this repeatedly. This issue requires support from a customer service specialist. I'll connect you with an agent and provide them with the conversation details.

→ **Human Handoff**

---

## 12. Success Criteria

The solution should be evaluated against the following business targets defined during project initiation:

| KPI | Target |
|---|---:|
| Tier-1 Query Deflection | 25–35% |
| Chatbot Resolution Rate | ≥60% |
| Standard Response Time | <10 seconds |
| Human Escalation Rate | <30% |
| Chatbot CSAT | ≥80% |
| Knowledge-Grounded Responses | ≥95% for supported FAQ scenarios |
| Availability | 24/7, subject to service availability |

These are **simulated portfolio targets**, not actual NovaCart production results.

---

## 13. Key BA Decisions

The following decisions were made based on requirements and opportunity analysis:

1. Start with high-volume, lower-complexity support interactions.
2. Keep complex and high-risk cases human-led.
3. Use approved knowledge sources for customer-facing information.
4. Require appropriate authentication for protected customer data.
5. Provide human handoff as a core capability rather than an exception.
6. Capture conversation and outcome data for analytics.
7. Design clear fallback behavior for low-confidence and system-failure scenarios.
8. Keep the MVP focused before expanding into more complex workflows.

---

## 14. BA Assumptions

- NovaCart has an existing customer support platform.
- Order information is available through an authorized system/API.
- A maintained knowledge base exists or can be established.
- Customer authentication is available.
- CRM integration is available for human handoff.
- Required analytics data can be captured.
- Business owners will review and approve chatbot knowledge content.
- Policies and knowledge content will be governed and periodically reviewed.

---

## 15. Next Design Artifacts

The next solution-design artifacts will convert this business design into visual process documentation:

- **Conversation_Flow.png** — customer-to-chatbot conversation logic.
- **To_Be_Process.png** — future-state customer support process.

These diagrams will provide the bridge between the requirements and the later Agile, UAT, and analytics stages.
