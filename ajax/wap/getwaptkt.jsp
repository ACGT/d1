<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
private static String getgdsbox(String msg){
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"240\" height=\"300\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td width=\"17\" height=\"117\">&nbsp;</td>");
	strb.append("<td width=\"203\"  valign=\"top\" style=\"padding-top:15px;font-size:24px;\"><a onclick=\"closetktmsg(this)\" style=\"color:#ffffff;cursor:pointer; \">&nbsp;&nbsp;关闭&nbsp;&nbsp;</a></td>");
	strb.append("<td width=\"20\">&nbsp;</td> </tr>");
	strb.append("<tr>    <td height=\"82\">&nbsp;</td>");
	strb.append("<td class=\"tktmsg4\">"+msg+"</td>");
	strb.append("<td>&nbsp;</td>  </tr>");
	strb.append("<tr><td height=\"47\">&nbsp;</td>");
	strb.append("<td class=\"tktmsg5\">D1优尚全体员工祝您新春愉快阖家幸福！</td>");
	strb.append("<td>&nbsp;</td>  </tr>");
	strb.append("<tr>    <td>&nbsp;</td>");
	strb.append("<td><a href=\"/wap/user_mytkts.html\" ><div class=\"tktopbut\"></div></a></td>");
	strb.append("<td>&nbsp;</td>  </tr></table>");
return strb.toString();
}
private static String geterror(String err){
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"240\" height=\"300\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td width=\"17\" height=\"117\">&nbsp;</td>");
	strb.append("<td width=\"203\" align=\"center\" valign=\"top\" style=\"padding-top:15px;font-size:24px;\"><a onclick=\"closetktmsg(this)\" style=\"color:#ffffff;cursor:pointer; \">&nbsp;&nbsp;关闭&nbsp;&nbsp;</a></td>");
	strb.append("<td width=\"20\">&nbsp;</td> </tr>");
	strb.append("<tr>    <td height=\"82\">&nbsp;</td>");
	strb.append("<td class=\"tktmsg4\">"+err+"</td>");
	strb.append("<td>&nbsp;</td>  </tr>");
	strb.append("<tr><td height=\"47\">&nbsp;</td>");
	strb.append("<td class=\"tktmsg5\">D1优尚全体员工祝您新春愉快阖家幸福！</td>");
	strb.append("<td>&nbsp;</td>  </tr>");
	strb.append("<tr>    <td>&nbsp;</td>");
	strb.append("<td><a href=\"/wap/user_mytkts.html\" ><div class=\"tktopbut\"></div></a></td>");
	strb.append("<td>&nbsp;</td>  </tr></table>");
	return strb.toString();
}
public static String getOrderMain(String mbrId,Date dStartDate,Date dsDate){
	if(Tools.isNull(mbrId))return null;
	ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
	listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(1)));
	listRes.add(Restrictions.ge("odrmst_orderdate",dsDate));
	listRes.add(Restrictions.le("odrmst_orderdate",dStartDate));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("odrmst_orderdate"));
	//加入main订单
	List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, listOrder, 0, 1000);
	
	if(list_main!=null&&list_main.size()>0){
		for(BaseEntity be:list_main){
			OrderBase ob = (OrderBase)be;
			
			if(ob.getOdrmst_customerword()!=null&&ob.getOdrmst_customerword().indexOf("新年赠券已领")==-1){
				return ob.getId();
			}
		}
	}
		List<BaseEntity> list_c = Tools.getManager(OrderCache.class).getList(listRes, listOrder, 0, 1000);
		
		if(list_c!=null&&list_c.size()>0){
			for(BaseEntity be:list_c){
				OrderBase ob = (OrderBase)be;
				
				if(ob.getOdrmst_customerword()!=null&&ob.getOdrmst_customerword().indexOf("新年赠券已领")==-1){
					return ob.getId();
				}
			}
		}

	

	
	return "";
}

public static String getOrderM2(String mbrId,Date dStartDate,Date dsDate){
	if(Tools.isNull(mbrId))return null;
	ArrayList<OrderBase> rlist = new ArrayList<OrderBase>();
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrmst_mbrid",new Long(mbrId)));
	listRes.add(Restrictions.ge("odrmst_orderstatus",new Long(1)));
	listRes.add(Restrictions.ge("odrmst_orderdate",dsDate));
	listRes.add(Restrictions.le("odrmst_orderdate",dStartDate));
	//加入main订单
	List<BaseEntity> list_main = Tools.getManager(OrderMain.class).getList(listRes, null, 0, 1000);
	
	if(list_main!=null&&list_main.size()>0){
		for(BaseEntity be:list_main){
			OrderBase ob = (OrderBase)be;
			if(ob.getOdrmst_customerword()!=null&&ob.getOdrmst_customerword().indexOf("新年赠券已领")==-1){
				return ob.getId();
			}
		}
	}
		
			List<BaseEntity> list_r = Tools.getManager(OrderRecent.class).getList(listRes, null, 0, 1000);
			
			if(list_r!=null&&list_r.size()>0){
				for(BaseEntity be:list_r){
					OrderBase ob = (OrderBase)be;
					
					if(ob.getOdrmst_customerword()!=null&&ob.getOdrmst_customerword().indexOf("新年赠券已领")==-1){
						return ob.getId();
					}
				}
			}


	
	return "";
}

