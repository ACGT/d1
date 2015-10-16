<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="7878";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		
	
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	
	if(productlist!=null){
		int i=1;
		%>
		<table>
		
		<%for(Product product:productlist){
			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(pproductlist!=null && directory!=null){
				
			 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 if(!Tools.isNull(product.getGdsmst_img200250())){
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_img200250();
				 }else{
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
				 }
				 
			 }
			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
			 String t="";
				String x="";
				if(spgdsrcm_layertype.trim().length()!=0){ 
					t=spgdsrcm_layertype;
					x=pProduct.getSpgdsrcm_layertitle();
					//PromotionProductHelper.showLayer(spgdsrcm_layertype, promotionProduct.getSpgdsrcm_layertitle());
				}else{
					t=product.getGdsmst_layertype();
					x=product.getGdsmst_layertitle();
					//PromotionProductHelper.showLayer(product.getGdsmst_layertype(),product.getGdsmst_layertitle());
				}
			 request.setAttribute("t", t);
			   request.setAttribute("x", x);
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice/2);
			   String sprice=ProductGroupHelper.getRoundPrice(memberprice);
			   long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
   			 long currentTime = System.currentTimeMillis();
			  if(i%4==1){
				  
	%>
	<tr><td width="23">&nbsp;</td>
	<%} 
	%>
	<td width="226" height="311" align="center">
	<table height="311">
	<tr><td height="15"></td></tr>
	<tr><td valign="top" width="200"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="200" height="250" />
		</a></td></tr>
		<tr><td width="200px" height="60px" align="center"  style="background:#F5C364; color:#333333;font-size:13px;">
		<table width="100%" border="0">
		<tr>
		<td width="120"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,28)%></td>
		<td><b style="color:#5D4E37;font-size:18px;font-family: '微软雅黑';">￥</b>
		<span style="color:#5D4E37;font-size:30px;font-family: '微软雅黑';"><%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span>
		</td>
		</tr>
		</table>
		</td></tr>
		
	</table>
	
	</td>
	<%if(i%4!=0){
		%>
		<td width="10">&nbsp;</td>
		<%}if(i%4==0){ %>
		<td width="23">&nbsp;</td></tr><tr><td height="15">&nbsp;</td></tr>
		<%} %>

		<%
		i++;
			}
	}if((i-1)%4!=0){%>
	</tr><tr><td height="15">&nbsp;</td></tr>
	<%} %>
	</table>
		<%}
	}
}
}
%>