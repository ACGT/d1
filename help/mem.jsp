<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>帮助中心</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/help.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
 <style type="text/css">
.re-send,.tips11 .img1,.tips111 .img1,.btn_validate2{background:url(http://images.d1.com.cn/images2012/New/registerbg.gif) no-repeat;}
.mobile111{width:99%;}
.mobile111 .txt{width:100%;float:left;display:inline;padding:6px 0;}
.mobile111 .num{width:100%; float:left; background:#F4FCFE; padding:5px 0; border:1px solid #D4E8FC;}
.mobile111 .code{width:100%; float:left; background:#FFF; padding:5px 0;}
.editinputmobile{border:1px solid #A6A6A6; width:130px; height:24px; margin-top:20px; float:left; line-height:24px;}
.mobile111 .l{width:60px; float:left; text-align:center; line-height:34px;}
.mobile111 .c{float:left; text-align:center; line-height:34px;}
.sendmsg{float:left;width:100%;line-height:20px; font-size:12px;text-align:left;border-top: 1px dashed #D6D6D6;padding-top:10px;}
.mobile111 .button{float:left;width:100%;text-align:center;margin-bottom:10px;}
.inputmobile{border:1px solid #A6A6A6; width:126px; height:18px; margin-top:4px; float:left; padding-top:4px; padding-left:4px;}
.btn_validate2{width:100px; height:36px;margin-top:8px; cursor:pointer; border:0px;background-position:-115px -381px;margin-left:7px; display:none;}
.tips11{border:1px solid #40B3FF; background:#E5F5FF;float:left; color:#000000; font-size:12px;  margin-top:4px; margin-left:8px;line-height:22px; padding:0px 10px 0px 6px}
.tips111{border:1px solid #FCCE83; background:#FFFAF4;float:left; color:#000000; font-size:12px;margin-top:4px; margin-left:8px; line-height:22px; padding:0px 10px 0px 6px}
.tips111 .img1{background-position:-4px -270px; float:left; height:16px; width:22px; margin-top:3px}
.tips11 .img1{background-position:-4px -218px; float:left; height:16px; width:22px; margin-top:3px}
.mobile111 .sends{width: 100%;float: left;line-height: 24px;font-size: 12px;height: 24px;overflow: hidden;display:none;margin-bottom: 10px;}
.xq_t {border-bottom: 1px dashed #D6D6D6;width: 510px;float: left;padding-bottom: 6px;margin-bottom: 4px;margin-left: 24px;}
.center1{width:980px; overflow:hidden; margin:0px auto;}
</style>
</head>
<body>
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->

<div class="center1">
  <%@include file="menunew.jsp"%>
<%
String code="";
String userid="";
if(request.getParameter("code")!=null){
	  code= request.getParameter("code");
	  if(code.trim().length()==0){
		  code="0101";
	  }
	  if(code.trim().equals("0401")){
		  response.sendRedirect("mem.jsp");
	  }
	  if(!Tools.isMath(code)){
		  out.print("你的数据不合法！");
	  }
}
if(request.getParameter("userid")!=null){
	userid=request.getParameter("userid");
}
%>
<div class="right2" style="padding-left:10px; width:742px; overflow:hidden;">
	       
<div class="dialogdiv02"><!-- 找回密码 -->
	<span class="xq_t" style="margin-left:0px;width:100%;"><strong>请输入您的用户名与验证码：</strong></span>
	<div class="mobile111">
		<form id="form1" action="/" method="post" onsubmit="return false;">
	 		<div id="c_mobile">
	 			<div class="num">
		 			<span class="l">用户名：</span> <span class="c"><input type="text" id="txt_mobile" maxlength="255" name="txt_mobile" class="inputmobile"></span>
			        <!--成功-->
		    	    <span class="tips11" id="div_CheckCodeMsg"> <span class="img1"></span> 请输入您的用户名</span>
		        </div>
		        <div class="code">
		 			<span class="l">验证码：</span><span class="c"><input type="text" id="txt_pic" maxlength="4" onkeyup="this.value=this.value.replace(/[^\d]/g,'');" name="txt_mobile" class="inputmobile"></span>
			        <!--成功-->
		    	    <span class="lll" style="padding-left:9px;"><img src="/ImageCode?r=<%=System.currentTimeMillis() %>" alt="点击刷新" style="padding-left:9px;overflow:hidden;margin-top:4px;" onclick="this.src='/ImageCode?r='+Math.random();" /> </span>
		        </div>
		        <div class="button">
		        	<input name="" type="button" class="layer_button" id="b_getCode" onmousemove="this.className='layer_button_over'" onmouseout="this.className='layer_button'" value="确　　定"/>
		        </div>
		        <div class="clear"></div>
	 		</div>
		    <div class="clear"></div>
		</form>
	</div>
</div>

</div>
</div>
<%@include file="/inc/foot.jsp"%>
</body>
</html>
<script type="text/javascript">
$('#b_getCode').click(function(){
	if($("#txt_mobile").val() == ""){
		$('#div_CheckCodeMsg').attr('className','tips111').html(' <span class="img1"></span> 请输入您的用户名 ');
		$("#txt_mobile").focus();
		return;
	}
	var g_v = $('#txt_pic').val();
	if(g_v == ""){
		$('#div_CheckCodeMsg').attr('className','tips111').html(' <span class="img1"></span> 请输入验证码 ');
		$("#txt_pic").focus();
		return;
	}
	if(g_v.length!=4 || !/^[0-9]{4}/.test(g_v)){
		$('#div_CheckCodeMsg').attr('className','tips111').html(' <span class="img1"></span> 验证码输入错误 ');
		$("#txt_pic").focus();
		return;
	}
	$(this).attr('disabled',true);
	g_getCodeLength();
});
var g_getCodeLength = function(){
	$.post("/ajax/user/findPwd.jsp", {"mobile":$("#txt_mobile").val(),"code":$('#txt_pic').val(),"m":new Date().getTime()},function(data){
		if(data.success){
			$.load("提示",480,"/ajax/dialog/user/getbackPwd_confirm.jsp");
		}else{
			$('#div_CheckCodeMsg').attr('className','tips111').html(' <span class="img1"></span> '+data.message);
			$('#b_getCode').attr('disabled',false);
		}
	},"json");
};
</script>