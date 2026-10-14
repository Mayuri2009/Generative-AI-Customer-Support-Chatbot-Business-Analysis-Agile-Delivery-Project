/*
Purpose:
1. Establish the pre-chatbot support baseline.
2. Identify automation opportunities.
3. Provide post-launch chatbot KPI queries.
4. Keep SQL aligned with KPI_Definitions.md.
*/

-- ================================================================
-- 1. DATA QUALITY CHECKS
-- ================================================================

SELECT COUNT(*) AS total_interactions
FROM support_interactions;

SELECT
    COUNT(*) FILTER (WHERE interaction_id IS NULL) AS null_interaction_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE interaction_date IS NULL) AS null_interaction_date,
    COUNT(*) FILTER (WHERE intent IS NULL) AS null_intent,
    COUNT(*) FILTER (WHERE resolution_status IS NULL) AS null_resolution_status,
    COUNT(*) FILTER (WHERE aht_minutes IS NULL) AS null_aht,
    COUNT(*) FILTER (WHERE escalated IS NULL) AS null_escalated
FROM support_interactions;

SELECT
    interaction_id,
    COUNT(*) AS duplicate_count
FROM support_interactions
GROUP BY interaction_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT DISTINCT channel
FROM support_interactions
ORDER BY channel;

SELECT DISTINCT intent
FROM support_interactions
ORDER BY intent;


-- ================================================================
-- 2. PRE-CHATBOT SUPPORT BASELINE
-- ================================================================

SELECT COUNT(*) AS total_support_interactions
FROM support_interactions;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS volume_percentage
FROM support_interactions
GROUP BY intent
ORDER BY interaction_volume DESC;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes
FROM support_interactions
GROUP BY intent
ORDER BY avg_aht_minutes DESC;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    COUNT(*) FILTER (WHERE escalated = TRUE) AS escalated_interactions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage
FROM support_interactions
GROUP BY intent
ORDER BY escalation_rate_percentage DESC;

SELECT
    intent,
    COUNT(csat) AS rated_interactions,
    ROUND(AVG(csat), 2) AS average_csat
FROM support_interactions
WHERE csat IS NOT NULL
GROUP BY intent
ORDER BY average_csat DESC;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    COUNT(*) FILTER (WHERE repeat_contact = TRUE) AS repeat_contacts,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE repeat_contact = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_contact_rate_percentage
FROM support_interactions
GROUP BY intent
ORDER BY repeat_contact_rate_percentage DESC;

SELECT
    channel,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(AVG(frt_seconds), 2) AS avg_frt_seconds,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(csat), 2) AS average_csat
FROM support_interactions
GROUP BY channel
ORDER BY interaction_volume DESC;


-- ================================================================
-- 3. AUTOMATION OPPORTUNITY ANALYSIS
-- ================================================================

WITH intent_metrics AS (
    SELECT
        intent,
        COUNT(*) AS interaction_volume,
        AVG(aht_minutes) AS avg_aht_minutes,
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
            / NULLIF(COUNT(*), 0) AS escalation_rate_percentage
    FROM support_interactions
    GROUP BY intent
),
ranked AS (
    SELECT
        *,
        NTILE(4) OVER (ORDER BY interaction_volume DESC) AS volume_quartile,
        NTILE(4) OVER (ORDER BY escalation_rate_percentage ASC) AS escalation_quartile,
        NTILE(4) OVER (ORDER BY avg_aht_minutes ASC) AS aht_quartile
    FROM intent_metrics
)
SELECT
    intent,
    interaction_volume,
    ROUND(avg_aht_minutes, 2) AS avg_aht_minutes,
    ROUND(escalation_rate_percentage, 2) AS escalation_rate_percentage,
    CASE
        WHEN volume_quartile = 1
         AND escalation_quartile IN (1, 2)
         AND aht_quartile IN (1, 2)
            THEN 'Strong Automation Candidate'
        WHEN volume_quartile IN (1, 2)
         AND escalation_quartile IN (1, 2, 3)
            THEN 'Review for Phase 2'
        ELSE 'Human-led / Further Analysis'
    END AS automation_recommendation
