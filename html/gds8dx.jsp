<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>

<%
String code="0";
if(request.getAttribute("reccode")!=null ){
code=(String)request.getAttribute("reccode");
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString());
}
String dxcode="";
if(request.getAttribute("dxcode")!=null){
	dxcode=(String)request.getAttribute("dxcode");
}
ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,100);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		
	int i=1;
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	int l=0;
	if(productlist!=null){
		%>
		<table >
		<tr><td height="5px">&nbsp;</td></tr>
		<%
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
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
			   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
				 String fl=ProductGroupHelper.getRoundPrice((float)dl);
				 boolean booldx=false;
				 float dxprice=0;
				 if(!Tools.isNull(dxcode)){
				  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxcode));
				  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
				  if(rcmdusr!=null 
				    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
				    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
				    	){
				    	booldx=true;
				    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(product.getId(), dxcode);
				    	if(rcmdgds!=null)dxprice=rcmdgds.getRcmdgds_memberprice();
	                    }
				 }
	
	 if(i%3==1){
				  
	%>
	<tr><td width="17">&nbsp;</td>
	<%} 
	%>
	<td style="background:url('http://images.d1.com.cn/zt2012/20120928sytl/sybj_05-1.jpg') no-repeat;" width="302" height="385" align="center">
	<table height="385">
	<tr><td valign="top" height="302">
	<div style="position:relative;left;width:302px;height:302px;">
	<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="302" height="302" />
		</a>
		<span style="position:absolute; width:51px; height:83px; dislay:block; background:url('http://images.d1.com.cn/images2013/act/tl5.png'); left:4px; top:10px; z-index:5000;"></span>
		</div>
		</td></tr>
		
		<tr><td width="300px" height="26px" align="center"  valign="bottom" style="color:#ccc;font-size:14px;font-weight:bold;"><%=StringUtils.getCnSubstring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),0,36) %></td></tr>
		<tr><td align="center" valign="top" style="color:#ccc;">
		<table width="302">
		<%
		 if(booldx && dxprice>0){
			 %> 
		<tr><td width="80" align="center" valign="middle"><span style="font-size:12px;"><strike>会员价:￥<%=strmprice%></strike></span></td>
		<td><span style="font-size:24px;font-weight:bold;color:white;font-family:'微软雅黑';color:#ED7E2C">独享价:￥<%=ProductGroupHelper.getRoundPrice(dxprice)%></span></td>
		<%}else{ %>
		<tr><td width="80" align="center" valign="middle"><span style="font-size:12px;">市场价:￥<%=sprice%></span></td>
		<td><span style="font-size:24px;font-weight:bold;color:white;font-family:'微软雅黑';color:#ED7E2C">会员价:￥<%=strmprice%></span></td>
		<%} %>
		<td width="60">
		<%
		if(Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0){
			%>
			<img alt="" src="http://images.d1.com.cn/zt2012/20120928sytl/sx.png"/>
		<%}else{
			%>
			<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
			<img alt="" src="http://images.d1.com.cn/zt2012/20120928sytl/q.png"/>
			</a>
			<%}
		%>
		</td>
		</tr>
		</table>
		</td></tr>
	</table>
	
	</td>
	<%if(i%3!=0){
		%>
		<td width="20">&nbsp;</td>
		<%}if(i%3==0){ %>
		<td width="17">&nbsp;</td></tr><tr><td height="15">&nbsp;</td></tr>
		<%} %>

		<%
		i++;
			}
	}if((i-1)%3!=0){%>
	</tr><tr><td height="15">&nbsp;</td></tr>
	<%} %>
	</table>
		<%
}}}}
%>