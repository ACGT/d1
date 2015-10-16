<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<% 
/**
 * 图片文字推荐<a><img></a>
 *getBrandImgText(String[] codes)
 * @return
 */
if(request.getAttribute("imgTextCode")!=null){
	 String codelist=request.getAttribute("imgTextCode").toString();
	 String[] codes=new String[]{codelist};
	 if(codelist.contains("|")){
			 codes=codelist.split("\\|");
	 }
	 ArrayList<Promotion> list=PromotionHelper.getBrandList(codes);
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Promotion promotion=list.get(i);
				//String url=promotion.getSplmst_url().replace("http://www.d1.com.cn/html/result.asp", "/result.jsp").replace("http://www.d1.com.cn/sales/salesviews.asp", "salesviews.jsp");
				
				if(!(i==0 && promotion.getSplmst_seqview().intValue()==0)){
					
				%>
					<li>
				<% }
				if(!promotion.getSplmst_url().equals("#")){
					String url=StringUtils.encodeUrl(PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url())));
					if(url.startsWith("http://www.d1.com.cn/html/brand/brand")){
						String str1="http://www.d1.com.cn/html/brand/brand";
						String str=url.substring(str1.length(),url.length()-4);
						url="/html/brand/index.jsp?id="+str;
					}
				%>
				
					<a href="<%=url%>" target="_blank">
				<%} %>
				<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>">
				<% if(!promotion.getSplmst_url().equals("#")){%>
					</a>
				<%}
				if(i==0 && promotion.getSplmst_seqview().intValue()==0){%>
				   <br/>
				<%}else{%>
					</li>
				<%}
			}
		}
}
%>