<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkdfmng.jsp"%>
<%

	
	String price=request.getParameter("price");

	String admin_mng =session.getAttribute("dfadmin").toString();
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"修改ID错误！\"}");
		return;
	}
	if(Tools.isNull(price)){
		out.print("{\"code\":0,message:\"价格错误！\"}");
		return;
	}

	OrderItemBase ob = (OrderItemBase)Tools.getManager(OrderItemBase.class).get(id);
		if(ob!=null&&admin_mng.equals(ob.getOdrdtl_shopcode())){
			ob.setOdrdtl_purprice(Tools.parseDouble(price));
			
		if(Tools.getManager(OrderItemBase.class).update(ob, true)){
			out.print("{\"code\":1,message:\"更新成功！\"}");
		    return;
		}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}
		


%>