FROM ranked
ORDER BY interaction_volume DESC;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage
FROM support_interactions
WHERE intent IN (
    'Order Status',
    'Delivery ETA',
    'Return Policy',
    'Password Reset',
    'Product Information'
)
GROUP BY intent
ORDER BY interaction_volume DESC;

SELECT
    intent,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage
FROM support_interactions
WHERE intent IN ('Payment Issue', 'Complex Complaint')
GROUP BY intent
ORDER BY escalation_rate_percentage DESC;


-- ================================================================
-- 4. TIME-BASED BASELINE ANALYSIS
-- ================================================================

SELECT
    DATE_TRUNC('month', interaction_date)::date AS month,
    COUNT(*) AS interaction_volume
FROM support_interactions
GROUP BY 1
ORDER BY 1;

SELECT
    DATE_TRUNC('month', interaction_date)::date AS month,
    COUNT(*) AS interaction_volume,
    ROUND(AVG(aht_minutes), 2) AS avg_aht_minutes,
    ROUND(AVG(frt_seconds), 2) AS avg_frt_seconds,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(csat), 2) AS average_csat
FROM support_interactions
GROUP BY 1
ORDER BY 1;


-- ================================================================
-- 5. POST-LAUNCH CHATBOT KPIs
-- ================================================================
-- Assumes a chatbot_interactions table with:
-- interaction_id, customer_id, interaction_date, channel, intent,
-- session_status, resolved_by_bot, escalated, escalation_reason,
-- response_time_seconds, csat, repeat_contact, fallback_flag,
-- knowledge_grounded_flag, intent_correct_flag,
-- eligible_tier1_flag, system_failure_flag.

SELECT
    COUNT(*) AS total_chatbot_sessions
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (
        WHERE eligible_tier1_flag = TRUE
          AND resolved_by_bot = TRUE
          AND escalated = FALSE
    ) AS deflected_interactions,
    COUNT(*) FILTER (
        WHERE eligible_tier1_flag = TRUE
    ) AS eligible_tier1_interactions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE eligible_tier1_flag = TRUE
              AND resolved_by_bot = TRUE
              AND escalated = FALSE
        )
        / NULLIF(
            COUNT(*) FILTER (WHERE eligible_tier1_flag = TRUE),
            0
        ),
        2
    ) AS tier1_deflection_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (WHERE resolved_by_bot = TRUE) AS resolved_by_bot,
    COUNT(*) AS total_chatbot_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS chatbot_resolution_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (WHERE escalated = TRUE) AS escalated_sessions,
    COUNT(*) AS total_chatbot_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS human_escalation_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) AS response_count,
    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE response_time_seconds < 10)
        / NULLIF(COUNT(*), 0),
        2
    ) AS responses_under_10_seconds_percentage
FROM chatbot_interactions
WHERE response_time_seconds IS NOT NULL;

SELECT
    COUNT(csat) AS rated_sessions,
    ROUND(AVG(csat), 2) AS chatbot_average_csat
FROM chatbot_interactions
WHERE csat IS NOT NULL;

SELECT
    COUNT(*) FILTER (WHERE repeat_contact = TRUE) AS repeat_contacts,
    COUNT(*) AS total_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE repeat_contact = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_contact_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (WHERE knowledge_grounded_flag = TRUE) AS grounded_responses,
    COUNT(*) AS supported_responses,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE knowledge_grounded_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS knowledge_grounded_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (WHERE fallback_flag = TRUE) AS fallback_interactions,
    COUNT(*) AS total_chatbot_interactions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE fallback_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS fallback_rate_percentage
FROM chatbot_interactions;

