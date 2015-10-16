<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@page	import="java.util.regex.Pattern"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户反馈 - D1优尚</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/feedback.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">

    .file{border:1px solid #333333;color:#666666;background:#eeeeee;font:normal 12px Tahoma;height:18px}
</style>
<script type="text/javascript">
$(document).ready(function() {
	//alert("1111111111");
	$("#username").focus()
    });
function isorder(orderid){
	 if (typeof(orderid) == 'undefined'){
		 orderid = $.trim($('#txtorderid').val());
	    }
	var patrn=/^\d{12}$/;  
	if(orderid.length>0){
		if (!patrn.exec(orderid)) {
			$("#sorder").show();
			$("#sorder").css("color","red");
			$("#sorder").text("*订单号为12位数字");
			$("#imgorderid").hide();
			return false;
		}
		else{
			$("#sorder").hide();
			$("#imgorderid").show();
			return true;
		}
	}else return true;
}

function isemail(email){
	  if (typeof(email) == 'undefined'){
		  email = $.trim($('#txtemail').val());
	    }
	//var patrn=/^(\S+@\S+\.\S+) | (\d{3}\-\d{8})|(\d{4}\-\d{7})|([1]\d{10})$/;  
	if(email.length==0){
		$("#smail").show();
		$("#smail").css("color","red");
		$("#smail").text("*联系电话/邮箱不能为空");
		$("#imgemail").hide();
		return false;
	}
	var patrn1=/^(\d{3}\-\d{8})$/;  
	var patrn2=/^(\d{4}\-\d{7})$/;  
	var patrn3=/^[1]\d{10}$/;  
	var patrn4=/^\S+@\S+\.\S+$/;  
	if ((!patrn1.exec(email)) && (!patrn2.exec(email)) && (!patrn3.exec(email))&& (!patrn4.exec(email))) {
		$("#smail").show();
		$("#smail").css("color","red");
		$("#smail").text("*联系电话/邮箱格式不正确");
		$("#imgemail").hide();
		return false;
	}
	else{
		$("#smail").hide();
		$("#imgemail").show();
		return true;
	}
}

function contentnum(text1) //textarea输入长度处理
{
    var len; //记录剩余字符串的长度
    if (text1.value.length >=1000)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了
    {
    	$.alert("超过字数限制，请您精简部分文字!");
        text1.value = text1.value.substr(0, 1000);
    }
   // len =  text1.value.length;

   // $("#snum").text(len);
  
}
function add(){
	var orderid=$.trim($("#txtorderid").val());
	var email=$.trim($("#txtemail").val());
	if( isorder(orderid)&& isemail(email)){
		document.form1.submit();
	}
	
	
}


</script>
</head>

<body style=" background-color:#fff;">
<center>
<%@include file="/inc/head2.jsp" %>
<%!
/**
 * 判断是否是手机号码
 * @param str - String
 * @return true or false
 */
 boolean isMobile(String str){
	if(str == null || str.length()!=11) return false;
	return Pattern.matches("^(\\d{3}\\-\\d{8})|(\\d{4}\\-\\d{7})|([1]\\d{10})$", str);
}
%>
<%
if("post".equals(request.getMethod().toLowerCase())){
	String username="";
	String orderid="";
	String email="";
	String content="";
	String tel="";
 if(request.getParameter("username")!=null){
	 username=request.getParameter("username");
 }
 if(request.getParameter("txtorderid")!=null){
	 orderid=request.getParameter("txtorderid");
 }
 if(request.getParameter("txtemail")!=null){
	 email=request.getParameter("txtemail");
 }
 if(Tools.isNull(email)){
	 Tools.outJs(out,"联系电话/邮箱不能为空！","back");
	 return;
 }
// if((!Tools.isEmail(email)) && (!isMobile(email))){
	// Tools.outJs(out,"联系电话/邮箱格式不正确！","back");
	// return;
 //}
 if(isMobile(email)){
	 tel=email;
	 email="";
 }
 if(request.getParameter("txtcontent")!=null){
	 content=request.getParameter("txtcontent");
 }
 Feedback feedback=new Feedback();

 feedback.setFeedback_uid(username);
 feedback.setFeedback_orderid(orderid);
 feedback.setFeedback_phone(tel);
 feedback.setFeedback_email(email);
 feedback.setFeedback_type(new Long(-1));
 feedback.setFeedback_content(content);
 feedback.setFeedback_attach("");
 feedback.setFeedback_isceo(new Long(1));
 feedback.setFeedback_createdtime(new Date());
 feedback.setFeedback_replaystatus(new Long(0));
 feedback.setFeedback_operater("");
 feedback.setFeedback_replaycontent("");
 feedback.setFeedback_replaydate(null);

feedback=(Feedback)Tools.getManager(Feedback.class).create(feedback);
 if(feedback!=null){
 	// out.print("<script>window.open('sucess.jsp?sucesstype=yhfk')<script>");
 	response.sendRedirect("sucess.jsp?sucesstype=ceo");
 	//out.print("sucess");
 }else{
 	 out.print("fail");
 }
}
%>
 <form name="form1" action="feedback_ceo.jsp?for=ceo" method="post"   >
<div class="center">
  <div class="yhfk_ceo">
        <table width="694" border="0" cellspacing="0" cellpadding="0">
	      <tr><td height="170px" colspan="3"></td></tr>
		  <tr>
		      <td class="td1"  >您的姓名：</td><td class="td2" align="left" style="text-align:left;"><input type="text" name="username" id="username" class="input1" /></td><td><span >选填</span></td>
	      </tr>
		 <tr>
			   <td class="td1" height="65px;">您的订单号：</td><td class="td2" align="left" style="text-align:left;"><input type="text" maxlength="12"  name="txtorderid" id="txtorderid" class="input1" onkeyup="this.value=this.value.replace(/[^\d]/g,'')"  onblur="isorder(this.value)"/></td><td><span id="sorder" >选填（订单号12位数）</span><img id="imgorderid" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"/></td>
			  
		  </tr>
		    <tr>
			   <td style=" color:#333; font-size:15px;"><span style="color:red">*</span>联系电话或邮箱：</td><td class="td2" style="text-align:left;"><input type="text" name="txtemail" id="txtemail" class="input1" onblur="isemail(this.value)"/></td><td><span id="smail">请填写准确信息能让我们及时联系你(固话请注明区号)</span><img id="imgemail" src="http://images.d1.com.cn/images2011/feedback/image/suc.jpg" style="display:none"/></td>
			  
		  </tr>
		   <tr><td height="20px" colspan="3"></td></tr>
		   <tr>
		       <td style="text-align:left;" colspan="3">
			       <font><b>&nbsp;&nbsp;对CEO说：</b></font>		       
			   </td>
		   </tr>
		    <tr>
		       <td style="text-align:left; padding-top:10px; padding-left:12px;" colspan="3">
			       <div style="float:left;">
				      <textarea  id="txtcontent"  name="txtcontent" style=" width:474px; height:88px; border:solid 1px #acacac; background:#f4f4f4;"></textarea>
				   </div>
				   <div style=" float:left; padding-left:5px; padding-top:2px; line-height:16px; color:#333;"><span>购买商品的任何问题，<br/>您可以<a href="feedback.jsp" target="_blank" style="color:#AA2E24">点击这里</a>得到最及时的帮助。</span></div>
			   </td>
		   </tr>
		   <tr><td colspan="3" height="30"></td></tr>
		    <tr><td colspan="3" style=" text-align:center; " height="50px;"><a href="javascript:add();"><img src="http://images.d1.com.cn/images2012/New/feedback/yhfk_tjfk.jpg" /></a></td></tr>
	  </table>
	</div>  
   </div> 
   </form>
   <%@include file="/inc/foot.jsp" %>
   </center>
</body>
</html>