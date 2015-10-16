<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
	if(!is_edit){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<%
String id = request.getParameter("id");
String name=request.getParameter("name");
String title=request.getParameter("title");
if(Tools.isNull(id)){
	out.print("{\"succ\":false,message:\"参数不正确！\"}");
    return;
}
if(Tools.isNull(name)){
	out.print("{\"succ\":false,message:\"名称不能为空！\"}");
    return;
}
if(Tools.isNull(title)){
	out.print("{\"succ\":false,message:\"标题不能为空！\"}");
    return;
}
GoodsGroup gg=(GoodsGroup)Tools.getManager(GoodsGroup.class).get(id);
if(gg==null)
{
	out.print("{\"succ\":false,message:\"记录不存在！\"}");
    return;
}

try{
		gg.setGdsgrpmst_stdname(name);
		gg.setGdsgrpmst_title(title);
		if(Tools.getManager(GoodsGroup.class).update(gg, true)){
			out.print("{\"succ\":true,message:\"更新成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"更新失败，请稍后重试！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"更新出错，请稍后重试！\"}");
	    return;
	}

%>