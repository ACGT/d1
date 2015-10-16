<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>问卷调查</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script type="text/javascript" >
function checkq1(){
	var ischeck=$.trim( $('input[type=radio][name=riused]:checked').val());
	if(ischeck.length==0){
		$("#s1").show();
		return false;
	}else{
		$("#s1").hide();
		return true;
	}
}
function checkq2(){
	var ischeck=$.trim( $('input[type=radio][name=rphonebrand]:checked').val());
	if(ischeck.length==0){
		$("#s2").show();
		return false;
	}else{
		$("#s2").hide();
		return true;
	}
}
function checkq3(){
	var ischeck=$.trim( $('input[type=radio][name=rphonetype]:checked').val());
	if(ischeck.length==0){
		$("#s3").show();
		return false;
	}else{
		$("#s3").hide();
		return true;
	}
}
function checkq4(){
	var ischeck=$.trim( $('input[type=radio][name=roptype]:checked').val());
	if(ischeck.length==0){
		$("#s4").show();
		return false;
	}else{
		$("#s4").hide();
		return true;
	}
}
function check(){
	var isval=true;
	if(!checkq1())isval=false;
	if(!checkq2())isval=false;
	if(!checkq3())isval=false;
	if(!checkq4())isval=false;
	return isval;
}
function ok(){
	if(check()){
		var q1=$.trim( $('input[type=radio][name=riused]:checked').val());
		var q2=$.trim( $('input[type=radio][name=rphonebrand]:checked').val());
		var q3=$.trim( $('input[type=radio][name=rphonetype]:checked').val());
		var q4=$.trim( $('input[type=radio][name=roptype]:checked').val());
		$("#hanwser").val(q1+"|"+q2+"|"+q3+"|"+q4+"|");
		//alert($("#hanwser").val());
		document.form1.submit();
	}
}
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <center>
      <%
 if(lUser==null){%>
	 <table width="890" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td><img src="img/5.jpg" width="890" height="106"/></td>
	  </tr>
	   <tr>
	    <td valign="top" background="img/6.jpg" align="center">
		<table width="885" border="0" cellpadding="0" cellspacing="0" >
		<tr><td style="border-top: 1px solid #AD4456;">&nbsp;</td></tr>
		</table>
		</td>
	  </tr>
	  <tr>
	    <td  valign="top" background="img/6.jpg"  >
		<table width="890" border="0" cellpadding="0" cellspacing="0" >
		<tr><td height="10px">&nbsp;</td></tr>
		<tr>
		  <td align="center"><div>
		  <div style="margin-top:20px; margin-bottom:20px;">
		  <p style="font-weight:bold;font-size:16px; color:#AD4456">请您登录后填写调查问卷</p>
		 <br/>
		 <a href="/login.jsp" style="font-weight:bold;color:#3333FF; font-size:14px;">现在登录  &gt;&gt;</a>
		  </div>
		  </div></td>
		</tr>
		<tr><td height="10px">&nbsp;</td></tr>
		
	</table>
	</td>
	</tr>

		<tr><td align="center"><table width="885" border="0" cellpadding="0" cellspacing="0" >
		<tr><td style="border-top: 1px solid #CCCCCC;">&nbsp;</td></tr>
		</table></td></tr>
		</table> 
 <%}else{
	 if(!Tools.isNull(request.getParameter("op"))){
		 %> 
		 <table width="890" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="img/5.jpg" width="890" height="106"/></td>
  </tr>
   <tr>
    <td valign="top" background="img/6.jpg" align="center">
	<table width="885" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="border-top: 1px solid #AD4456;">&nbsp;</td></tr>
	</table>
	</td>
  </tr>
  <tr>
    <td  valign="top" background="img/6.jpg"  >
	<table width="890" border="0" cellpadding="0" cellspacing="0" >
	<tr><td height="10px">&nbsp;</td></tr>
	<tr>
	  <td align="center">
	  <div style="margin-top:20px; margin-bottom:24px;">
	  <table  border="0" cellpadding="0" cellspacing="0" >
	  <tr><td> <img src="img/7.jpg"/></td><td>&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold;font-size:20px; color:#AD4456">问卷提交成功</span></td></tr>
	  <tr><td colspan="2" height="20px"></td></tr>
	  <tr><td></td><td>&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:bold;font-size:14px; color:#AD4456">感谢您的参与。</span></td></tr>
	  </table>
	  </div>
	 </td>
	</tr>
	<tr><td height="10px">&nbsp;</td></tr>
	
</table>
</td>
</tr>

	<tr><td align="center"><table width="885" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="border-top: 1px solid #CCCCCC;">&nbsp;</td></tr>
	</table></td></tr>
	</table>
<%	 }else{
 %>
     <form name="form1" action="questionnaire.jsp" method="post">
     <input type="hidden" id="hanwser" name="hanwser"/>
<table width="890" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="img/5.jpg" width="890" height="106"/></td>
  </tr>
   <tr>
    <td valign="top" background="img/6.jpg" align="center">
	<table width="885" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="border-top: 1px solid #AD4456;">&nbsp;</td></tr>
	</table>
	</td>
  </tr>
  <tr>
    <td  valign="top" background="img/6.jpg"  >
	<table width="890" border="0" cellpadding="0" cellspacing="0" >
	<tr><td height="10px">&nbsp;</td></tr>
	<tr>
	  <td><span style="font-size: 16px; line-height:30px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;尊敬的D1优尚会员：<br />
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;D1优尚计划推出wap客户端，方便您使用手机浏览网站，购买商品。对于D1优尚的wap客户端，您有什么样<br />
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;的需求和想法，请填写问卷告诉我们。您的建议对我们非常重要，D1优尚非常感谢参与本次调查!<br />
	    </span></td>
	</tr>
	<tr><td height="10px">&nbsp;</td></tr>
	<tr><td  align="center" >
	<table width="885" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="border-top: 1px dashed #CCCCCC;">&nbsp;</td></tr>
	</table>
	</td></tr>
	<tr><td height="10px">&nbsp;</td></tr>
	<tr><td align="center"><table width="800" border="0" cellpadding="0" cellspacing="0" style="text-align:left; font-size:12px; line-height:26px;">
	<tr>
	<td bgcolor="#ffecf2" height="30px" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="font-size:14px; font-weight:bold">Q1：您是否使用过其他购物网站的wap客户端？</span><span id="s1" style="color:red;display:none">*您还没有回答这个问题</span>
	
	</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="riused" value="1"/>是<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="riused" value="0"/>否</td></tr>
	
	<tr>
	<td bgcolor="#ffecf2" height="30px" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="font-size:14px; font-weight:bold">Q2：您的手机品牌？</span><span id="s2" style="color:red;display:none">*您还没有回答这个问题</span>
	
	</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="1"/>诺基亚（Nokia）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="2"/>摩托罗拉（Moto）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="3"/>三星（Samsung）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="4"/>HTC<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="5"/>LG<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="6"/>苹果iphone<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="7"/>联想（Lenovo）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="8"/>黑莓<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="9"/>小米<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonebrand" value="10"/>其它品牌
	</td></tr>
	<tr>
	<td bgcolor="#ffecf2" height="30px" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="font-size:14px; font-weight:bold">Q3：您的手机是否为智能手机？</span><span id="s3" style="color:red;display:none">*您还没有回答这个问题</span>
	
	</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonetype" value="1"/>是<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonetype" value="0"/>否<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rphonetype" value="3"/>不知道<br />
	</td></tr>
	<tr>
	<td bgcolor="#ffecf2" height="30px" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="font-size:14px; font-weight:bold">Q4：您的手机操作系统型号？</span><span id="s4" style="color:red;display:none">*您还没有回答这个问题</span>
	
	</td>
	</tr>
	<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="roptype" value="1"/>Symbian（塞班）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="roptype" value="2"/>Android（安卓）<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="roptype" value="3"/>Windows<br />
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="roptype" value="4"/>BlackBerry<br />

	</td></tr>
	<tr>
	<td bgcolor="#ffecf2" height="30px" align="left">&nbsp;&nbsp;&nbsp;&nbsp;
	<span style="font-size:14px; font-weight:bold">Q5：您对wap客户端有什么其它需求？</span>
	
	</td>
	</tr>
	<tr><td height="15px"></td></tr>
	 <tr>
	  <td>&nbsp;&nbsp;&nbsp;&nbsp;<textarea id="txtcontent" name="txtcontent" style=" width:474px; height:88px; border:solid 1px #acacac; background:#f4f4f4;" ></textarea></td>
	 </tr>
	 <tr><td height="35px">&nbsp;</td></tr>
	  <tr><td align="center"><a href="javascript:void(0);" onclick="ok();"><img src="img/ok.jpg" border="0"/></a></td></tr>
	 <tr><td height="35px">&nbsp;</td></tr>
	</table>
	</td></tr>
	
 
</table>
</td>
</tr>

	<tr><td align="center"><table width="885" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="border-top: 1px solid #CCCCCC;">&nbsp;</td></tr>
	</table></td></tr>
	</table>
	</form>
	<%} }%>
	</center>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

