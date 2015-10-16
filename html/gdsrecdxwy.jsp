<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:760; background-color:#F4F4F4; text-align:center;">
<div style="width:760px;overflow:hidden;  padding-bottom:18px;">
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
ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,len);
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
				 theimgurl=product.getGdsmst_otherimg3();
				 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
					 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
						}else{
							theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
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
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice().floatValue());
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
	%>
	
	<div style="width:145px; float:left; height:260px; /*FF*/ *height:260px;/*IE7*/ _height:260px;/*IE6*/  margin-left:5px; _margin-left:5px;/*IE6*/   margin-top:8px; padding-top:10px; line-height:21px;" >
<dl style="text-align:left;">
<dt style="width:145px; text-align:center;float:left">
			<div style="position:relative;left;width:144px;height:144px;">
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl.trim()%>" width=120 height=120 style="border: 1px solid #E1E1E1" >
		</a></div>
		<dd style="width:145px; text-align:left;float:left">
		<div style="height:42px;width:145px;">
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none' >
		 <font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(pProduct.getSpgdsrcm_gdsname(),36)%></font></a></div>
		<%
		 if(booldx && dxprice>0){
			 %> 
			
			 <div  align="center">
			  <span style="font-size:12px;color:#666666;"><strike>会员价:￥<%=oldmprice%></strike></span><br />
		    <span style="font-size:13px;font-weight:bold;color:#E96210;">网易独享价:￥<%=ProductGroupHelper.getRoundPrice(dxprice)%></span><br>
			 </div>
			
		 <%}else{%> 
		  <div  align="center">
		 <span style="font-size:12px;font-weight:800;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span><br>
		<span style="font-size:13px;font-weight:800;color:#E96210;">会员价:￥<%=strmprice%></span><br>
		</div>
		<%}%> 
		
		<div align="center" style="height:40px"><%
		if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
		%>
			<a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/market/1206/wydh/wydh01.jpg" border="0" /></a><%
		}else{
		%>
			<a href="###"><img src="http://images.d1.com.cn/images2012/New/product/qh.jpg" /></a><%
		} %>
		</div>
		
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