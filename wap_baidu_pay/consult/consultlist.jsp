<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—商品咨询</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, hr, pre, form,
	fieldset, input, textarea, p, label, blockquote, th, td, button, span {
	padding: 0;
	margin: 0;
}

body {
	background: #fff;
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 21px;
	padding-left: 5px;
}

img {
	border: none;
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
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>>商品咨询 <br />
		</div>
		<% String goodsid="";
       if(request.getParameter("productid")!=null&&request.getParameter("productid").length()>0)
       {
    	   goodsid=request.getParameter("productid");
       }
       List<GoodsAsk> asklist=new ArrayList<GoodsAsk>();
       int pagecount=0;
       Product p=ProductHelper.getById(goodsid);
       if(p==null)
       {
    	   out.print("对不起，该商品不存在！");
       }
       else
       {
    	   int pageno=1;
    	   if(request.getParameter("pageno")!=null&&request.getParameter("pageno").length()>0)
    	   {
    		   pageno=Tools.parseInt(request.getParameter("pageno"));
    	   }
    	   asklist=GoodsAskHelper.getlistByProductId(goodsid, 0, 100);
    	   if(asklist!=null&&asklist.size()>0)
    	   {
    		   out.print("&nbsp;商品名称：<a href=\"/wap/goods.jsp?productid="+goodsid+"\">"+Tools.clearHTML(p.getGdsmst_gdsname())+"</a>");
    		   out.print("<br/>&nbsp;本商品咨询共"+asklist.size()+"条&nbsp;&nbsp;&nbsp;<a href=\"addconsult.jsp?productid="+goodsid+"\">我要咨询</a>");
               out.print("<table style=\"border-top:solid 1px #333;\">");
    		   for(int i=10*(pageno-1);i<pageno*10&&i<asklist.size();i++)
               {
    			   GoodsAsk ga=asklist.get(i);
            	   if(ga!=null)
            	   {%>
		<tr>
			<td style="text-align: right">用户：</td>
			<td>
				<%out.print(ga.getGdsask_uid()); %>
			</td>
			<td style="text-align: right"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(ga.getGdsask_createdate()) %></td>
		</tr>
		<tr>
			<td style="text-align: right">问题：</td>
			<td colspan="2"><%=Tools.clearHTML( ga.getGdsask_content()) %></td>
		</tr>
		<tr style="color: #f00; border-bottom: solid 1px #333;">
			<td>&nbsp;D1回复：</td>
			<td colspan="2"><%= ga.getGdsask_replyContent() %></td>
		</tr>
		<%}
               }
    		   out.print("</table>");  
    		   
    		   pagecount=asklist.size()%5>0?asklist.size()/5+1:asklist.size()/5;
    		   %><br />
		<form action="consultlist.jsp">
			<input type="hidden" name="productid" value="<%=goodsid%>" /> &nbsp;
			<a
				href="<%=request.getRequestURI()%>?productid=<%=goodsid %>&pageno=<%= pageno==pagecount?pageno:pageno+1%>">下页</a>
			<input type="text" style="width: 50px;" id="page" name="pageno"
				value="<%=pageno%>" />/<%=pagecount  %>
			<input type="submit" value="跳&nbsp;转" style="padding: 4px;" />
			<br />&nbsp;
			<a
				href="<%=request.getRequestURI()%>?productid=<%=goodsid %>&pageno=<%= pageno==1?pageno:pageno-1%>">返回上一页>></a>
			<br /> &nbsp;
			<a href="/wap/goods.jsp?productid=<%=goodsid %>">返回商品详情>></a>
		</form>
		<br />
		<%
    		 out.print("<br/>&nbsp;本商品咨询共"+asklist.size()+"条&nbsp;&nbsp;&nbsp;<a href=\"addconsult.jsp?productid="+goodsid+"\">我要咨询</a>");
             
  		   
    		}
    	   else
    	   {
    		   out.print("<br/>没有任何咨询的问题！<a href=\"/wap/goods.jsp?productid="+goodsid+"\">返回商品详情</a><br/>");
    	   }
       }
    %>

		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>&nbsp;&nbsp; <a href="">购物车</a>&nbsp;&nbsp;<br />
			<a href="/wap/login.jsp">登录</a>&nbsp;&nbsp;<a
				href="/wap/emailregist.jsp">注册</a>&nbsp;&nbsp;<a
				href="/wap/html/help.jsp">帮助</a> <br />
		</div>
	</div>


</body>
</html>

