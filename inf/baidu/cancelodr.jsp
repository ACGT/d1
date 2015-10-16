<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="public.jsp"%>
<%
String reqodr=request.getQueryString();
JSONObject json = JSONObject.fromObject(reqodr);
String retheader=json.getString("header");
if(retheader!=null&&retheader.equals("")){
	String odrbody=json.getString("body");
	JSONObject jsonbody = JSONObject.fromObject(odrbody);
	String package_id=jsonbody.getString("package_id");
	long status=0;
	if(!Tools.isNull(odrbody)){
		OrderBase odr=OrderHelper.getById(package_id);
		long printflag=odr.getOdrmst_printflag().longValue();
		if (printflag>0){
			status=2;
		}else{
			
		}
		String strheader=getHeader();
		StringBuilder sb=new StringBuilder();
		sb.append("\"header\":{");
		sb.append("\"status\": "+status+"");  //0:成功取消  1: 微购显示该包裹单状态为取消确认中, 2: 包裹单不能被取消 3:商家内部api错误
		sb.append("},");
		sb.append("\"body\":{}}");
	}
}
%>