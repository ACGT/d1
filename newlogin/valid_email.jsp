<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%!
String getmsg(String type,String str){
	if(Tools.isNull(type)|| Tools.isNull(str)){
			return "参数错误！";
	}
	if(!"set".equals(type)){
		return "参数错误！";
	}
	DESUtil des = new DESUtil( "hd1comcn" );
	System.out.println(str);
	String deStr = des.decryptStr(str);  //解密
	System.out.println(deStr);
	String [] strlist=deStr.split("\\|");
	if(strlist.length!=3){
		return "验证失败！";
	}
	String userid=strlist[0];
	String mail=strlist[1];
	String t=strlist[2];
		if(Tools.isNull(userid) || Tools.isNull(mail) || Tools.isNull(t)){
			return "参数错误！";
		}
		if(!Tools.isNumber(userid) || !Tools.isNumber(t)){
			return "参数错误！";
		}
		if(!Tools.isEmail(mail)){
			return "验证邮箱格式错误！";
		}
		//判断用户是否存在
		User user=UserHelper.getById(userid);
		if(user==null){
			return "参数错误！";
		}
		//判断时间是否过期
		if(new Date().getTime()-Tools.parseLong(t)>24*3600*1000){
			return "该链接已过时！";
		}
		
		//判断是否验证过
		boolean isvalemail=UserHelper. getByUserMail(mail);
		if(isvalemail){
			return"该邮箱已验证过！";
		}
		user.setMbrmst_email(mail);
		user.setMbrmst_mailflag(new Long(1));
		 Tools.getManager(user.getClass()).update(user, true);
		return "验证成功！";
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>邮箱验证</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/validate.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head1208.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css" >
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; }
.reg_suc{ margin:0px auto; margin-top:40px; width:756px; height:76px; background:url(http://images.d1.com.cn/images2012/login/zc_10.jpg) no-repeat; }
.regsuc_top{width:700px;  height:70px; text-align:left; padding-top:2px;padding-left:50px;margin:0px ;}
.regsuc_top span{color:#ffffff;font-weight:bold;font-size:40px;}
.regsuc_main{margin:0px auto; width:756px;  background:url(http://images.d1.com.cn/images2012/login/zc_06.jpg) ;padding-top:20px; }
.regsuc_mainspan{ font-size:16px; color:#d1436b; font-weight:bold;}
.regsuc_maindetail{padding-left:100px;}
.regsuc_maindetail table td{font-size:14px; line-height:36px;}
.reg_bottom{margin:0px auto;  width:756px;}
</style>
<script>

</script>
</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<!-- 注册成功-->

<div class="reg_suc">
   	   <div class="regsuc_top">
   	   <img src="http://images.d1.com.cn/images2012/login/yz_03.jpg"/>
			  <span>&nbsp;验证邮箱</span>
		</div>
		</div>
		<div style="clear:both;"></div>
		 <div class="regsuc_main"> 
		    <div class="regsuc_maindetail">
		   <%
		   String str=request.getParameter("vc");
		  // System.out.println(str);
		    String type=request.getParameter("type");  
		    String msg=getmsg(type, str);
		  
		   %>
		   <span class="regsuc_mainspan"><%=msg %></span>
		   </div> 
		
		 </div>
   <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>