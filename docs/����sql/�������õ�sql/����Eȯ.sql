--利用随机数生成D1券 Start
declare @rnd int
declare @count int
declare @str varchar(200)
declare @start varchar(50)
declare @rndflag varchar(50)
declare @rnd2 int

set @count=1
while @count<=30000
  begin
    set @start='000000000'+cast(@count as varchar)
    set @rnd=cast( floor(rand()*10000000) as int)
    set @rnd2=cast( floor(rand()*10000000) as int)
    set @rnd=@rnd+@rnd2
    set @rnd=cast( floor(rand()*@rnd) as int)
    set @rndflag='0000000000'+cast(@rnd as varchar)
    set @str='d1091_ newegg090330'+right(@start,5)+right(@rndflag,5)
    if not exists(select tktnum from tkt_temporary where tktnum=@str)
      begin
	set nocount on --不返回"所影响行数"
	insert into tkt_temporary (tktnum) values(@str)
	set @count=@count+1
      end
    else
      continue      
end
delete from tkt_temporary where tktnum like 'd1091_yahoo0905%'
select * from minimst where minimst_id=503
update minimst set minimst_tlmap='<area shape="rect" coords="14,40,277,244" href="http://www.d1.com.cn/html/01204163.htm"><area shape="rect" coords="0,0,697,281" href="http://www.d1.com.cn/html/mini/mininew502.htm"><area shape="rect" coords="303,103,575,173" href="#"><area shape="rect" coords="277,186,504,280" href="#">' where minimst_id=503
--利用二次order by 取表中的记录
select top 10 tktnum from (select top 30 tktnum from tkt_temporary order by tktnum desc) as tkt order by tktnum desc
delete from tkt_temporary where tktnum like 'd1091_yahoo100904%'
--truncate table tkt_temporary
select count(distinct tktnum) from tkt_temporary
select * from tkt_temporary order by tktnum desc
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno in(select tktnum from tkt_temporary)
--update tkt_temporary set tktnum=replace(tktnum,'_2','_3')
--一张可以领10000次的券
select top 10 * from tktpwd where tktpwd_cardno like 'd1091_alipay090410%'

--利用随机数生成D1券 End
--把生成的券插入到tktpwd表中Start
--百货券
--台历券表tkt_temp071130
--insert into tktpwd (tktpwd_cardno,tktpwd_pwd,tktpwd_value,tktpwd_enddate,tktpwd_gdsvalue,tktpwd_rackcode,
tktpwd_sendcount,tktpwd_maxcount,tktpwd_everymaxcount,tktpwd_createdate,tktpwd_tktstartdate,tktpwd_tktenddate,tktpwd_mbrid,tktpwd_ifvip,tktpwd_sprckcodestr,tktpwd_baihuo)
select tktnum,'www.d1.com.cn',10,'2009-11-30 23:59:59',0,'000',0,1,1,getdate(),'2009-7-1','2009-11-30 23:59:59',0,0,'',0 from tkt_temporary

--insert into tktpwd (tktpwd_cardno,tktpwd_pwd,tktpwd_value,tktpwd_enddate,tktpwd_gdsvalue,tktpwd_rackcode,
tktpwd_sendcount,tktpwd_maxcount,tktpwd_everymaxcount,tktpwd_createdate,tktpwd_tktstartdate,tktpwd_tktenddate,tktpwd_mbrid,tktpwd_ifvip,tktpwd_sprckcodestr,tktpwd_baihuo)
values('d1030_0809yahoo','www.d1.com.cn',30,'2009-4-1 23:59:59',0,'000',0,1000000,1,getdate(),getdate(),'2009-4-1 23:59:59',0,0,',1752,',0)

--select top 200 tktnum,'www.d1.com.cn',20,'2008-2-20 23:59:59',150,'000',0,1,1,getdate(),'2008-1-1','2008-2-20 23:59:59',0,0,'',0 from (select top 2200 tktnum from tkt_temporary order by tktnum) as tkt order by tktnum desc
--把生成的券插入到tktpwd表中End

--测试tktpwd表的所有的券
select count(distinct tktpwd_cardno) from tktpwd
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_jeboo%'--捷报券
select * from tktpwd where tktpwd_cardno like 'd1030_jeboo%'

--易价券
--delete from tktpwd where tktpwd_cardno like 'd1030_yijia0712%'
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_yijia0712%'
select * from tktpwd where tktpwd_cardno like 'd1030_yijia0712%' and tktpwd_value=5 order by tktpwd_cardno
select * from tktpwd where tktpwd_cardno like 'd1030_fy0805%' and tktpwd_value=10
select * from tktpwd where tktpwd_cardno like 'd1030_yijia0712%' and tktpwd_value=20

select * from tktpwd where tktpwd_cardno like 'd1002_ebooom0712%' and tktpwd_value=10--Ebooom券

--百货券
select * from tktpwd where tktpwd_cardno like 'd1002_book0712_%'

--龙樱券
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_ly0712%'
select * from tktpwd where tktpwd_cardno like 'd1030_ly0712%' and tktpwd_value=20 and tktpwd_gdsvalue=199 --(199-20)券3500张
select * from tktpwd where tktpwd_cardno like 'd1030_ly0712%' and tktpwd_value=20 and tktpwd_gdsvalue=150 --(150-20)券200张
select * from tktpwd where tktpwd_cardno like 'd1030_ly0712%' and tktpwd_value=30 and tktpwd_gdsvalue=199 --(199-30)券2000张
select top 10 * from tktpwd where tktpwd_cardno like 'b8%_2' --台历券

--首信券

select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_sx0801%'
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_sx0801%'

--易佳
--新蛋
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_newegg0803%' and tktpwd_value=30
select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_newegg0803%' and tktpwd_value=20
--傲游
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_maxthon0803%'
select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_maxthon0803%'

select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_newegg0804%' and tktpwd_value=20
select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_newegg0804%' and tktpwd_value=30

--台历券
select top 10 * from tkt_temp071130
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'b8%_4'

--新钻券
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno like 'd1030_xinzuan0804%'
select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_xinzuan0804%'

--封印传说
select distinct tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_fy0805%' and tktpwd_value=10
select distinct tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1030_fy0805%' and tktpwd_value=20