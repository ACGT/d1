<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%!
static HWeightManDtl getHeightDtl(String id){
	HWeightManDtl m=(HWeightManDtl)	Tools.getManager(HWeightManDtl.class).get(id);
	return m;
}
static ArrayList<HWeightManDtl> getAllHeightDtl(String gdsid){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("wheightman_gdsid", gdsid));
	}

	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, null, 0, 12);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
%>
<%
String tomanid=request.getParameter("tomanid");
if(Tools.isNull(tomanid)){
	out.print("您要复制到哪个模板");
	return;
}
	ArrayList<HWeightManDtl> list= getAllHeightDtl(tomanid);
	if(list!=null && list.size()>0){
		out.print("-1");
		 return;
	}	
out.print("1");
return;
%>