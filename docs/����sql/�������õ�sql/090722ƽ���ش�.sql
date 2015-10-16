insert into 
odrmstpingan(odrmstpingan_subodrid,odrmstpingan_finalprice,odrmstpingan_gdsid,odrmstpingan_odrid,odrmstpingan_mbrid)
select odrdtl_subodrid,round((odrdtl_finalprice*odrdtl_gdscount),2),odrdtl_gdsid,odrdtl_odrid,odrmst_mbrid from odrmst,odrdtl,mbrmstpingan
where odrmst_mbrid=mbrmstpingan_mbrid and odrmst_odrid=odrdtl_odrid and odrdtl_subodrid not in 
(select odrmstpingan_subodrid from odrmstpingan) and odrdtl_finalprice>0 and odrdtl_purtype>0
and (odrmst_orderstatus>0)

select odrdtl_odrid from odrmstpingan,odrdtl where odrmstpingan_subodrid=odrdtl_subodrid and round((odrdtl_finalprice*odrdtl_gdscount),2)<>odrmstpingan_finalprice
and odrdtl_gdscount>1  group by odrdtl_odrid

select odrdtl_odrid into tempinganerrodr from odrmstpingan,odrdtl where odrmstpingan_subodrid=odrdtl_subodrid and round((odrdtl_finalprice*odrdtl_gdscount),2)<>odrmstpingan_finalprice
and odrdtl_gdscount>1 and odrmstpingan_createtime>'2009-6-15' group by odrdtl_odrid

select * from odrmstpingan where odrmstpingan_ifsendxml>1 odrmstpingan_status=1 and odrmstpingan_sendxmltime>'2009-7-22'

select * from tempinganerrodr

--update odrmstpingan set odrmstpingan_status=-2 where odrmstpingan_odrid in (select odrdtl_odrid from tempinganerrodr) and odrmstpingan_sendxmltime>'2009-7-22'

select odrmstpingan_odrid from odrmstpingan where  odrmstpingan_status=-2 and odrmstpingan_odrid in 
(select odrdtl_odrid from tempinganerrodr) and odrmstpingan_sendxmltime>'2009-7-22'
group by odrmstpingan_odrid

update odrmstpingan set odrmstpingan_finalprice=round((odrdtl_finalprice*odrdtl_gdscount),2) from odrdtl where odrmstpingan_subodrid=odrdtl_subodrid
and odrmstpingan_odrid in (select odrdtl_odrid from tempinganerrodr)

update odrmstpingan set odrmstpingan_status=1,odrmstpingan_odrid='1'+right(odrmstpingan_odrid,11) where odrmstpingan_odrid in (select odrdtl_odrid from tempinganerrodr)