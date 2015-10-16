<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<%!
public static OrderItemBase getOrderItem(String orderId,String subodrid){
	if(Tools.isNull(orderId)) return null;
	OrderBase order = (OrderBase)OrderHelper.getById(orderId);
	//if(order==null||order.getOdrmst_orderstatus().longValue()>=3)return null;
	if(order instanceof OrderMain){
		return (OrderItemBase)Tools.getManager(OrderItemMain.class).get(subodrid);
	}else if(order instanceof OrderRecent){
	   	return (OrderItemBase)Tools.getManager(OrderItemRecent.class).get(subodrid);
	}
	return null;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——退换货管理</title>
<style type="text/css">

.tab td {
	margin:10 px;padding:10 px;
}   
</style>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/flow/flowCheck.js")%>"></script>
<script type="text/javascript" >
function displayOption() { 
	document.getElementById("req_thwhy").options.remove(0);
	document.getElementById("req_thwhy").options[0].selected = 'selected';
}
function showOption() { 
	document.getElementById("req_thwhy").options.add(new Option('发货速度慢', '发货速度慢'),0);
	document.getElementById("req_thwhy").options[0].selected = 'selected';
}
<!---->
function getpaytype(){
	var req_thtype=$('input:radio[name="req_thtype"]:checked').val();
	if(parseInt(req_thtype)==1){	
		 $('#paytype').show();
		 showOption();
	}else{
		$('#paytype').hide();
		 displayOption();
	}
}

 function odrdtlth(){
	var req_odrid= $('#req_odrid').val();
	var req_subodrid= $('#req_subodrid').val();
	var req_thtype=$('input:radio[name="req_thtype"]:checked').val();
	var req_paytype=$('input:radio[name="req_paytype"]:checked').val();
	
	var req_thwhy= $('#req_thwhy').val();
	var req_memo= $('#req_memo').val();
 	
	if(req_thwhy=='') {
		alert("请选择退货原因!");
	}else{
	 	$.post("/ajax/user/odrdtlth.jsp",{"req_odrid":req_odrid,"req_subodrid":req_subodrid,"req_thtype":req_thtype,"req_paytype":req_paytype,"req_thwhy":req_thwhy,"req_memo":req_memo},function(json){
				if(json.success) {
			 		window.location.href="/user/odrstatusdetail.jsp?odrid="+req_odrid+"&subodrid="+req_subodrid+"&thtype="+req_thtype+"&lstatus=0";
				}else {
					$.alert(json.message)
				}
		},"json");
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
<%
	String thtype = request.getParameter("thtype");
%>
  <div class="mbr_right">
  <table>
    			<tr>
    				<td align="center">
    					<img src="http://images.d1.com.cn/images2012/New/user/red_deric.jpg" />
    				</td>
    				<td align="center">
    				<%
							out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
    				%>
    				</td>
    				<td align="center">
    				<%
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
    				%>
    				</td>
    				<td align="center">
    				<%
    						out.println("<img src='http://images.d1.com.cn/images2012/New/user/white_direc.jpg' />");
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
		<br/>
		<br/>
		<table ><tr><td height="15"></td></tr></table>

		<div class="paylist">
    		
   
    		<%String subodrid=request.getParameter("subodrid");
    		String odrid=request.getParameter("odrid");
    		if(!Tools.isNull(subodrid)&&odrid!=null){
    			OrderItemBase odritem =getOrderItem(odrid,subodrid);
    			
    			//if(odritem.getOdrdtl_shipstatus().longValue()>=2){
    	
    		%>
    		<input type="hidden" id="req_odrid" name="req_odrid" value="<%=odrid %>" />
    		<input type="hidden" id="req_subodrid" name="req_subodrid" value="<%=subodrid %>" />
    		<table width="769" border="0" style="padding: 10px">
  <tr style="display:none">
    <td width="230" align="right" height="30">退货换货类型：&nbsp;&nbsp;</td>
    <td width="539">    <input type="radio" id="req_thtype" <%if(thtype.equals("1")){out.print("checked='checked'");} %> onclick="getpaytype();" name="req_thtype" value="1" />
退货&nbsp;&nbsp;
  <input type="radio" id="req_thtype"  name="req_thtype" <%if(thtype.equals("2")){out.print("checked='checked'");} %> onclick="getpaytype();" value="2" />
    换货</td>
  </tr>
  <tr id="paytype" style="display:<%if(thtype.equals("2")) {out.print("none");} else {out.print("''");}%>">
    <td width="230"  align="right" height="30">退款方式：&nbsp;&nbsp;</td>
    <td width="539"><input type="radio" id="req_paytype1"  name="req_paytype" value="1" />
退到预存款 &nbsp;&nbsp;
  <input type="radio" id="req_paytype2"  name="req_paytype" value="2" checked="checked" />
原路退回</td>
  </tr>
 <!--  <tr>
    <td>上传图片</td>
    <td><input type="text" name="textfield2" /></td>
  </tr> -->
  <!--odrdtl OdrDtl_rackcode商品分类 -->
<%
String rackcode = odritem.getOdrdtl_rackcode();//商品分类
String rackcode_new = "";
%> 
  <tr>
    <td align="right" height="30">退货换货原因：&nbsp;&nbsp;</td>
    <td><select name="req_thwhy" id="req_thwhy" >
    	<option value="">请选择退货原因</option>
      <%
   	   if(rackcode != null){
	   rackcode_new = rackcode.substring(0, 3);
	   if(rackcode_new.equals("020")||rackcode_new.equals("030")){//服装 
	   %>
		   <option value="尺码不合适">尺码不合适</option>
		   <option value="尺码表不标准">尺码表不标准</option>
		   <option value="面料问题">面料问题</option>
		   <option value="颜色有色差">颜色有色差</option>
		   <option value="做工不好">做工不好</option>
		   <option value="面料问题">面料问题</option>
		   <option value="明显质量问题">明显质量问题</option>
		   <option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
	  <% 
	  }else if(rackcode_new.equals("014")){//化妆品
		  %>
		   <option value="商品过期">商品过期</option>
		   <option value="包装磨损严重">包装磨损严重</option>
		   <option value="商品破损">商品破损</option>
	  <%  
	  }else if(rackcode_new.equals("050")){//包
		  %>
		   <option value="商品破损">商品破损</option>
		   <option value="颜色有色差">颜色有色差</option>
		   <option value="尺码不标准">尺码不标准</option>
		   <option value="材质与介绍不符合">材质与介绍不符合</option>
		   <option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
		   <option value="做工不好">做工不好</option>
		   <option value="质量问题">质量问题</option>
	  <%  
	  }else if(rackcode_new.equals("031")||rackcode_new.equals("021")){//鞋子
		  %>
		   <option value="颜色有色差">颜色有色差</option>
		   <option value="尺码不标准">尺码不标准</option>
		   <option value="材质与介绍不符合">材质与介绍不符合</option>
		   <option value="明显质量问题(污渍、破损等)">明显质量问题(污渍、破损等)</option>
		   <option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
		   <option value="做工不好">做工不好</option>
	  <%  
	  }else if(rackcode_new.equals("012")){//创意家居
		  %>
		   <option value="颜色有色差">颜色有色差</option>
		   <option value="做工不好">做工不好</option>
		   <option value="款式或颜色不喜欢">款式或颜色不喜欢</option>
		   <option value="明显质量问题(污渍、破损等)">明显质量问题(污渍、破损等)</option>
	  <%  
	  }else if(rackcode_new.equals("015")||rackcode_new.equals("040")||rackcode_new.equals("060")){
		  %>
		   <option value="发错货">发错货</option>
		   <option value="包装残损">包装残损</option>
		   <option value="质量问题">质量问题</option>
	  <%  
	  }else if(rackcode_new.equals("070")){
		  %>
		   <option value="商品变质">商品变质</option>
		   <option value="包装残损">包装残损</option>
		   <option value="过保质期">过保质期</option>
	  <%  
	  }   }
  %>
		<option value="其它">其它</option>
    </select>
    </td>
  </tr>
  <tr>
    <td align="right" height="30">退货换货备注：&nbsp;&nbsp;</td>
    <td><textarea name="req_memo" id="req_memo"  cols="60" rows="4"></textarea></td>
  </tr>
  <tr>
    <td height="30">&nbsp;</td>
    <td><input type="submit" name="Submit" onclick="odrdtlth()" value="提交" /></td>
  </tr>
</table>
<%   // }
    			ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(odritem.getOdrdtl_shopcode());
    			if(shpmst!=null){
    				out.print("<div> 提交退换货申请后请按以下地址寄回：<br>");
    				out.print("<span style=\"color:red\">"+shpmst.getShpmst_postaddr()+"</span>");
    				out.print("</div>");
    			}
    			
    			} %>
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

