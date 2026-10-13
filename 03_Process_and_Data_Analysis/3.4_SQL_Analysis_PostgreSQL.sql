
-- ============================================================
-- 0. CREATE TABLE
-- ============================================================
-- Create this table after loading the synthetic dataset into
-- PostgreSQL.

CREATE TABLE IF NOT EXISTS support_interactions (
    interaction_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    interaction_date DATE,
    channel VARCHAR(20),
    intent VARCHAR(50),
    sub_intent VARCHAR(100),
    agent_id VARCHAR(20),
    resolution_status VARCHAR(30),
    aht_minutes NUMERIC(6,2),
    frt_seconds INTEGER,
    escalated VARCHAR(5),
    csat INTEGER,
    repeat_contact VARCHAR(5),
    resolution_code VARCHAR(50)
);


-- ============================================================
-- 1. TOTAL SUPPORT VOLUME
-- Business Question:
-- How many customer-support interactions were received?
-- ============================================================

SELECT
    COUNT(*) AS total_interactions
FROM support_interactions;


-- ============================================================
-- 2. SUPPORT VOLUME BY INTENT
-- Business Question:
-- What are the most common reasons customers contact support?
-- ============================================================

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS volume_percentage
FROM support_interactions
GROUP BY intent
ORDER BY interaction_volume DESC;


-- ============================================================
-- 3. AVERAGE HANDLING TIME BY INTENT
-- Business Question:
-- Which customer issues consume the most agent time?
-- ============================================================

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(
        SUM(aht_minutes),
        2
    ) AS total_agent_minutes
FROM support_interactions
GROUP BY intent
ORDER BY total_agent_minutes DESC;


-- ============================================================
-- 4. ESCALATION RATE BY INTENT
-- Business Question:
-- Which intents are more likely to require human escalation?
-- ============================================================

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    COUNT(*) FILTER (WHERE escalated = 'Yes') AS escalated_interactions,
    ROUND(
        COUNT(*) FILTER (WHERE escalated = 'Yes') * 100.0
        / COUNT(*),
        2
    ) AS escalation_rate_percentage
FROM support_interactions
GROUP BY intent
ORDER BY escalation_rate_percentage DESC;


-- ============================================================
-- 5. CSAT BY INTENT
-- Business Question:
-- Which customer issues have stronger or weaker satisfaction?
-- ============================================================

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(csat), 2) AS avg_csat
FROM support_interactions
GROUP BY intent
ORDER BY avg_csat DESC;


-- ============================================================
-- 6. REPEAT CONTACT RATE BY INTENT
-- Business Question:
-- Which issues are more likely to cause customers to contact
-- support again?
-- ============================================================

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    COUNT(*) FILTER (WHERE repeat_contact = 'Yes')
        AS repeat_contacts,
    ROUND(
        COUNT(*) FILTER (WHERE repeat_contact = 'Yes') * 100.0
        / COUNT(*),
        2
    ) AS repeat_contact_rate_percentage
FROM support_interactions
GROUP BY intent
ORDER BY repeat_contact_rate_percentage DESC;


-- ============================================================
-- 7. CHANNEL PERFORMANCE
-- Business Question:
-- How does support volume and performance vary by channel?
-- ============================================================

SELECT
    channel,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(AVG(frt_seconds), 2) AS avg_frt_seconds,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(
        COUNT(*) FILTER (WHERE escalated = 'Yes') * 100.0
        / COUNT(*),
        2
    ) AS escalation_rate_percentage
FROM support_interactions
GROUP BY channel
ORDER BY interaction_volume DESC;


-- ============================================================
-- 8. POTENTIAL AUTOMATION CANDIDATES
-- Business Question:
-- Which high-volume intents have relatively low escalation
-- and therefore appear suitable for chatbot automation?
--
-- Portfolio rule:
-- Volume >= 5% of total interactions
-- AND escalation rate <= 15%
-- ============================================================

