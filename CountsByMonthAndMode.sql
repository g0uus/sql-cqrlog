
SELECT DATE_FORMAT(qsodate, '%Y-%m-01') AS month, mode, COUNT(*) AS qso_count
FROM cqrlog_main
GROUP BY month, mode
ORDER BY month, mode;
