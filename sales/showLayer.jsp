<%@ page contentType="text/html; charset=UTF-8"%>
<%
	/**
	 * 显视商品浮层t="top,left,http://www.****.gif",x="****<BR>****"
	 *showLayer(String t,String x)
	 */
if(request.getAttribute("t")!=null && request.getAttribute("x")!=null){
	String t=request.getAttribute("t").toString();
	String x=request.getAttribute("x").toString();
	if(t.contains(",")){
		
		String[] strlist=t.split("\\,");
		if(strlist.length>=3){
			%>
			<div style="width:90px;height:90px;position:absolute;<%=strlist[0]%>:0;<%=strlist[1]%>:0;background-image:url('<%=strlist[2]%>');">
			<div style="z-index:20;width:90px;height:90px;position:absolute;padding-top:30px;left:0;color:#ffffff;font-size:16;text-align:center;font-weight:600;text-decoration:none;">
			<%=x%>
			</div></div>

		<%}
}
}
%>