<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<%
String code="3885";
if(request.getAttribute("code")!=null){
	code=request.getAttribute("code").toString();
	//num=(Integer.valueOf(request.getAttribute("num").toString())).intValue();
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,100);
	//out.println(list.size());
	ArrayList gdsidlist=new ArrayList();
	if(list!=null && list.size()>0){
		
		for(PromotionProduct pProduct:list){
			gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
			
		}
		if(gdsidlist!=null && gdsidlist.size()>0){
			
		int i=0;
		ArrayList<Product> productlist=ProductHelper.showlist(gdsidlist,100);
		if(productlist!=null){
			
			%>
			<table  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr height=10><td></td></tr>
			</table>
		<%	for(Product product:productlist){
				ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
				Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
				if(pproductlist!=null && directory!=null){
					if((i+1)%4==1){
					%>
					<table width="880" border="0" cellspacing="0" cellpadding="0" align="center"  bgcolor=#ffffff>
					<tr align="center"  height=209> 
					<td width=10>
					</td>
					<%}
				 PromotionProduct pProduct=pproductlist.get(0);
				 String theimgurl="";
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
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
				 %>
			<td width="25%" align="center" valign=top><center>
		<table width="205"  border="0" cellspacing="0" cellpadding="0" class="sp_outer">
		<tr><td  width="205" style="padding-top:2px;padding-left:2px;">	
		<div style="position:relative;left;width:200px;height:200px;">
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=product.getGdsmst_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		<jsp:include   page= "/sales/showLayer.jsp"   />   	
		</a></div>
		</td></tr>
			<tr><td align="left" valign="middle" style="padding-top:5px;line-height:22px;"><div style="height:60px;">
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none' >
		
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),101)%></font></a></div><span style="font-size:12px;font-weight:bold;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span><br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">D1价:￥<%=strmprice%></span>&nbsp;&nbsp;
		</td></tr>
		</table></center>
		</td>
		
		<td width=5>&nbsp;</td>
			<%
			
			 i++;
			 if(i==productlist.size() && i%4!=0){
				 for(int m=1;m<=4-(i%4);m++){
					%> 
					 <td width="25%"><center>
			<table border=0 width=95%>
			<tr><td>&nbsp;
			</td></tr>
			</table></center>
			</td>
			<td width=5>&nbsp;</td>
				 <% }%>
				 </tr></table>	
			<% }
			  if(i%4==0){%> 
			  
				 </tr><tr>
	<td width=5></td>
	</tr>
	</table>
	<table width="880" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr height=10><td></td></tr>
	</table>
			  <% }
			
				 
				}
		}%>
		
	 <%}
		}
}
}
%>