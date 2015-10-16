<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
public static ArrayList<ShopBrand> getBrandByShop(String shopCode){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("shopbrand_shopcode", shopCode));	
	List<BaseEntity> list = Tools.getManager(ShopBrand.class).getList(clist, null, 0, 1000);
	if(list==null||list.size()==0)return null;
	
	ArrayList<ShopBrand> resList = new ArrayList<ShopBrand>();
	for(BaseEntity brand:list){
		resList.add((ShopBrand)brand);
	}
	return resList;
}
public static ArrayList<Brand> getBrandByRackCode(String rackcode){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.like("brand_rackcode", rackcode+"%"));	
	List<BaseEntity> list = Tools.getManager(Brand.class).getList(clist, null, 0, 1000);
	if(list==null||list.size()==0)return null;
	
	ArrayList<Brand> resList = new ArrayList<Brand>();
	for(BaseEntity brand:list){
		resList.add((Brand)brand);
	}
	return resList;
}
%>
<option value='' selected>无品牌</option>
<%
    String rackcode=request.getParameter("code");
    if(!rackcode.equals("")){
	    String shopCode=session.getAttribute("shopcodelog").toString().trim();
	    if(!shopCode.equals("00000000"))
	    {
		    ArrayList<ShopBrand> blist=new ArrayList<ShopBrand>();
		    blist=getBrandByShop(shopCode);
		    if(blist!=null&&blist.size()>0)
		    {
		    	for(ShopBrand b:blist)
		    	{
		    		if(b!=null)
		    		{%>
		    			<option value='<%= b.getShopbrand_brand() %>'><%= b.getShopbrand_brandname() %></option>
		    		<%}
		    	}
		    }
	    }
	    else
	    {
	        ArrayList<Brand> blist=new ArrayList<Brand>();
	        blist=getBrandByRackCode(rackcode.length()>=6?rackcode.substring(0,6):rackcode);
	        if(blist!=null&&blist.size()>0)
		    {
		    	for(Brand b:blist)
		    	{
		    		if(b!=null)
		    		{%>
		    			<option value='<%= b.getBrand_code() %>'><%= b.getBrand_name() %></option>
		    		<%}
		    	}
		    }
	    }
	    
    }
%>