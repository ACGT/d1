<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
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
		<tr><td height="5px">&nbsp;</td></tr>
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
			  if(i%4==1){
				  
	%>
	<tr><td width="23">&nbsp;</td>
	<%} 
	%>
	<td style="background:url('http://images.d1.com.cn/zt2012/20120706xzj/xzj-1_25.jpg') no-repeat;" width="226" width="319" align="center">
	<table height="319">
	<tr><td height="15"></td></tr>
	<tr><td valign="top" height="200"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="200" height="200" />
		</a></td></tr>
		<tr><td width="210px" height="50px" align="center"  style="color:#333333;font-size:13px;"><%=Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()) %></td></tr>
		<tr><td align="center" valign="top"><b style="color:red;font-size:14px;">
		<%if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){ %>
		特价：￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %>&nbsp;</b>
		&nbsp;&nbsp;&nbsp;原价：<strike>￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice()) %></strike>
		<%}else{ %>
		会员价：￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice()) %></b>
		<%} %>
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