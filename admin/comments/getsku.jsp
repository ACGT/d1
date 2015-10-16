<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%@include file="/admin/chkrgt.jsp"%><%!
public static ArrayList<Sku> getSkuListViaProductId(String productId){
		
		if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("skumst_gdsid", productId));
		
		List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
		
		ArrayList<Sku> rlist = new ArrayList<Sku>();
		if(list!=null&&list.size()>0){
			for(BaseEntity sku:list){
				rlist.add((Sku)sku);
			}
		}
		return rlist ;
	}%>
<%
 String gdsid=request.getParameter("gdsid");
StringBuilder sb = new StringBuilder();
if(!Tools.isNull(gdsid)){
	if(gdsid.trim().length()==8){
		Product p=ProductHelper.getById(gdsid);
		if(p!=null && !Tools.isNull(p.getGdsmst_skuname1())){
			
			if(p.getGdsmst_rackcode().startsWith("020")||p.getGdsmst_rackcode().startsWith("030")){
				ArrayList<Sku> list=getSkuListViaProductId(gdsid);
				if(list!=null){
					
					for(Sku sku:list){
						sb.append(sku.getSkumst_sku1()).append("|").append(sku.getSkumst_sku1()).append(",");
					}
					int length = sb.length();
					if(length>0){
						sb.delete(length-1,length);
					}
					out.print(sb.toString());
				}
			}
		}
	}
 }
if(sb.toString().trim().length()==0){
	out.print("-1");
}
%>