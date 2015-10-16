<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<table width="750" border="0" cellspacing="0" cellpadding="0" align="center">

<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
if(request.getAttribute("num")!=null){
	len=Integer.parseInt((request.getAttribute("num")).toString().trim());
}
String subad=request.getAttribute("subad").toString();
String subadurl="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=";
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,len);
ArrayList gdsidlist=new ArrayList();
if(list!=null && list.size()>0){
	
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
	int i=0;
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	int l=0;
	if(productlist!=null){
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
				 if(product.getGdsmst_rackcode().startsWith("014")){
				 theimgurl=product.getGdsmst_imgurl();
				 }else{
					 theimgurl=product.getGdsmst_img200250();
				 }
			 }
			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
				 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
					}else{
						theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
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
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			   String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   String brandname=product.getGdsmst_brandname();
			    if (i==0 || i%3==0 ){ %>
			    <tr><td colspan="3" height="10"></td></tr>
			     <tr><td style="padding-left:10px;">
			     <%} else{%>
    <td>
    <%} %>
			   <table width="230" height="320" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td height="200" colspan="3" align="center">
    <a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%><%=subadurl %>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a>
    </td>
  </tr>
  <tr>
    <td height="48" colspan="3">
 <a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%><%=subadurl %>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
 <font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(imgalt,48)%></font></a>
</td>
  </tr>
  <tr>
    <td width="57"><a href="<%=subadurl %>http://www.d1.com.cn/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/1203/nztj.jpg" border="0"></a></td>
    <td width="70"><span style="font-family: '微软雅黑';font-size:36px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span></td>
    <td width="103">
<%if(product.getGdsmst_discountenddate()==null||Tools.dateValue(fmt.parse("2999-01-01"))==Tools.dateValue(product.getGdsmst_discountenddate())) {%>
		
		 市场价:￥<span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=saleprice%></strike></span><br>
		
		<%}else{ %>
		 会员价:￥<span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=sprice%></strike></span><br>
		<%} %>
</td>
  </tr>
</table>
		</td>
		<%
		i++;
		if(i==productlist.size() && i<3){
			 for(int m=1;m<=3-i;m++){
				out.print("<td>&nbsp;</td>");
				 
			 }
		}
		if(i%3==0){
			out.print("</tr>");	 
		}
		
			}
	}
}
	}
}
}
%>
</table>