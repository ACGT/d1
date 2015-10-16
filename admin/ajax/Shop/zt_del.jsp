<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"参数错误！\"}");
		return;
	}
	ShopInfo act_list = (ShopInfo)Tools.getManager(ShopInfo.class).get(id);
	if(act_list != null){
		ShopModel shopm=(ShopModel)Tools.getManager(ShopModel.class).findByProperty("shopmodel_infoid",new Long(Tools.parseLong(id)));
		if(shopm!=null)Tools.getManager(ShopModel.class).delete(shopm);
        Tools.getManager(ShopInfo.class).delete(id);
	 
			out.print("{\"code\":1,message:\"您所操作的记录已删除成功！\"}");
		    return;
	}else{
		out.print("{\"code\":0,message:\"操作失败！\"}");
		return;
	}
%>