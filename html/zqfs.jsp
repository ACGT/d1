<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="";
String brandcode="";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("bcode")!=null){
	brandcode=request.getAttribute("bcode").toString();
}
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
if(list!=null && list.size()>0){
		int i=1;
		%>
		<table>
		<tr><td height="5px">&nbsp;</td></tr>
		<%for(PromotionProduct pProduct:list){
		Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
		if(!Tools.isNull(brandcode) && !brandcode.equals(product.getGdsmst_brand().trim())){
		 continue;
		}
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(directory!=null){
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
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
   			
   			 String pname=pProduct.getSpgdsrcm_gdsname().replace("<br>", "<br/>").replace("</br>", "<br/>");
   			int end=pname.indexOf("<br/>");
   			String gg="";
   			if(end>0){
   				gg=pname.substring(0,end);
   			}
			  if(i%4==1){
				  
	%>
	<tr><td width="20">&nbsp;</td>
	<%} 
	%>
	<td style="background:url('http://images.d1.com.cn/zt2012/20120910tjfw/fs_04.jpg') no-repeat;" width="220" width="299" align="center">
	<table height="299">
	<tr><td height="15"></td></tr>
	<tr><td valign="top" height="200"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="200" height="200" />
		</a></td></tr>
		<tr><td width="210px" height="32px" align="center"  style="color:#333333;font-size:14px;font-weight: bold;color:#2f2f2f;"><%=gg %></td></tr>
		<tr><td width="210px" height="18px" align="center"  style="color:#333333;font-size:12px;"><%=StringUtils.getCnSubstring(pname.substring(end+"<br/>".length()),0,26)%>
		<tr><td align="center" valign="top"><b style="color:#c10000;font-size:20px; font-family: '微软雅黑';">
		<%if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){ %>
		￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %>&nbsp;</b>
		&nbsp;&nbsp;&nbsp;<strike>￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></strike>
		<%}else{ %>
		￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b>
		<%} %>
		&nbsp;&nbsp;&nbsp;<a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/zt2012/20120910tjfw/hzp_07.jpg" border="0"/></a>
		</td></tr>
	</table>
	
	</td>
	<%if(i%4!=0){
		%>
		<td width="20">&nbsp;</td>
		<%}if(i%4==0){ %>
		<td width="20">&nbsp;</td></tr><tr><td height="15">&nbsp;</td></tr>
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
%>