<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<%
String sid="";
String t="";
if(request.getParameter("sid")!=null)
{
	sid=request.getParameter("sid");
}
if(request.getParameter("type")!=null)
{
	t=request.getParameter("type");
}
if(Tools.isNull(sid)){
	out.print("{\"succ\":false,message:\"商户信息id不能为空！\"}");
    return;
}
if(Tools.isNull(t)){
	t="1";
}
ShopInfo sif=(ShopInfo)Tools.getManager(ShopInfo.class).get(sid);
if(sif==null){
	out.print("{\"succ\":false,message:\"该商户信息不存在！\"}");
    return;
}
if(!sif.getShopinfo_shopcode().equals(session.getAttribute("shopcodelog").toString())){
	out.print("{\"succ\":false,message:\"您没有权限执行此操作！\"}");
    return;
}
try{
	sif.setShopinfo_lineflag(t);
	if(Tools.getManager(ShopInfo.class).update(sif, true)){
		if(t.equals("1")){
		out.print("{\"succ\":true,shopinfo_lineflag:\""+t+"\",message:\"上线成功！\"}");
		//out.print("{\"succ\":true,message:\"上线成功！\"}");
	    return;
		}
		else
		{
			out.print("{\"succ\":true,shopinfo_lineflag:\""+t+"\",message:\"下线成功！\"}");
			//out.print("{\"succ\":true,message:\"下线成功！\"}");
		    return;
		}
	}
	
	else{
		if(t.equals("1")){
		out.print("{\"succ\":false,message:\"上线失败！\"}");
		return;
		}
		else
		{
			out.print("{\"succ\":false,message:\"下线失败！\"}");
			return;
		}
	}
}
catch(Exception e){
	//out.print(e.getMessage());
	out.print("{\"succ\":false,message:\"操作出错，请稍后重试！\"}");
    return;
}

%>