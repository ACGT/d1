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

private static String gettktbox(long num,long gdsvalue,long hcount){
	StringBuilder strb=new StringBuilder();
	
	strb.append("<table width=\"450\" height=\"300\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#D70B52\">");
	strb.append("<tr><td width=\"151\" height=\"95\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/logo11.jpg\" width=\"135\" height=\"79\" /></td>");
	strb.append("<td colspan=\"2\" class=\"cjboxt\">恭喜您！</td> </tr>");
	strb.append("<tr> <td height=\"80\" colspan=\"3\"><table width=\"450\" height=\"80\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr> <td width=\"165\" align=\"right\" class=\"cjboxtxt\">抽中一张</td>");
	strb.append("<td width=\"82\" class=\"cjboxnum\">"+num+"</td> <td width=\"203\" class=\"cjboxtxt\">元购物券");
	if(num>=gdsvalue){
	  strb.append("<span class=\"cjboxbq\">全场无限制</span></td>");
	}else{
	  strb.append("<span class=\"cjboxbq\">满"+gdsvalue+"可用</span></td>");
	}
	strb.append("</tr></table> </td> </tr><tr><td>&nbsp;</td>");
    strb.append("<td width=\"160\"><a href=\"#\" onclick=\"javascript:$.close();\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/butjx.jpg\" width=\"81\" height=\"31\" /></a></td>");
	strb.append("<td width=\"139\">&nbsp;</td></tr>");
	strb.append("<tr><td colspan=\"3\" align=\"center\" class=\"cjboxgdst\">您还有"+(2-hcount)+"次抽奖机会！</td></tr>");
	strb.append("<tr><td height=\"39\" colspan=\"3\" align=\"center\" class=\"cjboxgdst\">购物券已经发放到您的账户，购物流程可使用</td>");
	strb.append(" </tr><tr><td height=\"38\"></td><td><a href=\"http://www.d1.com.cn/user/ticket.jsp\" target=\"_blank\"><span style=\"color:#fff\">查看购物券</span></a>&nbsp;&nbsp;<a href=\"http://help.d1.com.cn/hphelpnew.htm?code=0105\" target=\"_blank\"><span style=\"color:#fff\">使用帮助</span></a></td><td></td></tr></table>");
	return strb.toString();
}
private static String getgdsbox(LotWinAct lot,long hcount){
	Product product = ProductHelper.getById(lot.getLotwin8zn_gdsid());
	String smallimg=product.getGdsmst_smallimg();
	if(smallimg.startsWith("/shopimg/gdsimg")){
		smallimg = "http://images1.d1.com.cn"+smallimg;
	}else{
		smallimg = "http://images.d1.com.cn"+smallimg;
	} 
	String gdsname=Tools.clearHTML(product.getGdsmst_gdsname());
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"450\" height=\"356\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#D70B52\">");
	strb.append("<tr><td width=\"151\" height=\"95\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/logo11.jpg\" width=\"135\" height=\"79\" /></td>");
	strb.append("<td colspan=\"2\" class=\"cjboxt\">恭喜您！</td></tr>");
	strb.append("<tr> <td height=\"80\" colspan=\"3\"><table width=\"450\" height=\"80\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td align=\"center\" class=\"cjboxtxt\">您真是太太太幸运了！<br /> 抽中一张产品优惠券！</td> </tr>");
	strb.append(" </table>    </td></tr>");
    strb.append("<tr><td colspan=\"2\" rowspan=\"4\"><table height=\"116\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td width=\"117\" rowspan=\"2\" align=\"center\"><a href=\"/product/"+product.getId()+"\" target=\"_blank\" ><img src=\""+smallimg+"\" width=\"80\" height=\"80\" /></a></td>");
	strb.append("<td height=\"81\" colspan=\"2\" class=\"cjboxgdst\"><a href=\"/product/"+product.getId()+"\" target=\"_blank\" ><span style=\"color:#fff\">"+gdsname+"</span></a></td></tr>");
	strb.append("<tr><td width=\"157\" height=\"35\" class=\"cjboxgdst\">市场价："+Tools.getFormatMoney(product.getGdsmst_saleprice())+"</td><td width=\"176\" class=\"cjboxgdst\">会员价："+Tools.getFormatMoney(product.getGdsmst_memberprice())+"</td>");
	strb.append("</tr></table></td><td width=\"139\" height=\"35\"><a href=\"#\" onclick=\"javascript:$.close();\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/butjx.jpg\"  width=\"81\" height=\"31\" /></a></td>");
	strb.append("</tr><tr><td height=\"25\" class=\"cjboxgdst\">您还有"+(2-hcount)+"次抽奖机会！</td></tr>");
	strb.append("<tr> <td><a href=\"/flow.jsp\" target=\"_blank\" ><img src=\"http://images.d1.com.cn/zt2013/cj1311/5.png\" alt=\"查看购物车\" /></a></td>");
	strb.append("</tr><tr><td>&nbsp;</td></tr>");
	strb.append("<tr><td height=\"43\" colspan=\"3\" align=\"center\" class=\"cjboxgdsp\">幸运价：<span style=\"font-size:50px;\">"+lot.getLotwin8zn_flag()+"</span></td>");
	strb.append("</tr><tr><td height=\"22\">&nbsp;</td><td width=\"160\">&nbsp;</td>");
	strb.append(" <td>&nbsp;</td></tr></table>");
