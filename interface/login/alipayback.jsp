<%@ page contentType="text/html; charset=UTF-8" import="com.alipay.util.*,com.d1.bean.id.SequenceIdGenerator" %><%@include file="../../inc/header.jsp"%><%!

private static final Object obj = new Object();//同步锁

%><%
//获取支付宝GET过来反馈信息
Map<String,String> params = new HashMap<String,String>();
Map requestParams = request.getParameterMap();
for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
	String name = (String) iter.next();
	String[] values = (String[]) requestParams.get(name);
	String valueStr = "";
	for (int i = 0; i < values.length; i++) {
		valueStr = (i == values.length - 1) ? valueStr + values[i]
				: valueStr + values[i] + ",";
	}
	//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
	//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "UTF-8");
	//System.err.println(valueStr);
	params.put(name, valueStr);
}

//计算得出通知验证结果
boolean verify_result = AlipayNotify.verify(params);

if(verify_result){//验证成功
	//////////////////////////////////////////////////////////////////////////////////////////
	//请在这里加上商户的业务逻辑程序代码
	
	//支付宝用户id
	String user_id = request.getParameter("user_id");
	//授权令牌
	String token = request.getParameter("token");
	//支付宝用户名或昵称
	String real_name = request.getParameter("real_name");
	if(real_name != null) real_name = URLDecoder.decode(real_name,"UTF-8");
	String strTarget_Url = request.getParameter("target_url");  //一淘的返回地址，如果不为空是一淘用户，如果为空则是支付宝登陆过来的
	   
	String strUserName = user_id + "@@Alipay";
	
	session.setAttribute("AlipayToken",token);
	Tools.setCookie(response,"AlipayUName",real_name,(int)(Tools.YEAR_MILLIS/1000));
	
	User u = null;
	synchronized(obj){
		u = UserHelper.getByUsername(strUserName);
		if(u == null){//会员不存在
			Date currDate = new Date();
    		String pwd = "9EF5D4D62B8169AFCAB7D4B4DADF7C9628AC";
			
			u = new com.d1.bean.User();
			u.setId(SequenceIdGenerator.generate("3"));
			u.setMbrmst_uid(strUserName);
			u.setMbrmst_pwd(pwd);
			u.setMbrmst_passwd(MD5.to32MD5(pwd));
			u.setMbrmst_question("");
			u.setMbrmst_answer("");
			u.setMbrmst_createdate(currDate);
			u.setMbrmst_modidate(currDate);
			u.setMbrmst_lastdate(currDate);
			u.setMbrmst_name(real_name);
			u.setMbrmst_visittimes(new Long(0));
			u.setMbrmst_sex(new Long(0));
			u.setMbrmst_email("");
			u.setMbrmst_hphone("");
			u.setMbrmst_usephone("");
			u.setMbrmst_haddr("");
			u.setMbrmst_countryid(new Long(1));
			u.setMbrmst_provinceid(new Long(1));
			u.setMbrmst_cityid(new Long(1));
			u.setMbrmst_postcode("");
			u.setMbrmst_certifiertype(new Long(0));
			u.setMbrmst_certifierno("");
			u.setMbrmst_myd1type(new Long(0));
			u.setMbrmst_myd1count(new Long(10));
			u.setMbrmst_myd1codes("");
			u.setMbrmst_specialtype(new Long(0));
			u.setMbrmst_srcurl("");
			u.setMbrmst_peoplercm("");
			u.setMbrmst_subad("");
			u.setMbrmst_temp("Alipay_lmlogin");
			u.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
			u.setMbrmst_bookletflag(new Long(0));
			u.setMbrmst_buyerrcount(new Long(0));
			u.setMbrmst_buyquestionid("");
			u.setMbrmst_downflag(new Long(0));
			u.setMbrmst_magazineflag(new Long(0));
			u.setMbrmst_validflag(new Long(0));
			u.setMbrmst_rcmcount(new Long(0));
			u.setMbrmst_ip("");
			u.setMbrmst_bktstep(new Long(0));
			u.setMbrmst_aliasname("");
			u.setMbrmst_src(new Long(0));
			u.setMbrmst_sendcount(new Long(0));
			u.setMbrmst_replycount(new Long(0));
			u.setMbrmst_kicktype(new Long(0));
			u.setMbrmst_bbsAlllogintimes(new Long(0));
			u.setMbrmst_bbsDaylogintimes(new Long(0));
			u.setMbrmst_allsrc(new Long(0));
			u.setMbrmst_jcsrc(new Long(0));
			u.setMbrmst_goldsrc(new Long(0));
			u.setMbrmst_goldallsrc(new Long(0));
			u.setMbrmst_birthflag(new Long(0));
			u.setMbrmst_tktmail(new Long(0));
			u.setMbrmst_ip(request.getRemoteAddr());
			u = (User)UserHelper.manager.create(u);
		}
	}
	
	if(u == null || u.getId() == null){
		out.print("获得用户信息出错，请重新登录！");
		return;
	}
	session.removeAttribute("showmsg");
	UserHelper.setLoginUserId(session,u.getId());
	session.setAttribute("AlipayToken", token);


	 SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     Date actendDate=null;
     Date tktendDate=null;
     try{
    	 actendDate=fmt2.parse("2013-4-30 23:59:59");
     	 tktendDate=fmt2.parse("2013-4-30 23:59:59");
     	 }
     catch(Exception ex){
     	ex.printStackTrace();
     }
     String cardt="";
     String bakurl="";
     if(Tools.dateValue(actendDate)>System.currentTimeMillis()&&session.getAttribute("d1lianmengsubad")!=null&&("p1304012tmkh".equals(session.getAttribute("d1lianmengsubad"))
    		 ||session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay"))){
    	 cardt="ptmallqq0416";

     String cardno=cardt+u.getId();

    	 Ticket tktmstf= (Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", cardno);
    	 if(tktmstf==null){
    	  Ticket tktmst=new Ticket();
		 tktmst.setTktmst_value(new Float(30));
		 tktmst.setTktmst_type("002001");
		 tktmst.setTktmst_mbrid(Tools.parseLong(u.getId()));
		 tktmst.setTktmst_validflag(new Long(0));
		 tktmst.setTktmst_createdate(new Date());
		 tktmst.setTktmst_validates(new Date());
		 tktmst.setTktmst_validatee(tktendDate);
		 tktmst.setTktmst_rackcode("000");
         tktmst.setTktmst_gdsvalue(new Float(200));
         tktmst.setTktmst_payid(new Long(-1));
         tktmst.setTktmst_cardno(cardno);
         tktmst.setTktmst_ifcrd(new Long(0));
         tktmst.setTktmst_memo("淘宝聚会新会员激活！");
         Tools.getManager(Ticket.class).create(tktmst);
         bakurl="http://www.d1.com.cn/user/ticket.jsp";
    	 }
     }
   	 
	//查询购物车中商品数量
	/*int cartLength = CartHelper.getTotalProductCount(request,response);
	if(cartLength > 0){
		response.sendRedirect("/flow.jsp");
	}else{
		response.sendRedirect("/");
	}*/
	 if(Tools.isNull(bakurl)){
	if (strTarget_Url != null)
	{
		response.sendRedirect(strTarget_Url);
	}
	else{
		response.sendRedirect("http://www.d1.com.cn");
	}
	 }else{
		 response.sendRedirect(bakurl);
	 }
	//////////////////////////////////////////////////////////////////////////////////////////
}else{
	//该页面可做页面美工编辑
	out.println("验证失败");
}
%>