<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
String code="0";
if(request.getAttribute("reccode")!=null ){
code=(String)request.getAttribute("reccode");
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString());
}
String dxcode=(String)request.getAttribute("dxcode");
ArrayList gdslist=PromotionProductHelper. getGdsList(code);
if(gdslist!=null){
	int i=0;
	ArrayList<Product> productlist=ProductHelper.showlist(gdslist,200);
	if(productlist!=null){
		%>
		 <div style="background-color:#CCCCCC; width:700px;padding-bottom:18px;"> 
		<table width="700" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr align="center"  height=10> 
		<td  colspan="6">
		</td></tr>
	<tr>
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
				 String str="独享价";
				 if(!Tools.isNull(dxcode)){
				  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(dxcode));
				  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
				  if(rcmdusr!=null 
				    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
				    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
				    	){
				    	booldx=true;
				    	ProductExpPriceItem rcmdgds=(ProductExpPriceItem)ProductExpPriceHelper.getExpPrice(product.getId(), dxcode);
				    	if(rcmdgds!=null){dxprice=rcmdgds.getRcmdgds_memberprice();
				    	str=rcmdgds.getRcmdgds_title().substring(0,rcmdgds.getRcmdgds_title().indexOf(":"));
				    	}
	                    }
				 }
	%>
<td width=15>&nbsp;</td>
	 <td width="210" align="center" valign=top>
			<center>
			<table width="210" height="310" border="0" cellspacing="0" cellpadding="0" style=" background-color:#FFFFFF; margin-top:15px;" class="sp_outer">
		<tr>
		
		<td width="210"  valign="top"  style="padding-top:2px;padding-left:2px;">
		
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=p111214jhtj&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>"></a>
		</td></tr>
		<tr><td align="center" valign="middle" style="padding-top:5px;">
		<font style="font-size:10pt"><%=Tools.substring(product.getGdsmst_gdsname(),25)%></font><br><br>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/product/<%=product.getId()%>
		<%}else{%>
		<%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%>
		<%}%>" target=_blank style='text-decoration:none'></a>
		<%
		 if(booldx && dxprice>0){
			 %> 
			  <span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike>&nbsp;&nbsp;&nbsp;&nbsp;<strike>会员价:￥<%=strmprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;"><%=str %>:￥<%=dxprice%>&nbsp;</span><br>
			
		 <%}else{%> 
		 <span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">会员价:￥<%=strmprice%>&nbsp;折扣：<%=fl%></span><br>
		<%}%> 
		
		<div align="right" style="height:40px"><%
		if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
		%>
			<a href="http://www.d1.com.cn/product/<%=product.getId()%>" ><img src="http://images.d1.com.cn/images2011/sales/tm004.gif" border="0" /></a><%
		}else{
		%>
			<a href="###"><img src="/res/images/product/qh.jpg" /></a><%
		} %>
		</div>
		</td></tr>
		</table>
		</center>
		</td>
	
			<%
			 i++;
			 if(i==productlist.size() && i<3){
				 for(int m=1;m<=3-i;m++){
					%> 
					 <td width="33%"><center>
			<table border=0 width=95%>
			<tr><td>&nbsp;
			</td></tr>
			</table></center>
			</td>
			
				 <% }
			 }
			  if(i%3==0){%> 
			  	<td width=15>&nbsp;</td>
				  </tr><tr>
			  <% }
			
				 
				}
		}%>
		</tr><tr align="center"  height=20> 
			<td width=20>
			</td></tr></table>	
			</div>
	 <%}
}
}
%>