return strb.toString();
}
private static String geterror(String err){
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"450\" height=\"300\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#D70B52\">");
	strb.append("<tr><td height=\"95\"><img src=\"http://images.d1.com.cn/zt2013/cj1311/logo11.jpg\" width=\"135\" height=\"79\" /></td>");
	strb.append("</tr><tr>");
	strb.append("<td height=\"80\"><table width=\"450\" height=\"80\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td align=\"center\" class=\"cjboxtxt\">"+err+"</td>");
	strb.append("</tr></table>    </td> </tr> <tr> <td><div class=\"lotbutton\"><input name=\"but\" type=\"button\" class=\"layer_button\" onclick=\"javascript:$.close();\" onmousemove=\"this.className='layer_button_over'\" onmouseout=\"this.className='layer_button'\" value=\"关　　闭\"/></div></td> </tr></table>");
	return strb.toString();
}

private static ArrayList<LotCon> getLotCon(long winid,long sex){
	ArrayList<LotCon> list=new ArrayList<LotCon>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("lotcon_flag", new Long(0)));
	clist.add(Restrictions.eq("lotcon_winid", new Long(winid)));
	/*if(sex==1){
		clist.add(Restrictions.ne("Lotcon_winid", new Long(0)));
	}else{
		clist.add(Restrictions.ne("Lotcon_winid", new Long(1)));
	}*/
	
	List<BaseEntity> mxlist= Tools.getManager(LotCon.class).getList(clist, null, 0, 200);
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


