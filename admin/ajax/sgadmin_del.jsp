<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "sg_admin");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<%
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"参数错误！\"}");
		return;
	}
	SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).get(id);
	if(sg != null){

		if(Tools.getManager(SgGdsDtl.class).delete(sg)){
			out.print("{\"code\":1,message:\"您所操作的记录已删除成功！\"}");
		    return;
		}
	}else{
		out.print("{\"code\":0,message:\"操作失败！\"}");
		return;
	}
%>