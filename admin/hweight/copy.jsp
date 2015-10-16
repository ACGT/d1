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
String fromid=request.getParameter("fromid");
String tomanid=request.getParameter("tomanid");
//fromid="03000244";
//tomanid="03000324";
if(Tools.isNull(fromid)){
	out.print("请选择您要复制的商品");
	return;
}if(Tools.isNull(tomanid)){
	out.print("您要复制到哪个商品");
	return;
}

	ArrayList<HWeightManDtl> list=getAllHeightDtl(fromid);
	if(list==null || list.size()==0){
		out.print("请选择您要复制的商品");
		return;
	}
	ArrayList<HWeightManDtl> list2=getAllHeightDtl(tomanid);
	if(list2!=null && list2.size()>0){
		for(HWeightManDtl d:list2){
			Tools.getManager(HWeightManDtl.class).delete(d);
		}
	}
	int i=0;
	for(HWeightManDtl d:list){
		HWeightManDtl mdtl=new HWeightManDtl();
		 mdtl.setWheightman_dtlcreatedate(new Date());
		 mdtl.setWheightman_gdsid(tomanid);
		 mdtl.setWheightman_dtlsize1(d.getWheightman_dtlsize1());
			mdtl.setWheightman_dtlsize2(d.getWheightman_dtlsize2());
			mdtl.setWheightman_dtlsize3(d.getWheightman_dtlsize3());
			mdtl.setWheightman_dtlsize4(d.getWheightman_dtlsize4());
			mdtl.setWheightman_dtlsize5(d.getWheightman_dtlsize5());
			mdtl.setWheightman_dtlsize6(d.getWheightman_dtlsize6());
			//mdtl.setWheightman_dtlsize7(d.getWheightman_dtlsize7());
			//mdtl.setWheightman_dtlsize8(d.getWheightman_dtlsize8());
			mdtl.setWheightman_dtlweight(d.getWheightman_dtlweight());
			mdtl=(HWeightManDtl)Tools.getManager(HWeightManDtl.class).create(mdtl);
			if(mdtl!=null && !Tools.isNull(mdtl.getId())){
				i++;
			}
	}
	if(i==list.size()){
		 out.print("1");
		   return;
		}else{
			 out.print("-1");
			 return;
		}	



%>