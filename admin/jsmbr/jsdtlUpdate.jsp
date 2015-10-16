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

	String jsdtl_jsmstcode = request.getParameter("jsdtl_jsmstcode");
	String jsmst_shpcode = request.getParameter("jsmst_shpcode");
	String jsmst_shpname = request.getParameter("jsmst_shpname");
	String jsmst_status = request.getParameter("jsmst_status");
	String jsdtl_odrid = request.getParameter("jsdtl_odrid");
	String jsdtl_gwjshare = request.getParameter("jsdtl_gwjshare");
	String jsdtl_flag = request.getParameter("jsdtl_flag");
	
	String pageno1 = request.getParameter("pageno1")==null?"1":request.getParameter("pageno1");
	
	if(jsdtl_jsmstcode == null || "".equals(jsdtl_jsmstcode) 
			|| jsmst_status == null || "".equals(jsmst_status)
			|| jsmst_shpcode == null || "".equals(jsmst_shpcode)
			|| jsmst_shpname == null || "".equals(jsmst_shpname)) {
		response.sendRedirect("jsdtllist.jsp?jsdtl_jsmstcode="+jsdtl_jsmstcode+"&jsmst_shpcode="+jsmst_shpcode+"&jsmst_shpname="+jsmst_shpname+"&jsmst_status="+jsmst_status+"&code=参数错误!");
	}
	
	ArrayList<Jsdtl> list=new ArrayList<Jsdtl>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	
	listRes.add(Restrictions.eq("jsdtl_jsmstcode", jsdtl_jsmstcode));
	listRes.add(Restrictions.eq("jsdtl_flag", new Long(jsdtl_flag)));
	
	List<BaseEntity> list2 = Tools.getManager(Jsdtl.class).getList(listRes, null, 0, 3000);
	if(list2==null || list2.size()==0){
		response.sendRedirect("jsdtllist.jsp?jsdtl_jsmstcode="+jsdtl_jsmstcode+"&jsmst_shpcode="+jsmst_shpcode+"&jsmst_shpname="+jsmst_shpname+"&jsmst_status="+jsmst_status+"&code=数据不存在!");
	}
	for(BaseEntity be:list2){
		list.add((Jsdtl)be);
	}
	
	//计算金额
	double jsmst_sumprice = 0; 
	for(Jsdtl jd:list) {
		//更新数据
		if(jd.getJsdtl_odrid().equals(jsdtl_odrid)) {
			jd.setJsdtl_gwjshare(new Long(jsdtl_gwjshare));
	
			Tools.getManager(Jsdtl.class).update(jd, true);
		}

		jsmst_sumprice += jd.getJsdtl_gdsprice()==null?0:jd.getJsdtl_gdsprice();
		jsmst_sumprice += jd.getJsdtl_giftfee()==null?0:jd.getJsdtl_giftfee();
		jsmst_sumprice -= 2*jd.getJsdtl_shipfee();
		jsmst_sumprice -= jd.getJsdtl_jmprice()==null?0:jd.getJsdtl_jmprice();
		jsmst_sumprice -= jd.getJsdtl_lmcommision()==null?0:jd.getJsdtl_lmcommision();
		jsmst_sumprice -= (jd.getJsdtl_gwjshare().intValue()==2)?0:(jd.getJsdtl_gwjprice()==null?0:jd.getJsdtl_gwjprice());
	}
	
	ArrayList<Jsmst> listMst=new ArrayList<Jsmst>();
	List<SimpleExpression> listRes1 = new ArrayList<SimpleExpression>();
	
	listRes1.add(Restrictions.eq("jsmst_code", jsdtl_jsmstcode));
	
	List<BaseEntity> list3 = Tools.getManager(Jsmst.class).getList(listRes1, null, 0, 3000);
	if(list3==null || list3.size()==0){
		response.sendRedirect("jsdtllist.jsp?jsdtl_jsmstcode="+jsdtl_jsmstcode+"&jsmst_shpcode="+jsmst_shpcode+"&jsmst_shpname="+jsmst_shpname+"&jsmst_status="+jsmst_status+"&code=数据不存在!&href="+request.getParameter("href"));
	}
	for(BaseEntity be:list3){
		listMst.add((Jsmst)be);
	}
	
	listMst.get(0).setJsmst_sumprice(jsmst_sumprice);
	
	Tools.getManager(Jsmst.class).update(listMst.get(0), true);
		
	response.sendRedirect("jsdtllist.jsp?jsdtl_jsmstcode="+jsdtl_jsmstcode+"&jsmst_shpcode="+jsmst_shpcode+"&jsmst_shpname="+jsmst_shpname+"&jsmst_status="+jsmst_status+"&code=更新成功!&href="+request.getParameter("href"));
%>