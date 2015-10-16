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
java.io.*,
com.d1.bean.LotCon"%><%
User lUser = UserHelper.getLoginUser(request, response);
%><%!

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

private void addtkt(int tkttype,String mbrid,String mbruid){
	long cardvalue=0;
	long gdsvalue=0;
	String memotxt="";
	String winname="";
	 switch (tkttype)
	    {
	        case 1:
	        	cardvalue=100;
	        	gdsvalue=300;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元优惠券，全场购满300元可用，15天内有效!";
                break;
	        case 2:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场通用，15天内有效!";
	            break;
	        case 3:
	        	cardvalue=20;
	        	gdsvalue=20;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场通用，15天内有效!";
	            break;
	        case 4:
	        	cardvalue=20;
	        	gdsvalue=100;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场购满100元可用，15天内有效!";
	            break;
	        case 5:
	        	cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元优惠券，全场购物按商品金额的15%减免，15天内有效!";
	            break;
	        case 6:
	        	cardvalue=10;
	        	gdsvalue=50;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场购满50元可用，15天内有效!";
	            break;
	        case 7:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场购满100元可用，15天内有效!";
	            break;
	        case 8:
	        	cardvalue=50;
	        	gdsvalue=200;
	        	memotxt="50元优惠券";
	        	winname="恭喜您获得50元优惠券，全场购满200元可用，15天内有效!";
	            break;
	    }
	 /*
	tktcrd_cardno,tktcrd_mbrid,tktcrd_value,tktcrd_realvalue,tktcrd_discount,
	tktcrd_type,tktcrd_validflag,tktcrd_enddate,tktcrd_validates,tktcrd_validatee,
	tktcrd_memo) values('"&cardnotitle&mbrid&randvalue&"',"&mbrid&","&gdsvalue&",
	"&cardvalue&",0.15,'004001',1,'"&now()+15&"','"&now()&"','"&now()+15&"','中秋抽奖活动券') ")

	
	 */
	 Random rndcard = new Random();
	 String cardno="ptaili1201"+mbrid+rndcard.nextInt(20000);
	 Date startdate=new Date();Date enddate=null;
	 try{
	 enddate=addDate(new Date(),15);
	 }
	 catch(Exception ex){
		 ex.printStackTrace();
	 }
	 if (tkttype==5){
		 TicketCrd tktcrd=new TicketCrd();
		 tktcrd.setTktcrd_cardno(cardno);
		 tktcrd.setTktcrd_mbrid(Tools.parseLong(mbrid));
		 tktcrd.setTktcrd_value(new Long(gdsvalue));
		 tktcrd.setTktcrd_realvalue(new Long(cardvalue));
		 tktcrd.setTktcrd_discount(new Float(0.15));
		 tktcrd.setTktcrd_type("004001");
		 tktcrd.setTktcrd_createdate(new Date());
		 tktcrd.setTktcrd_validflag(new Long(1));
		 tktcrd.setTktcrd_enddate(enddate);
		 tktcrd.setTktcrd_validates(startdate);
		 tktcrd.setTktcrd_validatee(enddate);
		 tktcrd.setTktcrd_memo("台历抽奖活动！");
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
		 tktmst.setTktmst_validatee(enddate);
		 tktmst.setTktmst_rackcode("000");
         tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("台历抽奖活动！");
         Tools.getManager(Ticket.class).create(tktmst);
	 }
	
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	 lotwinact.setLotwin8zn_uid(mbruid);
	 lotwinact.setLotwin8zn_winid(new Long(1));
	 lotwinact.setLotwin8zn_memo(memotxt);
	 lotwinact.setLotwin8zn_winname(winname);
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2012-2-1");
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
LotAct lotact=(LotAct)Tools.getManager(LotAct.class).findByProperty("lot8zn_mbrid",Tools.parseLong(lUser.getId()));
if(lotact==null){
	out.print("&roulette=999&rouletteStr=您还没有抽奖机会，请先输入台历券获取抽奖机会吧！");
	return;
}
if (lotact.getLot8zn_count()<=0){
	out.print("&roulette=999&rouletteStr=您还没有抽奖机会，请先输入台历券获取抽奖机会吧！");
	return;
}
lotact.setLot8zn_count(new Long(lotact.getLot8zn_count().longValue()-1));
Tools.getManager(LotAct.class).update(lotact, false);

ArrayList<LotCon> list=getLotCon();
if(list!=null && list.size()>0){
	LotCon lotcon=list.get(0);
	int lotcode=(int)lotcon.getLotcon_winid().longValue();
	long lotcodevalue=0;
	 switch (lotcode)
	    {
	        case 2:
	        	lotcodevalue=224;
	            break;
	        case 3:
	        	lotcodevalue=180;
	            break;
	        case 4:
	        	lotcodevalue=90;
	            break;
	        case 5:
	        	lotcodevalue=42;
	            break;
	        case 6:
	        	lotcodevalue=1;
	            break;
	        case 7:
	        	lotcodevalue=312;
	            break;
	        case 8:
	        	lotcodevalue=270;
	            break;
	    }
	 lotcon.setLotcon_flag(new Long(1));
	 Tools.getManager(LotCon.class).update(lotcon, false);
	 LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(lUser.getId()));
	 lotwinact.setLotwin8zn_uid(lUser.getMbrmst_uid());
	 lotwinact.setLotwin8zn_winid(new Long(lotcode));
	 lotwinact.setLotwin8zn_gdsid(lotcon.getLotcon_gdsid());
	 lotwinact.setLotwin8zn_memo(lotcon.getLotcon_name());
	 lotwinact.setLotwin8zn_winname(lotcon.getLotcon_winname());
	 lotwinact.setLotwin8zn_flag(new Long(0));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
	 out.print("&roulette="+lotcodevalue+"&rouletteStr="+lotcon.getLotcon_winname()+"");
	 return;
}
else{
	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(1000);
   long rndround=134;
   String mbrid=lUser.getId();
   String mbruid=lUser.getMbrmst_uid();
   /*
100元购物券（300-100）5%			600个300减100元券      1    大于950
10元购物券（10-10）  20%		2400个10元无限制券               2    大于750  小于等于950  
20元购物券（10-10）10%			1200个20元无限制券     3     大于650  小于等于750 3
20元购物券（100-20）20%			2400个100元减20元券  4    大于450  小于等于650 3
100元购物券（15元减免）10%			1200个15元减免    5    大于350  小于等于450 3
10元购物券（50-10）10%			1200个50减10元券         6   大于250  小于等于350 3
10元购物券（100-10）15%			1800个100-10元券         7    大于100  小于等于250 3
50元购物券（200-50）10%			1200个200减50券            8  0-100
   */
   if (rndvalue>950){
	   addtkt(1,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元优惠券，全场购满300元可用，15天内有效!");
	   return;
   }
   else if(rndvalue>750 && rndvalue<=950){
	   addtkt(2,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场通用，15天内有效!");
	   return;
   }
   else if(rndvalue>650 && rndvalue<=750){
	   addtkt(3,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得20元优惠券，全场通用，15天内有效!");
	   return;
   }
   else if(rndvalue>450 && rndvalue<=650){
	   addtkt(4,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得20元优惠券，全场购满100元可用，15天内有效!");
	   return;
   }
   else if(rndvalue>350 && rndvalue<=450){
	   addtkt(5,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元优惠券，全场购物商品金额按15％减免，15天内有效!");
	   return;
   }
   else if(rndvalue>250 && rndvalue<=350){
	   addtkt(6,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场购满50元可用，15天内有效!");
	   return;
   }
   else if(rndvalue>100 && rndvalue<=250){
	   addtkt(7,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场购满100元可用，15天内有效!");
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=100){
	   addtkt(8,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得50元优惠券，全场购满200元可用，15天内有效!");
	   return;
   }

}

%>