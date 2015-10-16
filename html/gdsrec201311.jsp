<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:980px;  text-align:center;">
<div style="width:965px; overflow:hidden;  padding-bottom:18px; ">
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
				 theimgurl=product.getGdsmst_imgurl();
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
			   String brandname=product.getGdsmst_brandname();
			
	%>
	
<div style="  float:left;  width:231px;height:310px; /*FF*/ *height:310px;/*IE7*/ _height:310px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:10px; ">
			<div style="position:relative;left;width:200px;height:200px;">
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		<jsp:include   page= "/sales/showLayer.jsp"   />   	
		</a></div>
		<dd style="width:205px; text-align:left; padding-left:10px; float:left">
		<div style="height:42px;width:205px;">
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none' >
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),48)%></font></a>
		</div>
	 <span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike>会员价:￥<%=sprice%></strike></span>&nbsp;&nbsp;<br>
		<span style="font-family: '微软雅黑';font-size:30px;font-weight:bold;color:#ff0000;"><img src="http://images.d1.com.cn/zt2013/cj1311/1111price.png" /> <%=strmprice%></span><br>
	 <% 
		 if(!Tools.isNull(brandname)&&!brandname.equals("D1推荐"))
			 {brandname=brandname.trim();
		 String rackcode_temp = product.getGdsmst_rackcode();
		 if(rackcode_temp!=null&&rackcode_temp.length()>=3){
			 rackcode_temp = rackcode_temp.substring(0,3);
			 String url="/result.jsp?productsort="+rackcode_temp+"&productbrand="+java.net.URLEncoder.encode(brandname,"UTF-8")+"&bf=1";
			 ArrayList<Brand> blist=BrandHelper. getBrandInfo(rackcode_temp,product.getGdsmst_brand().trim());
			 if(blist!=null && blist.size()>0){
				 if(!Tools.isNull(blist.get(0).getBrand_url())){
					 url=blist.get(0).getBrand_url();
				 }
			 }
		
		%>
		<span><a href="<%=url %>" target=_blank>【 <%=brandname %>】品牌馆</a></span>
		<%
		 }
		 }else{ %>
		 <span style="color:#666666;">【 优尚自营】</span>
		 <%} %>
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