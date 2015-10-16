<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<%!
public static OrderItemBase getOrderItem(String orderId,String subodrid){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	if(order instanceof OrderMain){
		return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
	}else if(order instanceof OrderRecent){
	   	return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid);
	}
	return null;
}

public static OrderBase getOrder(String orderId) {
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	return order;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——退换货管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<script language="javascript">
function odrdtlth(){
	var req_subodrid= $('#req_subodrid').val();
	var req_usrwl= $('#req_usrwl').val();
	var req_usrkd= $('#req_usrkd').val();
 	
 	$.post("/ajax/user/odrdtlth1.jsp",{"req_subodrid":req_subodrid,"req_usrwl":req_usrwl,"req_usrkd":req_usrkd},function(json){
			if(json.success) {
				location.replace(location.href);
			}else {
				$.alert(json.message)
			}
	},"json");
 }
 
 function sel_usrwl(obj) {
	 if(obj.value=='其他') {
		 $('#req_usrwl').val('');
		$('#req_usrwl').show();
	 }else{
	 	$('#req_usrwl').val(obj.value);
		 $('#req_usrwl').hide();

	 }
 }
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->

  <div class="mbr_right">
<div class="mypayrecord1">

		  &nbsp;&nbsp;<span>退换货管理</span>

		</div>

		<table ><tr><td height="15"></td></tr></table>

		<div class="paylist">
    		<%
    		
    		String subodrid=request.getParameter("subodrid");
    		String odrid=request.getParameter("odrid");
    		String thtype = request.getParameter("thtype");//1退货 2换货
    		String lstatus = request.getParameter("lstatus");
    		String shop_name = "";

    		
    		if(!Tools.isNull(subodrid)&&odrid!=null){
        		OrderBase order = getOrder(odrid);
        		
    			OrderItemBase odritem =getOrderItem(odrid,subodrid);
    			ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(odritem.getOdrdtl_shopcode());
    			String addr = "";
    			if(shpmst!=null){
    				if(shpmst.getShpmst_postaddr() != null){
    					addr = shpmst.getShpmst_postaddr();
    				}
    				if(shpmst.getShpmst_shopname() != null){
    					shop_name = shpmst.getShpmst_shopname();
    				}
    			}
    			
    			OdrShopTh odrshopth=(OdrShopTh)Tools.getManager(OdrShopTh.class).findByProperty("odrshopth_subodrid", new Long(subodrid));
    			String kd = "";
    			String ydh = "";
    			OrderBase ob_base = OrderHelper.getHistoryById(odrid);
    			if(ob_base != null){
    				if(ob_base.getOdrmst_d1shipmethod() != null){
    					kd = ob_base.getOdrmst_d1shipmethod();//快递
    				}
    				if(ob_base.getOdrmst_goodsodrid() != null){
    					ydh = ob_base.getOdrmst_goodsodrid();//运单号
    				}
    			}
    			
    			
    		%>
    		<input type="hidden" id="req_odrid" name="req_odrid" value="<%=odrid %>" />
    		<input type="hidden" id="req_subodrid" name="req_subodrid" value="<%=subodrid %>" />
    		<table>
    			<tr>
    				<td align="center">
    					<img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" />
    				</td>
    				<td align="center">
    				<%
    					if(lstatus.equals("0") || lstatus.equals("1") || lstatus.equals("2")) {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/red_deric.jpg' />");
    					}else {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
    					}
    				%>
    				</td>
    				<td align="center">
    				<%
    					if(lstatus.equals("1") || lstatus.equals("2")) {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/red_deric.jpg' />");
    					}else {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
    					}
    				%>
    				</td>
    				<td align="center">
    				<%
    					if(lstatus.equals("2")) {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/red_deric.jpg' />");
    					}else {
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
    					}
    				%>
    				</td>
    			</tr>
    			<tr>
    				<td align="center">
    				<%
    						if(thtype.equals("1")) {
    							out.println("您申请退货");
    						}
    						else {
    							out.println("您申请换货");
    						}
    				 %>	
    				</td>
    				<td align="center">
    					您将货品寄给卖家，并填写退货物流信息
    				</td>
    				<td align="center">
    					卖家确认收到货
    				</td>
    				<td align="center">
    					<%
    						if(thtype.equals("1")) {
    							out.println("优尚网退款");
    						}
    						else {
    							out.println("卖家将换货寄回");
    						}
    					%>
    				</td>
    			</tr>
    		</table>
    		<table width="769" border="0" cellspacing="0" cellpadding="0">
    		<tr style="height: 40px;"></tr>
  <tr>
    <td width="185"></td>
    <td width="499" style="font-size: 16px;">   
    <%if(thtype!=null){
    	if(thtype.equals("1")){//退货
    		if(lstatus != null){//0待受理 1等退款 2已退款
    			if(lstatus.equals("0")){
    				%>
    				<span style="height: 26px; line-height: 26px;">您的退货申请已经提交。</span><br />								
    				<span style="height: 26px; line-height: 26px;">您的退换货原因是：<%=odrshopth.getOdrshopth_thwhy()==null?"":odrshopth.getOdrshopth_thwhy()%>	</span><br />							
    				<span style="height: 26px; line-height: 26px;">您选择的退款方式是：<%=odrshopth.getOdrshopth_paytype()==1?"退到预存款":"原路退回"%></span><br />									
    				<span style="height: 26px; line-height: 26px;">如果您的退货未寄出，请按如下地址退回商品：	</span><br />								
    				<span style="height: 26px; line-height: 26px; color:red;">地址：<%=addr %>	</span><br />								

    				<span style="height: 26px; line-height: 26px;"><%=shop_name %>收到您的退货后，将尽快给您办理退款。</span><br />									
	    			<br>
	    			<%if(odrshopth.getOdrshopth_usrwl() == null || "".equals(odrshopth.getOdrshopth_usrwl())) { %>
	    			如果您已经寄出货品，请填写如下快递信息<br>
	    			<%}else { %>
	    			退货寄回的快递信息<br>
	    			<%} %>
	    			物流公司：
	    			<%if(odrshopth.getOdrshopth_usrwl() == null || "".equals(odrshopth.getOdrshopth_usrwl())) { %>
	    			<select name="selectprinttype" onchange="sel_usrwl(this)">
						<option value="领航快递">领航快递</option>
						<option value="EMS">EMS</option>
						<option value="宅急送">宅急送</option>
						<option value="圆通速递">圆通速递</option>
						<option value="韵达快运">韵达快运</option>
						<option value="顺丰快递">顺丰快递</option>
						<option value="申通快递">申通快递</option>
						<option value="中通快递">中通快递</option>
						<option value="全峰快递">全峰快递</option>
						<option value="其他">其他</option>
					</select>
	    			<input type="text" name="req_usrwl" id="req_usrwl" value="领航快递" style="display:none"><br/>
	    			<%}else { %>
	    			<%= odrshopth.getOdrshopth_usrwl()%><br>
	    			<%} %>
	    			快递单号：
	    			<%if(odrshopth.getOdrshopth_usrkd() == null || "".equals(odrshopth.getOdrshopth_usrkd())) { %>
	    			<input type="text" name="req_usrkd" id="req_usrkd">
	    			&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn_usrdate" id="btn_usrdate" value="确    认" onclick="odrdtlth()"><br/>
	    			<%}else { %>
	    			<%= odrshopth.getOdrshopth_usrkd()%>
	    			<%} %>
	    			
	    		
				<%
    			}else if(lstatus.equals("1")){%>
    				<span style="height: 26px; line-height: 26px;">卖家已经收到您的货品。优尚网将尽快给您办理退款。</span><br />
    			<%}else{%>
    				<span style="height: 26px; line-height: 26px;">您的退货已接收，并已经给您退款。</span><br />
    				<span style="height: 26px; line-height: 26px;">您的退换货原因是：<%=odrshopth.getOdrshopth_thwhy()==null?"":odrshopth.getOdrshopth_thwhy()%>	</span><br />							
    				<span style="height: 26px; line-height: 26px;">您选择的退款方式是：<%=odrshopth.getOdrshopth_paytype()==1?"退到预存款":"原路退回"%></span><br />
    				<%if(odrshopth.getOdrshopth_paytype()==1){
    					%>
    					<span style="height: 26px; line-height: 26px;">请查询您的预存款。</span><br />
    					<% 
    				}%>
    			<%}
    				
    		}
    	}else{//换货
			if(lstatus != null){//0待受理 1已受理 2已换货
    			if(lstatus.equals("0")){%>
    				<span style="height: 26px; line-height: 26px;">您的换货申请已经提交。</span><br />
    				<span style="height: 26px; line-height: 26px;">您的换货原因是：<%=odrshopth.getOdrshopth_thwhy()==null?"":odrshopth.getOdrshopth_thwhy()%></span><br />
    				<span style="height: 26px; line-height: 26px;">如果您的退货未寄出，请按如下地址退回商品：</span><br />
    				<span style="height: 26px; line-height: 26px; color:red;">地址：<%=addr %></span><br />
    				<span style="height: 26px; line-height: 26px;"><%=shop_name %>收到您的退货后，将尽快给您办理换货。</span><br />
	    			<br>
	    			<%if(odrshopth.getOdrshopth_usrwl() == null || "".equals(odrshopth.getOdrshopth_usrwl())) { %>
	    			如果您已经寄出货品，请填写如下快递信息<br>
	    			<%}else { %>
	    			退货寄回的快递信息<br>
	    			<%} %>
	    			物流公司：
	    			<%if(odrshopth.getOdrshopth_usrwl() == null || "".equals(odrshopth.getOdrshopth_usrwl())) { %>
	    			<select name="selectprinttype" onchange="sel_usrwl(this)">
						<option value="领航快递">领航快递</option>
						<option value="EMS">EMS</option>
						<option value="宅急送">宅急送</option>
						<option value="圆通速递">圆通速递</option>
						<option value="韵达快运">韵达快运</option>
						<option value="顺丰快递">顺丰快递</option>
						<option value="申通快递">申通快递</option>
						<option value="中通快递">中通快递</option>
						<option value="全峰快递">全峰快递</option>
						<option value="其他">其他</option>
					</select>
	    			<input type="text" name="req_usrwl" id="req_usrwl" value="领航快递" style="display:none"><br/>
	    			<%}else { %>
	    			<%= odrshopth.getOdrshopth_usrwl()%><br>
	    			<%} %>
	    			快递单号：
	    			<%if(odrshopth.getOdrshopth_usrkd() == null || "".equals(odrshopth.getOdrshopth_usrkd())) { %>
	    			<input type="text" name="req_usrkd" id="req_usrkd">
	    			&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn_usrdate" id="btn_usrdate" value="确    认" onclick="odrdtlth()"><br/>
	    			<%}else { %>
	    			<%= odrshopth.getOdrshopth_usrkd()%>
	    			<%} %>
    			<%}else if(lstatus.equals("1")){%>
    				<span style="height: 26px; line-height: 26px;">卖家已经收到您的货品，将尽快将您所换物品寄出。</span><br />
    			<%}else if(lstatus.equals("2")){%>
   				<span style="height: 26px; line-height: 26px;">您的换货原因是：<%=odrshopth.getOdrshopth_thwhy()==null?"":odrshopth.getOdrshopth_thwhy()%></span><br />
    			<span style="height: 26px; line-height: 26px;">您的换货地址是：<%=order.getOdrmst_paddress()%></span><br />   				
				<span style="height: 26px; line-height: 26px;">
					您的换货商品已寄出，
				<%if(!"".equals(odrshopth.getOdrshopth_shipname())) { %>
					物流公司是<%=odrshopth.getOdrshopth_shipname() %>,
				<%} %>
				<%if(!"".equals(odrshopth.getOdrshopth_shipcode())) { %>
					快递单号是<%=odrshopth.getOdrshopth_shipcode() %>,
				<%} %>
				
					请注意查收。
				</span><br />
			<%}
    		}
    	}
    }
    %>
    
    </td>
    <td width="185"></td>
  </tr>
</table>
<%} %>
      		</div>

 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

