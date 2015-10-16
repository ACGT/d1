<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%!
ArrayList<Sku> getSkuListViaProductId(String productId){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));
	List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 10);
	
	ArrayList<Sku> rlist = new ArrayList<Sku>();
	if(list!=null&&list.size()>0){
		for(BaseEntity sku:list){
			rlist.add((Sku)sku);
		}
	}
	return rlist ;
}
//根据商品编号获得身高体重信息
static ArrayList<HWeightManDtl> getHeightDtl(String gdsid,String weight){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("wheightman_gdsid", gdsid));
	}
	if(!Tools.isNull(weight)){
		clist.add(Restrictions.eq("wheightman_dtlweight", new Long(weight)));
	}
	
	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, null, 0, 12);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
boolean adddtl(String str,String weight,String gdsid,int len){
	String [] strlist=str.split("\\|");
	//System.out.println(strlist.length);
	if(strlist.length==len){
		 HWeightManDtl mdtl=new HWeightManDtl();
		 mdtl.setWheightman_dtlweight(new Long(weight));
			 mdtl.setWheightman_dtlcreatedate(new Date());
			 mdtl.setWheightman_gdsid(gdsid);
			 mdtl.setWheightman_dtlsize1(strlist[0].equals("1")? "" :strlist[0]);
			 mdtl.setWheightman_dtlsize2(strlist[1].equals("1")? "" :strlist[1]);
			 mdtl.setWheightman_dtlsize3(strlist[2].equals("1")? "" :strlist[2]);
			 mdtl.setWheightman_dtlsize4(strlist[3].equals("1")? "" :strlist[3]);
			 mdtl.setWheightman_dtlsize5(strlist[4].equals("1")? "" :strlist[4]);
			 if(len==6){
				 mdtl.setWheightman_dtlsize6(strlist[5].equals("1")? "" :strlist[5]); 
			 }
			 
			 mdtl=(HWeightManDtl)Tools.getManager(HWeightManDtl.class).create(mdtl);
				if(mdtl!=null && !Tools.isNull(mdtl.getId())){
					return true;
				}
		}
	
	return false;
}
boolean updatedtl(String str,String weight,String gdsid,String rackcode){
	String [] strlist=str.split("\\|");
	ArrayList<HWeightManDtl> list= getHeightDtl( gdsid,weight);
	if((strlist.length==5 || strlist.length==6) && list!=null && list.size()>0){
		HWeightManDtl mdtl=list.get(0);
		if(rackcode.startsWith("030")){
		if(!Tools.isNull(strlist[0]) && !"1".equals(strlist[0])) mdtl.setWheightman_dtlsize2(strlist[0]);
		if(!Tools.isNull(strlist[1])&& !"1".equals(strlist[1])) mdtl.setWheightman_dtlsize3(strlist[1]);
		if(!Tools.isNull(strlist[2])&& !"1".equals(strlist[2])) mdtl.setWheightman_dtlsize4(strlist[2]);
		if(!Tools.isNull(strlist[3])&& !"1".equals(strlist[3])) mdtl.setWheightman_dtlsize5(strlist[3]);
		if(!Tools.isNull(strlist[4])&& !"1".equals(strlist[4])) mdtl.setWheightman_dtlsize6(strlist[4]);
		if(strlist.length==6){
			if(!Tools.isNull(strlist[5])&& !"1".equals(strlist[5])) mdtl.setWheightman_dtlsize7(strlist[5]);
		}
		}else{
			if(!Tools.isNull(strlist[0]) && !"1".equals(strlist[0])) mdtl.setWheightman_dtlsize1(strlist[0]);
			if(!Tools.isNull(strlist[1])&& !"1".equals(strlist[1])) mdtl.setWheightman_dtlsize2(strlist[1]);
			if(!Tools.isNull(strlist[2])&& !"1".equals(strlist[2])) mdtl.setWheightman_dtlsize3(strlist[2]);
			if(!Tools.isNull(strlist[3])&& !"1".equals(strlist[3])) mdtl.setWheightman_dtlsize4(strlist[3]);
			if(!Tools.isNull(strlist[4])&& !"1".equals(strlist[4])) mdtl.setWheightman_dtlsize5(strlist[4]);
			if(strlist.length==6){
				if(!Tools.isNull(strlist[5])&& !"1".equals(strlist[5])) mdtl.setWheightman_dtlsize6(strlist[5]);
			}
		}
	
		
		return Tools.getManager(HWeightManDtl.class).update(mdtl, true);
		
	}
	return false;
}
%>
<%
String gdsid=request.getParameter("gdsid");
String sid=request.getParameter("sid");
String sku=request.getParameter("sku");
String str1=request.getParameter("str1");
String str2=request.getParameter("str2");
String str3=request.getParameter("str3");
String str4=request.getParameter("str4");
String str5=request.getParameter("str5");
String str6=request.getParameter("str6");
String str7=request.getParameter("str7");
String str8=request.getParameter("str8");
String str9=request.getParameter("str9");
String str10=request.getParameter("str10");

