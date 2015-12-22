<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/islogin.jsp"%><%

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册成功</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/validate.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css" >
body{ margin:0px; padding:0px; border:none; background:#fff; font-size:12px; color:#000;}
a img{ border:none;}
img{ border:none;}
.center{margin:0px auto; }
.reg_suc{ margin:0px auto; margin-top:40px; width:756px; height:76px; background:url(http://images.d1.com.cn/images2012/login/zc_10.jpg) no-repeat; }
.reg_suc table{ text-align:center;}
.reg_suc table td span{ font-size:16px; color:#d1436b; font-weight:bold; padding-bottom:30px;}
.reg_suc table td .newspan{ color:#000; font-size:14px; line-height:22px;}
.regsuc_top{width:739px;  height:50px; line-height:50px;text-align:left; padding-top:6px;padding-left:20px;margin:0px ;}
.regsuc_top span{color:#ffffff;font-weight:bold;font-size:25px;}
.regsuc_main{margin:0px auto; width:756px;  background:url(http://images.d1.com.cn/images2012/login/zc_06.jpg) ;padding-top:20px; }
.regsuc_mainspan{ font-size:16px; color:#d1436b; font-weight:bold;}
.regsuc_maindetail{padding-left:100px;}
.regsuc_maindetail table td{font-size:14px; line-height:36px;}
.ulvalidate{ list-style-type: none;}
.ulvalidate li{ float:left;padding-left:20px;}
.reg_bottom{margin:0px auto;  width:756px;}
</style>
<script type="text/javascript">

</script>
</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<!-- 注册成功-->
<%
String lkturl="";
String strLtinfo="";
//LTINFO
/*String ckeLtinfo = Tools.getCookie(request,"LTINFO");

if (!Tools.isNull(ckeLtinfo))
{
    strLtinfo = URLDecoder.decode(ckeLtinfo.trim(),"UTF-8");
    strLtinfo = strLtinfo.replace("'","\"");

if (!Tools.isNull(strLtinfo)){
	 lkturl="http://service.linktech.cn/purchase_cpa.php";
		StringBuffer str=new StringBuffer();
		str.append("a_id=");
		str.append(strLtinfo);
		str.append("&m_id=d1bianli");
		str.append("&mbr_id=").append(lUser.getMbrmst_uid());
		str.append("&&o_cd=").append(lUser.getMbrmst_uid());
		str.append("&p_cd=d1_member");
		//IntfUtil.GetPostData(url, str.toString());
		lkturl+="?"+str.toString();
		
} */%>
<%//if (!Tools.isNull(lkturl)) {%>
		<!-- <img src="<%//= lkturl%>" width=1 height=1 style=display:none> -->
<%//}} %>
   <div class="reg_suc">
   	   <div class="regsuc_top">
			  <span>恭喜您成为D1优尚注册会员！</span>
		</div>
		</div>
		<div style="clear:both;"></div>
		 <div class="regsuc_main"> <div class="regsuc_maindetail">
		 <table cellpadding="0" cellspacing="0" border="0" width="550px">
			<tr><td align="center">
				<table cellpadding="0" cellspacing="0" border="0" >
				<tr><td><img src="http://images.d1.com.cn/images2012/login/zc_31.jpg"/></td>
				<td><span class="regsuc_mainspan">&nbsp;恭喜您已注册成功&nbsp;&nbsp;&nbsp;&nbsp;</span></td><td></td>
				</tr>
				</table>
			</td></tr>
			<tr><td align="center"><span style="font-size:14px;">您的登录用户名为：<b><%=lUser.getMbrmst_uid() %></b></span></td></tr>
			<tr><td align="center">
			 <a href="/index.jsp" target="_blank" style="display: block;padding:10px 10px 10px 10px;background-color: #79AB37;font-size:15px;font-weight: bold;color: white;margin-bottom:30px;margin-top:30px;width: 160px;">立即去购物</a>
			</td></tr>
		</table>
		
		 </div>  
		  
		 <div style=" background:#f6f6f6; float:left;width:745px; height:140px;margin-top:20px;margin-left:3px;">
	 <div style="padding-top:15px;padding-left:30px;color:gray;">或者：</div>
	<div style="padding-top:35px;padding-left:30px;">
	<ul class="ulvalidate">
	<li><a href="/newlogin/profile.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/login/zc_25.jpg" border="0"/></a><br/>
	<span style="color:red;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;生日期间可收到生日礼物哦</span>
	</li>
	</ul>
	</div>
	</div>
	<div class="clear"></div>
	
	<div style="height:15px;">&nbsp;</div>
		</div>
    <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>