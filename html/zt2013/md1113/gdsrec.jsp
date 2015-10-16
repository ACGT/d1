<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<div style="width:980px;  text-align:center;">
<div style="width:965px; overflow:hidden;  padding-bottom:18px; ">
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
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 if(product.getGdsmst_rackcode().startsWith("014")){
				 theimgurl=product.getGdsmst_imgurl();
				 }else{
					 theimgurl=product.getGdsmst_img200250();
				 }
			 }
			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
					}else{
						theimgurl = "http://images.d1.com.cn"+theimgurl;
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
			   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice() );
			   String saleprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			   String brandname=product.getGdsmst_brandname();
			   boolean	msflag= CartHelper.getmsflag(product);
			   
   	           
			   
			   if(product.getGdsmst_rackcode().startsWith("014")){
				   %>
	<div style="  float:left;  width:231px;height:310px; /*FF*/ *height:310px;/*IE7*/ _height:310px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
				   
				   <%
			   }else{
			   if(code.equals("8996")){		
	%>
	
<div style="  float:left;  width:231px;height:400px; /*FF*/ *height:400px;/*IE7*/ _height:400px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >
<%}else{ %>
<div style="  float:left;  width:231px;height:360px; /*FF*/ *height:360px;/*IE7*/ _height:360px;/*IE6*/ _width:232px; <%if (l!=0 && i%4!=0 ){ %>		  margin-left:15px; <%}else{%> margin-left:10px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;" >

<%}} %>
<dl style="text-align:left;">
<dt style="width:205px; text-align:center;padding-left:10px; ">
<%if (product.getGdsmst_rackcode().startsWith("014")){ %>
			<div style="position:relative;left;width:200px;height:200px;">
			<%}else{ %>
				<div style="position:relative;left;width:200px;height:250px;">
			<%} %>
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%=pProduct.getSpgdsrcm_otherlink().trim()%><%}%>" target=_blank style='text-decoration:none' title="<%=pProduct.getSpgdsrcm_gdsname()%>">
		<img src="<%=theimgurl%>" border=1 style="border-color:#c0c0c0" >
		</a></div>
		<dd style="width:205px; text-align:left; padding-left:10px; float:left">
		<div style="height:42px;width:205px;">
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=pProduct.getSpgdsrcm_otherlink().trim()%>
		<%}%>" target=_blank style='text-decoration:none' >
		<font style="font-size:10pt" color="#3c3c3c"><%=Tools.substring(product.getGdsmst_gdsname(),48)%></font></a>
		</div>
		<%if(code.equals("8996")){
			out.print("<div style=\"height:85px;width:205px;padding-top:5px; \">");
		}else{
			out.print("<div style=\"height:85px;width:205px;padding-top:5px;\">");
		}
		
		if (code.equals("8996")){ %>
		<div style="float:left;width:115px;">
		 <span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;line-height:28px;"><strike>会员价:￥<%=sprice%></strike></span>&nbsp;&nbsp;<br>
		<span style="font-family: '微软雅黑';font-size:42px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span><br>
		</div>
		<div style="float:right;width:81px;">
		<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/mh1113/50.gif" broder="0"></a>
		</div>
		<%}else{ %>
		<div style="float:left;width:52px;">
		<%if ((",9092,9098,9099,9100,9101,").indexOf(","+code+",")>=0){ %>
				<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/1213/sdtj.jpg" broder="0"></a>
				<%}else if ((",9123,").indexOf(","+code+",")>=0){ %>	
			<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/1225/qcdj.png" broder="0"></a>
			<%}else if ((",9116,9117,9118,9119,").indexOf(","+code+",")>=0){ %>	
			<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/1225/ydtj.jpg" broder="0"></a>
		<%} else{%>
		<a href="/product/<%=product.getId()%>" target="_blank"><img src="http://images.d1.com.cn/zt2013/mh1113/tj.gif" broder="0"></a>
		<%} %>
		</div>
		<div style="float:right;width:148px;">
		<%
		if(msflag){
	        	strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_msprice().floatValue());
	 
	       
%>
		<span style="font-family: '微软雅黑';font-size:36px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span>
		 市场价:￥<span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=saleprice%></strike></span><br>
		
		<%}else{ %>
		<span style="font-family: '微软雅黑';font-size:36px;font-weight:bold;color:#ff0000;line-height:48px;"> <%=strmprice%></span>
		 会员价:￥<span style="font-family: '微软雅黑';font-size:12px;font-weight:bold;color:#666666;"><strike><%=sprice%></strike></span><br>
		<%} %>
		</div>
		
		<%} 
		out.print("</div>");
		 
		 if(code.equals("8996")){ %>
		 <div style=" height:24px;width:205px;color:#fff;background-color:#d70b52;text-align:center">双11销售：<%=pProduct.getSpgdsrcm_tghit() %>件</div>
		 <%} %>
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