Product p=ProductHelper.getById(gdsid);
if(p!=null){
	////ArrayList<Sku> skulist=getSkuListViaProductId(gdsid);
	//boolean hassku=false;
	//if(skulist!=null && skulist.size()>0){
	//	for(Sku sku1:skulist){
			
	//	}
	//}
	String rackcode=p.getGdsmst_rackcode();
	if(!Tools.isNull(sid)){
		String [] strlist=sid.split("\\_");	
		if(strlist.length==2){
			String weight=strlist[0];
			String height=strlist[1];
			ArrayList<HWeightManDtl> list= getHeightDtl( gdsid,weight);
			HWeightManDtl mdtl=list.get(0);
			//gjlhw:030004002---高：50---sku:XS
			//gjlhw:50_165---分类：030004002---高：50---sku:S
			//gjlhw:50_165---分类：030004002---重：50----高165---sku:M
			if(rackcode.startsWith("030")){
				if("160".equals(height)){ mdtl.setWheightman_dtlsize1(sku);}
				else if("165".equals(height)){ mdtl.setWheightman_dtlsize2(sku);}
				else if("170".equals(height)){ mdtl.setWheightman_dtlsize3(sku);}
				else if("175".equals(height)){ mdtl.setWheightman_dtlsize4(sku);}
				else if("180".equals(height)){ mdtl.setWheightman_dtlsize5(sku);}
				else if("185".equals(height)){ mdtl.setWheightman_dtlsize6(sku);}
				Tools.getManager(HWeightManDtl.class).update(mdtl, true);
				out.print("1");
				return;
			}else if(rackcode.startsWith("020")){
				if("150".equals(height)){ mdtl.setWheightman_dtlsize1(sku);}
				else if("155".equals(height)){ mdtl.setWheightman_dtlsize2(sku);}
				else if("160".equals(height)){ mdtl.setWheightman_dtlsize3(sku);}
				else if("165".equals(height)){ mdtl.setWheightman_dtlsize4(sku);}
				else if("170".equals(height)){ mdtl.setWheightman_dtlsize5(sku);}
				else if("175".equals(height)){ mdtl.setWheightman_dtlsize6(sku);}
				Tools.getManager(HWeightManDtl.class).update(mdtl, true);
				out.print("1");
				return;
			}else{
				out.print("该商品不属于服装");
				return;
			}

			
		}
	}else{
		
		ArrayList<HWeightManDtl> list= getHeightDtl( gdsid,"");
		
		if(rackcode.startsWith("020")){
			if(list ==null || list.size()==0){//第一次添加
				//adddtl( str1,"35", gdsid);
				adddtl( str1,"40", gdsid,6);
				adddtl( str2,"45", gdsid,6);
				adddtl( str3,"50", gdsid,6);
				adddtl( str4,"55", gdsid,6);
				adddtl( str5,"60", gdsid,6);
				adddtl( str6,"65", gdsid,6);
				adddtl( str7,"70", gdsid,6);
				out.print("1");
			}else{
				//updatedtl( str1,"35", gdsid);
				updatedtl( str1,"40", gdsid,rackcode);
				updatedtl( str2,"45", gdsid,rackcode);
				updatedtl( str3,"50", gdsid,rackcode);
				updatedtl( str4,"55", gdsid,rackcode);
				updatedtl( str5,"60", gdsid,rackcode);
				updatedtl( str6,"65", gdsid,rackcode);
				updatedtl( str7,"70", gdsid,rackcode);
				//System.out.println("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
				out.print("1");
			}
		}else if(rackcode.startsWith("030")){
			if(list ==null || list.size()==0){//第一次添加
				adddtl( str1,"45", gdsid,5);
				adddtl( str2,"50", gdsid,5);
				adddtl( str3,"55", gdsid,5);
				adddtl( str4,"60", gdsid,5);
				adddtl( str5,"65", gdsid,5);
				adddtl( str6,"70", gdsid,5);
				adddtl( str7,"75", gdsid,5);
				adddtl( str8,"80", gdsid,5);
				adddtl( str9,"85", gdsid,5);
				adddtl( str10,"90", gdsid,5);
				out.print("1");
			}else{
				//updatedtl( str1,"40", gdsid);
				updatedtl( str1,"45", gdsid,rackcode);
				updatedtl( str2,"50", gdsid,rackcode);
				updatedtl( str3,"55", gdsid,rackcode);
				updatedtl( str4,"60", gdsid,rackcode);
				updatedtl( str5,"65", gdsid,rackcode);
				updatedtl( str6,"70", gdsid,rackcode);
				updatedtl( str7,"75", gdsid,rackcode);
				updatedtl( str8,"80", gdsid,rackcode);
				updatedtl( str9,"85", gdsid,rackcode);
				updatedtl( str10,"90", gdsid,rackcode);
				out.print("1");
			}
		}else{
			out.print("该商品不属于服装");
			return;
		}
	}

}else{
	out.print("商品不存在！");
	return;
}
%>