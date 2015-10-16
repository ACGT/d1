<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!


//获取tag
private static String getTag(String code,String flag)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	StringBuilder sb1 = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		sb.append("<ul class=\"tabAuto").append(flag).append("\">");
		sb1.append("<div class=\"tgh-box").append(flag).append("\">");
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
 		String title = recommend.getSplmst_name();
 		sb.append("<li>").append(title).append("</li>");
 		sb1.append("<div><a href=").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("").append(title).append(" target=_blank>").append("<img src=").append(recommend.getSplmst_picstr()).append(" width=980 height=500  />").append("</a></div>");
 		
		}
		sb.append("</ul>");
		sb1.append("</div>");
	}
	return sb.append(sb1.toString()).toString();


}

%>
<% Map<String,Object> map = new HashMap<String,Object>();
map.put("message","<div id=\"tabAuto\">"+getTag("2951","")+"</div><div id=\"tabAuto1\">"+ getTag("2952","1")+"</div><div id=\"tabAuto2\">"+ getTag("2953","2")+"</div><div id=\"tabAuto3\">"+ getTag("3021","3")+"</div>");
map.put("success" , new Boolean(true));
out.print(JSONObject.fromObject(map));
%>
