select profile from cqrlog_main;

select count(*) from cqrlog_main where profile = 0;

select profile, count(*)
from cqrlog_main
group by
    profile
ORDER BY profile;


select unique mode from cqrlog_main;

--
-- Select all callsigns with WWA suffix or are like N%W worked in January 2026
--
SELECT unique callsign, award FROM cqrlog_main
where qsodate between '2026-01-01' and '2026-01-31'
and (callsign like '%WWA'
 or callsign like 'N%W')
ORDER BY callsign;

--
-- select a bunch of WWA calls that dont match %WWA
--
SELECT unique callsign, award
FROM cqrlog_main
where
    qsodate between '2026-01-01' and '2026-01-31'
    and callsign in ('TK4TH','RW1F', 'YL73R','8A1A', 'BG0DXC', 'E7W', 'SX0W','EG8WW', 'W4I','YI1RN','YU45MJA', 'ZW5B','RU0LL','4U1A')
ORDER BY callsign;

Select DISTINCT SUBSTRING(loc, 1, 4) AS gridsquares 
from cqrlog_main 
where loc is not null and loc <> '' 
AND qsodate between '2026-02-08' and '2026-02-28'
order by loc;


--
-- Gridsquares count 2025
--
Select DISTINCT
    count( SUBSTRING(loc, 1, 4)) AS gridsquares
from cqrlog_main
where
    loc is not null
    and loc <> ''
    AND qsodate between '2025-01-01' and '2025-12-31'
order by loc;

--
-- Gridsquares count By year
--
Select 
    year(qsodate) as year,
    count(DISTINCT SUBSTRING(loc, 1, 4)) AS gridsquares
from cqrlog_main
where
    loc is not null
    and loc <> ''
    group by year
    order by year;


Select year(qsodate) as year, band, count(DISTINCT SUBSTRING(loc, 1, 4)) AS gridsquares
from cqrlog_main
where
    loc is not null
    and loc <> ''
group by
    year, band
order by year, band;