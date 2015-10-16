--利用随机数生成D1券 Start
declare @rnd int
declare @count int
declare @str varchar(200)
declare @start varchar(50)
declare @rndflag varchar(50)
declare @rnd2 int

set @count=1
while @count<=1500
  begin
    set @start='000000000'+cast(@count as varchar)
    set @rnd=cast( floor(rand()*10000000) as int)
    set @rnd2=cast( floor(rand()*10000000) as int)
    set @rnd=@rnd+@rnd2
    set @rnd=cast( floor(rand()*@rnd) as int)
    set @rndflag='0000000000'+cast(@rnd as varchar)
    set @str='d1101_sxy0907'+right(@start,4)
    set @str=@str+right(@rndflag,5)
    --set @rnd=cast( floor(rand()*@rnd) as int)
    --set @rndflag='0000000000'+cast(@rnd as varchar)
    --set @str=@str+right(@rndflag,4)
    if not exists(select tktcrd_cardno from tktcrd where tktcrd_cardno=@str)
      begin
	set nocount on --不返回"所影响行数"
	insert into tktcrd (tktcrd_cardno,tktcrd_value,tktcrd_realvalue,tktcrd_discount,tktcrd_type,tktcrd_validflag,
	tktcrd_enddate,tktcrd_validates,tktcrd_validatee) 
	values(@str,100,100,0.2,'004003',0,'2009-06-30','2009-04-01','2009-06-30') 
	--print @str
	set @count=@count+1
      end
    else
      continue      
end
update tkt_temporary set tktnum=replace(tktnum,'d1101_xunlei0911','d1101_xunlei0912')
select top 10 * from tktcrd where tktcrd_cardno like 'd1101_snda%'
update tktcrd set tktcrd_type='005001' where tktcrd_cardno like 'd1091_sxy%'
select * from tktmst where tktmst_cardno ='1234555323'
--truncate table tkt_temporary
select * from marketmail
select * from mbrmstpingan order by mbrmstpingan_createdate desc
	insert into tktcrd (tktcrd_cardno,tktcrd_value,tktcrd_realvalue,tktcrd_discount,tktcrd_type,tktcrd_validflag,
	tktcrd_enddate,tktcrd_validates,tktcrd_validatee) 
	select tktnum,100,100,0.15,'005001',0,'2010-4-30 23:59:59','2010-1-20','2010-4-30 23:59:59' from tkt_temporary 
select * from tktcrd where tktcrd_cardno like 'd1101_1761001%' and tktcrd_value=50
delete from tkt_temporary where tktnum in (select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1101_xunlei1001%')

select * from tktcrd where tktcrd_cardno like 'd1101_kingsoft0908%'
update tktcrd set tktcrd_discount=0.2 where  tktcrd_cardno like 'd1101_xiaonei0905%'
--利用二次order by 取表中的记录
select top 10 tktnum from (select top 30 tktnum from tkt_temporary order by tktnum desc) as tkt order by tktnum desc
select count(*) from tktcrd
--truncate table tkt_temporary
select count(distinct tktnum) from tkt_temporary
select * from tkt_temporary
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno in(select tktnum from tkt_temporary)
delete tkt_temporary where tktnum in (select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1101_163mail0909%')
--update tkt_temporary set tktnum=replace(tktnum,'_2','_3')
--一张可以领10000次的券
select top 10 * from tktpwd where tktpwd_cardno='d1101_163mail0909'
update tkt_temporary set tktnum=replace(tktnum,'d1101_shgwj0909','d1101_163mail0909')
update tktpwd set tktpwd_cardno=replace(tktpwd_cardno,'d1101_shgwj0909','d1101_163mail0909') where tktpwd_cardno like 'd1101_shgwj0909%'
--利用随机数生成D1券 End
--把生成的券插入到tktpwd表中Start
--百货券
--台历券表tkt_temp071130
select count(*) from tktpwd where tktpwd_cardno like 'd1101_jj091%'
delete from tkt_temporary where tktnum in(select tktpwd_cardno from tktpwd where tktpwd_cardno like 'd1101_gyyx1001%')
--insert into tktpwd (tktpwd_cardno,tktpwd_pwd,tktpwd_value,tktpwd_enddate,tktpwd_gdsvalue,tktpwd_rackcode,
tktpwd_sendcount,tktpwd_maxcount,tktpwd_everymaxcount,tktpwd_createdate,tktpwd_tktstartdate,tktpwd_tktenddate,tktpwd_mbrid,tktpwd_ifvip,tktpwd_sprckcodestr,tktpwd_baihuo)
select tktnum,'www.d1.com.cn',10,'2010-4-30 23:59:59',0,'000',0,1,1,getdate(),'2010-1-25','2010-4-30 23:59:59',0,0,'',0 from tkt_temporary order by tktnum desc


update tktpwd set tktpwd_sprckcodestr=',3486,3487,3488,3489,3490,3491,3492,' where tktpwd_cardno like 'd1101_xunlei1001%'
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