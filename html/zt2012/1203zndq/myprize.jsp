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
	        	winname="恭喜您获得100元优惠券，全场购满300元可用，30天内有效!";
                break;
	        case 2:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场通用，30天内有效!";
	            break;
	        case 3:
	        	cardvalue=20;
	        	gdsvalue=20;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场通用，30天内有效!";
	            break;
	        case 4:
	        	cardvalue=20;
	        	gdsvalue=100;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场购满100元可用，30天内有效!";
	            break;
	        case 5:
	        	cardvalue=100;
	        	gdsvalue=100;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元优惠券，全场购物按商品金额的15%减免，30天内有效!";
	            break;
	        case 6:
	        	cardvalue=10;
	        	gdsvalue=50;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场购满50元可用，30天内有效!";
	            break;
	        case 7:
	        	cardvalue=10;
	        	gdsvalue=100;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场购满100元可用，30天内有效!";
	            break;
	        case 8:
	        	cardvalue=50;
	        	gdsvalue=200;
	        	memotxt="50元优惠券";
	        	winname="恭喜您获得50元优惠券，全场购满200元可用，30天内有效!";
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
		 tktcrd.setTktcrd_memo("9周年活动！");
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
         tktmst.setTktmst_memo("9周年活动！");
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
	 dStartDate =fmt.parse("2012-4-1");
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

List<SimpleExpression> clistcount = new ArrayList<SimpleExpression>();
clistcount.add(Restrictions.ge("lotwin8zn_createtime", starttime));
clistcount.add(Restrictions.le("lotwin8zn_createtime", endtime));
clistcount.add(Restrictions.eq("lotwin8zn_mbrid", new Long(lUser.getId())));

int count=Tools.getManager(LotWinAct.class).getLength(clistcount);
if (count>=3){
	out.print("&roulette=998&rouletteStr=一个用户一天只能抽三次！");
	return;
}

float upoint = UserScoreHelper.getRealScore(lUser.getId());//用户的总积分
long total_point_for_cut=100;
if(upoint>=total_point_for_cut){//如果有积分兑换商品，减用户的积分
	List<SimpleExpression> clist123 = new ArrayList<SimpleExpression>();
	clist123.add(Restrictions.eq("usrscore_mbrid", new Long(lUser.getId())));
	clist123.add(Restrictions.gt("usrscore_realscr", new Float(0)));

	List<Order> olist123 = new ArrayList<Order>();
	olist123.add(Order.asc("usrscore_createdate"));
	
	List<BaseEntity> listus123 = Tools.getManager(UserScore.class).getList(clist123, null, 0, 1000);//用户所有积分记录
	if(listus123!=null&&listus123.size()>0){
		for(int i=0;i<listus123.size();i++){
			UserScore us = (UserScore)listus123.get(i);
			if(total_point_for_cut>0){
				if(us.getUsrscore_realscr()!=null){
					if(us.getUsrscore_realscr().longValue()>=total_point_for_cut){
     					us.setUsrscore_realscr(Tools.getFloat(new Float(us.getUsrscore_realscr().longValue()-total_point_for_cut),2));
						Tools.getManager(UserScore.class).update(us, false);
						total_point_for_cut = 0;//扣完了
					}else{
						total_point_for_cut = total_point_for_cut-us.getUsrscore_realscr().longValue();
						us.setUsrscore_realscr(new Float(0));
						Tools.getManager(UserScore.class).update(us, false);

					}
				}
			}
		}
	}else{
		out.print("&roulette=999&rouletteStr=您的积分不足100，不能参与抽奖，送祝福得积分！");
		return;
	}

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
	        	lotcodevalue=2;
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
	 System.out.println("&roulette="+lotcodevalue+"&rouletteStr="+lotcon.getLotcon_winname()+"");
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
1-----100元购物券（300-100）2%    980-1000
2-----10元购物券（10-10）  30%     680-980
3-----20元购物券（20-20）10%      580-680
4-----20元购物券（100-20）15%     430-580
5-----100元购物券（15元减免）10%   330-430
6-----10元购物券（50-10）10%       230-330
7-----10元购物券（100-10）15%      80-230
8-----50元购物券（200-50）8%       1-80
   */
   if (rndvalue>980){
	   addtkt(1,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元优惠券，全场购满300元可用，30天内有效!");
	   return;
   }
   else if(rndvalue>680 && rndvalue<=980){
	   addtkt(2,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场通用，30天内有效!");
	   return;
   }
   else if(rndvalue>580 && rndvalue<=680){
	   addtkt(3,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得20元优惠券，全场通用，30天内有效!");
	   return;
   }
   else if(rndvalue>430 && rndvalue<=580){
	   addtkt(4,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得20元优惠券，全场购满100元可用，30天内有效!");
	   return;
   }
   else if(rndvalue>330 && rndvalue<=430){
	   addtkt(5,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得100元优惠券，全场购物商品金额按15％减免，30天内有效!");
	   return;
   }
   else if(rndvalue>230 && rndvalue<=330){
	   addtkt(6,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场购满50元可用，30天内有效!");
	   return;
   }
   else if(rndvalue>80 && rndvalue<=230){
	   addtkt(7,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得10元优惠券，全场购满100元可用，30天内有效!");
	   return;
   }
   else if(rndvalue>=0 && rndvalue<=80){
	   addtkt(8,mbrid,mbruid);
	   out.print("&roulette="+rndround+"&rouletteStr=恭喜您获得50元优惠券，全场购满200元可用，30天内有效!");
	   return;
   }

}
}
else{
	out.print("&roulette=999&rouletteStr=您的积分不足100，不能参与抽奖，送祝福得积分！");
	return;
}
%>