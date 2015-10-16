<%@ page contentType="text/html; charset=UTF-8"%><%@page import="
java.text.*,
java.util.Date,
com.d1.util.Tools" %>
<%
Date d = null;
	Date dnow =new Date();
	DateFormat df2 = new SimpleDateFormat("MMdd");
	try {
		int week=dnow.getDay();
		if (week==0){
			week=-6;
		}
		else{
			week=-1*week+1;
		}
		
	d = Tools.addDate(dnow ,week);
	} catch (ParseException e) {
		e.printStackTrace();
	}
	String mdstr=df2.format(d);
response.sendRedirect("http://m.d1.cn/intf/lianmengwap.jsp?id=d1_1111&subad=sp"+mdstr+"&url=http://m.d1.cn"); %>
