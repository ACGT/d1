<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%><%
	//每3小时执行一次...
	String ip = request.getRemoteHost();
	if(ip.equals("localhost")||ip.equals("127.0.0.1")){
		System.out.println("优化搜索文件....start");
		SearchManager.getInstance().optimize();//优化搜索文件
		System.out.println("优化搜索文件....end");
		
		//System.out.println("重新加载销量....start");
		//Tools.getManager(ProductSaleCount.class).loadAllData();
		//ProductManager pm = (ProductManager)Tools.getManager(Product.class);
		//pm.loadProductSales();//重新载入销量
		//System.out.println("重新加载销量....end");
		//System.out.println("重新加载销量排行....start");
		//Tools.getManager(RackcodeTop.class).loadAllData();

		System.out.println("重新加载销量排行....end");
		System.out.println("重新加载组商品....start");
		Tools.getManager(GoodsGroup.class).loadAllData();
		Tools.getManager(GoodsGroupDetail.class).loadAllData();
		System.out.println("重新加载组商品....end");
		
	}
%>