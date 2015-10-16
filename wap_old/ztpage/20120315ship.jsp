<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/wap/ztpage/public.jsp"%>
<%
request.setCharacterEncoding("GBK");
int pages=1;
int pagesize=10;
if(request.getParameter("page")!=null&&request.getParameter("page").length()>0&&Tools.isNumber(request.getParameter("page")))
{
   pages=Tools.parseInt(request.getParameter("page"));	
}
if(pages<=0)
{
	pages=1;
}
int count=0;
count=GetCount("7022");
count=count%pagesize>0?count/pagesize+1:count/pagesize;
if("post".equals(request.getMethod().toLowerCase()) && "r".equals(request.getParameter("act")))
{
	
   if(Tools.isNumber(request.getParameter("pages")))
   {
	   pages=Tools.parseInt(request.getParameter("pages"));
	   
	   if(pages>count)
	   {
		   pages=count;
	   }
	   
   }
   else
   {
	   pages=1;
   }
   response.sendRedirect(request.getRequestURI()+"?page="+pages);
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>YOUSOO春季新品上市，小鱼公主项链戒指手链套装仅售139元！-D1优尚网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<style type="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;font:14px Arial,"微软雅黑";color:#4b4b4b; padding-bottom:15px; line-height:18px; padding-left:4px; }
ol,ul{list-style:none;}
a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}
img{ border:none;}
.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
.newli{ padding-left:8px;}
</style>
</head>

<body>
<%@include file="/wap/inc/head.jsp" %>
<div class="all">
     <div class="box">
			<% String result=GetZtList("7022",pages,pagesize);
			   out.print(result);
			   if(result.length()>0)
			   {%>
				  <a href="<%=request.getRequestURI() %>?page=<%=pages-1 %>">上一页</a> 
				  <a href="<%=request.getRequestURI() %>?page=<%=pages+1 %>">下一页</a>  
				  <form action="<%=request.getRequestURI() %>?act=r" method="post">
				  <input type="text" id="pages" name="pages" style="width:50px;"/>/<%= count %>页<input type="submit" value="跳转"/>
				  </form>	
			   <%}
			 %>
	
	</div>
			
</div>


</body>
</html>