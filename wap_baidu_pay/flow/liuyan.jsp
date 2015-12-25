<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%
    String ticketid = request.getParameter("ticketid");//优惠券ID
    String addressid = request.getParameter("addressid");//用户选择的地址ID
    String prepay=request.getParameter("prepay");//预付款
    String liuyan=request.getParameter("liuyan");//订单留言
    
    String url="ticketid="+ticketid+"&prepay="+prepay+"&addressid="+addressid+"&liuyan="+liuyan;
	String msg="";
	if ("post".equals(request.getMethod().toLowerCase())) {
		if(!Tools.isNull(request.getParameter("liuyan"))){
			liuyan=URLEncoder.encode(request.getParameter("liuyan"),"utf-8");
			url="ticketid="+ticketid+"&prepay="+prepay+"&addressid="+addressid+"&liuyan="+liuyan;
		response.sendRedirect("/wap/flowCheck1.jsp?"+url);
		}else{
			msg="请填写留言内容！";
		}
	}
	if(Tools.isNull(liuyan) || "null".equals(liuyan.toLowerCase())){
		liuyan="";
	}
	liuyan=URLDecoder.decode(liuyan,"utf-8");
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-订单留言</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			订单留言 <br />

		</div>
		<span style="color: red;"><%=msg %></span>
		<form action="liuyan.jsp" method="post">
			<input name="ticketid" type="hidden" value="<%=ticketid%>"></input>
			<input name="addressid" type="hidden" value="<%=addressid%>"></input>
			<input name="prepay" type="hidden" value="<%=prepay%>"></input>
			<table>
				<tr>
					<td style="width: 98%;"><textarea name="liuyan"
							id="txtCustomerMemo" rows="5" style="width: 95%;"><%=liuyan %></textarea>
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="确定"></input></td>
				</tr>
				<tr>
					<td><a href="/wap/flowCheck1.jsp?<%=url %>">&lt;&lt;返回上一级</a></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

