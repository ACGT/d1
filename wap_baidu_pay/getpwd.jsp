<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.bean.id.SequenceIdGenerator
,java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException,
javax.xml.namespace.QName,
org.apache.axis.client.Call,
org.apache.axis.client.Service,
org.apache.axis.encoding.XMLType"%><%@include file="/inc/header.jsp"%>
<%@include file="/inc/sendsms.jsp" %><%!
public static boolean sendmsg(String phone,String msg){
	boolean ret=SendSms(phone,msg);
	 return ret;
}
%>
<%


String tele="";
if(request.getParameter("tele")!=null&&request.getParameter("tele").length()>0)
{
	tele=request.getParameter("tele").trim();
}
String teles="";
if(request.getParameter("teles")!=null&&request.getParameter("teles").length()>0)
{
	teles=request.getParameter("teles").trim();
}
if(teles.length()>0)
{
	tele=teles;
}
String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
String yzcode=request.getParameter("yzcode");



String sign=request.getParameter("sign");
String info="";
//System.out.print(sign);
 if(sign!=null&&sign.equals("vcode"))
{
	 if(yzcode == null || vImageCode==null|| !vImageCode.equals(yzcode)){
			info="验证码输入错误，请重试！";
return;
		} 
	
	if(tele.length()>0)
	{
	   String SendTime=	"0";	 //即时发送	//request.getParameter("dtTime");
	  
	   //生成激活码
	  
			String random="";
			int num = new Random().nextInt(10000);
			 if (num <1000) {
				  random="0"+String.valueOf(num);
			  }
			 else if(num<100)
			 {
				 random="0"+String.valueOf(num)+"0";
			 }
			 else if(num<10)
			 {
				 random="000"+String.valueOf(num);
			 }
			 else
			 {
				 random=String.valueOf(num);
			 }
		//创建记录(该记录已存在)	
		PhoneCode pc1=PhoneCodeHelper.getPhoneCodeByTele(tele);
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
				info="您今天只能发送3次激活码！";
			}
			else
			{
				//发送短信
				   String msg="优宝贝，您正在进行优尚网找回密码验证，验证码是："+random+"";

				   
				   if(sendmsg(tele,msg))
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
					      info="验证码已发送，请注意查收！";
					   }
				   }
				   else
				   {
					   info="发送验证码失败，请稍后重试！";
				   }
				  
			}
		}

		else
		{
			info="该手机号还没有注册为会员，请重新输入！";
			   
		}
	   
	}	
}
else
{
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String code=request.getParameter("code");
		if(code==null||code.length()==0)
		{
			info="验证码不能为空！";
		}
		else if(code.length()<4||code.length()>6)
		{
			info="验证码格式不正确！";
		}
		else
		{
			User user=UserHelper.getByUsername(tele);
			if(user==null)
			{
				info="该手机号还没有注册为会员！";
			}
			else
			{
				PhoneCode pc=PhoneCodeHelper.getPhoneCodeByTele(tele);
				if(pc==null)
				{
					info="该手机号还没有获取验证码！";
				}
				else
				{
					if(!pc.getPhonecode_code().equals(code)){
						info="验证码输入不正确！";
					}
					else
					{
						response.sendRedirect("/wap/getpwd1.jsp?tele="+tele);
					}
				}
			}
		}
		
	}
}



%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-手机版-取回密码</title>

<style type="text/css">
body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

input {
	width: 150px;
}

.red {
	color: #f00;
}
</style>

</head>

<body>
	<div style="padding-left: 4px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>>取回密码 <br />
		</div>
		<a href="mindex.jsp"><img
			src="http://images.d1.com.cn/wap/newlogo.jpg" /></a> <br /> 第2步/共3步<br />
		<span id="erroinfo" name="erroinfo"
			style="color: red; font-weight: bold;"><%= info %></span> <br />

		验证信息稍侯将以免费短信的形式发送给您，您有两种方式修改密码，任选其中一种即可：<br /> 1.点击短信中的链接，修改密码<br />
		2.输入短信中的验证码，修改密码<br /> 您的手机号:<%= tele %><br />
		<form name="form_Regist" id="form_Regist" action="getpwd.jsp"
			method="post">
			<input type="hidden" id="tele" name="tele" value="<%= tele%>" />
			请输入短信验证码：
			<input type="text" id="code" name="code" maxlength="6"
				style="width: 50px;"></input>
			</br>
			<input type="submit" value="修改密码" style="width: 80px;" />
		</form>
		短信发送有时稍有延迟<br /> 若您5分钟内还未收到激活短信<br />
		<form action="getpwd.jsp?sign=vcode" method="post">
			<input type="hidden" id="teles" name="teles" value="<%= tele%>" />
			<input type="submit" value=" 请重新发送激活短信" />
			<br /> 或核实您输入的手机号是否正确
			<br />
		</form>

		<br /> <a href="/mindex.jsp">返回首页</a>&nbsp;&nbsp;<a
			href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a href="/wap/html/help.jsp">帮助</a>
		<br /> 切换到<a href="http://www.d1.com.cn">电脑版</a> <br />京ICP证030072号
	</div>
</body>
</html>


