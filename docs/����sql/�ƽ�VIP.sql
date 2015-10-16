select max(mbrmst_id),max(mbrmst_uid),max(mbrmst_name),mbrmst_usephone,(max(prvmst_name)+max(ctymst_name)+max(mbrmst_haddr)),max(mbrmst_postcode),max(mbrmst_birthday),max(odrmst_odrid)
 from mbrmst inner join (select max(odrmst_orderdate) odrmst_odrid,odrmst_mbrid 
from odrmst group by odrmst_mbrid UNION all select max(odrmst_orderdate) odrmst_odrid,odrmst_mbrid 
from odrmst_history group by odrmst_mbrid) as a on a.odrmst_mbrid=mbrmst_id
inner join prvmst on prvmst_provinceid=mbrmst_provinceid
inner join ctymst on ctymst_cityid=mbrmst_cityid where mbrmst_vipenddate>'2199-1-1' and month(mbrmst_birthday)=12
group by mbrmst_usephone

--会员号 会员名  姓名  电话  地址  邮编  生日  最近购买日期 
--会员号 会员名  姓名  电话  地址（需要导出省市详细地址）  邮编   最近购买日期 （月日）  订单号  消费金额 （导出300以上的）
--会员号 会员名  姓名  电话  地址（省市都导出来）  邮编  生日  最近购买日期  
select mbrmst_id,mbrmst_uid,mbrmst_name,mbrmst_usephone,(prvmst_name+ctymst_name+mbrmst_haddr) mbrmst_haddr,mbrmst_postcode,odrmst_orderdate,odrmst_odrid,odrmst_gdsmoney
 from mbrmst inner join (select max(odrmst_odrid) odrmst_odrid,max(odrmst_orderdate) odrmst_orderdate,
max(odrmst_gdsmoney) odrmst_gdsmoney,odrmst_mbrid from odrmst_history
where odrmst_orderdate>'2009-1-1' and odrmst_orderstatus in(3,31,5,51) and odrmst_gdsmoney>300 group by odrmst_mbrid)
 as a on odrmst_mbrid=mbrmst_id
inner join prvmst on prvmst_provinceid=mbrmst_provinceid
inner join ctymst on ctymst_cityid=mbrmst_cityid
and not exists (select 1 from odrmst where odrmst_mbrid=mbrmst_id)
and mbrmst_vipenddate>'2199-1-1' and month(mbrmst_birthday)=12
and mbrmst_haddr<>'未填' order by odrmst_gdsmoney desc

select top 1 * from mbrmst
select top 1 * from prvmst
select top 1 * from ctymst

select * from odrpur09dtl where odrpur09dtl_code='NS090530-181025'

select MbrmstPingAn_MemberID,finalprice,odrmst_orderdate,odrmst_odrid
from MbrmstPingAn,odrmst inner join (select sum(odrmstpingan_finalprice) finalprice,odrmstpingan_odrid from odrmstpingan
where odrmstpingan_status=1 group by odrmstpingan_odrid) as a on odrmstpingan_odrid=odrmst_odrid
where odrmst_mbrid=MbrmstPingAn_mbrid

select * from odrmstpingan where odrmstpingan_status=1

select top 100 odrdtl_finalprice from odrdtl order by odrdtl_subodrid

select * from tktcrd where tktcrd_cardno='d1091_yahoo090500470890890'
update tktcrd set tktcrd_realvalue=100 where tktcrd_cardno='d1091_yahoo090500470890890'

select max(mbrmst_id),max(mbrmst_uid),max(mbrmst_name),mbrmst_usephone,(max(prvmst_name)+max(ctymst_name)+max(mbrmst_haddr)),max(mbrmst_postcode),max(mbrmst_birthday) from mbrmst 
inner join prvmst on prvmst_provinceid=mbrmst_provinceid
inner join ctymst on ctymst_cityid=mbrmst_cityid where mbrmst_id in (select bjvip_mbrid from bjvip) and month(mbrmst_birthday)=3
group by mbrmst_usephone



select max(mbrmst_id),max(mbrmst_uid),max(mbrmst_name),mbrmst_usephone,(max(prvmst_name)+max(ctymst_name)+max(mbrmst_haddr)),max(mbrmst_postcode),max(mbrmst_birthday) from mbrmst 
inner join prvmst on prvmst_provinceid=mbrmst_provinceid
inner join ctymst on ctymst_cityid=mbrmst_cityid where mbrmst_vipenddate>'2199-1-1' and month(mbrmst_birthday)=3
group by mbrmst_usephone