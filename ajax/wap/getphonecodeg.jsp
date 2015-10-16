<%@ page contentType="text/html; charset=UTF-8" import="java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException,
javax.xml.namespace.QName,
org.apache.axis.client.Call,
org.apache.axis.client.Service,
org.apache.axis.encoding.XMLType"%><%@include file="/html/header.jsp" %><%!
public static boolean sendmsg(String phone,String msg){
String url="http://121.199.48.186:1210/services/msgsend.asmx";  
//.net webService 命名空间
String namespace = "http://tempuri.org/";  
//.net webService 需调用的方法
String methodName = "SendMsg";  
String soapActionURI = "http://tempuri.org/SendMsg";  
String ret2 ="";
try{
Service service = new Service();

Call call = (Call) service.createCall();

call.setTargetEndpointAddress(new java.net.URL(url));  
call.setUseSOAPAction(true);  
//这个地方没设对就会出现Server was unable to read request的错误  
call.setSOAPActionURI(soapActionURI);  
//设置要调用的.net webService方法
call.setOperationName(new QName(namespace, methodName));  
//设置该方法的参数，temp为.net webService中的参数名称
call.addParameter( new QName(namespace,"userCode"),  
org.apache.axis.encoding.XMLType.XSD_STRING,   
javax.xml.rpc.ParameterMode.IN);  
call.addParameter( new QName(namespace,"userPass"),  
org.apache.axis.encoding.XMLType.XSD_STRING,   
javax.xml.rpc.ParameterMode.IN); 
call.addParameter( new QName(namespace,"DesNo"),  
org.apache.axis.encoding.XMLType.XSD_STRING,   
javax.xml.rpc.ParameterMode.IN); 
call.addParameter( new QName(namespace,"Msg"),  
org.apache.axis.encoding.XMLType.XSD_STRING,   
javax.xml.rpc.ParameterMode.IN); 
call.addParameter( new QName(namespace,"Channel"),  
org.apache.axis.encoding.XMLType.XSD_STRING,   
javax.xml.rpc.ParameterMode.IN); 
//设置该方法的返回值
call.setReturnType(XMLType.XSD_STRING);
//call.invoke(new Object[] { "kusix" });  中"kusix"为传入参数值
ret2 = (String) call.invoke(new Object[] { "bjqm","bjqm5858",phone,msg+"【D1优尚】", ""});  
System.out.println(phone+"codeg:"+msg+"【D1优尚】"+"返回结果---> " + ret2);  
} catch (Exception e) {
	e.printStackTrace();
}
if (ret2.indexOf("-")>=0){
	return false;
}else{
return true;
}
}
%><%
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


if(telephone.length()>0)
{
   String SendTime=	"0";	 //即时发送	//request.getParameter("dtTime");
  
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
	if(pc1!=null&&pc1.getPhonecode_status().longValue()==1)
	{
		Calendar c=Calendar.getInstance();
	    c.set(Calendar.YEAR,Tools.parseInt(new SimpleDateFormat("yyyy").format(new Date())));
		c.set(Calendar.MONTH,new Date().getMonth());
		c.set(Calendar.DATE,new Date().getDate());
		c.set(Calendar.HOUR_OF_DAY,0);
		c.set(Calendar.MINUTE,0);
		c.set(Calendar.SECOND,0);
		
		if(pc1.getPhonecode_updatetimeg()!=null&&new Date().after(pc1.getPhonecode_updatetimeg())&& pc1.getPhonecode_updatetimeg().after(c.getTime())&& pc1.getPhonecode_flagg()!=null&&pc1.getPhonecode_flagg().longValue()%3==0)
		{
			out.print("{\"success\":false,\"message\":\"您今天只能发送3次激活码！\"}");
		}
		else
		{
			//发送短信
	
			   String msg="优宝贝，您正在进行优尚网注册验证，验证码是："+random+"";
			   if(sendmsg(telephone,msg))
			   {
				   pc1.setPhonecode_updatetimeg(new Date());
				   if(pc1.getPhonecode_flagg()==null)
				   {
					   pc1.setPhonecode_flagg(new Long(1));
				   }
				   else
				   {
					   pc1.setPhonecode_flagg(pc1.getPhonecode_flagg().longValue()+1);
				   }
				   pc1.setPhonecode_code(random);
				   if(Tools.getManager(PhoneCode.class).update(pc1,true))
				   {
				      out.print("{\"success\":true,\"message\":\"验证码已发送，请注意查收！\"}");
				   }
			   }
			   else
			   {
				   out.print("{\"success\":false,\"message\":\"发送验证码失败，请稍后重试！\"}");
			   }
			  
		}
	}

	else
	{
		out.print("{\"success\":false,\"message\":\"该手机号还没有注册为会员，请重新输入！\"}");
		   
	}
   
}


%>