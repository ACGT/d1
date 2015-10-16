select * from odrsurvey

select odrsurvey_option4,count(*) from odrsurvey where odrsurvey_odrid like '0911%' group by odrsurvey_option4
order by odrsurvey_option4 desc

select odrmst_d1shipmethod,count(*) from odrsurvey,odrmst where odrsurvey_odrid=odrmst_odrid and odrsurvey_odrid like '0911%' 
group by odrmst_d1shipmethod order by count(*) desc


select * from odrmst where odrmst_odrid='091202000670'