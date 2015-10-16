<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/zt2012/public.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>米奇限量抢购 全场109元起-D1优尚网</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/gdsmstlistCart.js")%>"></script>

<style type="text/css">
    .detail_gdscoll{ width:700px; margin:0px auto; margin-top:1px; }
	.gdscollleft{ width:320px; margin:7px;  float:left;  }
	.gdscollright{ width:360px; float:left; margin-top:7px; margin-bottom:7px;}
	.gdscollright1{ width:360px; float:left;  margin:7px; _margin:4px;}
	.gdscollleft1{ width:320px; float:left;  margin-top:7px; margin-bottom:7px; }
	.gdscollleft ul{ list-style:none; width:320px; margin:0px; padding:0px;}
	.gdscollleft ul li{ height:108px; font-size:12px; color:#333; overflow:hidden; font-weight:none; text-align:left; }
	.gdscollleft ul li span{ display:block; height:108px; overflow:hidden;  padding-top:4px; padding-left:5px; float:left; color:#010004; }
	.gdscollleft ul li img{ border:solid 1px #000;}
	.gdscollleft ul li div{ float:left; width:190px; margin-left:18px; height:128px; line-height:18px;}
	.gdscollleft ul li div span{ display:block; height:auto; overflow:hidden; padding-left:0px; width:210px;}
	.gdscollleft ul li div .span1_1{ padding-top:2px;  width:190px; height:52px; overflow:hidden;}
	.gdscollleft ul li div .span2_1{ padding-top:4px; width:190px; }
	.gdscollleft ul li div .span3_1{ padding-top:4px;  padding-left:0px;width:190px;}
	.span3_1 a{float:left; margin-right:6px; display:block;}
	
	.gdscollleft1 ul{ list-style:none; width:320px; margin:0px; padding:0px;}
	.gdscollleft1 ul li{ height:108px; font-size:13px; color:#333; overflow:hidden; text-align:left; }
	.gdscollleft1 ul li span{ display:block; height:108px; overflow:hidden;  padding-top:4px; padding-left:5px; float:left; color:#010004;}
	.gdscollleft1 ul li img{ border:solid 1px #000;}
	.gdscollleft1 ul li div{ float:left; width:190px; margin-left:18px; height:128px; line-height:18px;}
	.gdscollleft1 ul li div span{ display:block; height:auto; overflow:hidden; padding-left:0px; }
	.gdscollleft1 ul li div .span1_1{ padding-top:2px; width:190px; height:52px; overflow:hidden;}
	.gdscollleft1 ul li div .span2_1{ padding-top:4px; width:190px; }
	.gdscollleft1 ul li div .span3_1{ padding-top:4px; padding-left:0px; width:190px;}
	.clear{ clear:both;font-size:1px;line-height:0;height:0px;*zoom:1; float:none;}
	.textdiv{ width:320px;height:8px; padding-left:25px; text-align:left;padding-right:15px; padding-top:22px; line-height:18px; }
	.textdiv font{ color:#333;}

    .gdscollleft1 ul li div .sq{position:absolute; margin-left:141px;margin-left:141px\0; _margin-left:-24px; +margin-left:-49px; +margin-top:-90px;  _margin-top:-65px;display:none;}
    .gdscollleft ul li div .sq{position:absolute; margin-left:141px;margin-left:141px\0; _margin-left:-24px; +margin-left:-49px; +margin-top:-90px;  _margin-top:-65px;display:none;}
    
</style>
<script type="text/javascript" language="javascript">
   function gdscollover(obj,flag,overcolor)
   {
	   $(obj).css('background','#'+overcolor);
	   if($('#gwx_'+flag)!=null)
		   {
		       $('#gwx_'+flag).css('display','block');
		   }
	   if($('#fav_'+flag)!=null)
	   {
	        $('#fav_'+flag).css('display','block');
	   }
	   if($('#sq_')+flag!=null)
		   {
		       $('#sq_'+flag).css('display','block');
		   }
   }
   function gdscollout(obj,flag)
   {
	   $(obj).css('background','');
	   if($('#gwx_'+flag)!=null)
	   {
	   $('#gwx_'+flag).css('display','none');
	   }
	   if($('#fav_'+flag)!=null)
	   {
	   $('#fav_'+flag).css('display','none');
	   }
	   if($('#sq_')+flag!=null)
	   {
	       $('#sq_'+flag).css('display','none');
	   }
   }
 //搭配加到购物车

   function AddGdscollInCart(obj){
   	var productid=$(obj).attr("attr");
   	if(productid==null)
   		{
   		   $.alert('加入购物车的商品不存在！');
   		   return;
   		}
   	$.inCart1(obj,{ajaxUrl:'/ajax/flow/productInCart.jsp',width:400,align:'center'});
   }
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<center>
<table id="__01" width="980" height="550" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<a href="/product/01717540" target="_blank"><img src="http://images.d1.com.cn/zt2011/20111130MICKEY/MICKEY_01.jpg" alt="" width="980" height="427" border="0"></a></td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/zt2011/20111130MICKEY/MICKEY_02.jpg" width="980" height="47" alt=""></td>
	</tr>
	<tr>
		<td>
			<% request.setAttribute("code","7146");
		request.setAttribute("length","50");%>
		<jsp:include   page= "/html/zt2011/20111104hzp/gdsrcm0305.jsp"   /></td>
	</tr>
	<tr>
	  <td>
	  <%= getGdscollInDetail("fbd2e4","e2bdce","fef1f8","3057") %>  
	  </td>
	</tr>
</table>
</center>

<%@include file="/inc/foot.jsp"%>
</center>
</body>
</html>