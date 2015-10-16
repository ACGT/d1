<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%
String showid=request.getParameter("showid");
if(Tools.isNull(showid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
	}
if(!Tools.isNumber(showid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}
MyShow show=(MyShow)Tools.getManager(MyShow.class).get(showid);
if(show==null){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}
String imgurl="http://images1.d1.com.cn";
if(show.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
	imgurl="http://d1.com.cn";
}
StringBuilder sb=new StringBuilder();
Map<String,Object> map = new HashMap<String,Object>();
map.put("succ",new Boolean(true));
sb.append("<a href=\"").append(imgurl).append(show.getMyshow_img400500()).append("\"  target=\"_blank\">");
//sb.append("<img width=\"400\"  src=\"http://d1.com.cn").append(show.getMyshow_img120150()).append("\"").append(" border=\"0\">");
sb.append("<img width=\"400\"  src=\"").append(imgurl).append(show.getMyshow_img120150()).append("\"").append(" border=\"0\" onmouseover=\"sdimg_over2('").append( show.getId()).append("')\" onmouseout=\"sdimg_out('").append( show.getId()).append("')\">");
sb.append("</img></a>");
map.put("message", sb.toString());
out.print(JSONObject.fromObject(map));

%>