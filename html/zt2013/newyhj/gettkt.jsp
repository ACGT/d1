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
private static String getgdsbox(){
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"450\" height=\"300\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	strb.append("<tr> <td height=\"40\">&nbsp;</td> </tr>");
	strb.append("<tr> <td height=\"30\" align=\"center\" style=\"color:#F00\">优惠券已激活</td> </tr>");
	strb.append(" <tr> <td height=\"90\" align=\"center\"><a href=\"/user/ticket.jsp\" target=\"_blank\">");
	strb.append("<img src=\"http://images.d1.com.cn/zt2013/1231/viewtkt.jpg\" width=\"269\" height=\"66\" border=\"0\" /></a></td> </tr>");
	strb.append("<tr>    <td height=\"90\" align=\"center\"><a href=\"http://www.d1.com.cn\" target=\"_blank\">");
	strb.append("<img src=\"http://images.d1.com.cn/zt2013/1231/gobuy.jpg\" width=\"268\" height=\"65\" border=\"0\" /></a></td> </tr>");
		strb.append("<tr>  <td height=\"50\">&nbsp;</td></tr></table>");
return strb.toString();
}
private static String geterror(String err){
	StringBuilder strb=new StringBuilder();
	strb.append("<table width=\"450\" height=\"300\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#CCFF99\">");
	strb.append("<tr><td height=\"95\"></td>");
	strb.append("</tr><tr>");
	strb.append("<td height=\"80\"><table width=\"450\" height=\"80\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	strb.append("<tr><td align=\"center\" class=\"cjboxtxt\">"+err+"</td>");
	strb.append("</tr></table>    </td> </tr> <tr> <td align=\"center\"><div class=\"lotbutton\"><input name=\"but\" type=\"button\" class=\"layer_button\" onclick=\"javascript:$.close();\" onmousemove=\"this.className='layer_button_over'\" onmouseout=\"this.className='layer_button'\" value=\"关　　闭\"/></div></td> </tr></table>");
	return strb.toString();
}
%>
<%
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
User lUser = UserHelper.getLoginUser(request, response);
Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2015-01-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	out.print(geterror("券号已失效！"));
	return;
}


Date endDate=Tools.addDate(new Date(), 30);

if(lUser==null) {
	out.print(geterror("请先登录或注册！"));
	return;
}

String cardno=request.getParameter("cardno");

if(!cardno.equals("2014youshang322")&&!cardno.startsWith("2014mg")){
	out.print(geterror("券号错误！"));
	return;
}
//2014youshang322   通用券
//券头是：2014mg
TicketPwd tp = (TicketPwd)Tools.getManager(TicketPwd.class).findByProperty("tktpwd_cardno", cardno);
if(tp==null){
	out.print(geterror("券号不存在！"));
	return;
}

if(tp.getTktpwd_tktstartdate()!=null&&tp.getTktpwd_tktenddate()!=null){
	if(tp.getTktpwd_tktstartdate().getTime()>System.currentTimeMillis()||
			tp.getTktpwd_tktenddate().getTime()<System.currentTimeMillis()){
		out.print(geterror("券号已过期！"));
		return;
	}
}

if(tp.getTktpwd_sendcount()!=null&&tp.getTktpwd_maxcount()!=null){
	if(tp.getTktpwd_sendcount().longValue()>=tp.getTktpwd_maxcount().longValue()){
		out.print(geterror("券号使用次数已超过限制！"));
		return;
	}
}

List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
clist.add(Restrictions.eq("tktmst_mbrid", new Long(lUser.getId())));//会员已经刮开的记录
clist.add(Restrictions.eq("tktmst_cardno", cardno));//会员已经刮开的记录

int sendcount = Tools.getManager(Ticket.class).getLength(clist);

if(tp.getTktpwd_everymaxcount()!=null&&(long)sendcount>=tp.getTktpwd_everymaxcount().longValue()){
	out.print(geterror("使用次数已超过限制！"));
	return;
}
if(cardno.equals("2014mg")){
	Ticket t = new Ticket();
	t.setTktmst_baihuo(tp.getTktpwd_baihuo());
	t.setTktmst_cardno(cardno);
	t.setTktmst_createdate(new Date());
	t.setTktmst_downflag(new Long(0));
	t.setTktmst_gdsvalue(new Float(tp.getTktpwd_gdsvalue()));//满多少
	t.setTktmst_ifcrd(new Long(0));
	t.setTktmst_mbrid(new Long(lUser.getId()));
	t.setTktmst_memo(tp.getTktpwd_memo());
	t.setTktmst_payid(tp.getTktpwd_payid());
	t.setTktmst_rackcode(tp.getTktpwd_rackcode());
	t.setTktmst_sprckcodeStr(tp.getTktpwd_sprckcodeStr());
	t.setTktmst_validatee(tp.getTktpwd_tktenddate());
	t.setTktmst_validates(tp.getTktpwd_tktstartdate());
	t.setTktmst_validflag(new Long(0));//未使用
	t.setTktmst_value(new Float(tp.getTktpwd_value()));//减多少
	t.setTktmst_type("003005");
	t.setTktmst_brandname(tp.getTktpwd_brandname());
	t.setTktmst_memo("免费送200元购物券！");
	Tools.getManager(Ticket.class).create(t);
	out.print(getgdsbox());
	return;
}

if(cardno.equals("2014youshang322")){
	/*
	100-10   5张
299-25   2张
499-50   2张

	*/
	for (int i=1;i<=5;i++){
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(10));
		tktmst.setTktmst_type("003005");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(tp.getTktpwd_tktstartdate());
		tktmst.setTktmst_validatee(tp.getTktpwd_tktenddate());
		tktmst.setTktmst_rackcode("000");
		tktmst.setTktmst_gdsvalue(new Float(100));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno("2014youshang322");
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("免费送200元购物券！");
		Tools.getManager(Ticket.class).create(tktmst);
	}
	for (int i=1;i<=2;i++){
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(25));
		tktmst.setTktmst_type("003005");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(tp.getTktpwd_tktstartdate());
		tktmst.setTktmst_validatee(tp.getTktpwd_tktenddate());
		tktmst.setTktmst_rackcode("000");
		tktmst.setTktmst_gdsvalue(new Float(299));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno("2014youshang322");
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("免费送200元购物券！");
		Tools.getManager(Ticket.class).create(tktmst);
	}
	for (int i=1;i<=2;i++){
		Ticket tktmst=new Ticket();
		tktmst.setTktmst_value(new Float(50));
		tktmst.setTktmst_type("003005");
		tktmst.setTktmst_mbrid(Tools.parseLong(lUser.getId()));
		tktmst.setTktmst_validflag(new Long(0));
		tktmst.setTktmst_createdate(new Date());
		tktmst.setTktmst_validates(tp.getTktpwd_tktstartdate());
		tktmst.setTktmst_validatee(tp.getTktpwd_tktenddate());
		tktmst.setTktmst_rackcode("000");
		tktmst.setTktmst_gdsvalue(new Float(499));
		tktmst.setTktmst_payid(new Long(-1));
		tktmst.setTktmst_cardno("2014youshang322");
		tktmst.setTktmst_ifcrd(new Long(0));
		tktmst.setTktmst_memo("免费送200元购物券！");
		Tools.getManager(Ticket.class).create(tktmst);
	}
		
		out.print(getgdsbox());
		return;
}


%>


