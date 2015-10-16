<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="4189";
String subad="";
int num=100;
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
			 <div style="background-color:#CCCCCC; width:750px;padding-bottom:8px;"> 
			<table width="750" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr align="center"  height=10> 
			<td width=20>
			</td></tr>
		<tr>
		<%	if(code.equals("8645")||code.equals("8646")||code.equals("8647")){
			urlreq="http://www.d1.com.cn/zhuanti/201305/xqr0524";
		}
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
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_img240300();
				 }
				 
				   float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
				   long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
		   			 long currentTime = System.currentTimeMillis();
			 %>
			<td width=7></td>
			 <td width="240" align="center" valign=top>
			<center>
			<table width="240" height="310" border="0" cellspacing="0" cellpadding="0" style=" background-color:#FFFFFF; margin-top:8px;" class="sp_outer">

		<tr><td width="240"  valign="top"  style="padding-top:2px;padding-left:5px;">
		<%if (code.equals("8622")) {%>
		<div style="z-index:999;position:relative;">
		<%} %>
         <%if (Tools.isNull(urlreq)) { %>
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<%}else{ %>
		<a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%=urlreq%>" target="_blank">
		<%} %>
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>"></a>
		
		<%if (code.equals("8622")) {%>
		<span style="position:absolute; width:51px; height:74px; dislay:block; background:url('http://images.d1.com.cn/images2013/product/jg.png'); left:0px; top:0px; z-index:5000;"></span>
		</div>
		<%} %>
		</td></tr>
		<tr><td align="center" valign="middle" style="padding-top:5px;">
		<%if (code.equals("8645") || code.equals("8646") || code.equals("8647")){ %><span style="font-size:16px; color:#000000">购物车下方<span style="color:red; font-weight:bold;font-size:20px;">0</span>元抢</span><br /><%}%>
		<font style="font-size:10pt"><%=Tools.substring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname().trim()),60)%></font><br>
		 <%if (Tools.isNull(urlreq)) { %>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%>
		<%}else{%>
		<%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%>
		<%}%>" target=_blank style='text-decoration:none'>
		<%}else{ %>
		<a href="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=<%=urlreq%>" style='text-decoration:none' target="_blank">
		<%} %>
		<%if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){ %>
		<span style="font-size:12px;color:#666666;"><strike>原价:￥<%=Tools.getFormatMoney(product.getGdsmst_oldmemberprice())%></strike></span>
		&nbsp;
		<%if (code.equals("8622")) {%>
		<span style="font-size:26px;font-weight:bold;color:#ff0000;">￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice())%>
		<%}else{ %>
				<span style="font-size:15px;font-weight:bold;color:#ff0000;">特价:￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice())%>
		<%} %>
		</span><br>
		<%}else{ %><span style="font-size:12px;color:#666666;"><strike>市场价:￥<%=sprice%></strike></span>
		&nbsp;
		
		<span style="font-size:15px;font-weight:bold;color:#ff0000;">

		<%if(code.equals("8578")||code.equals("8645") || code.equals("8646") || code.equals("8647")){ 
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
		<td width=5></td>
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
			  	<td width=10></td>
				  </tr><tr>
			  <% }
			
				 
				}
		}}%>
		</tr><tr align="center"  height=5> 
			<td width=20>
			</td></tr></table>	
			</div>
	 <%}
}
}
%>