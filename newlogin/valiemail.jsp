<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		   
		    	  <div><span style="font-size:14px;">您的邮箱：</span>
			     <input type="text" id="txtREmail" maxlength="40" value="<%=lUser.getMbrmst_email() %>" onblur="CheckEmail()" style="width:180px;height:20px;" />&nbsp;&nbsp;<span id="spanREmail" style="color:red;display:none;">*请输入您的邮箱地址 </span><img  id="imgemail" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" />
			     </div>
			     <div style="clear:both;"></div>
			     <div style="padding-top:50px; padding-bottom:50px; text-align:center;">
			    <a href="javascript:validemail();"><img src="http://images.d1.com.cn/images2012/login/yz_07.jpg" border="0"/></a>
			     </div>
		  
		   </div> 
		
		 </div>
   <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<script>
$(document).ready(function(){
	$("#txtREmail").focus();
});
</script>
<%@include file="/inc/foot.jsp" %>
</body>
</html>