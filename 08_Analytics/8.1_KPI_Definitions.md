# KPI Definitions

## 1. Purpose

This document defines the key performance indicators used to evaluate
the simulated NovaCart Generative-AI Customer Support Chatbot.

The KPIs connect the solution to the business objectives defined during
project initiation and provide a consistent basis for post-launch
monitoring.

> **Portfolio Disclaimer:** NovaCart is a fictional company and all
> targets, calculations, and results in this portfolio project are
> simulated for demonstration purposes.

------------------------------------------------------------------------

## 2. KPI Framework

The KPI framework is grouped into six areas:

1.  **Adoption & Volume** --- Is the chatbot being used?
2.  **Automation & Resolution** --- Is it successfully resolving
    supported queries?
3.  **Customer Experience** --- Are customers satisfied?
4.  **Operational Efficiency** --- Is it reducing support effort and
    improving speed?
5.  **AI Quality & Safety** --- Is it responding accurately and safely?
6.  **Reliability & Escalation** --- Does it hand off appropriately when
    needed?

------------------------------------------------------------------------

## 3. Core KPIs

  ----------------------------------------------------------------------------------------------
  KPI ID      KPI                  Definition     Formula        Target /     Business Objective
                                                                 Benchmark    
  ----------- -------------------- -------------- -------------- ------------ ------------------
  KPI-001     Chatbot Adoption     Percentage of  Chatbot        Monitor      Improve
              Rate                 eligible       Interactions ÷ trend        self-service
                                   support        Eligible                    
                                   interactions   Support                     
                                   handled        Interactions ×              
                                   through the    100                         
                                   chatbot                                    

  KPI-002     Tier-1 Deflection    Percentage of  Eligible       25--35%      Reduce repetitive
              Rate                 eligible       Interactions                support workload
                                   Tier-1         Resolved by                 
                                   interactions   Bot ÷ Eligible              
                                   resolved       Tier-1                      
                                   without        Interactions ×              
                                   human-agent    100                         
                                   involvement                                

  KPI-003     Chatbot Resolution   Percentage of  Resolved       ≥60%         Improve
              Rate                 chatbot        Chatbot                     self-service
                                   sessions       Sessions ÷                  
                                   resolved       Total Chatbot               
                                   without        Sessions × 100              
                                   escalation                                 

  KPI-004     Human Escalation     Percentage of  Escalated      \<30%        Reduce avoidable
              Rate                 chatbot        Sessions ÷                  agent workload
                                   sessions       Total Chatbot               
                                   transferred to Sessions × 100              
                                   a human agent                              

  KPI-005     Average Response     Average time   Total Response \<10 seconds Improve response
              Time                 taken by the   Seconds ÷      for standard time
                                   chatbot to     Number of      responses    
                                   provide a      Responses                   
                                   standard                                   
                                   response                                   

  KPI-006     Chatbot CSAT         Average        Sum of Chatbot ≥80%         Maintain/improve
                                   customer       CSAT Scores ÷               customer
                                   satisfaction   Number of                   satisfaction
                                   score for      Rated Sessions              
                                   chatbot                                    
                                   interactions                               

  KPI-007     Repeat Contact Rate  Percentage of  Repeat         Downward     Improve
                                   customers who  Contacts ÷     trend        first-contact
                                   contact        Total Resolved              resolution
                                   support again  Interactions ×              
                                   for the same   100                         
                                   or related                                 
                                   issue within                               
                                   the defined                                
                                   observation                                
                                   window                                     

  KPI-008     Knowledge-Grounded   Percentage of  Grounded       ≥95%         Improve response
              Response Rate        supported      Supported                   accuracy
                                   responses      Responses ÷                 
                                   successfully   Total                       
                                   grounded in    Supported                   
                                   approved       Responses ×                 
                                   knowledge      100                         
                                   sources                                    

  KPI-009     Fallback Rate        Percentage of  Fallback       Monitor;     Improve
                                   chatbot        Interactions ÷ reduce over  intent/response
                                   interactions   Total Chatbot  time         quality
                                   where the      Interactions ×              
                                   system cannot  100                         
                                   confidently                                
                                   answer and                                 
                                   uses a                                     
                                   fallback or                                
                                   escalation                                 
                                   path                                       

  KPI-010     Intent Recognition   Percentage of  Correct Intent Monitor      Improve AI
              Accuracy             test or        Predictions ÷  against UAT  usability
                                   validated      Validated      benchmark    
                                   interactions   Intent Cases ×              
                                   where the      100                         
                                   chatbot                                    
                                   identifies the                             
                                   correct intent                             

  KPI-011     UAT Pass Rate        Percentage of  Passed Test    ≥95% for     Support quality
                                   executed UAT   Cases ÷        release      and release
                                   test cases     Executed Test  readiness    confidence
                                   that pass      Cases × 100                 

  KPI-012     Critical Defect Rate Number or      Critical       0 unresolved Reduce release
                                   percentage of  Defects ÷      at release   risk
                                   critical       Total Defects               
                                   defects        × 100                       
                                   identified                                 
                                   during UAT                                 
  ----------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## 4. Supporting KPIs

