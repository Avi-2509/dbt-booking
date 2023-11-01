{% set query %}
        set enable_case_sensitive_identifier to true
{% endset %}
{% do run_query(query)%}

{{ config(materialized='table') }}
select
        mc.userid ,
        mc.profileid ,
        mcp.defaultrole as "createdBy",
        mcp."name" ,
	m.slot."from",
	m.slot."to",
	m.meetingjoinstateenum,
        m.meetingstatus,
        dis."name" as "disease",
        md.modalitytype
        FROM booking.meeting m, booking.meeting_modality md, booking.meeting_disease dis, 
        booking.meeting_createdby mc, booking.meeting_createdby_profile mcp
        where m."_airbyte_meeting_hashid" = md."_airbyte_meeting_hashid" and 
        dis."_airbyte_meeting_hashid" = m."_airbyte_meeting_hashid" and 
        mc._airbyte_meeting_hashid = m._airbyte_meeting_hashid and 
        mcp._airbyte_createdby_hashid = mc._airbyte_createdby_hashid 