<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>
<div style="width:980px; background-color:#F9E9CF; text-align:center;">
<div style="width:970px; overflow:hidden;  padding-bottom:18px; ">
<% 
/**
 * 图片文字推荐<a><img></a>
 *getBrandImgText(String[] codes)
 * @return
 */
if(request.getAttribute("code")!=null){
	 String code=request.getAttribute("code").toString();
	 ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code,100);
		if(list!=null){
			int i=0;
			
			for(Promotion promotion:list){
			%>
			<div style="  float:left;  width:233px;height:376px; /*FF*/ *height:376px;/*IE7*/ _height:376px;/*IE6*/ _width:233px; <%if (i!=0 && i%4!=0 ){ %>		  margin-left:8px; <%}else{%> margin-left:8px; _margin-left:5px;/*IE6*/ <% }%> margin-top:8px; padding-top:10px; line-height:21px;  overflow:hidden;" >
<dl style="text-align:left;">
		<dd style="width:233px; text-align:left; float:left">
		<div style="width:233px;">
		<%	
				if(!promotion.getSplmst_url().equals("#")){%>
					<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
				<%} %>
				<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0">
				<% if(!promotion.getSplmst_url().equals("#")){%>
					</a>
				<%}%>
		</div>
		
		
		
</dd>
</dl>
</div>

				<%
				i++;
			}

		}
}
%>
</div>
</div>