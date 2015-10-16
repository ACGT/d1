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
String id=request.getParameter("id").toString();
String gdsid="";
if(request.getParameter("gid")!=null)
{
	gdsid=request.getParameter("gid").trim();
}
String value=request.getParameter("val");
if(Tools.isNull(gdsid)){
	out.print("{\"succ\":false,message:\"商品编号不能为空！\"}");
    return;
}
if(Tools.isNull(value)){
	out.print("{\"succ\":false,message:\"名称不能为空！\"}");
    return;
}
Product p=ProductHelper.getById(gdsid);
if(p==null){
	out.print("{\"succ\":false,message:\"商品不存在，请重新填写！\"}");
    return;
}
GoodsGroupDetail gg=new GoodsGroupDetail();
try{
		gg.setGdsgrpdtl_createtime(new Date());
		gg.setGdsgrpdtl_gdsid(gdsid);
		gg.setGdsgrpdtl_mstid(new Long(id));
		gg.setGdsgrpdtl_stdvalue(value);
		gg=(GoodsGroupDetail)Tools.getManager(GoodsGroupDetail.class).create(gg);
		if(gg.getId()!=null){
			out.print("{\"succ\":true,\"id\":"+gg.getId()+",message:\"添加成功！\"}");
		    return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"添加失败，请稍后重试！\"}");
		    return;
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
		out.print("{\"succ\":false,message:\"添加出错，请稍后重试！\"}");
	    return;
	}

%>