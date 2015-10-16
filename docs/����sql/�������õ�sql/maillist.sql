135,mbrmst_email,mbrmst_uid,mbrmst_name
select * from maildtl where maildtl_mailid=135
insert into maildtl(maildtl_mailid,maildtl_email,maildtl_uid,maildtl_name)
select distinct 135,mbrmst_email,mbrmst_uid,mbrmst_name from mbrmst inner join odrmst on odrmst_mbrid=mbrmst_id
where odrmst_orderdate>'2008-1-1' and odrmst_orderdate<'2009-1-1'
and mbrmst_email<>''
and odrmst_orderstatus in(3,31,5,51,6,61) 
and mbrmst_id not in(select odrmst_mbrid from odrmst where odrmst_orderdate>'2009-1-1' 
and odrmst_orderstatus in(3,31,5,51,6,61))
and mbrmst_id not in(select mbrid from smssnddtl where smsid in (14,15,16))
and mbrmst_usephone not in(select phone from smssnddtl where smsid in (14,15,16))

--一般情况
select distinct rtrim(mbrmst_email) from mbrmst where mbrmst_email not in
--
(
insert into [09all]
select distinct rtrim(odrmst_remail) as mail into mailtem090414  from odrmst inner join odrdtl on odrmst_odrid =odrdtl_odrid
where odrmst_orderstatus in (3,31,5,51,6,61) 
and (odrdtl_rackcode like '017002%') 
and odrmst_remail not in (select email from bademail) 
and odrmst_remail not like '%etang.com'
and odrdtl_creatdate>'2008-1-1'  and odrdtl_finalprice>=20
and odrmst_remail not in (select col001 from [09all])
)
--
and mbrmst_sex=1  and mbrmst_birthday<'1989-1-1'  and mbrmst_birthday>'1972-1-1'
and mbrmst_email not like '%etang.com'
and mbrmst_email not in (select email from bademail) 
select * from stock where stock_gdsid='01502751' order by stock_createdate desc
select count(*) from mailtem090414 group by mail having count(*)>1 order by count(*) desc
--最新会员
insert into mailtem090414
select distinct (rtrim(mbrmst_email)) from mbrmst where mbrmst_createdate>'2009-1-20'
and mbrmst_email not in 
(select distinct (odrmst_remail) from odrmst where odrmst_orderdate>'2009-1-20' and odrmst_orderstatus>0) 
and mbrmst_email not in  (select email from bademail)
and mbrmst_email not in (select mail from mailtem090414)
and mbrmst_sex=0
and mbrmst_birthday >'1960-1-1' and mbrmst_birthday<'1985-1-1'


select distinct (rtrim(mbrmst_email)) from mbrmst where 
mbrmst_email not in (select col001 from [09all])
and mbrmst_email not in (select email from bademail) 

select top 1 * from [09all]
select col001 from [09all] group by col001 having count(*)>1
08年-09年7月买过015009，017001的顾客发！！！
--人群是：08年1月至今购买过014001产品的女性用户! 
--truncate table maillist090612
select top 1 * from odrmst
insert into smssnddtl (smsid,mbrid,name,phone)
select 88,max(odrmst_mbrid),max(odrmst_rname),odrmst_rphone
--select  distinct odrmst_mbrid --into maillist090612
 from (select * from odrmst union all select * from odrmst_history) a inner join (select * from odrdtl union all select * from odrdtl_history) b 
on a.odrmst_odrid=b.odrdtl_odrid
inner join mbrmst on mbrmst_id=a.odrmst_mbrid
--inner join d1mall on odrdtl_rackcode like d1mall_rackcode+'%'
where odrmst_orderstatus in (3,31,5,51,6,61)
--and odrdtl_finalprice>50
and odrmst_mbrid not in (select d.odrmst_mbrid from (select * from odrmst union all select * from odrmst_history) d inner join (select * from odrdtl union all select * from odrdtl_history) e 
on d.odrmst_odrid=e.odrdtl_odrid where 
e.odrdtl_rackcode like '015002014%' or e.odrdtl_rackcode like '014%' or e.odrdtl_gdsname like '%玫瑰%' and odrmst_orderdate>'2009-3-1')
--and d1mall_id=5
and odrmst_orderdate>'2009-3-1'
and odrmst_remail not in  (select email from bademail)
and mbrmst_id not in (select mbrmstpingan_mbrid from mbrmstpingan)
and mbrmst_sex=1
and mbrmst_birthday>'1969-8-26' and mbrmst_birthday<'1989-8-26'
and odrmst_rprovince='北京'
group by odrmst_rphone
select * from d1mall
