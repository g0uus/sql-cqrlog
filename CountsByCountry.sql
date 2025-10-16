SELECT
    country,
    COUNT(*) AS total_qsos,
    COUNT(DISTINCT callsign) AS unique_callsigns
FROM
    view_cqrlog_main_by_qsodate
GROUP BY
    country
ORDER BY
    total_qsos DESC;