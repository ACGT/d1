<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<table id="__01" width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td   style="background:url(http://images.d1.com.cn/zt2012/20120726tldz/tldz_13.jpg);" height="20px"></td>	</tr>
	<tr>
		<td style="background:url(http://images.d1.com.cn/zt2012/20120726tldz/tldz_13.jpg);" valign="top">

<%
String code="7916";
String subad="";
if(request.getAttribute("code")!=null && request.getAttribute("subad")!=null){
	code=request.getAttribute("code").toString();
	subad=request.getAttribute("subad").toString();

ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		
	
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	if(productlist!=null){
		%>
		 <table width="700"  border="0" cellpadding="0" cellspacing="0">
		<% int i=0;
		StringBuilder sb = new StringBuilder();
		for(Product product:productlist){
			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(pproductlist!=null && directory!=null){
				
			 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
			 }
			String url="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url"+"http://www.d1.com.cn/product/"+product.getId();
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String sprice=ProductGroupHelper.getRoundPrice(memberprice);
				 String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
	
	if (i==0 || (float)i/3==(int)i/3){%>
				<tr>
				<td width="25">&nbsp;</td>
				<%} %>
				<td width="200"  valign="top" >
				
				<table width="200"   border="0" cellpadding="0" cellspacing="0">
				<tr>
				<td valign="top">
				<div class="lf" >
				<p style="z-index:999;">
				<a href="<%=url%>" target="_blank"><img src="<%= theimgurl%>" border="0" width="200" height="200" /> </a>
				</p>
				<p class="retime" > <a href="<%=url %>" target="_blank" style="font-size:12px; color:#fff; "><%=StringUtils.getCnSubstring(pProduct.getSpgdsrcm_gdsname(),0,60)%></a> </p>
				</div>
				<div style="overflow:hidden; +margin-top:-10px;_margin-top:-18px;*margin-top:-18px;background: url('http://images.d1.com.cn/zt2012/20120718qchd/bg.jpg');width:200px; height:45px;">
				<table width="200"  border="0" cellpadding="0" cellspacing="0">
				 <tr>
    <td rowspan="2" width="8">&nbsp;</td>
    <td height="20" align="left"><span style="color:#969696;font-size:14px;font-family: '微软雅黑'; ">原价￥<%=oldmprice %></span></td>
    <td rowspan="2" align="center"><a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/zt2012/20120718qchd/yjbuy.png" border="0" /></a></td>
  </tr>
  <tr>
    <td align="left"><span style="color:#AB1A1C;font-size:14px;font-family: '微软雅黑'; ">活动价￥</span><span style="color:#B0130B;font-size:20px;font-weight:bold;"><%=sprice %></span></td>
  </tr>
 
				</table>
				</div>
				</td>
				
				</tr>
				
				</table>
				</td>
			<% 
				
				i++;
	          if (i%3==0){%>
	        	 <td width="25">&nbsp;</td>
				<% }else{%>
					<td width="25">&nbsp;</td>
				<%}
	          if (i%3==0){ %>
				</tr>
				<tr><td colspan="4"  style="background:url(http://images.d1.com.cn/zt2012/20120726tldz/tldz_11.jpg);" height="10px"></td>
				</tr>
				<%}

	}
}%>
</table>
<%
	}
}
}
}
%>

	</td>
	  </tr>
<tr><td   style="background:url(http://images.d1.com.cn/zt2012/20120726tldz/tldz_11.jpg);" height="15px"></td>	</tr>
</table>

