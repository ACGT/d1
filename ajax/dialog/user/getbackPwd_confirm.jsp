<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../../inc/header.jsp" %><%

%><style type="text/css">
.re-send,.tips11 .img1,.btn_validate2{background:url(http://images.d1.com.cn/images2012/New/registerbg.gif) no-repeat;}
.mobile111{width:99%;}
.mobile111 .txt{width:100%;float:left;display:inline;padding:6px 0;}
.mobile111 .num{ width:100%; float:left; background:#F4FCFE; padding:10px 0; border:1px solid #D4E8FC; margin-bottom:16px;}
.mobile111 .l{width:60px; float:left; text-align:center; line-height:34px;}
.sendmsg{float:left;width:100%;line-height:20px; font-size:12px;text-align:left;border-top: 1px dashed #D6D6D6;padding-top:10px;}
.mobile111 .button{float:left;width:100%;text-align:center;margin-bottom:15px;margin-top: 10px;}
.inputmobile{border:1px solid #A6A6A6; width:126px; height:18px; margin-top:4px; float:left; padding-top:4px; padding-left:4px;}
.xq_t {border-bottom: 1px dashed #D6D6D6;width: 510px;float: left;padding-bottom: 6px;margin-bottom: 4px;margin-left: 24px;}
</style>
<div class="dialogdiv02"><!-- 验证手机 -->
<span class="xq_t" style="margin-left:0px;width:100%;"><strong>我们已发出了通知信到您的邮箱:<%request.getParameter("message"); %>，请在点击邮件内的链接继续创建密码。</strong></span>
<div class="mobile111">
	<span class="txt"><span class="blue">如果您忘记了注册的邮箱地址或者未收到邮件，请致电：<font color="red">400-680-8666</font>，我们的客户服务人员很乐意帮助您。</span></span>
	<div class="button">
		<input name="" type="button" class="layer_button" onclick="javascript:$.close();" onmousemove="this.className='layer_button_over'" onmouseout="this.className='layer_button'" value="关　　闭"/>
	</div>
   <div class="clear"></div>
</div>
</div>