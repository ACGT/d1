<%@ page contentType="text/html; charset=UTF-8"%><%@include file="inc/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>D1优尚网</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>

<body bgcolor="#FFFFFF" >
<%  String area="";
    if(request.getParameter("area")!=null&&request.getParameter("area").length()>0&&Tools.isNumber(request.getParameter("area"))&&Tools.parseInt(request.getParameter("area"))<=2
    		&&Tools.parseInt(request.getParameter("area"))>0)
    {
    	area=request.getParameter("area");
    }
    if(area.equals("0"))
    {
    	session.setAttribute("flaghead", null);
    }
    else
    {
        session.setAttribute("flaghead", area);
    }
    response.sendRedirect("http://www.d1.com.cn/");
 %>



</body>
</html>