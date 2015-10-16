<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
static ArrayList<Sku> getSku(String productid){
	int count=0;
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productid));
	//clist.add(Restrictions.eq("skumst_validflag", new Long(1)));//上架	
	List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
	ArrayList<Sku> rlist = new ArrayList<Sku>();
	if(list!=null&&list.size()>0){
		for(BaseEntity sku:list){
			rlist.add((Sku)sku);
		}
	}
	return rlist;
}
%>
<div style="width:980px; background-color:#CCCCCC; text-align:center;">
<div style="width:965px; overflow:hidden;  padding-bottom:18px; ">
<%
String code="7006";
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
		
	int i=0;
	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	int l=0;
	if(productlist!=null){
		for(Product product:productlist){
			//ArrayList<Sku> skulist=getSku(product.getId());
			int count=0;
			//if(skulist!=null && skulist.size()>0){
				//for(Sku sku:skulist){
				//count+=	sku.getSkumst_vstock().intValue();
				//}
			//}
			if(product.getGdsmst_virtualstock().intValue()>0){
				count=product.getGdsmst_virtualstock().intValue()*3;
			}
			
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
			   float memberprice=product.getGdsmst_oldmemberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_memberprice().floatValue());//特价
			   String soldprice=ProductGroupHelper.getRoundPrice(memberprice);//会员价
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());//市场价
				  
	%>
	
<div style="  float:left;  width:231px;height:320px; /*FF*/ *height:320px;/*IE7*/ _height:320px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
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
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(pProduct.getSpgdsrcm_gdsname(),len)%></font></a>
		</div>
		<span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike>  <strike>会员价:￥<%=soldprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">特价:￥<%=strmprice%>&nbsp;仅剩：<%=count%>件</span><br>
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