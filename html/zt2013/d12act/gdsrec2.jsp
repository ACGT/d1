<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div class="id3" style="width:980px;  text-align:center;">
<div style="width:980px; overflow:hidden;  padding-bottom:18px; font-size:12px;">
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
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
			 		
			 if(product.getGdsmst_rackcode().startsWith("014")){
				 theimgurl=product.getGdsmst_imgurl();
				 }else{
					 theimgurl=product.getGdsmst_img200250();
				 }
			
			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
					}else{
						theimgurl = "http://images.d1.com.cn"+theimgurl;
					}

			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			   String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   String brandname=product.getGdsmst_brandname();
			   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);

			 %>
<%if (product.getGdsmst_rackcode().startsWith("014")){ %>
<div style="  float:left;  width:231px;height:290px; /*FF*/ *height:290px;/*IE7*/ _height:290px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px;border: 1px solid #999999; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
<%}else{ %>
				<div style="  float:left;  width:231px;height:340px; /*FF*/ *height:340px;/*IE7*/ _height:340px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px;border: 1px solid #999999; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >

			<%} %>
 
<dl style="text-align:left;padding:0px;margin:0px">
<dt style="width:205px; text-align:center;text-align:left;padding:0px 0px 0px 10px;margin:0px ">
<%if (product.getGdsmst_rackcode().startsWith("014")){ %>
			<div style="position:relative;left;width:200px;height:200px;">
			<%}else{ %>
				<div style="position:relative;left;width:200px;height:250px;">
			<%} %>
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a></div>
		<dd style="width:230px; text-align:left; padding:0px;margin:0px; float:left">
	<table width="230" height="85" border="0" cellpadding="0" cellspacing="0" style="background-color:#D3000B">
  <tr>
    <td height="44" colspan="3">
    		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
    <span  class="d12title" style="font-size:14px"><%=Tools.substring(imgalt,48)%></span></a></td>
  </tr>
  <tr>
    <td width="73" height="36" rowspan="2" class="d12price"><span style="font-size:18px;line-height:26px;">￥</span><%=strmprice%></td>
    <td width="53" valign="top" class="d12zk"  ><%=dl%>折</td>
    <td width="109" rowspan="2">		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
    <img src="http://images.d1.com.cn/zt2013/1209/d12act002.png" width="84" height="30" border="0" /></a></td>
  </tr>
  <tr>
    <td><s>￥<%=saleprice%></s></td>
  </tr>
</table>

</dd>
</dl>
</div>
		<%
		l++;
			}
	}
}
	}
}
}
%>
</div>
</div>