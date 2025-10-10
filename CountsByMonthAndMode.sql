SELECT DATE_FORMAT(qsodate, '%Y-%m') AS month, mode, COUNT(*) AS qso_count
FROM cqrlog_main
GROUP BY
    month,
    mode
ORDER BY month, mode;