private static LotWinAct addcard(long sex,String mbrid,String mbruid,long winid,HttpServletRequest request,HttpServletResponse response){
	
	ArrayList<LotCon> list=getLotCon(winid,sex);
	long wincount=0;
	String gdsid="";
	double gdsprice=0f;
	long lotcount=0;
	String memotxt="";
	String winname="";
	if(list!=null && list.size()>0){
		 Random rnd = new Random();
		 
		   int rndvalue=(int)rnd.nextInt(list.size());
		LotCon lotcon=list.get(rndvalue);
		wincount=lotcon.getLotcon_wincount().longValue();
		lotcount=lotcon.getLotcon_count().longValue();
		gdsid=lotcon.getLotcon_gdsid();
		gdsprice=lotcon.getLotcon_price().doubleValue();
		winname=lotcon.getLotcon_winname();
		//memotxt=lotcon.getLotcon_memo();
		
		if(wincount>=lotcount){
			lotcon.setLotcon_flag(new Long(2));
			Tools.getManager(LotCon.class).update(lotcon, true);
			return null;
			
		}
	Product product = ProductHelper.getById(gdsid);
	if(product == null){
		return null;
	}
	//商品是否在架上
	if(Tools.longValue(product.getGdsmst_validflag()) != 1&&Tools.longValue(product.getGdsmst_validflag()) != 4){
		return null;
	}
	lotcon.setLotcon_wincount(new Long(wincount+1));
	 Tools.getManager(LotCon.class).update(lotcon, true);
	Cart cart = new Cart();
	cart.setAmount(new Long(1));
	cart.setCookie(CartHelper.getCartCookieValue(request, response));
	cart.setCreateDate(new Date());
	cart.setHasChild(new Long(0));
	cart.setHasFather(new Long(0));
	cart.setIp(request.getRemoteHost());
	cart.setMoney(Tools.getFloat(new Float(gdsprice),2));
	cart.setOldPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
	cart.setPoint(new Long(0));
	cart.setPrice(Tools.getFloat(new Float(gdsprice),2));
	cart.setSkuId("");//?
	cart.setTuanCode("");//注意parentId值
	cart.setProductId(gdsid.trim());
	cart.setType(new Long(15));
	cart.setShopcode(product.getGdsmst_shopcode());
	cart.setUserId(CartHelper.getCartUserId(request, response));
	cart.setVipPrice(Tools.getFloat(new Float(gdsprice),2));
	cart.setTitle("【签到活动抽奖】"+Tools.clearHTML(product.getGdsmst_gdsname()));
	
	Tools.getManager(Cart.class).create(cart);
	
	
	LotWinAct lotwinact=new LotWinAct();
	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	 lotwinact.setLotwin8zn_uid(mbruid);
	 lotwinact.setLotwin8zn_gdsid(gdsid);
	 lotwinact.setLotwin8zn_winid(new Long(winid));
	 if(gdsprice>0){
	 lotwinact.setLotwin8zn_memo("恭喜您获得"+winname+"的惊喜独享价购买资格");
	 }else{
		 lotwinact.setLotwin8zn_memo("恭喜您免费获得"+winname);
	 }
	 lotwinact.setLotwin8zn_winname(winname);
	 lotwinact.setLotwin8zn_flag(new Long((long)(gdsprice)));
	 lotwinact.setLotwin8zn_createtime(new Date());
	 Tools.getManager(LotWinAct.class).create(lotwinact);
	return lotwinact;
	}else{
		return null;
	}
}

