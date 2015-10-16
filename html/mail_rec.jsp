<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="4189";
String subad="";
int num=50;
String urlreq="";
if(request.getAttribute("code")!=null && request.getAttribute("subad")!=null){
	if(request.getAttribute("num")!=null){
		num=Tools.parseInt(request.getAttribute("num").toString());
	}
	if(request.getAttribute("urlreq")!=null){
		urlreq=request.getAttribute("urlreq").toString();
	}
	//System.out.println(num+"MMMMMMMMMMMMMMMMMMMMMMM");
	code=request.getAttribute("code").toString();
	subad=request.getAttribute("subad").toString();
	ArrayList gdslist=PromotionProductHelper. getGdsList(code);
	if(gdslist!=null){
		int i=0;
		ArrayList<Product> productlist=ProductHelper.showlist(gdslist,num);
		if(productlist!=null){
			%>
			 <div style="width:750px;padding-bottom:18px;"> 
			<table width="750" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr align="center"  height=10> 
			<td width=20>
			</td></tr>
		<tr>
		<%	
		for(Product product:productlist){
			if(i<num){
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
					 theimgurl=product.getGdsmst_imgurl().trim();
					 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
						 theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
							}else{
								theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
							}
				 }
				 
				   float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
				   long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
		   			 long currentTime = System.currentTimeMillis();
			 %>
			<td width=20>&nbsp;</td>
			 <td width="210" align="center" valign=top>
			<center>
			<table width="210" height="310" border="0" cellspacing="0" cellpadding="0" style=" background-color:#FFFFFF; margin-top:15px;" class="sp_outer">

		<tr><td width="210"  valign="top"  style="padding-top:2px;padding-left:5px;">
         <%if (Tools.isNull(urlreq)) { %>
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0||1==1){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<%}else{ %>
		<a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%=urlreq%>" target="_blank">
		<%} %>
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>"></a>
		</td></tr>
		<tr><td align="center" valign="middle" style="padding-top:5px;">
		<font style="font-size:10pt"><%=Tools.substring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname().trim()),60)%></font><br>
		 <%if (Tools.isNull(urlreq)) { %>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0||1==1){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%>
		<%}else{%>
		<%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%>
		<%}%>" target=_blank style='text-decoration:none'>
		<%}else{ %>
		<a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%=urlreq%>" style='text-decoration:none' target="_blank">
		<%} %>
		<%if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){ %>
		<span style="font-size:12px;color:#666666;"><strike>原价:￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice())%></strike></span>
		&nbsp;<br>
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">特价:￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice())%>
		</span><br>
		<%}else{ %><span style="font-size:12px;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span>
		&nbsp;<br>
		
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">
		<%if(code.equals("8578")){ 
		out.print("原售价");
		}else{
			out.print("D1价");
		}
		%>
		 :￥<%=strmprice%>
		</span><br>
		<%} %>
		</td></tr>
		</table>
		</center>
		</td>
		<td width=5>&nbsp;</td>
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
		}}%>
		</tr><tr align="center"  height=20> 
			<td width=20>
			</td></tr></table>	
			</div>
	 <%}
}
}
%>