SELECT
    COUNT(*) FILTER (WHERE intent_correct_flag = TRUE) AS correctly_identified_intents,
    COUNT(*) FILTER (WHERE intent_correct_flag IS NOT NULL) AS validated_intents,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE intent_correct_flag = TRUE)
        / NULLIF(
            COUNT(*) FILTER (WHERE intent_correct_flag IS NOT NULL),
            0
        ),
        2
    ) AS intent_recognition_accuracy_percentage
FROM chatbot_interactions;


-- ================================================================
-- 6. INTENT-LEVEL CHATBOT PERFORMANCE
-- ================================================================

SELECT
    intent,
    COUNT(*) AS sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(AVG(csat), 2) AS average_csat,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE fallback_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS fallback_rate_percentage
FROM chatbot_interactions
GROUP BY intent
ORDER BY sessions DESC;


-- ================================================================
-- 7. ESCALATION REASON ANALYSIS
-- ================================================================

SELECT
    COALESCE(escalation_reason, 'Not Specified') AS escalation_reason,
    COUNT(*) AS escalation_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS escalation_share_percentage
FROM chatbot_interactions
WHERE escalated = TRUE
GROUP BY COALESCE(escalation_reason, 'Not Specified')
ORDER BY escalation_count DESC;


-- ================================================================
-- 8. SYSTEM FAILURE ANALYSIS
-- ================================================================

SELECT
    COUNT(*) FILTER (WHERE system_failure_flag = TRUE) AS system_failure_sessions,
    COUNT(*) AS total_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE system_failure_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS system_failure_rate_percentage
FROM chatbot_interactions;


-- ================================================================
-- 9. DAILY CHATBOT PERFORMANCE
-- ================================================================

SELECT
    interaction_date::date AS interaction_day,
    COUNT(*) AS chatbot_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(AVG(csat), 2) AS average_csat
FROM chatbot_interactions
GROUP BY 1
ORDER BY 1;


-- ================================================================
-- 10. SIMULATED OPERATIONAL VALUE
-- ================================================================
-- Illustrative assumption from the business case: ₹70 average
-- human handling cost. This is NOT realized financial savings.

WITH assumptions AS (
    SELECT 70.00::numeric AS avg_human_handling_cost
),
deflection AS (
    SELECT
        COUNT(*) FILTER (
            WHERE eligible_tier1_flag = TRUE
              AND resolved_by_bot = TRUE
              AND escalated = FALSE
        ) AS avoided_human_interactions
    FROM chatbot_interactions
)
SELECT
    avoided_human_interactions,
    assumptions.avg_human_handling_cost,
    ROUND(
        avoided_human_interactions * assumptions.avg_human_handling_cost,
        2
    ) AS estimated_gross_operational_value
FROM deflection
CROSS JOIN assumptions;


-- ================================================================
-- 11. KPI SCORECARD FOR POWER BI
-- ================================================================

SELECT
    COUNT(*) AS total_chatbot_sessions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE eligible_tier1_flag = TRUE
              AND resolved_by_bot = TRUE
              AND escalated = FALSE
        )
        / NULLIF(
            COUNT(*) FILTER (WHERE eligible_tier1_flag = TRUE),
            0
        ),
        2
    ) AS tier1_deflection_rate_percentage,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS chatbot_resolution_rate_percentage,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS human_escalation_rate_percentage,

    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(AVG(csat), 2) AS chatbot_average_csat,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE fallback_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS fallback_rate_percentage,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE knowledge_grounded_flag = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS knowledge_grounded_rate_percentage

FROM chatbot_interactions;


-- ================================================================
-- 12. POWER BI DATASET — INTENT PERFORMANCE
-- ================================================================

SELECT
    intent,
    COUNT(*) AS sessions,
    COUNT(*) FILTER (WHERE resolved_by_bot = TRUE) AS resolved_sessions,
    COUNT(*) FILTER (WHERE escalated = TRUE) AS escalated_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(AVG(csat), 2) AS average_csat
FROM chatbot_interactions
GROUP BY intent
ORDER BY sessions DESC;


