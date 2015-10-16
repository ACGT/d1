<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<html>
<head>
<title>会员专区——退换货管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<style type="text/css">

.service-type-list {
	margin-top: 40px; margin-left: 200px;
}
.service-type-list li {
	width: 100px; height: 100px;; 
}
.service-type-list li a {
	border-radius: 5px; border: 1px solid rgb(255, 228, 189); transition:background 0.5s, border 0.5s; border-image: none; width: 100px; height: 100px; text-align: center; color: rgb(176, 77, 31); line-height: 100px; font-family: "Microsoft YaHei"; font-size: 20px; font-weight: 400; display: block; background-color: rgb(255, 245, 229); -webkit-border-radius: 5px; -webkit-transition: background 0.5s, border 0.5s; -moz-transition: background 0.5s, border 0.5s; -o-transition: background 0.5s, border 0.5s;
}
.service-type-list li a:hover {
	border: 1px solid rgb(255, 83, 22); border-image: none; color: rgb(255, 255, 255); background-color: rgb(255, 133, 90);
}
.main-wrap {
	padding: 0px 40px;
}
</style>
</head>
<body>
	<%@include file="/inc/head.jsp" %>
	<div class="center">
     <%@include file="left.jsp" %>
     
	<DIV align="center" style="width:760px;height:600px;float:left;overflow:hidden">
		<div style="font-size:16px;"><b>请选择您要申请的服务类型</b></div>
		<div style="float:left;">
		<UL class="clearfix service-type-list service-list=4" style="list-style-type: none;">
		  <LI class="f-l" style="float:left;"><A href='/user/odrth.jsp?odrid=<%=request.getParameter("orderid") %>&subodrid=<%=request.getParameter("subodrid") %>&thtype=1'>
		  								退货														 </A></LI>
		 <li class="f-l" style="float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
		  <LI class="f-l" style="float:left;"><A href='/user/odrth.jsp?odrid=<%=request.getParameter("orderid") %>&subodrid=<%=request.getParameter("subodrid") %>&thtype=2'>
		  								换货															 </A></LI>
		</UL>
		</div>
		<div style="float:left;text-align: left;margin-left: 20px; ">
				<br>
				<b>退换货需知：</b><br>
				如果商品有质量问题，自您收到商品之日起30日内，可以申请退货或换货，卖家承担退回运费，退货后请保留物流底单，将快递单号填写在网页。<br>

				在商品无任何问题情况下，自您实际收到商品之日起30日内，在商品返回运费由您承担的情况下，可享受无理由退货。<br>

				<br>
				<b>以下情况不予办理退换货：</b><br> 
				（1）任何非由D1优尚网出售的商品，不予办理退换货；<br> 
				（2）任何已使用商品，不予办理退换货，但有质量问题除外；<br> 
				（3）密封产品原包装打开，非质量问题不予退换； <br>
				（4）因人为疏忽或使用不当而导致的商品损坏不予退换；<br> 
				（5）任何事先注明不在退换货范围的特殊商品，不予退换；<br>
				<br>
				<b>退货退款流程：</b>1.您申请退货 >2.按提示地址，您将货品寄给卖家，并填写退货物流信息 >3.卖家确认收到货 >4.优尚网退款<br>
				<br>
				<b>换货流程：</b>1.您申请换货 >2. 按提示地址，您将货品寄给卖家，并填写退货物流信息 >3. 卖家确认收到货 >4.卖家将换货寄回<br>				
		</div>
	</DIV>

	</div>
	
	<div class="clear"></div>
	<%@include file="/inc/foot.jsp" %>
</body>
</html>