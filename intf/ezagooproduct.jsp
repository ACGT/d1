<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static List getAllProduct(){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
	clist.add(Restrictions.gt("gdsmst_memberprice",new Float(0)));
	//clist.add(Restrictions.eq("id", "03000227"));
	return ProductHelper.manager.getList(clist, null, 0, 300);
}
%><%   
StringBuffer str=new StringBuffer();
/*<?xml version="1.0" encoding=" UTF-8"?>
<products>
	<productid>产品唯一ID:123456</productid>
	<productid>产品唯一ID:234567</productid>
</products>
*/
str.append( "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
str.append("<products>");

ProductManager manager = (ProductManager)ProductHelper.manager;
List<Product> list = manager.getTotalProductList();
String ret="1";
if(list==null || list.size()==0){
	list=getAllProduct();
}
if(list!=null && list.size()>0){
	for(Product p:list){
		if(p.getGdsmst_memberprice().floatValue()>0){
	      str.append("<productid>");
	      str.append(p.getId());
	      str.append("</productid>");
		}
	}
}
str.append("</products>");
out.println(str.toString());
%>