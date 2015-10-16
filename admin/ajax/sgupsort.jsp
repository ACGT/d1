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

	
	String sort=request.getParameter("sort");

	String admin_mng = "";
	//request.getSession().getAttribute("admin_mng").toString();
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"修改ID错误！\"}");
		return;
	}
	if(Tools.isNull(sort)){
		out.print("{\"code\":0,message:\"排序号错误！\"}");
		return;
	}

	SgGdsDtl sgtb = null;
		sgtb = (SgGdsDtl)Tools.getManager(SgGdsDtl.class).get(id);
		if(!Tools.isNull(sort)){
			sgtb.setSggdsdtl_sort(new Long(sort));
			}
		if(Tools.getManager(SgGdsDtl.class).update(sgtb, true)){
			out.print("{\"code\":1,message:\"更新成功！\"}");
		    return;
		}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}


%>