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

	
	String req_mailflag=request.getParameter("mainflag");

	String req_status=request.getParameter("showflag");
	String admin_mng = "";
	//request.getSession().getAttribute("admin_mng").toString();
	String id = request.getParameter("id");
	if(Tools.isNull(id)){
		out.print("{\"code\":0,message:\"修改ID错误！\"}");
		return;
	}

	SgGdsDtl sgtb = null;
		sgtb = (SgGdsDtl)Tools.getManager(SgGdsDtl.class).get(id);
		if(!Tools.isNull(req_mailflag)){
		sgtb.setSggdsdtl_mailflag(new Long(req_mailflag));
		}
		if(!Tools.isNull(req_status)){
			sgtb.setSggdsdtl_status(new Long(req_status));
			}
		sgtb.setSggdsdtl_modiuser(admin_mng);
		sgtb.setSggdsdtl_modidate(new Date());
		if(Tools.getManager(SgGdsDtl.class).update(sgtb, true)){
			out.print("{\"code\":1,message:\"更新成功！\"}");
		    return;
		}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}


%>