private static String addtkt(long hcount,long sex,int tkttype,String mbrid,String mbruid,int flag,HttpServletRequest request,HttpServletResponse response){
	long cardvalue=0;
	long gdsvalue=0;
	String ret="";
	String memotxt="";
	String winname="";
	String gdsid="";
	float gdsprice=0;

	/*
//10元购物卷范围1-1000,占购物卷概率20%                  7  
//满100减20购物卷范围1001-3000,占购物卷概率40%          6
//满200减50购物卷范围3001-4950，占购物卷概率39%         5
//100元购物卷范围4951-5000，占购物卷概率1%              4
//内定产品范围5001-9500，占购物卷概率45%                3
//0元产品（小商品）范围9501-9995，占购物卷概率99%       2
//0元产品（大件）范围9996-10000，占购物卷概率1%         1									

*/
LotWinAct lot=null;
	 switch (tkttype)
	    {
	        case 1:
	        	 lot=addcard(sex,mbrid,mbruid,4,request,response);
	        	break;
	        case 2:
	        	 lot=addcard(sex,mbrid,mbruid,3,request,response);
	            break;
	        case 3:
	        	 lot=addcard(sex,mbrid,mbruid,2,request,response);
	        	break;
	        case 4:
	        	cardvalue=100;
	        	gdsvalue=10;
	        	memotxt="100元优惠券";
	        	winname="恭喜您获得100元优惠券，全场无限制，30天内有效!";
	        	ret=gettktbox(cardvalue,gdsvalue,hcount);
	            break;
	        case 5:
	        	cardvalue=50;
	        	gdsvalue=200;
	        	memotxt="50元优惠券";
	        	winname="恭喜您获得50元优惠券，全场购满200元可用，30天内有效!";
	        	ret=gettktbox(cardvalue,gdsvalue,hcount);
	            break;
	        case 6:
	        	cardvalue=20;
	        	gdsvalue=100;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场购满100元可用，30天内有效!";
	        	ret=gettktbox(cardvalue,gdsvalue,hcount);
	            break;
	        case 7:
	        	cardvalue=10;
	        	gdsvalue=10;
	        	memotxt="10元优惠券";
	        	winname="恭喜您获得10元优惠券，全场通用，30天内有效!";
	        	ret=gettktbox(cardvalue,gdsvalue,hcount);
	            break;
	    }
	
	 Random rndcard = new Random();
	 String cardno="cjhd1311"+mbrid+rndcard.nextInt(20000);
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
         tktmst.setTktmst_memo("签到活动抽奖！");
         Tools.getManager(Ticket.class).create(tktmst);
         LotWinAct lotwinact=new LotWinAct();
    	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
    	 lotwinact.setLotwin8zn_uid(mbruid);
    	 lotwinact.setLotwin8zn_winid(new Long(1));
    	 lotwinact.setLotwin8zn_memo(winname);
    	 lotwinact.setLotwin8zn_winname(winname);
    	 lotwinact.setLotwin8zn_flag(new Long(0));
    	 lotwinact.setLotwin8zn_createtime(new Date());
    	 Tools.getManager(LotWinAct.class).create(lotwinact);
		 }else{
		 
		
		 if(lot==null){
			 cardvalue=20;
	        	gdsvalue=100;
	        	memotxt="20元优惠券";
	        	winname="恭喜您获得20元优惠券，全场购满100元可用，30天内有效!";
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
	         tktmst.setTktmst_memo("签到活动抽奖！");
	         Tools.getManager(Ticket.class).create(tktmst);
	         LotWinAct lotwinact=new LotWinAct();
	    	 lotwinact.setLotwin8zn_mbrid(new Long(mbrid));
	    	 lotwinact.setLotwin8zn_uid(mbruid);
	    	 lotwinact.setLotwin8zn_winid(new Long(1));
	    	 lotwinact.setLotwin8zn_memo(winname);
	    	 lotwinact.setLotwin8zn_winname(winname);
	    	 lotwinact.setLotwin8zn_flag(new Long(0));
	    	 lotwinact.setLotwin8zn_createtime(new Date());
	    	 Tools.getManager(LotWinAct.class).create(lotwinact);
	    		ret=gettktbox(cardvalue,gdsvalue,hcount);
		 }else{
        	 ret=getgdsbox(lot,hcount);
		 }
	 }
	 
	 return ret;
}
%>

<%
User lUser = UserHelper.getLoginUser(request, response);

SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2013-11-11");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	//out.print("抽奖活动已经结束");
	//out.print("{\"code\":0,\"message\":\"抽奖活动已经结束！\"}");
	out.print(geterror("抽奖活动已经结束！"));
	return;
}
if(lUser==null) {
	//out.print("请先登录或注册！");
	//out.print("{\"code\":0,\"message\":\"\"}");
	out.print(geterror("请先登录或注册！"));
	return;
}
if(lUser.getMbrmst_phoneflag()==null||lUser.getMbrmst_phoneflag().longValue()==0){
	out.print(geterror("亲，参加这个活动是需要手机验证的呦！！<br><a href=\"/newlogin/valitel.jsp\" target=\"_blank\"><span style=\"color:#FFFF00\">立即验证</span></a>"));
return;
}
/*
if(lUser.getMbrmst_bktstep() !=null||lUser.getMbrmst_bktstep().longValue() ==0){
	out.print("请验证性别！");
return;
}*/

SimpleDateFormat   df2=new   SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
SimpleDateFormat df3=new SimpleDateFormat("yyyy-MM-dd");
String stime=df3.format(new Date())+" 00:00:00";
String etime =df3.format(new Date())+" 23:59:59";
java.util.Date   starttime=df2.parse(stime); 
java.util.Date   endtime=df2.parse(etime);

String mbrid=lUser.getId();
String mbruid=lUser.getMbrmst_uid();
long sex=lUser.getMbrmst_sex();

