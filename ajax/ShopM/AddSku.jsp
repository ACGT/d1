<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%
	String gdsid=request.getParameter("gdsid");
    String hstrgdsid=request.getParameter("hstrgdsid");
	String sku1=request.getParameter("sku1");
	
	if(sku1.length()>25){
		out.print("{\"success\":false,\"message\":\"录入sku失败，SKU太长请不要超过25个汉字\"}");
	}else{
	String stock="";
	if(request.getParameter("stock")!=null){
		stock=request.getParameter("stock");
	}
	String vstock="";
	if(request.getParameter("vstock")!=null)
	{		
		vstock=request.getParameter("vstock");
	}
	String flag=request.getParameter("flag");
	
	if(stock.equals("")){stock="0";}
	if(vstock.equals("")){vstock="0";}
	String[] arrgdslist=null;
	if(hstrgdsid!=null&&hstrgdsid.length()>0){
		
	 if(hstrgdsid.indexOf(",")>=0){
		 arrgdslist=hstrgdsid.split(",");
	 }
	 if(hstrgdsid.indexOf("，")>=0){
		 arrgdslist=hstrgdsid.split("，");
	 }
	}
	 if(arrgdslist!=null&&arrgdslist.length>=2){
		 String skuone="";
		 for(int i=0;i<arrgdslist.length;i++){
	Sku sku=new Sku();
	sku.setSkumst_createdate(new Date());
    sku.setSkumst_gdsid(arrgdslist[i]);
    sku.setSkumst_sku1(sku1);
    sku.setSkumst_stock(new Long(stock));
	sku.setSkumst_vstock(new Long(stock));
	sku.setSkumst_validflag(new Long(flag));
	sku.setSkumst_sku2("");
    sku=(Sku)Tools.getManager(Sku.class).create(sku);
    if(i==0){
    	skuone=sku.getId();
    }
    
	  }
		 if(!Tools.isNull(skuone))
		    {
		    	out.print("{\"success\":true,\"message\":\"录入sku成功！\"}");
		    }
		    else
		    {
		    	out.print("{\"success\":false,\"message\":\"录入sku失败，请联系客服！\"}");
		    }
	 }else{
		 Sku sku=new Sku();
			sku.setSkumst_createdate(new Date());
		    sku.setSkumst_gdsid(gdsid);
		    sku.setSkumst_sku1(sku1);
		    sku.setSkumst_stock(new Long(stock));
			sku.setSkumst_vstock(new Long(stock));
			sku.setSkumst_validflag(new Long(flag));
			sku.setSkumst_sku2("");
		    sku=(Sku)Tools.getManager(Sku.class).create(sku);
		    if(!Tools.isNull(sku.getId()))
		    {
		    	out.print("{\"success\":true,\"message\":\"录入sku成功！\"}");
		    }
		    else
		    {
		    	out.print("{\"success\":false,\"message\":\"录入sku失败，请联系客服！\"}");
		    }
	 }
	}
	
	
%>