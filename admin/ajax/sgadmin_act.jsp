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
	String req_gdsid = request.getParameter("req_gdsid");
	if(Tools.isNull(req_gdsid)){
		out.print("{\"code\":0,message:\"请您填写商品编号！\"}");
		return;
	}
	String req_maxnum = request.getParameter("req_maxnum");
	if(Tools.isNull(req_maxnum)||Tools.parseInt(req_maxnum)<0){
		out.print("{\"code\":0,message:\"请您填写正添写最大购买个数！\"}");
		return;
	}
	String hsgimg = request.getParameter("hsgimg");
	

	String req_gdsname=request.getParameter("req_gdsname");
	String req_memo=request.getParameter("req_memo");
	String req_cls=request.getParameter("req_cls");
	String req_xsnum=request.getParameter("req_xsnum");
	String req_mailflag=request.getParameter("req_mailflag");
	String req_vallnum=request.getParameter("req_vallnum");
	String req_vusrnum=request.getParameter("req_vusrnum");
	String req_mailsort=request.getParameter("req_mailsort");
	String req_sort=request.getParameter("req_sort");
	String req_status=request.getParameter("req_status");
	String req_realbuynum=request.getParameter("req_realbuynum");
	String req_limitgroup=request.getParameter("req_limitgroup");
	String admin_mng = request.getSession().getAttribute("admin_mng").toString();
	String id = request.getParameter("id");
	String sgflag = request.getParameter("sgflag");
	SgGdsDtl sgtb = null;
	if(!Tools.isNull(id)){
		sgtb = (SgGdsDtl)Tools.getManager(SgGdsDtl.class).get(id);
	}else{
		sgtb = new SgGdsDtl();
	}
	   Product p=ProductHelper.getById(req_gdsid);
	   if(p==null){
		   out.print("{\"code\":0,message:\"添加更新失败，商品不存在\"}");  
			return;
	   }
	sgtb.setSggdsdtl_sdate(p.getGdsmst_promotionstart());
	sgtb.setSggdsdtl_edate(p.getGdsmst_promotionend());
	sgtb.setSggdsdtl_gdsid(req_gdsid);
	sgtb.setSggdsdtl_gdsname(req_gdsname);
	sgtb.setSggdsdtl_imgurl(hsgimg);
	sgtb.setSggdsdtl_memo(req_memo);

	try {  
		sgtb.setSggdsdtl_mailflag(new Long(req_mailflag));
		sgtb.setSggdsdtl_cls(new Long(req_cls));
		sgtb.setSggdsdtl_maxnum(new Long(req_maxnum));
		sgtb.setSggdsdtl_sort(new Long(req_sort));
		sgtb.setSggdsdtl_xsnum(new Long(req_xsnum));
		sgtb.setSggdsdtl_realbuynum(new Long(req_realbuynum));
		sgtb.setSggdsdtl_vallnum(new Long(req_vallnum));
		sgtb.setSggdsdtl_vusrnum(new Long(req_vusrnum));
		sgtb.setSggdsdtl_mailsort(new Long(req_mailsort));
		sgtb.setSggdsdtl_limitgroup(new Long(req_limitgroup));
	} catch(NumberFormatException e){            
		e.printStackTrace();            
		out.print("{\"code\":0,message:\"添加更新失败，数据类型添写错误！\"}");  
		return;
	}
	if(!Tools.isNull(hsgimg)&&sgflag.equals("0")){
		     
				p.setGdsmst_img310(hsgimg);
				Tools.getManager(Product.class).update(p, true);
	}
	if(!Tools.isNull(id)){
		sgtb.setSggdsdtl_modiuser(admin_mng);
		sgtb.setSggdsdtl_modidate(new Date());
		if(Tools.getManager(SgGdsDtl.class).update(sgtb, true)){
			out.print("{\"code\":1,message:\"更新成功！\"}");
		    return;
		}else{
			out.print("{\"code\":0,message:\"更新失败，请稍后重试！\"}");
		    return;
		}
	}else{
		sgtb.setSggdsdtl_adduser(admin_mng);		
		Tools.getManager(SgGdsDtl.class).create(sgtb);
		out.print("{\"code\":1,message:\"添加成功！\"}");
	}

%>