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
String name="";
if(request.getParameter("name")!=null)
{
	name=request.getParameter("name");
}
String title=request.getParameter("title");
if(Tools.isNull(name)){
	out.print("{\"succ\":false,message:\"名称不能为空！\"}");
    return;
}
if(Tools.isNull(title)){
	out.print("{\"succ\":false,message:\"标题不能为空！\"}");
    return;
}
GoodsGroup gg=new GoodsGroup();
try{
	    	
		gg.setGdsgrpmst_stdname(name);
		gg.setGdsgrpmst_title(title);
		gg.setGdsgrpmst_shopcode(session.getAttribute("shopcodelog").toString());
		gg.setGdsgrpmst_createtime(new Date());
		gg=(GoodsGroup)Tools.getManager(GoodsGroup.class).create(gg);
		if(gg.getId()!=null){
			out.print("{\"succ\":true,val:\""+gg.getId()+"\",message:\"添加成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"添加失败，请稍后重试！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		out.print("{\"succ\":false,message:\"添加出错，请稍后重试！\"}");
	    return;
	}

%>