<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%>
<%  
	String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
	backurl=backurl.replace("#", "");
	
	String id="";
	if(!Tools.isNull(request.getParameter("id")))
	{
		id=request.getParameter("id").trim();
		
	}
	
	String addressid="";
	if(!Tools.isNull(request.getParameter("addressid")))
	{
		addressid=request.getParameter("addressid").trim();
	}
	   String ticketid = request.getParameter("ticketid");//优惠券ID
	    String prepay=request.getParameter("prepay");//预付款
	    String liuyan=request.getParameter("liuyan");//订单留言
	    String from=request.getParameter("from");
	    String url="addressid="+addressid;
	    if(!Tools.isNull(ticketid) && ! "null".equals(ticketid)){
	    	url+="&ticketid="+ticketid;
	    }
	    if(!Tools.isNull(prepay) && ! "null".equals(prepay)){
	    	url+="&prepay="+prepay;
	    }
	    if(!Tools.isNull(liuyan) && ! "null".equals(liuyan)){
	    	url+="&liuyan="+liuyan;
	    }
	    if(!Tools.isNull(from) && ! "null".equals(from)){
	    	url+="&from="+from;
	    }
	   
	    String title="修改收货地址";
	    boolean isadd=false;
	    String op="";
	    if(!Tools.isNull(request.getParameter("op"))){
	    	op="add";
	    	title="新增收货地址";
	    	isadd=true;
	    }
	    
	    String errormsg="";
	    if("post".equals(request.getMethod().toLowerCase())){
	    	if(!Tools.isNull(request.getParameter("ddlProvince")) && !"0".equals(request.getParameter("ddlProvince")))
	    	{
	    		response.sendRedirect("addresscity.jsp?"+url+"&hideAddressId="+addressid+"&hideOldProid="+id+"&hideProvId="+request.getParameter("ddlProvince")+"&op="+op);
	    		//request.getRequestDispatcher("addresscity.jsp").forward(request, response); 
	    	}else{
	    		errormsg="请选择省/直辖市";
	    	}
	    }
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—<%=title %></title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
	padding-left: 4px;
}

ol, ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

.top {
	margin-top: 3px;
}

.top ul li {
	float: left;
	border-bottom: solid 1px #000;
}

.top ul li a {
	color: #000;
}

.top ul li a:hover {
	color: #aa2e44;
}

.newli {
	padding-left: 8px;
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">

		<% if(id.equals("") && !isadd)
     {
    	 out.print("该收货地址不存在，请返回<a href=\"/wap/user/address.jsp\">我的地址簿</a>");
     }
     else
     {
     %>

		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>><a
				href="address.jsp">收货地址簿</a>><%=title %>
			<br />
		</div>
		<div id="first" style="margin-top: 2px; line-height: 18px;">
			<form action="addressprovince.jsp" method="post">
				<input id="hideAddressId" name="hideAddressId" type="hidden"
					value="<%=addressid %>" />

				<input id="op" name="op" type="hidden" value="<%=op %>" />
				<input id="from" name="from" type="hidden" value="<%=from %>" />
				<input id="addressid" name="addressid" type="hidden"
					value="<%=addressid %>" />
				<input id="ticketid" name="ticketid" type="hidden"
					value="<%=ticketid %>" />
				<input id="prepay" name="prepay" type="hidden" value="<%=prepay %>" />
				<input id="liuyan" name="liuyan" type="hidden" value="<%=liuyan %>" />
				<input id="hideOldProid" name="hideOldProid" type="hidden"
					value="<%=id %>" />
				<span style="color: red;"><%=errormsg %></span>
				<br /> 第1步/共3步
				<br />
				<span id="provtip" style="color: red; display: none;"></span> &nbsp;
				<font color='red'>*</font>&nbsp;省/直辖市
				<select id="ddlProvince" name="ddlProvince">
					<option value="0">请选择</option>
					<%
			
			List list = ProvinceHelper.getAllProvince();
			if(list != null && !list.isEmpty()){
				for(int i=0;i<list.size();i++){
					Province pro = (Province)list.get(i);
					
					
					%>
					<option value="<%=pro.getId()%>" <%if(id.equals(pro.getId())){ %>
						selected="selected" <%} %>><%=pro.getPrvmst_name()%></option>
					<%}
			}
			%>
				</select>
				<br />

				<input type="submit" value="下一步" style="width: 65px; padding: 4px;" />&nbsp;&nbsp;
				<a href="<%=backurl %>" style="text-decoration: underline">返回上一步</a>
			</form>
		</div>



		<%}%>

		<div id="info"
			style="margin-top: 2px; line-height: 18px; display: none;"></div>

	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>


