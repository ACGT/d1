<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="7878";
String subad="";
if(request.getAttribute("code")!=null && request.getAttribute("subad")!=null){
code=request.getAttribute("code").toString();
subad=request.getAttribute("subad").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,12);

if(list!=null && list.size()>0){

		int i=1;
		%>
		<table width="700">
		
		<%for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 if(!Tools.isNull(product.getGdsmst_fzimg())){
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_fzimg();
				}else{
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_img200250();
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
	<tr>
	<%} 
	%>
	<td width="160px" height="251" align="left">
	<table height="251" width="160px">
	<tr><td height="15"></td></tr>
	<tr><td valign="top" width="160px">
	<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<img src="<%=theimgurl%>" border=0 width="160" height="200" />
		</a></td></tr>
		<tr><td width="160px" height="50px" align="center"  style="background:#F5C364; color:#333333;font-size:13px;">
		<table width="100%" border="0">
		<tr>
		<td width="80" style="font-size:12px;"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,24)%></td>
		<td><b style="color:#5D4E37;font-size:16px;font-family: '微软雅黑';">￥</b>
		<span style="color:#5D4E37;font-size:24px;font-family: '微软雅黑';"><%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></span>
		</td>
		</tr>
		</table>
		</td></tr>
		
	</table>
	
	</td>
	<%if(i%4!=0){
		%>
		
		<%}if(i%4==0){ %>
		</tr>
		<%} %>

		<%
		i++;
			}
	if((i-1)%4!=0){%>
	</tr><tr><td height="15">&nbsp;</td></tr>
	<%} %>
	</table>
		<%
}
}
%>