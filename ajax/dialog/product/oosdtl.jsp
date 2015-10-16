<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../../inc/header.jsp" %><%
String id = request.getParameter("id");
Product product = ProductHelper.getById(id);
if(product == null || !ProductHelper.isShow(product)){
	Tools.ajaxTips(out,"找不到商品信息！","找不到商品信息，可能商品已经下架！");
	return;
}
%><div class="dialogdiv02" id="os_step_1"><!-- 到货通知 -->
<span class="xq_t"><strong>请输入您的邮箱地址：</strong></span>
<div class="mobile111">
	<div class="num">
		<span class="l">邮箱：</span> <span class="c"><input type="text" id="txt_email" maxlength="64" name="txt_mobile" class="inputmobile"></span>
		<span class="tips11" id="div_CheckMsg"> <span class="img1"></span> 请输入您的邮箱地址 </span>
	</div>
	<div class="button">
		<input type="button" class="layer_button" id="osbutton" onmousemove="this.className='layer_button_over'" onmouseout="this.className='layer_button'" value="提　　交"/>
	</div>
</div>
<div class="sendmsg">一旦商品到货，您将收到邮件通知，第一时间获知商品到货情况。</div>
<div class="clear"></div>
</div>
<div class="dialogdiv02" id="os_step_2" style="display:none;">
<%Tools.ajaxTips(out,"订阅成功！","一旦商品到货，您将收到邮件通知，第一时间获知商品到货情况。"); %>
</div>
<script type="text/javascript">
$('#osbutton').click(function(){
	var txt_email = $.trim($('#txt_email').val());
	$('#txt_email').val(txt_email);
	if(txt_email == ""){
		$('#div_CheckMsg').attr('className','tips111').html(' <span class="img1"></span> 请填写您的邮箱地址 ');
		$("#txt_mobile").focus();
		return;
	}
	if(!isEmail(txt_email)){
		$('#div_CheckMsg').attr('className','tips111').html(' <span class="img1"></span> 请正确填写您的邮箱地址 ');
		$("#txt_mobile").focus();
		return;
	}
	$(this).attr('disabled',true);
	$.post("/ajax/product/oosdtlAdd.jsp", {"id":"<%=id %>","email":txt_email,"r":new Date().getTime()},function(json){
		if(json.success){
			$('#os_step_1').hide();
			$('#os_step_2').show();
		}else{
			$('#div_CheckCodeMsg').attr('className','tips111').html(' <span class="img1"></span> '+json.message);
			$('#b_getCode').attr('disabled',false);
		}
	},"json");
});
</script>