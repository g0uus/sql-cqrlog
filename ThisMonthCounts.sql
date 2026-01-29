--
--
--

select
    'January' as day,
    sum(
        case
            when mode = 'SSB' then 1
            else 0
        end
    ) as ssb,
    sum(
        case
            when mode = 'CW' then 1
            else 0
        end
    ) as cw,
    sum(
        case
            when mode = 'FM' then 1
            else 0
        end
    ) as fm,
    sum(
        case
            when mode = 'FT4' then 1
            else 0
        end
    ) as ft4,
    sum(
        case
            when mode = 'FT8' then 1
            else 0
        end
    ) as ft8,
    sum(
        case
            when mode = 'PSK' then 1
            else 0
        end
    ) as psk,
    sum(
        case
            when mode = 'RTTY' then 1
            else 0
        end
    ) as rtty,
    sum(
        case
            when mode <> "SSB"
            and mode <> "CW"
            and mode <> "FM"
            and mode <> "FT4"
            and mode <> "FT8"
            and mode <> "PSK"
            and mode <> "RTTY" then 1
            else 0
        end
    ) as other,
    count(*) as total
from view_cqrlog_main_by_qsodate
where
    qsodate between '2026-01-01' and '2026-01-31'
group by
    day
order by qsodate desc;