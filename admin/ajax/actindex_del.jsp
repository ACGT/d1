<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"参数错误！\"}");
		return;
	}
	ActIndex act_list = (ActIndex)Tools.getManager(ActIndex.class).get(id);
	if(act_list != null){
		act_list.setId(id);
		act_list.setActindex_delflag(new Long(1));
		act_list.setActindex_deldate(new Date());
		if(Tools.getManager(ActIndex.class).update(act_list, true)){
			out.print("{\"code\":1,message:\"您所操作的记录已删除成功！\"}");
		    return;
		}
	}else{
		out.print("{\"code\":0,message:\"操作失败！\"}");
		return;
	}
%>