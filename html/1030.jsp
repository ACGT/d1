<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%//tese
String code="8105";
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
		
	
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,12);
	
	if(productlist!=null){
		int i=1;
		%>
		<table >
		<tr><td height="5px">&nbsp;</td></tr>
		<%for(Product product:productlist){
			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			if(pproductlist!=null && directory!=null){
				
			 PromotionProduct pProduct=pproductlist.get(0);
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			if(!Tools.isNull(pProduct.getSpgdsrcm_otherimg())){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			}else{
				 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
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
	<tr><td width="20">&nbsp;</td>
	<%} 
	%>
	<td  width="220"  align="center">
	<table height="296">
	
	<tr><td valign="top" height="220" bgcolor="#fff"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="220" height="220" />
		</a></td></tr>
		<tr><td width="220px" height="30px" align="center" bgcolor="#ffae00" style="color:#FFFAD2;font-size:13px;"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,32) %></td></tr>
		<tr><td align="center" valign="top"  bgcolor="#ffae00" height="46px">
		<span style="color:#FFFAD2; font-size:13px;">原价:￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></span>&nbsp;&nbsp;
		<b style="color:#fff;font-size:26px;">
		
		特价:￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %>&nbsp;</b>
		
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
}
}
%>