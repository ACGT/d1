<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator,java.util.Hashtable,java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException,
java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException,
javax.xml.namespace.QName,
org.apache.axis.client.Call,
org.apache.axis.client.Service,
org.apache.axis.encoding.XMLType"%><%@include file="/html/header.jsp" %><%@include file="/inc/islogin.jsp"%><%@include file="/inc/sendsms.jsp" %><%!
public static boolean sendmsg(String phone,String msg){
	boolean ret=SendSms(phone,msg);
	 return ret;
}

%>
<%
//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
	String telephone=request.getParameter("tel");
	if(Tools.isNull(telephone)){
		out.print("{\"success\":false,\"message\":\"参数错误！\"}");
		return;
	}
	if(!Tools.isMobile(telephone)){
		out.print("{\"success\":false,\"message\":\"手机号码格式错误！\"}");
		return;
	}
	String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
	String yzcode=request.getParameter("yzcode");
	if(yzcode == null || vImageCode==null|| !vImageCode.equals(yzcode)){
		out.print("{\"success\":false,\"message\":\"验证码输入错误，请重试！\"}");
		return;
	}
	//判断是否验证过
	User user=UserHelper. getByUserPhone(telephone);
	if(user!=null){
		out.print("{\"success\":false,\"message\":\"该手机号已验证过！\"}");
		return;
	}
	
   //获取验证码
    if(request.getParameter("rec_act")!=null&&request.getParameter("rec_act").equals("getcode")){
	
		if(telephone.length()>0)
		{
		   String SendTime=	"0";	 //即时发送	//request.getParameter("dtTime");
		   //String type=request.getParameter("apitype");    //通道选择: 0：默认通道； 2：通道2； 3：即时通道
		   //生成激活码
		  
				String random=String.valueOf( new Random().nextInt(1000000));
				
				 String s="";
					for(int i=0;i<6-random.length();i++){
						s+="0";
					}
					random=s+random;
					   String msg="请您输入激活码"+random+"完成验证！";
					  
					   try {					
							   if(sendmsg(telephone,msg)){
								   session.setAttribute("valicode", random);
								   session.setAttribute("t", new Date().getTime());//获取验证码的时间
								   out.print("{\"success\":true,\"message\":\"验证码已发送，请注意查收！\"}");
									return;
							   }
							   else{
								  out.print("{\"success\":false,\"message\":\"发送验证码失败，请稍后重试！\"}");
									return;
							   }
					  } catch (IOException e) {
							e.printStackTrace();
						}
					   
				   } else{
					   out.print("{\"success\":false,\"message\":\"发送验证码失败，手机号不能为空！\"}");
						return;
						  
				   }
		
    }else  if(request.getParameter("rec_act")!=null&&request.getParameter("rec_act").equals("valicode")){
    	String code=request.getParameter("code");
    	   if(Tools.isNull(code)){
    		   out.print("{\"success\":false,\"message\":\"请输入验证码！\"}");
    			return;
    	   }
    	   if(session.getAttribute("valicode")==null || Tools.isNull(session.getAttribute("valicode").toString())){
    		   out.print("{\"success\":false,\"message\":\"请先获取验证码！\"}");
    			return;
    	   }
    	   if(!code.equals(session.getAttribute("valicode").toString())){
    		   out.print("{\"success\":false,\"message\":\"验证码错误！\"}");
    			return;
    	   }else{
    		   User u=lUser;
    		   u.setMbrmst_mphone(telephone);
    		   u.setMbrmst_phoneflag(new Long(1));
    		   u.setMbrmst_usephone(telephone);
    		   Tools.getManager(u.getClass()).clearListCache(u);
    		   if(Tools.getManager(u.getClass()).update(u, true)){
    			   out.print("{\"success\":true,\"message\":\"验证通过！\"}");
    	   			return;
    		   }else{
    			   out.print("{\"success\":false,\"message\":\"验证失败！\"}");
       			return;
    		   }
    		  
    	   }
    }
   
   

%>



