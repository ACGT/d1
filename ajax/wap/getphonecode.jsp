<%@ page contentType="text/html; charset=UTF-8" import="java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException,
javax.xml.namespace.QName,
org.apache.axis.client.Call,
org.apache.axis.client.Service,
org.apache.axis.encoding.XMLType"%><%@include file="/html/header.jsp" %>
<%@include file="/inc/sendsms.jsp" %><%!
public static boolean sendmsg(String phone,String msg){
 
boolean ret=SendSms(phone,msg);
 return ret;
 
}
%>
<%
String ip = request.getHeader("x-forwarded-for");
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getHeader("Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getHeader("WL-Proxy-Client-IP");
}
if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
ip = request.getRemoteAddr();
}
//System.out.println("host:"+request.getRemoteHost());
//System.out.println("IP:"+ip);
String httpurl=request.getHeader("Referer");
if(Tools.isNull(httpurl))httpurl=request.getHeader("referer");

if(Tools.isNull(httpurl)||httpurl.indexOf("wap/reg.html")<0){
	return;
}
System.out.println("Referer:"+httpurl);
String telephone="";
if(request.getParameter("phone")!=null&&request.getParameter("phone").length()>0)
{
    telephone=request.getParameter("phone");	
}
String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
String yzcode=request.getParameter("yzcode");
if(yzcode == null || vImageCode==null|| !vImageCode.equals(yzcode)){
	String erroinfo="验证码输入错误，请重试！";
	out.print("{\"success\":false,\"message\":\""+erroinfo+"\"}");
	   return;
}

if(telephone.length()>0)
{

	if(telephone!= null){
		if(Tools.isMobile(telephone)){
			User user = UserHelper.getByUsername(telephone);
			if(user != null){
				out.print("{\"success\":false,\"message\":\"该手机号已被注册，请重新输入!\"}");
			    return;
			}
		}else{
			out.print("{\"success\":false,\"message\":\"该手机号格式错误，请重新输入!\"}");
		    return;
		}
	}
	
   String SendTime=	"0";	 //即时发送	//request.getParameter("dtTime");
   //String type=request.getParameter("apitype");    //通道选择: 0：默认通道； 2：通道2； 3：即时通道
   //生成激活码
  
		String random="";
		int num = new Random().nextInt(10000);
		 if (num <10) {
			  random="0"+String.valueOf(num);
		  }
		 else
		 {
			 random=String.valueOf(num);
		 }
	//创建记录(该记录已存在)	
	PhoneCode pc1=PhoneCodeHelper.getPhoneCodeByTele(telephone);
	if(pc1!=null)
	{
		Calendar c=Calendar.getInstance();
	    c.set(Calendar.YEAR,Tools.parseInt(new SimpleDateFormat("yyyy").format(new Date())));
		c.set(Calendar.MONTH,new Date().getMonth());
		c.set(Calendar.DATE,new Date().getDate());
		c.set(Calendar.HOUR_OF_DAY,0);
		c.set(Calendar.MINUTE,0);
		c.set(Calendar.SECOND,0);
		
		if(new Date().after(pc1.getPhonecode_updatetime())&& pc1.getPhonecode_updatetime().after(c.getTime())&& pc1.getPhonecode_flag().longValue()%3==0)
		{
			out.print("{\"success\":false,\"message\":\"您今天只能发送3次激活码！\"}");
			  return;
		}
		else if(pc1.getPhonecode_status().longValue()==1)
		{
			out.print("{\"success\":false,\"message\":\"该手机号已成功注册！\"}");
			  return;
		}
		else
		{
			  // String msg="[D1优尚]请您输入激活码"+pc1.getPhonecode_code()+"，或手机访问：http://m.d1.cn/wap/regist.jsp完成验证！";
			   String msg="优宝贝，您正在进行优尚网注册验证，验证码是："+pc1.getPhonecode_code()+"";
			   if(sendmsg(telephone,msg))
			   {
				   pc1.setPhonecode_flag(pc1.getPhonecode_flag().longValue()+1);
				   pc1.setPhonecode_updatetime(new Date());
				   if(Tools.getManager(PhoneCode.class).update(pc1,true))
				   {
				      out.print("{\"success\":true,\"message\":\"验证码已发送，请注意查收！\"}");
				      return;
				   }
			   }
			   else
			   {
				   out.print("{\"success\":false,\"message\":\"发送验证码失败，请稍后重试！\"}");
				   return;
			   }
			  
		}
	}
	else
	{
		   PhoneCode pc=new PhoneCode();
		   pc.setPhonecode_code(random);
		   pc.setPhonecode_tele(telephone);
		   pc.setPhonecode_status(new Long(0));
		   pc.setPhonecode_updatetime(new Date());
		   pc.setPhonecode_flag(pc.getPhonecode_flag()!=null?new Long(pc.getPhonecode_flag().longValue()+1):new Long(1));
		   pc=(PhoneCode)Tools.getManager(PhoneCode.class).create(pc);
		   if(pc!=null)
		   {//发送短信
			   String msg="优宝贝，您正在进行优尚网注册验证，验证码是："+pc.getPhonecode_code()+"";
			  
			   if(sendmsg(telephone,msg))
			   {
				   out.print("{\"success\":true,\"message\":\"验证码已发送，请注意查收！\"}");
				   return;
			   }
			   else
			   {
				   out.print("{\"success\":false,\"message\":\"发送验证码失败，请稍后重试！\"}");
				   return;
			   }
		   }
		   else
		   {
			   out.print("{\"success\":false,\"message\":\"生成验证码失败，请稍后重试！\"}");
			   return;
				  
		   }
	}
	
   
   
   
   
}


%>