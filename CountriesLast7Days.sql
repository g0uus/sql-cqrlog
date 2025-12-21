select country, count(country) as n_qsos
from view_cqrlog_main_by_qsodate
where
    qsodate >= CURRENT_DATE - INTERVAL 7 DAY
group by
    country
ORDER BY country ASC;