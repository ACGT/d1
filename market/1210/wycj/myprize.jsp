<%@ page contentType="text/html; charset=GBK"%><%@page 
import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*"%><%!

private ArrayList<LotCon> getLotCon(){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist.add(Restrictions.lt("lotcon_starttime", new Date()));
	clist.add(Restrictions.gt("lotcon_endtime", new Date()));
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return null;
	for(BaseEntity be:mxlist){
		list.add((LotCon)be);
	}
	return list;
}

private boolean getLotAct(String mbrid){
	ArrayList<LotAct> list=new ArrayList<LotAct>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lot8zn_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("lot8zn_status", new Long(0)));
	List<BaseEntity> mxlist= Tools.getManager(LotAct.class).getList(clist, null, 0, 1);
	if(mxlist==null || mxlist.size()==0) return false;
	for(BaseEntity be:mxlist){
		list.add((LotAct)be);
	}
	LotAct lotact=list.get(0);
	lotact.setLot8zn_status(new Long(1));
	Tools.getManager(LotAct.class).update(lotact, false);
	return true;
}
/** 
* 添加日期 
* @param d 现日期 
* @param day 添加的天数 
* @return 添加后的日期 
* @throws ParseException 
*/ 
public static Date addDate(Date d,long day) throws ParseException { 

long time = d.getTime(); 
day = day*24*60*60*1000; 
time+=day; 
return new Date(time); 

} 
private static boolean addcard(String gdsid,float ftuanprice,HttpServletRequest request,HttpServletResponse response){
	Product product = ProductHelper.getById(gdsid);
	if(product == null){
		return false;
	}
	//商品是否在架上
	if(Tools.longValue(product.getGdsmst_validflag()) != 1&&Tools.longValue(product.getGdsmst_validflag()) != 4){
		return false;
	}
	Cart cart = new Cart();
	cart.setAmount(new Long(1));
	cart.setCookie(CartHelper.getCartCookieValue(request, response));
	cart.setCreateDate(new Date());
	cart.setHasChild(new Long(0));
	cart.setHasFather(new Long(0));
	cart.setIp(request.getRemoteHost());
	cart.setMoney(Tools.getFloat(new Float(ftuanprice),2));
	cart.setOldPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setPoint(new Long(0));
	cart.setPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setSkuId("");//?
	cart.setTuanCode("");//注意parentId值
	cart.setProductId(gdsid);
	cart.setType(new Long(15));
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(Tools.getFloat(new Float(ftuanprice),2));
	cart.setTitle("【网易活动抽奖】"+Tools.clearHTML(product.getGdsmst_gdsname()));
	
	Tools.getManager(Cart.class).create(cart);
	return true;
}