### 4.1 Volume & Adoption

**Chatbot Sessions** - Total number of chatbot sessions during the
reporting period. - Used as the denominator for several chatbot
performance metrics.

**Chatbot Interaction Volume by Intent** - Number of chatbot
interactions for each intent. - Helps identify which use cases are
driving adoption.

**Channel Adoption** - Chatbot usage split by channel, such as website
and mobile app. - Useful for identifying channel-specific behavior.

### 4.2 Resolution & Escalation

**Resolution Rate by Intent** - Measures chatbot resolution separately
for Order Status, Delivery ETA, Return Policy, Password Reset and
Product Information. - Helps identify weak-performing intents hidden by
the overall average.

**Escalation Rate by Intent** - Measures the percentage of sessions
escalated for each intent. - High escalation can indicate poor intent
recognition, missing knowledge, integration problems, or an unsuitable
automation candidate.

**Fallback Rate by Intent** - Shows where the chatbot most frequently
fails to provide a confident answer.

### 4.3 Customer Experience

**CSAT by Intent** - Compares satisfaction across chatbot use cases. - A
high overall CSAT can hide poor performance in a specific intent.

**Negative Feedback Rate** - Percentage of chatbot feedback responses
categorized as negative. - Used as an early-warning indicator for
customer experience issues.

### 4.4 Operational Efficiency

**Average Handling Time --- Baseline** - Average human support handling
time before chatbot deployment. - Used as a baseline for estimating
operational impact.

**Average Handling Time --- Post-Launch** - Average human handling time
after chatbot deployment. - Used to assess whether agent workload
changes after automation.

**Estimated Agent Interactions Avoided** - Estimated number of eligible
interactions resolved through self-service instead of human support. -
Used for operational capacity analysis.

**Estimated Gross Operational Value** - Illustrative value created by
avoided human handling. - Formula:
`Estimated Agent Interactions Avoided × Average Human Handling Cost`

This is a simulated business-case metric and should not be presented as
realized financial savings.

------------------------------------------------------------------------

## 5. KPI Calculation Rules

To keep reporting consistent:

1.  Define the reporting period before calculating KPIs.
2.  Use only eligible interactions for deflection calculations.
3.  Exclude test/internal sessions from production performance metrics.
4.  Do not treat an immediate escalation as a chatbot resolution.
5.  A session is considered resolved only when the defined resolution
    criteria are satisfied.
6.  CSAT should only be calculated from valid customer feedback
    responses.
7.  Response-time calculations should use the agreed system timestamp
    fields.
8.  Intent-level KPIs should use the final validated intent
    classification.
9.  Failed integrations and system outages should be separately
    identified rather than silently classified as customer failures.
10. KPI definitions should remain consistent across SQL and Power BI.

------------------------------------------------------------------------

## 6. Suggested Dashboard Structure

### Page 1 --- Executive Overview

Display: - Chatbot Adoption Rate - Tier-1 Deflection Rate - Chatbot
Resolution Rate - Human Escalation Rate - Chatbot CSAT - Average
Response Time - Total Chatbot Sessions

Purpose: \> Give leadership a quick view of whether the chatbot is
delivering the intended business outcomes.

### Page 2 --- Intent Performance

Display: - Volume by intent - Resolution rate by intent - Escalation
rate by intent - CSAT by intent - Fallback rate by intent

Purpose: \> Identify which customer journeys perform well and which
require improvement.

### Page 3 --- Operational Performance

