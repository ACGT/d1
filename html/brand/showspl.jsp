<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%
String splid="";
String pos="";
String title="";
String tp="";
String topimg="";
String imgurl="";
String counter_brandname="";
String brandname="";
if(request.getAttribute("splid")!=null )
{
	splid=request.getAttribute("splid").toString();
}
 if(request.getAttribute("pos")!=null )
{
	pos=request.getAttribute("pos").toString();
}
 if(request.getAttribute("title")!=null )
{
	 title=request.getAttribute("title").toString();
}
 if(request.getAttribute("tp")!=null )
{
	 tp=request.getAttribute("tp").toString();
}
 if(request.getAttribute("topimg")!=null )
{
	 topimg=request.getAttribute("topimg").toString();
}
if(request.getAttribute("imgurl")!=null ){
	imgurl=request.getAttribute("imgurl").toString();
}
if(! Tools.isMath(splid)){
	return;
}
//out.print("<script>alert('"+pos+"')</script>");
if(pos.equals("0")){
	
	%>
	<table width="194" border="0" cellpadding="0" cellspacing="0">
<%
if(!Tools.isNull(title)){
	%>
		<tr><td style="font-size:18px;font-family : simhei;"><BR>
	  <font color="#cc0000"><%=Tools.substring(title,4)%></font><%=title.substring(2,title.length())%>
	  </td></tr>
<%}
ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(splid, 1000);
if(plist!=null){
	int i=1;
	%>
	<tr><td style="font-size:13px;font-family : simhei;">
	<ul class="tekuang">
<%	for(Promotion promotion:plist){
	String url=StringUtils.encodeUrl(promotion.getSplmst_url());
	/*if(url.indexOf("brand/brandlist.asp")>0){
	url=url.replace("brandlist.asp", "index.jsp");
		}
	if(url.startsWith("http://www.d1.com.cn/html/brand/brand")){
		//	out.print("<script>alert('ssssssss')</script>");
			String str1="http://www.d1.com.cn/html/brand/brand";
			String str=url.substring(str1.length(),url.length()-4);
			url="/html/brand/index.jsp?id="+str;
		}*/
	%>	
	<li><a href="<%=url%>"><img src="images/n_<%=i%>.gif">&nbsp;<font style="color:000000;font-size:13px;"><%=promotion.getSplmst_name()%></font></a></li>	
	<%	i++;}%>	
	</ul>
	</td></tr>
<%}%>
</table>
	<%}if(pos.equals("1")){
		if(!Tools.isNull(topimg)){
			%>	
			<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr><td align=left>
		
		<%
		if(!Tools.isNull(imgurl)){
			%>	
			<a href="<%=imgurl%>" target="_blank" >
		<%}%>
		<img src="<%=topimg%>" border=0>
		<%
		if(!Tools.isNull(imgurl)){
			%>	
			</a>
	<%}	%>
	</td></tr>
	</table>
	<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr><td align=left height=5>
		</td></tr>
	</table>	
	<%	}
		ArrayList<Product> list=null;
		if(tp.equals("1")){
			ArrayList gdsidlist=PromotionProductHelper.getGdsList(splid);
			if(gdsidlist!=null && gdsidlist.size()>0){
				list=ProductHelper.getProductInfoById(gdsidlist) ;
			}
		}else if(tp.equals("2")){
			list=ProductHelper.getProductByBrandname(counter_brandname) ;
		}
		if(list!=null && list.size()>0){
			int i=0;
			%>
			<table width="740" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
		<%	
		 for(Product product:list){
				ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(splid,product.getId());
				Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
				if(pproductlist!=null && pproductlist.size()>0 &&directory!=null){
				 PromotionProduct pProduct=pproductlist.get(0);
				 
				 String imgalt=product.getGdsmst_gdsname()+"-"+product.getGdsmst_brandname()+"-"+directory.getRakmst_rackname();
				 imgalt=imgalt.replace("<","").replace(".","").replace("+","").replace("?","").replace(">","");
				 
				 String theimgurl="";
				 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
					 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
				 }else{
					 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
				 }
				
				   float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice());
			
			 %>
			
			 <td width="33%" align="center" valign=top>
			<center>
		<table width="220" border="0" cellspacing="0" cellpadding="0" style="background:url('http://www.d1.com.cn/html/mini/images/mini_bg2.gif') center top no-repeat;">
		<tr><td width="220" style="padding-top:2px;padding-left:8px;">
		<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%><%}else{%><%= StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank">
		<img src="<%=theimgurl%>" border=0 alt="<%=imgalt%>"></a>
		</td></tr>
			<tr><td align="center" valign="middle" style="padding-top:5px;">
		<font style="font-size:10pt"><%=Tools.substring(product.getGdsmst_gdsname(),100)%></font><br><br>
		<a  href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>/product/<%=product.getId()%>
		<%}else{%>
		<%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%>
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
			 if(i==list.size() && i<3){
				 for(int m=1;m<=3-i;m++){
					%> 
					 <td width="33%"><center>
			<table border=0 width=95%>
			<tr><td>&nbsp;
			</td></tr>
			</table></center>
			</td>
			<td width=5>&nbsp;</td>
				 <% }
			 }
			  if(i%3==0){%> 
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
	}else if(pos.equals("2")){%>
		<table width="194" border="0" cellpadding="0" cellspacing="0">
	<%
	if(!Tools.isNull(title)){
		brandname=title;
	}%>
	<tr><td style="font-size:18px; height:24px" height=24><BR>
	  <font color="#cc0000">销售</font>排行
	  </td></tr>
	<%
	ArrayList<Product> plist=ProductHelper. getProductByCodeAndBName(splid,brandname,8);
	if(plist!=null){
		int i=1;%>
		<tr><td style="font-size:13px;font-family : simhei;">
	<ul style="margin:2px;margin-top:8px;list-style : disc outside none ; list-style-position : outside;height:25px;color:#424242;padding:1px; font:12px Verdana, Arial;list-style-type:none;">
		<%for(Product p:plist){
			String lname=Tools.substring( Tools.clearHTML(p.getGdsmst_gdsname()) ,20);
			%>
			<li style="height:40px;"><a href="/product/<%=p.getId()%>" target="_blank" title="<%=p.getGdsmst_gdsname()%>"><img src="images/n_<%=i%>.gif">&nbsp;<font style="color:000000;font-size:13px;"><%=lname%></font></a></li>	
		<%
		i++;
		}%>
		</ul>
	</td></tr>
	<%}%>
	</table>
	<%}

%>