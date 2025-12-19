--
-- NOTE the output file is written to a path on the database server host
-- not the client host.
-- Also CANNOT OVERWRITE AND EXISTING FILE!
--
SELECT
    month,
    qso_count,
    SUM(qso_count) OVER (
        ORDER BY month  
    ) AS cumulative_qso_count
FROM (
        SELECT DATE_FORMAT(qsodate, '%Y-%m-01') AS month, COUNT(*) AS qso_count
        FROM cqrlog_main
        GROUP BY
            month
    ) AS monthly_counts
ORDER BY month
    -- Stop INTO clause being put onto one line !
    INTO OUTFILE '/home/graham/CumulativeQsosByMonth.csv'
    -- stop
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';