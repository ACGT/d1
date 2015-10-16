--利用随机数生成D1券 Start
--D27，yahoo0902
--E03,21cn0902，
declare @rnd int
declare @count int
declare @str varchar(200)
declare @start varchar(50)
declare @rndflag varchar(50)
declare @rnd2 int

set @count=1
while @count<=100
  begin
    set @start='000000000'+cast(@count as varchar)
    set @rnd=cast( floor(rand()*10000000) as int)
    set @rnd2=cast( floor(rand()*10000000) as int)
    set @rnd=@rnd+@rnd2
    set @rnd=cast( floor(rand()*@rnd) as int)
    set @rndflag='0000000000'+cast(@rnd as varchar)
    set @str='D43'+right(@rndflag,1)
    set @rnd=cast( floor(rand()*@rnd) as int)
    set @rndflag='0000000000'+cast(@rnd as varchar)
    set @str=@str+right(@rndflag,4)
    set @rnd=cast( floor(rand()*@rnd) as int)
    set @rndflag='0000000000'+cast(@rnd as varchar)
    set @str=@str+right(@rndflag,4)
    if not exists(select cardno from yahoogds080825 where cardno=@str)
      begin
	set nocount on --不返回"所影响行数"
	insert into yahoogds080825 (cardno,gdsid,status,startdate,enddate) 
	values(@str,'01900615',0,'2009-8-1','2009-9-30 23:59:59') 
	--print @str
	set @count=@count+1
      end
    else
      continue      
end

select top 10 * from yahoogds080825 where cardno like 'd%' order by left(cardno,3) desc
select * from yahoogds080825 where cardno like 'd49%' and len(cardno)>12 order by cardno desc
update yahoogds080825 set startdate='2008-11-30',enddate='2009-1-15' where cardno like 'D19%'

declare @rnd int
declare @count int
declare @str varchar(200)
declare @start varchar(50)
declare @rndflag varchar(50)
declare @rnd2 int

--利用二次order by 取表中的记录
select top 10 tktnum from (select top 30 tktnum from tkt_temporary order by tktnum) as tkt order by tktnum desc

select top 10 * from tktpwd where tktpwd_cardno='d1030_0811yahoo'
update tktpwd set tktpwd_rackcode='000' where tktpwd_cardno='d1030_0811yahoo'
select * from yahoogds080825 where printdate>'2009-1-1'
--truncate table tkt_temporary
select count(distinct tktnum) from tkt_temporary where 
select top 10 * from tkt_temporary
select count(distinct tktpwd_cardno) from tktpwd where tktpwd_cardno in(select tktnum from tkt_temporary)
--update tkt_temporary set tktnum=replace(tktnum,'_2','_3')
--一张可以领10000次的券
select top 10 * from tktpwd where tktpwd_cardno='d1030_build_0801'
select * from tktpwd where tktpwd_cardno like '2009%' and tktpwd_sendcount=1givetktnum
select * from tktmst where tktmst_cardno like  '2009%' 
--利用随机数生成D1券 End
--把生成的券插入到tktpwd表中Start
--百货券
--台历券表tkt_temp071130
--insert into tktpwd (tktpwd_cardno,tktpwd_pwd,tktpwd_value,tktpwd_enddate,tktpwd_gdsvalue,tktpwd_rackcode,
tktpwd_sendcount,tktpwd_maxcount,tktpwd_everymaxcount,tktpwd_createdate,tktpwd_tktstartdate,tktpwd_tktenddate,tktpwd_mbrid,tktpwd_ifvip,tktpwd_sprckcodestr,tktpwd_baihuo)
select top 500 tktnum,'www.d1.com.cn',20,'2008-7-30 23:59:59',100,'000',0,1,1,getdate(),'2008-5-1','2008-7-30 23:59:59',0,0,'',0 from tkt_temporary order by tktnum desc

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