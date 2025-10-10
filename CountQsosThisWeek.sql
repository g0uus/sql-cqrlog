SELECT COUNT(*) AS total_qsos_this_week
FROM view_cqrlog_main_by_qsodate
WHERE
    YEARWEEK(qsodate) >= YEARWEEK(CURRENT_DATE);