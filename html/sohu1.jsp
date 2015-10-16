<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String code="3226";
if(request.getAttribute("code")!=null ){
code=request.getAttribute("code").toString();
ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,100);

if(list!=null && list.size()>0){
		int i=1;
		%>
		<table style="background:url('http://images.d1.com.cn/zt2012/20120817sohu/sohu_25.jpg') ">
		
		<%for(Promotion promotion:list){
			
			  if(i%4==1){
				  
	%>
	<tr><td width="4px" style="background:url('http://images.d1.com.cn/zt2012/20120817sohu/sohu_18.jpg') ">&nbsp;</td>
	<%} 
	%>
	<td  width="241" height="376" align="center">
	<%	
				if(!promotion.getSplmst_url().equals("#")){%>
					<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
				<%} %>
				<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0">
				<% if(!promotion.getSplmst_url().equals("#")){%>
					</a>
				<%}%>
	</td>
	<%if(i%4!=0){
		%>
		<td width="3"  style="background:url('http://images.d1.com.cn/zt2012/20120817sohu/sohu_18.jpg') ">&nbsp;</td>
		<%}if(i%4==0){ %>
		<td width="3"  style="background:url('http://images.d1.com.cn/zt2012/20120817sohu/sohu_18.jpg') ">&nbsp;</td></tr><tr><td height="5" style="height:5px;"></td></tr>
		<%} %>

		<%
		i++;
			
	}if((i-1)%4!=0){%>
	</tr><tr><td height="5">&nbsp;</td></tr>
	<%} %>
	</table>
		<%
}

}
%>