-- ================================================================
-- 13. POWER BI DATASET — DAILY TREND
-- ================================================================

SELECT
    interaction_date::date AS interaction_day,
    COUNT(*) AS sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_rate_percentage,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0),
        2
    ) AS escalation_rate_percentage,
    ROUND(AVG(response_time_seconds), 2) AS avg_response_time_seconds,
    ROUND(AVG(csat), 2) AS average_csat
FROM chatbot_interactions
GROUP BY interaction_date::date
ORDER BY interaction_day;


-- ================================================================
-- 14. KPI TARGET CHECK
-- ================================================================
-- Portfolio targets:
-- Tier-1 deflection: 25–35%
-- Chatbot resolution: >= 60%
-- Standard response time: < 10 seconds
-- Human escalation: < 30%
-- Chatbot CSAT: >= 80%
-- Knowledge-grounded responses: >= 95%

WITH kpi AS (
    SELECT
        100.0 * COUNT(*) FILTER (
            WHERE eligible_tier1_flag = TRUE
              AND resolved_by_bot = TRUE
              AND escalated = FALSE
        )
        / NULLIF(
            COUNT(*) FILTER (WHERE eligible_tier1_flag = TRUE),
            0
        ) AS deflection_rate,

        100.0 * COUNT(*) FILTER (WHERE resolved_by_bot = TRUE)
        / NULLIF(COUNT(*), 0) AS resolution_rate,

        AVG(response_time_seconds) AS avg_response_time,

        100.0 * COUNT(*) FILTER (WHERE escalated = TRUE)
        / NULLIF(COUNT(*), 0) AS escalation_rate,

        AVG(csat) AS csat,

        100.0 * COUNT(*) FILTER (WHERE knowledge_grounded_flag = TRUE)
        / NULLIF(COUNT(*), 0) AS grounded_rate

    FROM chatbot_interactions
)
SELECT
    ROUND(deflection_rate, 2) AS deflection_rate_percentage,
    CASE
        WHEN deflection_rate BETWEEN 25 AND 35 THEN 'On Target'
        WHEN deflection_rate < 25 THEN 'Below Target'
        ELSE 'Above Target'
    END AS deflection_status,

    ROUND(resolution_rate, 2) AS resolution_rate_percentage,
    CASE
        WHEN resolution_rate >= 60 THEN 'On Target'
        ELSE 'Below Target'
    END AS resolution_status,

    ROUND(avg_response_time, 2) AS avg_response_time_seconds,
    CASE
        WHEN avg_response_time < 10 THEN 'On Target'
        ELSE 'Below Target'
    END AS response_time_status,

    ROUND(escalation_rate, 2) AS escalation_rate_percentage,
    CASE
        WHEN escalation_rate < 30 THEN 'On Target'
        ELSE 'Above Target'
    END AS escalation_status,

    ROUND(csat, 2) AS average_csat,
    CASE
        WHEN csat >= 80 THEN 'On Target'
        ELSE 'Below Target'
    END AS csat_status,

    ROUND(grounded_rate, 2) AS knowledge_grounded_rate_percentage,
    CASE
        WHEN grounded_rate >= 95 THEN 'On Target'
        ELSE 'Below Target'
    END AS knowledge_grounding_status

FROM kpi;


-- ================================================================
-- 15. BA ANALYTICS INTERPRETATION
-- ================================================================
-- High adoption + low resolution:
-- Investigate conversation flow, intent recognition, integrations,
-- and knowledge coverage.
--
-- High resolution + low CSAT:
-- Review customer experience, response clarity, and unnecessary
-- conversation steps.
--
-- High escalation for one intent:
-- Assess whether the intent is suitable for automation or requires
-- better integration, business rules, or knowledge.
--
-- High fallback rate:
-- Review intent taxonomy, training examples, ambiguous language,
-- and knowledge coverage.
--
-- Critical security or guardrail failures:
-- Treat as release-blocking regardless of overall KPI performance.
