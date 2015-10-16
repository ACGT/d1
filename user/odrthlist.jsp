<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
<%!
public static List<OdrShopTh> getOdrShopThList(String mbrid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("odrshopth_mbrid", new Long(mbrid)));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("odrshopth_createdate"));
	List list = Tools.getManager(OdrShopTh.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
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

		<div class="myaddress">

		  &nbsp;&nbsp;<span>退换货订单</span>

		</div>

		<table ><tr><td height="15"></td></tr></table>

		<div class="addresslist">

		  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >


				   <tr style=" color:#a25663;" height="33"><td class="d1"  width="80">订单号	</td><td  class="d1" width="60">商品编码</td><td class="d1" width="160">商品名称</td><td class="d1" width="40">	数量</td><td class="d1" width="40">	金额	</td><td class="d1" width="100">申请时间<br>受理时间<br>完成时间</td><td class="d1" width="60">受理</td></tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					<% String[] thstatus = new String[]{"待受理","已受理","已换货"};  
					   String[] thstatus2 = new String[]{"待受理","等退款","已退款"}; 
						List<OdrShopTh> list =getOdrShopThList(lUser.getId());
					if(list!=null){
						long lstatus=0;
				     	 long thtype=0;
				     	 SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						for(OdrShopTh odrth:list){									
							thtype=odrth.getOdrshopth_thtype().longValue();
							lstatus=odrth.getOdrshopth_status().longValue();
					%>
				  <tr height="33">
				  <td width="80"><%=odrth.getOdrshopth_odrid() %></td>
				  <td width="60"><%=odrth.getOdrshopth_gdsid() %></td>
				  <td width="160"><%=odrth.getOdrshopth_gdsname() %></td>
				  <td width="40"><%=odrth.getOdrshopth_gdscount() %></td>
				  <td width="40"><%=odrth.getOdrshopth_money() %></td>
				  <td width="100"><%=format.format(odrth.getOdrshopth_createdate()) %><br>
				  <%if(odrth.getOdrshopth_shopcldate()!=null){ %>
				  <%=format.format(odrth.getOdrshopth_shopcldate()) %><br>
				  <%}
				  if(odrth.getOdrshopth_cldate()!=null){ %>
				  <%=format.format(odrth.getOdrshopth_cldate()) %>
				  <%} %>
				  </td>
				  <td width="60"><% if(thtype==1){
        	   out.print("退货("+thstatus2[(int)lstatus]+")");
        	   }else{
        		   out.print("换货("+thstatus[(int)lstatus]+")");
        		} %>
				  </td>
			      </tr>
				   <%
						}
					}
				   %>

			   </table>
		</div>

		<table ><tr><td height="20"></td></tr></table>

		 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

