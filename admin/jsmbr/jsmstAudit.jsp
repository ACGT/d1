<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/inc/header.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "pop_order");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>

<%
	String jsmst_code = request.getParameter("jsmst_code");
	String jsmst_status = request.getParameter("jsmst_status");
	String pageno1 = request.getParameter("pageno1")==null?"1":request.getParameter("pageno1");
	
	if(jsmst_code == null || "".equals(jsmst_code) || jsmst_status == null || "".equals(jsmst_status)) {
		response.sendRedirect(request.getParameter("href")+"&code=参数错误!");
	}
	
	ArrayList<Jsmst> list=new ArrayList<Jsmst>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	
	listRes.add(Restrictions.eq("jsmst_code", jsmst_code));
	listRes.add(Restrictions.eq("jsmst_status", new Long(Long.parseLong(jsmst_status)-1)));
	
	List<BaseEntity> list2 = Tools.getManager(Jsmst.class).getList(listRes, null, 0, 3000);
	if(list2==null || list2.size()==0){
		response.sendRedirect(request.getParameter("href")+"&code=数据不存在!");
	}
	for(BaseEntity be:list2){
		list.add((Jsmst)be);
	}
	
	if(jsmst_status.equals("2"))
		list.get(0).setJsmst_auditdate(new Date());
	else if(jsmst_status.equals("3"))
		list.get(0).setJsmst_jsdate(new Date());
	else if(jsmst_status.equals("1"))
		list.get(0).setJsmst_createdate(new Date());
	
	list.get(0).setJsmst_status(new Long(Long.parseLong(jsmst_status)));
	
	Tools.getManager(Jsmst.class).update(list.get(0), true);
	
	response.sendRedirect(request.getParameter("href")+"&code=更新成功!");
%>