public static boolean savetktmemo(String id) {
	try {
		String ordertbl = "main";
		OrderBase order = (OrderBase)Tools.getManager(OrderMain.class).get(id);
		if(order == null) {
			order = (OrderBase)Tools.getManager(OrderCache.class).get(id);
			ordertbl = "cache";
		}
		if(order == null) {
			order = (OrderBase)Tools.getManager(OrderRecent.class).get(id);
			ordertbl = "recent";
		}
		order.setOdrmst_customerword(order.getOdrmst_customerword()+"<font color=\"red\">新年赠券已领</font>");
		if(ordertbl.equals("main")) {
			Tools.getManager(OrderMain.class).update(order, true);
		}
		else if (ordertbl.equals("recent")) {
			Tools.getManager(OrderRecent.class).update(order, true);
		}
		else if (ordertbl.equals("cache")) {
			Tools.getManager(OrderCache.class).update(order, true);
		}
		return true;
	} catch (Exception e) {
		e.printStackTrace();
		return false;
	}
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
Date dStartDate=null;
Date dsDate=null;
try{
	 dStartDate =fmt.parse("2016-02-15");
	 dsDate =fmt.parse("2016-01-26");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print(geterror("对不起活动已经结束！"));
	return;
}

if(lUser==null) {
	out.print(geterror("请先登录或注册！"));
	return;
}
String odrid= getOrderMain(lUser.getId(),dStartDate,dsDate);
if(Tools.isNull(odrid))odrid= getOrderM2(lUser.getId(),dStartDate,dsDate);
if(Tools.isNull(odrid)){
	out.print(geterror("抱歉亲没有可以领券的订单，请下单后再来领取！"));
	return;
}
Random rnd = new Random();
			   long rndvalue=(long)rnd.nextInt(1000);
			  
			   
			float tktvalue=0;
			float gdsvalue=0;
			String tktrck="000";
			String tktcardno="odrnewyear160131";
			String memo="";
			 if(rndvalue<100){
     			tktvalue=30;
				gdsvalue=100;
			
				memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚30元购物券";
			 }else if(rndvalue>=100&&rndvalue<200){
				 tktvalue=20;
					gdsvalue=50;
					memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚20元购物券";
			 }else if(rndvalue>=200&&rndvalue<400){
				 tktvalue=8;
					gdsvalue=8;
					memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚8元购物券";
			 }else if(rndvalue>=400&&rndvalue<600){
				 tktvalue=12;
					gdsvalue=12;
					memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚12元购物券";
			 }else if(rndvalue>=600&&rndvalue<800){
				 tktvalue=50;
					gdsvalue=50;
					tktrck="017";
					memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚50元购物券";
			 }else if(rndvalue>=800){
				 tktvalue=100;
					gdsvalue=200;
					tktrck="017";
					memo="<font style=\"font-size:18px\">恭喜您！</font></br>获得了D1优尚100元购物券";
			 }

			String strtkt=tktcardno+lUser.getId()+rndvalue;
			//Ticket tktcard=(Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", strtkt);
			//if(tktcard == null) {
					Ticket tktmst=new Ticket();
					tktmst.setTktmst_value(new Float(tktvalue));
					tktmst.setTktmst_type("003005");
					tktmst.setTktmst_sodrid(odrid);
					tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
					tktmst.setTktmst_validflag(new Long(0));
					tktmst.setTktmst_createdate(new Date());
					tktmst.setTktmst_validates(new Date());
					tktmst.setTktmst_validatee(Tools.addDate(new Date(), 30));
					tktmst.setTktmst_rackcode(tktrck);
					tktmst.setTktmst_gdsvalue(new Float(gdsvalue));
					tktmst.setTktmst_payid(new Long(-1));
					tktmst.setTktmst_cardno(strtkt);
					tktmst.setTktmst_ifcrd(new Long(0));
					tktmst.setTktmst_memo("春节购物赠券！");
					Tools.getManager(Ticket.class).create(tktmst);
					savetktmemo(odrid);
					out.print(getgdsbox(memo));
					return;
				//}


%>