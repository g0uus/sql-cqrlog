SELECT DATE_FORMAT(qsodate, '%Y-%m') AS month, COUNT(*) AS qso_count
FROM cqrlog_main
GROUP BY
    month
ORDER BY month;