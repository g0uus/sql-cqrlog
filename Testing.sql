select profile from cqrlog_main;

select count(*) from cqrlog_main where profile = 0;

select profile, count(*)
from cqrlog_main
group by
    profile
ORDER BY profile;