WITH intent_metrics AS (
    SELECT
        intent,
        COUNT(*) AS interaction_volume,
        ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
        ROUND(
            COUNT(*) FILTER (WHERE escalated = 'Yes') * 100.0
            / COUNT(*),
            2
        ) AS escalation_rate_percentage
    FROM support_interactions
    GROUP BY intent
),
total_volume AS (
    SELECT COUNT(*) AS total_interactions
    FROM support_interactions
)
SELECT
    im.intent,
    im.interaction_volume,
    ROUND(
        im.interaction_volume * 100.0 / tv.total_interactions,
        2
    ) AS volume_percentage,
    im.avg_aht_minutes,
    im.escalation_rate_percentage,
    'MVP - Automate' AS recommendation
FROM intent_metrics im
CROSS JOIN total_volume tv
WHERE im.interaction_volume * 100.0 / tv.total_interactions >= 5
  AND im.escalation_rate_percentage <= 15
ORDER BY im.interaction_volume DESC;


-- ============================================================
-- 9. HIGH-RISK / HUMAN-LED INTENTS
-- Business Question:
-- Which intents should remain primarily human-led because of
-- high escalation and/or high handling time?
-- ============================================================

WITH intent_metrics AS (
    SELECT
        intent,
        COUNT(*) AS interaction_volume,
        ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
        ROUND(
            COUNT(*) FILTER (WHERE escalated = 'Yes') * 100.0
            / COUNT(*),
            2
        ) AS escalation_rate_percentage
    FROM support_interactions
    GROUP BY intent
)
SELECT
    intent,
    interaction_volume,
    avg_aht_minutes,
    escalation_rate_percentage,
    'Human-led / Phase 2 review' AS recommendation
FROM intent_metrics
WHERE escalation_rate_percentage >= 25
   OR avg_aht_minutes >= 8
ORDER BY escalation_rate_percentage DESC, avg_aht_minutes DESC;


-- ============================================================
-- 10. FINAL AUTOMATION OPPORTUNITY SCORECARD
-- Business Question:
-- How should the BA prioritize chatbot candidates?
--
-- Simple portfolio scoring:
-- +2 = High volume
-- +2 = Low escalation
-- +1 = Lower handling time
--
-- Higher score = stronger initial automation candidate.
-- ============================================================

WITH intent_metrics AS (
    SELECT
        intent,
        COUNT(*) AS interaction_volume,
        ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
        ROUND(
            COUNT(*) FILTER (WHERE escalated = 'Yes') * 100.0
            / COUNT(*),
            2
        ) AS escalation_rate_percentage
    FROM support_interactions
    GROUP BY intent
),
scored AS (
    SELECT
        intent,
        interaction_volume,
        avg_aht_minutes,
        escalation_rate_percentage,
        CASE
            WHEN interaction_volume >= 5000 THEN 2
            WHEN interaction_volume >= 2500 THEN 1
            ELSE 0
        END AS volume_score,
        CASE
            WHEN escalation_rate_percentage <= 10 THEN 2
            WHEN escalation_rate_percentage <= 20 THEN 1
            ELSE 0
        END AS escalation_score,
        CASE
            WHEN avg_aht_minutes <= 5 THEN 1
            ELSE 0
        END AS efficiency_score
    FROM intent_metrics
)
SELECT
    intent,
    interaction_volume,
    avg_aht_minutes,
    escalation_rate_percentage,
    volume_score,
    escalation_score,
    efficiency_score,
    volume_score + escalation_score + efficiency_score
        AS automation_score,
    CASE
        WHEN volume_score + escalation_score + efficiency_score >= 4
            THEN 'MVP - Automate'
        WHEN volume_score + escalation_score + efficiency_score >= 2
            THEN 'Consider for Phase 2'
        ELSE 'Human-led'
    END AS recommendation
FROM scored
ORDER BY automation_score DESC, interaction_volume DESC;


-- ============================================================
-- BA INSIGHT
-- ============================================================
-- The purpose of these queries is not simply to report numbers.
-- The analysis should support a business decision:
--
-- High volume + low escalation + manageable AHT
--             -> Strong chatbot candidate
--
-- Medium volume / moderate complexity
--             -> Consider for Phase 2
--
-- High escalation / high AHT / complex issue
--             -> Keep human-led
--
-- This analysis becomes the evidence for the chatbot MVP scope.
-- ============================================================
