<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
//判断接收值是否验证通过
 String check(HttpServletRequest request, HttpServletResponse response){
	 String start="";
	 String end="";

    	if(!"4599".equals(request.getParameter("cid"))&&!"325".equals(request.getParameter("cid"))){
    		return "活动ID错误!";
    	}
    
    String time= request.getParameter("d").trim();
    if(time.length()!=8 && time.length()!=10){
    	return "参数d格式错误!";
    }
     return "true";

} 
%><%
StringBuffer str=new StringBuffer();
String msg=check(request,response);
if(msg=="true"){
	//out.print("验证通过");
	String time= request.getParameter("d").trim();
	String end="";
	String start="";
	if(time.length()==8){//年月日形式
		start = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8) + " 00:00:00";
	    end = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8) + " 23:59:59";
	}else if(time.length()==10){//年月日时形式
		start = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8)+" "+time.substring(8, 10)+ ":00:00";
	    end = time.substring(0, 4) + "-" + time.substring(4, 6) + "-" + time.substring(6, 8)+" "+time.substring(8, 10)+ ":59:59";
	}
	//String strcid="";
	/**
	if("325".equals(request.getParameter("cid"))){
		strcid="325";
	}else{
		strcid="4599";
	}**/
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ArrayList<OrderBase> orderlist=OrderHelper.getOrderList("eqifa", format.parse(start), format.parse(end));
	//out.println(format.parse(start));
	//out.println(format.parse(end));
	
	//out.println(new Date());
	if(orderlist!=null){
		str.append( "<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		 str.append("<orders>");
	  for(OrderBase base:orderlist){
		  String userid="";
		 
		  String temp=base.getOdrmst_temp();
		  int  i="4599yiqifa".length();
		  int j=temp.indexOf("|");
		  String wi=temp.substring(i,j);

		  str.append("<order>");
		  str.append("<wi>");
		  str.append(wi);
		  str.append("</wi>");
		  str.append("<order_no>");
		  str.append(base.getId());
		  str.append("</order_no>");
		  str.append("<order_status>");
		  str.append(base.getOdrmst_orderstatus());
		  str.append("</order_status>");
		  str.append("<update_date>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</update_date>");
		  str.append("<start_date>");
		  str.append(Tools.stockFormatDate(base.getOdrmst_orderdate()));
		  str.append("</start_date>");
		  str.append("<payment_status>");
		  str.append(base.getOdrmst_orderstatus());
		  str.append("</payment_status>");
		  str.append("<payment_type>");
		  str.append(base.getOdrmst_paymethod());
		  str.append("</payment_type>");
		  str.append("<fare>");
		  str.append(Tools.getDouble( base.getOdrmst_shipfee(), 2));
		  str.append("</fare>");
		  str.append("<favorable>");
		  str.append(Tools.getDouble(base.getOdrmst_tktvalue(),2));
		  str.append("</favorable>");
		 
		  str.append("</order>"); 
	  }
		  str.append("</orders>"); 
	}
	
   }else{
	str.append(msg);
}
out.println(str.toString());
%>