<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String code="3650";
int num=16;
if(request.getAttribute("code")!=null && request.getAttribute("num")!=null){
	code=request.getAttribute("code").toString();
	num=(Integer.valueOf(request.getAttribute("num").toString())).intValue();
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,num);
	//out.println(list.size());
	ArrayList gdsidlist=new ArrayList();
	if(list!=null && list.size()>0){
		for(PromotionProduct pProduct:list){
			gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
		}
		if(gdsidlist!=null && gdsidlist.size()>0){
		int i=0;
		ArrayList<Product> productlist=ProductHelper.showlist(gdsidlist,num);
		if(productlist!=null){
			%>
			 <table width="870"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white>
					  <tr><td height=3>
					  </td></tr>
		<tr>
		<%	for(Product product:productlist){
				ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
				Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
				if(pproductlist!=null && directory!=null){
				 PromotionProduct pProduct=pproductlist.get(0);
				 
				 String imgalt=product.getGdsmst_gdsname()+"-"+product.getGdsmst_brandname()+"-"+directory.getRakmst_rackname();
				 imgalt=imgalt.replace("<","").replace(".","").replace("+","").replace("?","").replace(">","");
				 
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
			
			 <td width="25%" align="center" valign=top>
			<center>
		<table border="0" cellspacing="0" cellpadding="0" style="background:url('http://www.d1.com.cn/html/mini/images/mini_bg2.gif') center top no-repeat;">
		<tr><td  style="padding-top:2px;padding-left:6px;">
		<div style="position:relative;left;width:190px;height:200px;">
		
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target="_blank">
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>" ></a>
		<jsp:include   page= "/sales/showLayer.jsp"   />   </a></div>
		</td></tr>
			<tr><td align="center" valign="middle" style="padding-top:5px;">
		<font style="font-size:10pt"><%=Tools.substring(product.getGdsmst_gdsname(),100)%></font><br><br>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none'>
		<span style="font-family:'Century Gothic';font-size:22px;	color:#941063;	letter-spacing:-1px;font-weight:bold;text-decoration:none;">￥</span>
		<span style="font-family:'Century Gothic';font-size:22px;	color:#941063;	letter-spacing:-1px;font-weight:bold;text-decoration:none;"><%=strmprice %></span>&nbsp;&nbsp;
		<span style="font-size: 12px;font-weight: bold;color: #666666;"><strike>￥<%=sprice%></strike></span></a>
		</td></tr>
		</table>
		</center>
		</td>
		<td width=5>&nbsp;</td>
			<%
			 i++;
			 if(i==productlist.size() && i<4){
				 for(int m=1;m<=4-i;m++){
					%> 
					 <td width="25%"><center>
			<table border=0 width=95%>
			<tr><td>&nbsp;
			</td></tr>
			</table></center>
			</td>
			<td width=5>&nbsp;</td>
				 <% }
			 }
			  if(i%4==0){%> 
				  </tr><tr>
			<td>
					<table width="100%" height="10" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor=white>
					  <tr><td>
					  </td></tr>
					</table>
			</td>
			</tr><tr>
			  <% }
			
				 
				}
		}%>
		</tr></table>	
	 <%}
		}
}
}
%>