private static int addtkt(int tkttype,String mbrid,String mbruid,int flag,HttpServletRequest request,HttpServletResponse response){
	long cardvalue=0;
	long gdsvalue=0;
	int ret=0;
	String memotxt="";
	String winname="";
	String gdsid="";
	float gdsprice=0;
	/*
1-----100元服饰券 20%    801-1000
2-----时尚家居拖鞋 0元  20%    601-800
3-----水晶项链  29元 20%   401-600
4-----小栗舍大衣 79元  20%       201-400
5-----马甲159% 89元 11-200
6-----5元现金券 （5元）1%       1-10
7 1000元券
8   手表
1000元现金券：恭喜您，抽中1000元现金券，已存入您的优惠券，请在2012年12月31日前使用
阿玛尼情侣表：恭喜您，抽中阿玛尼情侣表一对，请到购物车领取
100元服饰券：恭喜您，抽中100元服饰现金券一张，已存入您的优惠券，30天内有效
时尚家居拖鞋：恭喜您，抽中时尚家居拖鞋一双，请到购物车领取
5元现金券：恭喜您，抽中5元现金券一张，已存入您的优惠券，30天内有效
大衣120元减免券：恭喜您，抽中羊毛呢大衣120元减免券，此商品已经加入购物车，购物车直接减免
棉马甲70元减免：恭喜您，抽中棉马甲70元减免券，此商品已经加入购物车，购物车直接减免
项链130元减免券：恭喜您，抽中水晶项链130元减免券，此商品已经加入购物车，购物车直接减免
马甲  89  01719626
小栗舍大衣 79  01719898
水晶项链   29	 01516824

阿玛尼的情侣表	01512679	
拖鞋		 02103003							
				
							

*/
System.out.println("d1gjl-------"+tkttype);
	 switch (tkttype)
	    {
	        case 1:
	        	cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!";
                break;
	        case 2:
	        	gdsid="02000482";
	        	gdsprice=19;
	        	memotxt="小栗舍长袖打底衫20元减免券";
	        	winname="恭喜您，抽中原售39元的小栗舍长袖打底衫20元减免券，商品已加入您的购物车，仅需19元!";
	            break;
	        case 3:
	        	gdsid="01516824";
	        	gdsprice=29;
	        	memotxt="水晶项链130元减免券";
	        	winname="恭喜您，抽中原价159元的YOUSOO水晶项链130元减免券，此商品已加入您的购物车，购物车直接减免，仅需29元！";
	            break;
	        case 4:
	        	gdsid="01719898";
	        	gdsprice=79;
	        	memotxt="羊毛呢大衣120元减免券";
	        	winname="恭喜您，抽中原价199元的小栗舍羊毛呢大衣120元减免券，此商品已加入您的购物车，购物车直接减免，仅需79元！";
	            break;
	        case 5:
	        	gdsid="01719626";
	        	gdsprice=89;
	        	memotxt="棉马甲70元减免券";
	        	winname="恭喜您，抽中原价159元的FEEL MIND棉马甲70元减免券，此商品已加入您的购物车，购物车直接减免，仅需89元！";
	            break;
	        case 6:
	        	cardvalue=5;
	        	gdsvalue=5;
	        	memotxt="5元优惠券";
	        	winname="恭喜您获得5元优惠券，全场通用，30天内有效!";
	            break;
	        case 7:
	        	gdsid="01512679";
	        	gdsprice=0;
	        	memotxt="阿玛尼情侣表一对";
	        	winname="恭喜您，抽中价值4500元阿玛尼情侣表一对，此商品已经加入购物车!";
	            break;
	        case 8:
	            cardvalue=1000;
	        	gdsvalue=0;
	        	memotxt="1000元优惠券";
	        	winname="恭喜您，抽中1000元现金券，已存入您的帐号，请在2012年12月31日前使用,请进入我的帐户中查询!";
	            break;
	    }
	
	 Random rndcard = new Random();
	 String cardno="mwycj1210"+mbrid+rndcard.nextInt(20000);
	 PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", Tools.parseLong(mbrid));
	 if(pauser!=null){
		 cardno="pa"+cardno;
	 }
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),30);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }
	 if (flag==2){
	 if (tkttype==1){
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
		 tktcrd.setTktcrd_value(new Long(gdsvalue));
		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("004001");
		 tktcrd.setTktcrd_rackcode("017");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("网易活动抽奖！");
		 tktcrd.setTktcrd_payid(new Long(-1));
		 Tools.getManager(TicketCrd.class).create(tktcrd);
	 }
	 else{
		 Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(cardvalue));
		 tktmst.setTktmst_type("004001");
		 tktmst.setTktmst_mbrid(Tools.parseLong(mbrid));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(startdate);
		 tktmst.setTktmst_validates(startdate);
		 if (tkttype==8){
			 SimpleDateFormat   df4=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
			 String etime ="2012-12-31 23:59:59";
			 try{
				 enddate=df4.parse(etime);
				 }
				 catch(Exception ex){
					 ex.printStackTrace();
				 }
			 
		   tktmst.setTktmst_validatee(enddate);
		 }else{
		   tktmst.setTktmst_validatee(enddate);
		 }
		 tktmst.setTktmst_rackcode("000");
         tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("网易活动抽奖！");
         Tools.getManager(Ticket.class).create(tktmst);
	 }
	 }else{
		 
		 boolean addcardret=false;
		 addcardret=addcard(gdsid,gdsprice,request,response);
		 if(!addcardret){
			    cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元优惠券，全场购物按商品金额的15%减免，30天内有效!";
	        	TicketCrd tktcrd=new TicketCrd();
	   		 tktcrd.setTktcrd_cardno(cardno);
	   		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
	   		 tktcrd.setTktcrd_value(new Long(gdsvalue));
	   		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
	   		 tktcrd.setTktcrd_discount(new Float(0.15));
	   		 tktcrd.setTktcrd_type("004001");
	   		 tktcrd.setTktcrd_rackcode("017");
	   		 tktcrd.setTktcrd_createdate(new Date());
	   		 tktcrd.setTktcrd_validflag(new Long(1));
	   		 tktcrd.setTktcrd_enddate(enddate);
	   		 tktcrd.setTktcrd_validates(startdate);
	   		 tktcrd.setTktcrd_validatee(enddate);
	   		 tktcrd.setTktcrd_brandname("");
	   		 tktcrd.setTktcrd_memo("网易活动抽奖！");
	   		 tktcrd.setTktcrd_payid(new Long(-1));
	   		 Tools.getManager(TicketCrd.class).create(tktcrd);
	   		 ret=1;
		 }
	 }
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	 lotwinact.setLotwin8zn_uid(mbruid);
	 lotwinact.setLotwin8zn_winid(new Long(tkttype));
	 lotwinact.setLotwin8zn_memo(memotxt);
	 lotwinact.setLotwin8zn_winname(winname);
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
	 return ret;
}
%><%
User lUser = UserHelper.getLoginUser(request, response);

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2012-11-1");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print("&roulette=999&rouletteStr=抽奖活动已经结束");
	return;
}
if(lUser==null) {
	out.print("&roulette=998&rouletteStr=请先登录或注册！");
	return;
}

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
String stime=df3.format(new Date())+" 00:00:00";
String etime =df3.format(new Date())+" 23:59:59";
java.util.Date   starttime=df2.parse(stime); 
java.util.Date   endtime=df2.parse(etime);

