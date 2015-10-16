<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,
net.sf.json.JSONObject"%><%@include file="/inc/header.jsp"%>
<%
JSONObject json = new JSONObject();
if(lUser==null){
	json.put("status", "-1");
	out.print(json);
	return;
}
if(!Tools.isNull(request.getParameter("odrid"))){
	String orderid=request.getParameter("odrid").trim();
	if(orderid.length()!=12){
		json.put("status", "0");
		out.print(json);
		return;
	}
	//判断订单是否属于改用户
	OrderBase base=OrderHelper.getById(orderid);
	 if(base==null){
		 json.put("status", "0");
			out.print(json);
			return;
	 }
	 
	  if(!lUser.getId().equals(String.valueOf(base.getOdrmst_mbrid()))){
		  json.put("status", "-2");
			out.print(json);
			return;
	 }
	 
		 int status= base.getOdrmst_orderstatus().intValue();
		
		 if(status == 3 || status == 31){
		  if(status==3){
			  status=5;
		  }else if(status==31){
			  status=51;
		  }
		 base.setOdrmst_orderstatus(new Long(status));
		base.setOdrmst_finishdate(new Date());
		 Tools.getManager(base.getClass()).clearListCache(base);
		 if(!Tools.getManager(base.getClass()).update(base, true)){
			 json.put("status", "-3");
				out.print(json);
				return;
		 }else{
			 json.put("status", "1");
			 json.put("message", "确认收货成功！");
				out.print(json);
				return;
  }
}else{
	 json.put("status", "-3");
		out.print(json);
		return;
}
}
%>