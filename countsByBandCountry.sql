-- count of countries by band
-- This query counts the distinct countries for each band in the view_cqrlog_main_by_qsodate
-- and orders the results by band.

select band, count(distinct country) as ctryct
FROM view_cqrlog_main_by_qsodate
GROUP BY
    band
ORDER BY band