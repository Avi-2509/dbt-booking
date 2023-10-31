{% set query %}
        set enable_case_sensitive_identifier to true
{% endset %}
{% do run_query(query)%}

{{ config(materialized='table') }}
select
	m.slot."from",
	m.slot."to",
	m.meetingjoinstateenum,
    m.meetingstatus,
    dis."name",
    md.modalitytype
    FROM booking.meeting m, booking.meeting_modality md, booking.meeting_disease dis
    where m."_airbyte_meeting_hashid" = md."_airbyte_meeting_hashid" and 
    dis."_airbyte_meeting_hashid" = m."_airbyte_meeting_hashid"