SELECT DATE_FORMAT(qsodate, '%Y-%m') AS month, COUNT(*) AS qso_count
FROM cqrlog_main
GROUP BY
    month
ORDER BY month -- Stop INTO clause being put onto one line !
    INTO OUTFILE '~/QsoCountByMonth.csv'
    -- stop
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';