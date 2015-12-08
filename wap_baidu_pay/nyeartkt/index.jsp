<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%!
private static String gettkt(User lUser,String cardno){
SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

Date dStartDate=null;
try{
	 dStartDate =fmt.parse("2015-01-01");
	 }
catch(Exception ex){
	ex.printStackTrace();
}
if(Tools.dateValue(dStartDate)<System.currentTimeMillis())
{
	return "券号已失效";
}


if(lUser==null) {
	return "<a href=\"http://m.d1.cn/wap/login.jsp?url=/wap/nyeartkt/index.jsp\">请先登录或注册！</a>";
}



if(!cardno.equals("2014youshang322")&&!cardno.startsWith("2014mg")){
	return "券号错误！";
}
//2014youshang322   通用券
//券头是：2014mg
TicketPwd tp = (TicketPwd)Tools.getManager(TicketPwd.class).findByProperty("tktpwd_cardno", cardno);
if(tp==null){
	return "券号不存在！";
}

if(tp.getTktpwd_tktstartdate()!=null&&tp.getTktpwd_tktenddate()!=null){
	if(tp.getTktpwd_tktstartdate().getTime()>System.currentTimeMillis()||
			tp.getTktpwd_tktenddate().getTime()<System.currentTimeMillis()){
		return "券号已过期！";
	}
}

if(tp.getTktpwd_sendcount()!=null&&tp.getTktpwd_maxcount()!=null){
	if(tp.getTktpwd_sendcount().longValue()>=tp.getTktpwd_maxcount().longValue()){
		return "券号使用次数已超过限制！";
	}
}

List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
clist.add(Restrictions.eq("tktmst_mbrid", new Long(lUser.getId())));//会员已经刮开的记录
clist.add(Restrictions.eq("tktmst_cardno", cardno));//会员已经刮开的记录

int sendcount = Tools.getManager(Ticket.class).getLength(clist);

if(tp.getTktpwd_everymaxcount()!=null&&(long)sendcount>=tp.getTktpwd_everymaxcount().longValue()){
	return "使用次数已超过限制！";
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
	return "激活成功";
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
		
	return "激活成功";
}
return "激活成功";
}
%>
<%if(UserHelper.getLoginUser(request,response) == null){
	response.sendRedirect("/wap/login.jsp?url=/wap/nyeartkt/index.jsp");
	return;
}%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>免费送200元购物券激活</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>"
	type="text/css" rel="stylesheet" />
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="/user/index.jsp">我的优尚</a>><a
				href="/user/ticket.jsp">我的优惠券</a> >激活优惠券 <br />
		</div>


		<%
    String msg="";
    if ("post".equals(request.getMethod().toLowerCase())) {
    	if(!Tools.isNull(request.getParameter("ticketcode"))){
    		msg=gettkt(lUser,request.getParameter("ticketcode"));
    	}else{
    		msg="请输入优惠券号码!";
    	}
    }
    %>
		<br /> <span style="color: red; font-size: 16px;"><%=msg %></span><br />
		<br />
		<%if (msg.equals("激活成功")){  %>
		<a href="/wap/user/ticket.jsp">查看优惠券</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="/mindex.jsp">现在去购物</a>
		<%} %>
		<span style="color: #F00">200元优惠券激活</span><br />
		<form action="index.jsp" method="post">
			优惠券码:
			<input type="text" id="ticketcode" name="ticketcode" />
			<br />
			<input type="submit" id="activetickets"
				style="width: 70px; height: 26px;" value="激活" />
		</form>
		<br /> <a href="/user/ticket.jsp">查看我的优惠券>></a> <br /> 返回 <a
			href="/user/index.jsp">我的优尚</a>
	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

