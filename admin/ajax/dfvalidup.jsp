<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkdfmng.jsp"%>
<%

	
	String valid=request.getParameter("valid");

	String admin_mng =session.getAttribute("dfshopcode").toString();
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"修改ID错误！\"}");
		return;
	}
	if(Tools.isNull(valid)){
		out.print("{\"code\":0,message:\"修改状态错误！\"}");
		return;
	}

	GdsDf df = (GdsDf)Tools.getManager(GdsDf.class).get(id);
		if(df!=null&&admin_mng.equals(df.getGdsdf_shopcode())){
			df.setGdsdf_validflag(new Long(valid));
			
		if(Tools.getManager(GdsDf.class).update(df, true)){
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