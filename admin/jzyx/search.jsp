<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%!
static ArrayList<Product> getProduct(Date s,Date e,String brand,String gdsser){ 
	ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			if(!Tools.isNull(brand)){
				clist.add(Restrictions.eq("gdsmst_brand", brand));
			}
			if(s!=null){
				clist.add(Restrictions.ge("gdsmst_autoupdatedate", s));
			}
			if(e!=null){
				clist.add(Restrictions.le("gdsmst_autoupdatedate", e));
			}
			if(!Tools.isNull(gdsser)){
				clist.add(Restrictions.eq("gdsmst_gdscoll", gdsser));
			}
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.desc("gdsmst_autoupdatedate"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 100);
			
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}	
	return list;
}
%> 
<%
String start=request.getParameter("txtStart");
String end=request.getParameter("txtEnd");
String brand=request.getParameter("sbrand");
String gdsser=request.getParameter("sgdsser");
if(!Tools.isNull(start)){
	start=start+" 00:00:00";
}
if(!Tools.isNull(end)){
	end=end+" 23:59:59";
}
SimpleDateFormat format=	new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date s=null;
Date e=null;
if(!Tools.isNull(start)){
	s=format.parse(start);
}
if(!Tools.isNull(end)){
	e=format.parse(end);
}
ArrayList<Product> list= getProduct( s, e, brand, gdsser);
if(list!=null && list.size()>0){
	
}
%>
