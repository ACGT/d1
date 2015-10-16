<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="../../inc/header.jsp"%><%!

private static final Object obj = new Object();//同步锁

/////////
private Map<String,String> parameters = new HashMap<String,String>();

/**
 * 生成md5的sign码
 * @return String
 */
private String createSign(){
	StringBuilder sb = new StringBuilder();
	
	List<String> keys = new ArrayList<String>(parameters.keySet());
	Collections.sort(keys);
	
	for(String key : keys){
		String value = parameters.get(key);
		if(!Tools.isNull(value) && "sign".compareTo(key)!=0 && "key".compareTo(key)!=0){
			sb.append(key).append("=").append(value).append("&");
		}
	}
	sb.append("key=").append(PubConfig.get("TenPaySPKey"));
	
	String sign = MD5.to32MD5(sb.toString());
	
	return sign;
}

/**
 * 获得传递回来的参数
 * @param request - HttpServletRequest
 */
public void initRequestParameter(HttpServletRequest request){
	Enumeration en = request.getParameterNames();
	while(en.hasMoreElements()){
		String k = en.nextElement().toString();
		parameters.put(k, request.getParameter(k));
	}
}

/**
 * 验证是否通过财付通签名
 * @return
 */
public boolean isTenpaySign(){
	String sign = createSign();
	return sign.equals(parameters.get("sign").toLowerCase());
}

%><%
initRequestParameter(request);
if(isTenpaySign()){
	String strId = parameters.get("id");//用户财付通账号
	String token = parameters.get("request_token");//用户登录token，一段时间内有效。查询用户信息时，带上该token，财付通验证token有效性。
	
	User u = null;
	synchronized(obj){
		u = UserHelper.getByUsername(strId);
		if(u == null){
			Date currDate = new Date();
    		String pwd = "";
			
			u = new com.d1.bean.User();
			u.setId(SequenceIdGenerator.generate("3"));
			u.setMbrmst_uid(strId);
			u.setMbrmst_pwd(pwd);
			u.setMbrmst_passwd(MD5.to32MD5(pwd));
			u.setMbrmst_question("");
			u.setMbrmst_answer("");
			u.setMbrmst_createdate(currDate);
			u.setMbrmst_modidate(currDate);
			u.setMbrmst_lastdate(currDate);
			u.setMbrmst_name("QQ用户");
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
			u.setMbrmst_temp("QQ");
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
			
			if(u != null && u.getId() != null){
				//添加qqmbr数据
				QQUser qq = QQUserHelper.getById(strId);
				if(qq == null){
					qq = new QQUser();
					qq.setId(strId);
					qq.setQqmbr_mbrid(new Long(u.getId()));
					qq.setQqmbr_createdate(new Date());
					QQUserHelper.manager.create(qq);
					
				}
			}
		}
	}
	
	if(u == null || u.getId() == null){
		out.print("获得用户信息出错，请重新登录！");
		return;
	}
	session.removeAttribute("showmsg");
	Tools.removeCookie(response,"userid");
	Tools.setCookie(response,"request_token",token,(int)(Tools.DAY_MILLIS*3/1000));
	
	UserHelper.setLoginUserId(session,u.getId());
	//查询购物车中商品数量
	int cartLength = CartHelper.getTotalProductCount(request,response);
	if(cartLength > 0){
		response.sendRedirect("/flow.jsp");
	}else{
		response.sendRedirect("/");
	}
}else{
	out.print("签名签证失败！");
}
%>