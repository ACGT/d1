<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp"%>
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
		 <div style="width:600px;padding-bottom:18px;"> 
		<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
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

				 theimgurl="http://images.d1.com.cn"+product.getGdsmst_otherimg3();
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
				    	}
	                    }
				 }
	%>
<td width=15>&nbsp;</td>
	 <td width="140" align="center" valign=top>
			<center>
			<table width="140" height="200" border="0" cellspacing="0" cellpadding="0" style=" background-color:#FFFFFF; margin-top:15px;" class="sp_outer">
		<tr>
		
		<td width="140"  valign="top"  style="padding-top:2px;padding-left:2px;">
		
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/html/index99.jsp?id=p130409xjqhd&md=d1_1111&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>"></a>
		</td></tr>
		<tr><td align="center" valign="middle" style="padding-top:5px;">
		<font style="font-size:10pt"><%=Tools.substring(product.getGdsmst_gdsname(),38)%></font><br><br>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%>
		<%}%>" target=_blank style='text-decoration:none'></a>
		<%
		 if(booldx && dxprice>0){
			 %> 
			  <span style="DISPLAY: inline-block;font-size:12px; font-weight:bold;COLOR: #999; "><strike>会员价:￥<%=strmprice%></strike></span><br>
		<span style="DISPLAY: inline-block; COLOR: #b50023;font-size:13px; font-weight:bold;FONT-FAMILY: '微软雅黑'"><%=str %>:￥<%=dxprice%>&nbsp;</span><br>
			
		 <%}else{%> 
		 <span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">会员价:￥<%=strmprice%>&nbsp;折扣：<%=fl%></span><br>
		<%}%> 
		</td></tr>
		</table>
		</center>
		</td>
	
			<%
			 i++;
			 if(i==productlist.size() && i<4){
				 for(int m=1;m<=4-i;m++){
					%> 
					 <td width="33%"><center>
			<table border=0 width=95%>
			<tr><td>&nbsp;
			</td></tr>
			</table></center>
			</td>
			
				 <% }
			 }
			  if(i%4==0){%> 
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