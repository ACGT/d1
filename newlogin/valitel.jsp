<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>手机验证</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/newlogin/validate.js?"+System.currentTimeMillis())%>"></script>
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

</head>

<body>
<%@include file="/inc/head2.jsp" %>
<div class="center">
<!-- 注册成功-->
<%
if(session.getAttribute("zntkturl")!=null){
	 String url=session.getAttribute("zntkturl").toString();
	 System.out.println("周年领券："+url);
	 }
%>
<div class="reg_suc">
   	   <div class="regsuc_top">
			  <span>&nbsp;验证手机</span>
		</div>
		</div>
		<div style="clear:both;"></div>
		 <div class="regsuc_main"> <div class="regsuc_maindetail">
		
		     <div>
		     <div><span style="font-size:14px;">手机号码：</span>
		    <input type="text" id="txtRPhone" maxlength="11" onblur="CheckPhone(this.value,0)" onkeyup="this.value=this.value.replace(/[^\d]/g,'');CheckPhone2(this.value);" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "  />&nbsp;&nbsp;<span id="spanRPhone" style="color:red;display:none;">*请输入手机号码 </span><img  id="imgphone" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" />
		    </div>
		    <div class="yztxt" style="padding-left:72px;"><input name="yzcode" id="yzcode" placeholder="请输入右侧图片数字" class="yzcode mgt10"  type="text" >
							 <img id="vPic" class="vPic" style="vertical-align:bottom;cursor:pointer; margin-top:3px;" width="60" height="25"  />
							 <a class="ref" href="javascript:getyzcode();">刷新</a>
							 <br></br>
			</div>
			<div style="padding-left:72px;">
		    &nbsp;&nbsp;<input type="button" value="获取手机激活码" style="border:1px #727272 solid;height:24px;" onclick="checktime(this)"/>
		     </div>
		     </div>
		     
		      <div style="clear:both;padding-left:75px;"><span style="font-size:12px;color:#727272;" id="smsg"></span></div>
		       <div style="padding-top:10px;"><span style="font-size:14px;">验&nbsp;&nbsp;证&nbsp;&nbsp;码：</span><input type="text" id="txtcode" placeholder="请输入短信激活码"   maxlength="6" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "  />&nbsp;&nbsp;<span id="errCode" style="color:red;display:none;">*请输入验证码 </span><img  id="imgphone" src="http://images.d1.com.cn/images2012/New/user/infosucc.jpg" style=" vertical-align:middle;display:none;" /></div>
		       <div style="clear:both;"></div>
		     <div style="padding-top:50px; padding-bottom:50px; text-align:center;">
		    <a href="javascript:valitel();"><img src="http://images.d1.com.cn/images2012/login/zc_17.jpg" border="0"/></a>
		     </div>
		 </div> 
		
		 </div>
   <div style="clear:both;"></div>
    <div class="reg_bottom"><img src="http://images.d1.com.cn/images2012/login/zc_08.jpg"/></div>
</div>
<script>
	function getyzcode(){

		$.ajax({
	        type: "get",
	        dataType: "json",
	        url: "/ajax/wap/getyzcode.jsp",
	        cache: false,
	        error: function(json){
	        	alert("内部错误");
	        },
	        success: function(json){
	        	
	        	$("#vPic").attr("src",json.code);
	        }
	    });

	}
	getyzcode();
	</script>
<%@include file="/inc/foot.jsp" %>
</body>
</html>