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
  if("post".equals(request.getMethod().toLowerCase())&&"adde".equals(par))
  {
	  String email=request.getParameter("email");
	  if(lUser.getMbrmst_email()!=null&&lUser.getMbrmst_email().length()>0)
	  {
		  Tools.outJs(out, "该用户已填加邮箱!", "http://www.d1.com.cn");
		  return;
	  }
	  else
	  {
		  if(Tools.isEmail(email))
		  {
			  lUser.setMbrmst_email(email);
			  if(Tools.getManager(User.class).update(lUser, true))
			  {
				 response.sendRedirect("/addemail_succ.jsp");
			  }
			  else
			  {
				  Tools.outJs(out, "填加邮箱失败!", "/addemail.jsp");
			  }
		  }
		  else
		  {
			  Tools.outJs(out, "邮箱格式输入不正确!", "/addemail.jsp");
		  }
	  }
  }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>D1优尚网-添加邮箱</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<style type="text/css">
   #addemail1{ width:891px; height:303px; dispaly:none; margin:0px auto; background:url('http://images.d1.com.cn/images2012/addemailbg.jpg'); margin-top:50px; margin-bottom:70px;}
   #email_Notice{ background:url('http://images.d1.com.cn/images2012/tip.jpg'); width:210px; height:36px;  display:block;
                  padding-left:21px; font-size:15px; line-height:40px; _line-height:35px; }
</style>
</head>

<body >
   <!-- 头部 -->
   <%@include file="/inc/head.jsp" %>
   
   <!-- 头部结束 -->
<div id="addemail1">
<form id="addemail" method="post" action="addemail.jsp?par=adde">
<table>
   <tr><td colspan="3" height="100"></td></tr>
   <tr><td style=" text-align:right; font-family:'微软雅黑'; font-size:15px;" width="260"><b>请填写您的Email地址：</b></td>
   <td><input type="text" id="email" name="email" onblur="vemail(this.value)" style=" width:350px; height:24px;"/></td>
   <td><span id="email_Notice">请填写您常用的Email地址！</span></td>
   </tr>
   <tr><td></td><td height="70"><input type="image" src="http://images.d1.com.cn/images2012/submit_email.jpg" width="110" height="40" onclick="addemail.submit" />
  
   </td><td></td></tr>
   
</table>

</form>
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

