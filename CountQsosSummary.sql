-- Summary: counts of QSOs for today, this week and this month
-- MySQL-compatible. Adjust WEEK mode if your week-start differs.

SELECT
    SUM(
        CASE
            WHEN qsodate = CURRENT_DATE THEN 1
            ELSE 0
        END
    ) AS today,
    SUM(
        CASE
            WHEN qsodate = CURRENT_DATE -1 THEN 1
            ELSE 0
        END
    ) AS yesterday,
    SUM(
        CASE
            WHEN YEARWEEK(qsodate) >= YEARWEEK(CURRENT_DATE) THEN 1
            ELSE 0
        END
    ) AS this_week,
    SUM(
        CASE
            WHEN YEAR(qsodate) * 100 + WEEK(qsodate) >= YEAR(
                CURRENT_DATE - INTERVAL 1 week
            ) * 100 + (
                WEEK(
                    CURRENT_DATE - interval 1 week
                )
            ) THEN 1
            ELSE 0
        END
    ) AS last_week,
    SUM(
        CASE
            WHEN YEAR(qsodate) = YEAR(CURRENT_DATE)
            AND MONTH(qsodate) = MONTH(CURRENT_DATE) THEN 1
            ELSE 0
        END
    ) AS this_month,
    SUM(
        CASE
            WHEN YEAR(qsodate) = YEAR(
                CURRENT_DATE - INTERVAL 1 MONTH
            )
            AND MONTH(qsodate) = MONTH(
                CURRENT_DATE - INTERVAL 1 MONTH
            ) THEN 1
            ELSE 0
        END
    ) AS last_month,
    sum(
        CASE
            WHEN YEAR(qsodate) = YEAR(CURRENT_DATE) THEN 1
            ELSE 0
        END
    ) AS this_year,
    sum(
        CASE
            WHEN YEAR(qsodate) = YEAR(CURRENT_DATE) -1 THEN 1
            ELSE 0
        END
    ) AS last_year,
    COUNT(*) AS total_qsos
FROM view_cqrlog_main_by_qsodate;

-- Notes:
-- - Uses `view_cqrlog_main_by_qsodate` like the other files in this repo.