List<SimpleExpression> clistcount = new ArrayList<SimpleExpression>();
clistcount.add(Restrictions.ge("lotwin8zn_createtime", starttime));
clistcount.add(Restrictions.le("lotwin8zn_createtime", endtime));
clistcount.add(Restrictions.eq("lotwin8zn_mbrid", new Long(lUser.getId())));

int count=Tools.getManager(LotWinAct.class).getLength(clistcount);
if (count>=3){
	//out.print("一个用户一天只能抽三次！");
	//out.print("{\"code\":0,\"message\":\"一个用户一天只能抽三次！\"}");
	out.print(geterror("一个用户一天只能抽三次！"));
	return;
}

String ret="";

	Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(10000);
   //System.out.println(rndvalue);
 // rndvalue=4952;
 
   /*
   Random rnd = new Random();
   long rndvalue=(long)rnd.nextInt(10000);
   long rndround=134;
   String mbrid=lUser.getId();
   String mbruid=lUser.getMbrmst_uid();
   /*
10		10000		50%	20%		0.2	0.5	0.1	            10000	 1000
100-20		10000			40%		0.4	0.5	0.2	        10000	2000
200-50		10000			39%		0.39	0.5	0.195	10000	1950
100		5			1%		0.01	0.5	0.005	        10000	50
														10000	
xxxxxxx	39	10000		45%	概率平均分布		0.45 0.45	10000	4500
xxxxxxx	49	10000										10000	
														10000	
鼠标垫	0	10000		5%			0.05				10000	
杯子	0	10000			99%		0.05	0.99	0.0495	10000	495
ipad	0	5			1%		0.05	0.01	0.0005	10000	5
iphone	0	5									
//10元购物卷范围1-1000,占购物卷概率20%                  7  
//满100减20购物卷范围1001-3000,占购物卷概率40%          6
//满200减50购物卷范围3001-4950，占购物卷概率39%         5
//100元购物卷范围4951-5000，占购物卷概率1%              4
//内定产品范围5001-9500，占购物卷概率45%                3
//0元产品（小商品）范围9501-9995，占购物卷概率99%       2
//0元产品（大件）范围9996-10000，占购物卷概率1%         1
   */
   if (rndvalue>9995){//免费大额
	   boolean addcardret=false;
	   ret=addtkt(count,sex,1,mbrid,mbruid,1,request, response);
	   out.print(ret);
	   return;
   }
   else if(rndvalue>9501 && rndvalue<=9995){//免费小额
	   ret=addtkt(count,sex,2,mbrid,mbruid,1,request, response);
	   out.print(ret);
	   return;
   }
   else if(rndvalue>5001 && rndvalue<=9500){//收费
	   ret=addtkt(count,sex,3,mbrid,mbruid,1,request, response);
	   out.print(ret);
	   return;
   }
   else if(rndvalue>4951 && rndvalue<=5000){
	   List<SimpleExpression> clist100 = new ArrayList<SimpleExpression>();
	   clistcount.add(Restrictions.ge("lotwin8zn_createtime", starttime));
	   clistcount.add(Restrictions.le("lotwin8zn_createtime", endtime));
	   clistcount.add(Restrictions.eq("lotwin8zn_winname", "恭喜您获得100元优惠券，全场无限制，30天内有效!"));

	   int count100=Tools.getManager(LotWinAct.class).getLength(clist100);
	   if(count100>=5){
		   ret=addtkt(count,sex,5,mbrid,mbruid,2,request, response);
	   }else{
		   ret=addtkt(count,sex,4,mbrid,mbruid,2,request, response);
	   }
	   
	   
	   out.print(ret);
	   return;
   }
   else if(rndvalue>3001 && rndvalue<=4950){
	   ret=addtkt(count,sex,5,mbrid,mbruid,2,request, response);
	   out.print(ret);
	   return;
   }
   else if(rndvalue>1001 && rndvalue<=3000){
	   ret=addtkt(count,sex,6,mbrid,mbruid,2,request, response);
	   out.print(ret);
	   return;
   }else if(rndvalue>=0 && rndvalue<=1000){
	   ret=addtkt(count,sex,7,mbrid,mbruid,2,request, response);
	   out.print(ret);
	   return;
   }




%>