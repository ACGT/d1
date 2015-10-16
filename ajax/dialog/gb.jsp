<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../../inc/header.jsp" %><%
String zpid="";
if(!Tools.isNull(request.getParameter("zpid"))){
	zpid=request.getParameter("zpid");
}
float lastmoney=0f;
if(!Tools.isNull(request.getParameter("lastmoney"))){
	lastmoney=Tools.parseFloat(request.getParameter("lastmoney"));
}
String userid="";
if(lUser!=null){
	userid=lUser.getId();
}
%>
<script>
function flowdone(){
	var zpid=$.trim($("#zpid").val());
	if(zpid.length>0){
		$.ajax({
		    type: "post",
		    dataType: "text",
		    contentType: "application/x-www-form-urlencoded;charset=UTF-8",
		    url: "/ajax/flow/delcart.jsp",
		    cache: false,
		    data:{
		    	zpid: zpid
		   	 },error: function(XmlHttpRequest, textStatus, errorThrown){
		      //  $.alert('修改信息失败！');
		    },success: function(msg){
		    	//alert(msg);
		    	 if(msg==0){
		    		$.alert("错误，请稍后再试");
		    	 }else  if(msg==1){
		    		//$.alert("该活动已结束！");
		    		var userid=$.trim($("#userid").val());
		    		if(userid.length==0){
		    			Login_Dialog("/flowCheck.jsp");
		    		}else{
		    			window.location.href = "/flowCheck.jsp";
		    		}
		    		
		    	 }
		    	
		    }
		    }
		)
	}
	
}
function back(){
	$.close();
}

</script>
 <div class="form">
 <input type="hidden" id="zpid" value="<%=zpid %>" />
 <input type="hidden" id="userid" value="<%=userid %>" />
<table cellpadding="0" cellspacing="0" >

<tr><td>
<div style="padding:20px;float:left "><img src="http://images.d1.com.cn/images2012/2.png"/></div>
</td>
<td valign="middle"><div style="padding-top:0px; padding-right:0px; float:right ;"><span style="font-size:15px;">很抱歉，您选择的以下赠品无法领取，请返回购物车修改或放弃赠品直接结账。</span></div></td>
</tr>
<tr><td colspan="2">
<div style=" padding-left:140px; float:left; padding-bottom:30px;"><a href="javascript:back();"><img src="http://images.d1.com.cn/images2012/3.png"  alt="返回购物车" border="0"/></a></div>
<div style="padding-right:140px; float:right;padding-bottom:30px;"><a href="javascript:flowdone();"><img src="http://images.d1.com.cn/images2012/4.png"  alt="立即结算" border="0"/></a></div>
</td></tr>
<tr><td colspan="2">
<div style=" padding-left:30px; float:left; padding-bottom:10px;"><span style="font-weight:bold; font-size:16px;">无法领取赠品清单：</span><br/>
<table cellpadding="0" cellspacing="0" style="border:solid 1px #FAB345; width:600px; line-height:26px;">
<tr style="background:#F4F4F4; font-size:14px; color:#CCCCCC;"><td style="border-bottom:solid 1px #CCCCCC;">商品/商品号</td><td style="border-bottom:solid 1px #CCCCCC;">&nbsp;</td><td style="border-bottom:solid 1px #CCCCCC;">市场价</td></tr>
<%
Cart c=CartHelper.getById(request.getParameter("zpid"));
if(c!=null){
Product p=ProductHelper.getById(c.getProductId())	;
if(p!=null){
	%>
	<tr style="background:#FFFFE5;"><td><%=p.getGdsmst_gdsname() %> (<%=p.getId() %>)</td>
	<td><span style="color:#D0752C; font-size:12px;">再购买<%=lastmoney %>元商品即可换购。</span></td><td ><%=p.getGdsmst_saleprice() %></td></tr>
<%}
}
%>
</table>
</div>

</td></tr>

</table>
</div>