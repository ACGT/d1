<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
if(request.getAttribute("code")!=null){
String code= request.getAttribute("code").toString();

ArrayList<Promotion> list=PromotionHelper. getBrandListByCode (code , -10);
for(int i=0;i<list.size();i++){
	Promotion promotion=list.get(i);

		String splmst_name=promotion.getSplmst_name();
		String strdiv="";
		String url=promotion.getSplmst_url().replace(".asp", ".jsp");
		if(url.startsWith("http://www.d1.com.cn/html/brand/brand")){
		//	out.print("<script>alert('ssssssss')</script>");
			String str1="http://www.d1.com.cn/html/brand/brand";
			String str=url.substring(str1.length(),url.length()-4);
			url="/html/brand/brand"+str+".htm";
		}
		if(splmst_name.contains("</div>")){
			splmst_name=splmst_name.replace("</div>","");
			 strdiv="</div><div class=listbrand>";
		}
		
		url = url.replaceAll("/html/result.jsp", "/result.jsp");
		url = StringUtils.encodeUrl(url);
		%>
		
		  <li style="width:132.8px; font-size:12px"><a href="<%=url%>" target="_blank"><img src="<%=promotion.getSplmst_picstr()%>"></a><br /><%=splmst_name%></li>
			<%if((i+1)%7!=0){%>
			<li style="width:1px"><img src="http://images.d1.com.cn/images2011/brand/01.gif"></li>
			<%}%>
	<%

}
if(list.size()%7!=0){
	for(int j=0;j<7-(list.size()%7);j++){%>
		<li style="width:133px;"></li>
	<%}
}
}
%>