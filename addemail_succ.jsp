<%@ page contentType="text/html; charset=UTF-8" import="com.d1.bean.id.SequenceIdGenerator"%><%@include file="/inc/header.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<%
//注册页面不需要缓存。
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Cache-Control","no-store"); 
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache");
String par = request.getParameter("par");


String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-添加邮箱成功</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
   #addemail{ width:891px; height:303px; margin:0px auto; background:url('http://images.d1.com.cn/images2012/addemailbg.jpg'); margin-top:50px; margin-bottom:70px;}
   #email_Notice{ background:url('http://images.d1.com.cn/images2012/tip.jpg'); width:210px; height:36px; display:block;
                  padding-left:21px; font-size:15px; line-height:40px; }
</style>
</head>

<body >
   <!-- 头部 -->
   <%@include file="/inc/head.jsp" %>
   
   <!-- 头部结束 -->
<div id="addemail">

<table>
   <tr><td colspan="3" height="100"></td></tr>
   <tr><td width="230"></td>
   <td><img src="http://images.d1.com.cn/images2012/se_succes.jpg" /></td>
   <td style="padding-left:10px; line-height:30px; font-family:'微软雅黑'; font-size:15px; color:#333" >谢谢！您的Email地址已提交成功！
   <br/>您今后可使用<font color="#ad3f5a"><%= lUser.getMbrmst_email() %></font>取回密码、接收订单邮件或网站活动通知。</td>
   </tr>
   
</table>

</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript">
function vemail(v)
{
	if(v=="")
		{
			$('#email_Notice').html("邮箱地址不能为空！");
			return;
		}
	else if(!isEmail(v))
		{
			$('#email_Notice').html("邮箱地址格式不正确！");
			return;
		}
	else
		{
		  $('#email_Notice').html("邮箱填写正确！");
		}
	
}
</script>

