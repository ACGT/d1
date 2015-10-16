<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:750px;  text-align:center;">
<div style="width:750px; overflow:hidden;  padding-bottom:18px; font-size:12px;">
<%
String code="7006";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
String subad=request.getAttribute("subad").toString();
String subadurl="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=";
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
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 if(product.getGdsmst_rackcode().startsWith("014")||product.getGdsmst_rackcode().startsWith("015")){
				 theimgurl=product.getGdsmst_imgurl();
				 }else{
					 theimgurl=product.getGdsmst_img200250();
				 }
			 }
			 if(theimgurl!=null){
			 if(theimgurl.startsWith("/shopimg/gdsimg")){
				 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
					}else{
						theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
					}
			 }
		
			 String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			   String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   String brandname=product.getGdsmst_brandname();
			   int hig=370;
			   if(product.getGdsmst_rackcode().startsWith("014")||product.getGdsmst_rackcode().startsWith("015")){
				   hig=320;
	             } %>

<ul style="padding:0px;margin:0px;">
<li style="padding:0px;margin:0px; float:left;margin-left:10px; margin-top:10px;background:#FFFFFF;">
<table width="234" height="<%=hig %>" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%><%=subadurl %>http://www.d1.com.cn/html/zt2014/0121qc/index.jsp<%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a>
</td>
  </tr>
  <tr>
   <td align="center"><table width="200" border="0" cellspacing="0" cellpadding="0">
   <tr><td>
    <a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%><%=subadurl %>http://www.d1.com.cn/html/zt2014/0121qc/index.jsp
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank title="<%=pProduct.getSpgdsrcm_gdsname()%>" style='text-decoration:none' >
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),48)%></font></a>
    </td>
  </tr></table>
    </td>
  </tr>
  <tr>
    <td align="center"><table width="200" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="55"><img src="http://images.d1.com.cn/zt2014/0121qc/nztj-2.jpg" width="51" height="50" /></td>
        <td width="63"><span style="font-size:32px;line-height:32px;color:#ff0000;font-family: '微软雅黑'">
<%if(CartHelper.getmsflag(product)){
	strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_msprice());
}
out.print(strmprice);
	%>
</span></td>
        <td width="82" style="font-size:12px;">市场价：<s><%=saleprice %></s></td>
      </tr>
    </table></td>
  </tr>
</table>
</li>
</ul>



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