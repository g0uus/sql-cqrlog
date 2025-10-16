SELECT COUNT(*) AS total_qsos_this_month
FROM view_cqrlog_main_by_qsodate
WHERE
    YEAR(qsodate) = YEAR(CURRENT_DATE)
    AND MONTH(qsodate) = MONTH(CURRENT_DATE);