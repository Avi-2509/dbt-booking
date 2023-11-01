{% set query %}
        set enable_case_sensitive_identifier to true
{% endset %}
{% do run_query(query)%}

{{ config(materialized='table') }}
select tup.userid as "doctoruserid" , 
tup.profileid as "doctorprofileid",
t.validity."from" as "slotstart",
t.validity."to" as "slotend",
tdmap.monday, 
tdmap.tuesday , 
tdmap.wednesday , 
tdmap.thursday , 
tdmap.friday , 
tdmap.saturday, 
tdmap.sunday ,
t.timetableenum
from booking.timetable t,
booking.timetable_dayavailabilitymap tdmap,
booking.timetable_userprofile tup,
booking.timetable_userprofile_profile tuprof 
where t._airbyte_timetable_hashid = tdmap._airbyte_timetable_hashid and 
tup._airbyte_timetable_hashid = t._airbyte_timetable_hashid and 
tup._airbyte_userprofile_hashid = tuprof._airbyte_userprofile_hashid 