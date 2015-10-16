<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<ul>
<%
String code="";
int num=4;
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,num);
ArrayList gdsidlist=new ArrayList();
if(list!=null){
	for(PromotionProduct pProduct:list){
		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
	}
	if(gdsidlist!=null && gdsidlist.size()>0){
		
		ArrayList<Product> productlist=ProductHelper.getProductInfoById(gdsidlist);
		if(productlist!=null){
			int i=0;
			for(Product product:productlist){
				ArrayList<PromotionProduct> promotionlist=PromotionProductHelper. getPProductByCodeGdsid(code,product.getId());
			    if(promotionlist!=null){
			    	PromotionProduct promotionproduct=promotionlist.get(0);
			    	float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			
			    	if(promotionproduct.getSpgdsrcm_otherlink().trim().length()>0){
			    	%>	
			    	 <a href="<%=promotionproduct.getSpgdsrcm_otherlink().trim()%>" target="_blank">
			    	<%}else{%>	
			    		<a href="/product/<%=product.getId()%>" target="_blank">
			    	<%}%>
			    	 <p>
			    <%
			    if(promotionproduct.getSpgdsrcm_otherimg().trim().length()>0){
			    	%>	
			    	<img SRC="<%=promotionproduct.getSpgdsrcm_otherimg().trim()%>" alt="推荐产品" />
			    <%}else{%>
			      <img SRC="http://images.d1.com.cn<%=product.getGdsmst_otherimg3().trim()%>" alt="推荐产品" />
			   <% }%>
			     <br /><div style="padding-right:10px;padding-left:10px;">
			      <%=promotionproduct.getSpgdsrcm_gdsname().trim()%>
			      <br /><div><img src="/homeimg07/huzhuang_254.gif" /> <span class="yifu_hui"><strike>￥<%=sprice%></strike></span>&nbsp;&nbsp;<img src="/homeimg07/D1-price.gif" width="15" height="15" /> 
			      <span class="yifu_th">￥<%=strmprice%></span></div>
				 </div></p>
				        </a></li>	
			    <%}
			    i++;
			    if(i%5==0){%>
			    	</ul><ul>
			    <%}
			}
		}
		}
}

%>
</ul>