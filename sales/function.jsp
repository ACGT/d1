<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp" %>

<%
/**
 * 图片推荐<a><img></a>
 *getBrandImg(String[] codes)
 * @return
 */
 if(request.getAttribute("imgCode")!=null){
	 String codeimglist=request.getAttribute("imgCode").toString();
	 String[] imgcodes=new String[]{codeimglist};
	 if(codeimglist.contains("|")){
		 imgcodes=codeimglist.split("\\|");
	 }
	 ArrayList<Promotion> list2=PromotionHelper.getBrandList(imgcodes);
		StringBuffer str=new StringBuffer();
		if(list2!=null){
			for(int i=0;i<list2.size();i++){
				Promotion promotion=list2.get(i);
				if(!promotion.getSplmst_url().equals("#")){%>
					<a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url())) %>" target="_blank">
				<% }%>
				<img src="<%=promotion.getSplmst_picstr() %>" >
				<%
				if(!promotion.getSplmst_url().equals("#")){ %>
					</a>
				<%}
				
			}
		}
 }
%>