Display: - Daily/weekly interaction volume - Response-time trend - Human
escalation trend - Estimated interactions avoided - Baseline vs
post-launch operational metrics where available

Purpose: \> Evaluate workload and efficiency impact.

### Page 4 --- AI Quality & UAT

Display: - Knowledge-grounded response rate - Intent recognition
accuracy - Fallback rate - UAT pass rate - Defect severity/status -
Critical unresolved defects

Purpose: \> Monitor quality, safety, and release readiness.

------------------------------------------------------------------------

## 7. KPI-to-Objective Traceability

  -----------------------------------------------------------------------
  Business Objective                  Primary KPIs
  ----------------------------------- -----------------------------------
  Reduce repetitive support workload  Tier-1 Deflection Rate, Estimated
                                      Interactions Avoided

  Improve response time               Average Response Time

  Improve self-service                Chatbot Adoption Rate, Chatbot
                                      Resolution Rate

  Provide 24/7 support                Chatbot Sessions, Availability

  Maintain/improve CSAT               Chatbot CSAT, Negative Feedback
                                      Rate

  Improve agent productivity          Estimated Interactions Avoided,
                                      Human Escalation Rate

  Maintain response accuracy          Knowledge-Grounded Response Rate,
                                      Intent Recognition Accuracy

  Ensure effective human handoff      Human Escalation Rate, Escalation
                                      Rate by Intent

  Maintain quality and release        UAT Pass Rate, Critical Defect Rate
  confidence                          
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 8. BA Interpretation Examples

A BA should not only report KPI values but interpret what they mean.

**Example 1 --- High adoption, low resolution** \> Customers are using
the chatbot, but a large percentage still require human support. I would
analyze intent-level escalation, fallback reasons, and knowledge
coverage before expanding the chatbot scope.

**Example 2 --- Good resolution, low CSAT** \> The chatbot may be
resolving transactions but creating a poor customer experience. I would
review conversation flow, response clarity, unnecessary steps, and
customer feedback.

**Example 3 --- High escalation for one intent** \> I would investigate
whether the intent is too complex for automation, whether the required
API is unreliable, or whether the knowledge base is incomplete.

**Example 4 --- High fallback rate** \> I would review intent taxonomy,
training examples, ambiguous customer language, and knowledge coverage
before assuming that the model itself is the problem.

------------------------------------------------------------------------

## 9. Reporting Cadence

  -----------------------------------------------------------------------
  Reporting Level   Frequency         Audience          Focus
  ----------------- ----------------- ----------------- -----------------
  Operational       Daily             Support           Volume,
  Monitoring                          Operations,       escalation,
                                      Product, Data/BI  response time,
                                                        failures

  Performance       Weekly            Product, BA,      Resolution, CSAT,
  Review                              Support Manager   intent
                                                        performance

  Business Review   Monthly           Operations        Deflection,
                                      Leadership,       workload impact,
                                      Product, Finance  business value

  Quality Review    Sprint / Release  BA, QA, AI/ML,    UAT, defects,
                                      Engineering       accuracy,
                                                        guardrails
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 10. Data Sources

The analytics layer may use:

-   Chatbot interaction logs
-   Intent classification results
-   Knowledge-base retrieval logs
-   Order-management API response logs
-   CRM/ticketing records
-   Customer feedback / CSAT
-   UAT test results
-   Defect log
-   Existing support interaction data
-   Power BI semantic model

For this portfolio project, the underlying data is synthetic/simulated.

------------------------------------------------------------------------

## 11. BA Ownership

The Business Analyst is responsible for ensuring that:

-   KPIs are aligned with approved business objectives.
-   Definitions are understood by stakeholders.
-   KPI formulas are consistent across SQL and Power BI.
-   Business rules are reflected in calculations.
-   Data quality issues are identified and documented.
-   KPI exceptions are investigated with relevant teams.
-   Dashboard requirements remain traceable to business needs.
-   Changes to KPI definitions are documented and approved.

------------------------------------------------------------------------

## 12. Interview Takeaway

> "For the analytics stage, I translated the business objectives into
> measurable KPIs covering adoption, deflection, resolution, escalation,
> response time, CSAT, AI quality and operational impact. I also defined
> the calculation rules and traceability so the same KPI definitions
> could be implemented consistently in PostgreSQL and visualized in
> Power BI."
