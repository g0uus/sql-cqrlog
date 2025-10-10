SELECT
    month,
    qso_count,
    SUM(qso_count) OVER (
        ORDER BY month
    ) AS cumulative_qso_count
FROM (
        SELECT DATE_FORMAT(qsodate, '%Y-%m') AS month, COUNT(*) AS qso_count
        FROM cqrlog_main
        GROUP BY
            month
    ) AS monthly_counts
ORDER BY month
    -- Stop INTO clause being put onto one line !
    INTO OUTFILE '~/CumulativeQsosByMonth.csv'
    -- stop
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';