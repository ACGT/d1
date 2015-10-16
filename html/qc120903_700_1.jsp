<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<style type="text/css">
 p {text-align:left; }

 p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}

 .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-33px; position:relative; width:220px; padding-top:3px; padding-bottom:2px;

*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:20px;  }

.retime a{text-decoration:none; }

.lf{ over-flow:hidden;}

.lb{background-color:#f7f7f7;  padding:5px;  width:3100px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;

 text-align:left; vertical-align:middle; padding-top:8px;}

.lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none;}

</style>
<table id="__01" width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="20px"></td>	</tr>
	<tr>
		<td  valign="top">
<%
String code="7878";
String subad="";
if(request.getAttribute("code")!=null && request.getAttribute("subad")!=null){
code=request.getAttribute("code").toString();
subad=request.getAttribute("subad").toString();
int len=25;
if(request.getAttribute("length")!=null){
	len=Integer.parseInt((request.getAttribute("length")).toString().trim());
}
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,9);

if(list!=null && list.size()>0){

		int i=0;
		%>
		<table width="700">
		
		<%for(PromotionProduct pProduct:list){
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
			 String theimgurl="";
			 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
			 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
			 }else{
				 theimgurl="http://images.d1.com.cn"+product.getGdsmst_midimg();
			 }
			 String url="";
			 if(pProduct.getSpgdsrcm_otherlink()!=null&&pProduct.getSpgdsrcm_otherlink().length()>0)
			 {
				 url=pProduct.getSpgdsrcm_otherlink();
			 }
			 else
			 {
				 url="http://www.d1.com.cn/product/"+product.getId();
			 }
			 
			   float memberprice=product.getGdsmst_memberprice().floatValue();
				String sprice=ProductGroupHelper.getRoundPrice(memberprice);
				 String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
	
	if (i==0 || (float)i/3==(int)i/3){%>
				<tr>
				
				<%} %>
				<td width="220"  valign="top">
				
				<table width="220"  height="275" border="0" cellpadding="0" cellspacing="0">
				<tr>
				<td valign="top" height="220">
				<a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank"><img src="<%= theimgurl%>" border="0" width="220" height="220" /> </a>
				</td>
				
				</tr>
				<tr>
				<td height="55" style="background: #C2C2C0;">
				<table width="220"  border="0" cellpadding="0" cellspacing="0">
				 <tr>
    <td rowspan="2" width="10">&nbsp;</td>
    <td height="20"><span style="color:#404040;font-size:14px;font-family: '微软雅黑'; ">原价￥<%=oldmprice %></span></td>
    <td rowspan="2" width="52" align="left" valign="top" >
    <div style="padding-top:20px; height:25px;">
    <span style="color:#B0130B;font-size:24px;font-weight:bold;"><%=sprice %></span>
    </div>
    </td>
    <td rowspan="2"><a href="<%if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){%>http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad=<%=subad%>&url=http://www.d1.com.cn/product/<%=product.getId()%><%}else{%><%=StringUtils.encodeUrl(pProduct.getSpgdsrcm_otherlink().trim())%><%}%>" target="_blank"><img src="http://images.d1.com.cn/zt2012/20120904qc700/buy.png" border="0" /></a></td>
  </tr>
  <tr>
    <td><span style="color:#AB1A1C;font-size:18px;font-family: '微软雅黑'; ">活动价￥</span></td>
  </tr>
 
				</table>
				</td>
				</tr>
				</table>
				</td>
			<% 
				
				i++;
	          if (i%3==0){%>
	        	
				<% }else{%>
					
				<%}
	          if (i%3==0){ %>
				</tr>
				<tr><td colspan="4"  height="10px"></td>
				</tr>
				<%}

	
}%>
</table>
<%
	}

}
%>

	</td>
	  </tr>
<tr><td  height="15px"></td>	</tr>
</table>

