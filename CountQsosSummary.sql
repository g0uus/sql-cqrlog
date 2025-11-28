-- Summary: counts of QSOs for today, this week and this month
-- MySQL-compatible. Adjust WEEK mode if your week-start differs.

SELECT
    SUM(CASE WHEN qsodate = CURRENT_DATE THEN 1 ELSE 0 END) AS qsos_today,
    SUM(CASE WHEN YEAR(qsodate) = YEAR(CURRENT_DATE)
             AND WEEK(qsodate, 1) = WEEK(CURRENT_DATE, 1)
         THEN 1 ELSE 0 END) AS qsos_this_week,
    SUM(CASE WHEN YEAR(qsodate) = YEAR(CURRENT_DATE)
             AND MONTH(qsodate) = MONTH(CURRENT_DATE)
         THEN 1 ELSE 0 END) AS qsos_this_month
FROM view_cqrlog_main_by_qsodate;

-- Notes:
-- - Uses `view_cqrlog_main_by_qsodate` like the other files in this repo.
-- - `WEEK(..., 1)` uses Monday as the first day of the week; change the mode if you need a different week definition.