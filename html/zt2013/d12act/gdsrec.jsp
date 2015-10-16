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
			long tghit= pProduct.getSpgdsrcm_tghit().longValue();

				 theimgurl=ProductHelper.getImageTo400(product);


		
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
			   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
			   String brandname=product.getGdsmst_brandname();
%>
	
<div style="  float:left;  width:316px;height:400px; /*FF*/ *height:400px;/*IE7*/ _height:400px;/*IE6*/ _width:316px; <%if (l!=0 && i%3!=0 ){ %>		  margin-left:6px; <%}else{%> margin-left:6px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:5px;border: 1px solid #999999; background-color:#FFFFFF; overflow:hidden;" >

<dl style="text-align:left;padding:0px;margin:0px">
<dt style="width:304px; text-align:center;text-align:left;padding:0px 0px 0px 10px;margin:0px ">
			<div style="position:relative;left;width:300px;height:300px;">
		
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=0 width="300" height="300" style="border-color:#c0c0c0" >
		</a></div>
		</dt>
		<dd style="width:316px; text-align:left; padding:0px;margin:0px; float:left">
		<div style="position:relative; background-color:#D3000B">
<table width="316" height="100" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="81" rowspan="3">
	<span style="position:absolute; width:78px; height:77px; dislay:block; background:url('http://images.d1.com.cn/zt2013/1209/d12act001-2.png') no-repeat; left:2px; top:-10px; z-index:5000;"></span>	</td>
    <td colspan="3"  height="46">		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
    <span class="d12title"><%=Tools.substring(imgalt,48)%></span></a></td>
  </tr>
  <tr>
    <td width="73" rowspan="2" class="d12price"><span style="font-size:18px;line-height:38px;">￥</span><%=strmprice%></td>
    <td width="53" class="d12zk" valign="top"  ><%=dl%>折</td>
    <td width="109">已有<%=tghit%>人购买</td>
  </tr>
  <tr>
    <td><s>￥<%=saleprice%></s></td>
    <td>		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
    <img src="http://images.d1.com.cn/zt2013/1209/d12act002.png" width="84" height="30" border="0" /></a></td>
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