String mbrid=lUser.getId();
String mbruid=lUser.getMbrmst_uid();


List<SimpleExpression> clistcount = new ArrayList<SimpleExpression>();
clistcount.add(Restrictions.ge("lotwin8zn_createtime", starttime));
clistcount.add(Restrictions.le("lotwin8zn_createtime", endtime));
clistcount.add(Restrictions.eq("lotwin8zn_mbrid", new Long(lUser.getId())));

int count=Tools.getManager(LotWinAct.class).getLength(clistcount);
if (count>=1){
	out.print("&roulette=998&rouletteStr=一个用户一天只能抽一次！");
	return;
}

long rndround=42;
int ret=0;
boolean lotactret=false;
lotactret=getLotAct(lUser.getId());
if(!lotactret){
	out.print("&roulette=999&rouletteStr=您还没有抽奖机会，请先输入抽奖码获取抽奖机会吧！");
	return;
}
ArrayList<LotCon> list=getLotCon();
if(list!=null && list.size()>0){
	LotCon lotcon=list.get(0);
	int lotcode=(int)lotcon.getLotcon_winid().longValue();
	long lotcodevalue=0;
	 if(lotcode==7){
		 rndround=312;
		 ret=addtkt(7,mbrid,mbruid,1,request, response);
		   if(ret==1){
			   System.out.println("d1gjl-------typid=7错误");
			   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
			   return; }
	 }else if(lotcode==8){
		 rndround=270;
		 ret=addtkt(8,mbrid,mbruid,2,request, response);
		 if(ret==1){
			   System.out.println("d1gjl-------typid=8错误");
		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
		   return;   }
	 }else{
		   rndround=42;
		   addtkt(1,mbrid,mbruid,2,request, response);
		   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
		   return;
	 }
	 lotcon.setLotcon_flag(new Long(1));
	 Tools.getManager(LotCon.class).update(lotcon, false);
	 System.out.println("&roulette="+rndround+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 out.print("&roulette="+rndround+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 return;
}
else{
	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(1000);
 
   /*
1-----100元服饰券 20%    801-1000
2-----时尚家居拖鞋 0元  20%    601-800
3-----水晶项链  29元 20%   401-600
4-----小栗舍大衣 79元  20%       201-400
5-----马甲159% 89元 11-200
6-----5元现金券 （5元）1%       1-10
1  女大衣
2  100元券
3  饰品
4  马甲
5  5元优惠券
6  拖鞋
7  手表
8  1000元券
312
270
case 2:
	lotcodevalue=224;
case 3:
	lotcodevalue=180;
	134
case 4:
	lotcodevalue=90;
case 5:
	lotcodevalue=42;
case 6:
	lotcodevalue=2;
	1000元现金券：恭喜您，抽中1000元现金券，已存入您的优惠券，请在2012年12月31日前使用
	阿玛尼情侣表：恭喜您，抽中阿玛尼情侣表一对，请到购物车领取
	100元服饰券：恭喜您，抽中100元服饰现金券一张，已存入您的优惠券，30天内有效
	时尚家居拖鞋：恭喜您，抽中时尚家居拖鞋一双，请到购物车领取
	5元现金券：恭喜您，抽中5元现金券一张，已存入您的优惠券，30天内有效
	大衣120元减免券：恭喜您，抽中羊毛呢大衣120元减免券，此商品已经加入购物车，购物车直接减免
	棉马甲70元减免：恭喜您，抽中棉马甲70元减免券，此商品已经加入购物车，购物车直接减免
	项链130元减免券：恭喜您，抽中水晶项链130元减免券，此商品已经加入购物车，购物车直接减免
    */
   if (rndvalue>800){
	   rndround=42;
	   ret=addtkt(1,mbrid,mbruid,2,request, response);
	   
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
	   return;
   }
    else if(rndvalue>600 && rndvalue<=800){
    	rndround=224;
	   ret=addtkt(2,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您，抽中原售39元的小栗舍长袖打底衫20元减免券，商品已加入您的购物车，仅需19元！");
	   }else{
		   System.out.println("d1gjl-------typid=2错误");
		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
		   }
	   return;
   }
   else if(rndvalue>400 && rndvalue<=600){
	   rndround=90;
	   ret=addtkt(3,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您，抽中原价159元的YOUSOO水晶项链130元减免券，此商品已加入您的购物车，购物车直接减免，仅需29元！!");
      }else{
    	  System.out.println("d1gjl-------typid=3错误");
		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
	   }
	   return;
   }
   else if(rndvalue>200 && rndvalue<=400){
	   rndround=2;
	   ret=addtkt(4,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您，抽中原价199元的小栗舍羊毛呢大衣120元减免券，此商品已加入您的购物车，购物车直接减免，仅需79元！");
        }else{
        	System.out.println("d1gjl-------typid=4错误");
 		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
	   }
      return;
   }
   else if(rndvalue>10 && rndvalue<=200){
	   rndround=134;
	   ret=addtkt(5,mbrid,mbruid,1,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您，抽中原价159元的FEEL MIND棉马甲70元减免券，此商品已加入您的购物车，购物车直接减免，仅需89元！!");
       }else{
    	   System.out.println("d1gjl-------typid=5错误");
		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
	   }
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=10){
	   rndround=180;
	   ret=addtkt(6,mbrid,mbruid,2,request, response);
	   if(ret==0){
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得5元优惠券，全场通用，30天内有效,请进入我的帐户中查询!");
        }else{
        	  System.out.println("d1gjl-------typid=6错误");
 		   out.print("&roulette=42&rouletteStr=恭喜您获得100元服饰优惠券，全场服装饰品商品金额按15％减免，30天内有效,请进入我的帐户中查询!");
	   }
	   return;
   }

}

%>