<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:980; background-color:#CCCCCC; text-align:center;">
<div style="width:965px;overflow:hidden;  padding-bottom:18px;">
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
				 theimgurl=(!Tools.isNull(product.getGdsmst_imgurl())&&product.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn")+product.getGdsmst_imgurl();
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
	%>
	
	<div style="width:230px; float:left; height:320px; /*FF*/ *height:320px;/*IE7*/ _height:320px;/*IE6*/ <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF;" >
<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:10px; float:left">
			<div style="position:relative;left;width:200px;height:200px;">
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=product.getGdsmst_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		<jsp:include   page= "/sales/showLayer.jsp"   />   	
		</a>
		<%if (code.equals("3391")){ %>
		<span style="position:absolute; width:51px; height:83px; dislay:block; background:url('http://images.d1.com.cn/images2013/act/tl5.png'); left:4px; top:10px; z-index:5000;"></span>
		<%} %>
		</div>
		<dd style="width:205px; text-align:left; padding-left:10px; float:left">
		<div style="height:42px;width:205px;">
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none' >
		<%
		 if(booldx && dxprice>0){
			 %> 
			 <font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),len)%></font></a></div>
			 <span style="font-size:12px;color:#666666;"><strike>会员价:￥<%=strmprice%></strike>&nbsp;&nbsp;</span>
		    <span style="font-size:14px;font-weight:bold;color:#ff0000;">独享价:￥<%=ProductGroupHelper.getRoundPrice(dxprice)%></span> 
			<br>
		 <%}else{%> 
		 <font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),len)%></font></a></div><span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">会员价:￥<%=strmprice%>&nbsp;</span><br>
		<%}%> 
		
		<div align="right" style="height:40px"><%
		if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
		%>
			<a href="###" attr="<%=product.getId() %>" onclick="$.inCart(this);"><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" border="0" /></a><%
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