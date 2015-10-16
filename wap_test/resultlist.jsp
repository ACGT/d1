<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.comp.*,com.d1.manager.*"%><%@include
	file="/inc/header.jsp"%>
<%
request.setCharacterEncoding("GBK");

String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}

String productsort = request.getParameter("productsort");
String ps123 ="";
String parentId="000";
if(!Tools.isNull(productsort)){
	productsort = productsort.trim();
	productsort = Tools.simpleCharReplace(productsort);
	ps123= productsort;
	//如果传了多个分类，只取第一个，原来有传多个分类的链接
	if(ps123.indexOf(",")>-1){
		ps123 = ps123.substring(0,ps123.indexOf(","));
	}
	Directory dir = DirectoryHelper.getById(ps123);
	if(dir == null){
		response.sendRedirect("/mindex.jsp");
		return;
	}
}else{
	response.sendRedirect("/mindex.jsp");
	return;
}

int pages=1;
if(request.getParameter("page")!=null&&request.getParameter("page").length()>0&&Tools.isNumber(request.getParameter("page")))
{
   pages=Tools.parseInt(request.getParameter("page"));	
}
if(pages<=0)
{
	pages=1;
}

if("post".equals(request.getMethod().toLowerCase()) && "r".equals(request.getParameter("act")))
{
   if(Tools.isNumber(request.getParameter("pages")))
   {
	   pages=Tools.parseInt(request.getParameter("pages"));
   }
   else
   {
	   pages=1;
   }
   response.sendRedirect(request.getRequestURI()+"?productsort="+ps123+"&page="+pages);
}


%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
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
	line-height: 18px;
	padding-left: 4px;
	width: 100%
}

ul {
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

.sa0, .sa1, .sa2, .sa3, .sa4, .sa5, .sa6, .sa7, .sa8, .sa9, .sa10 {
	width: 100px;
	height: 18px;
	background-image:
		url(http://images.d1.com.cn/images2011/commentimg/star.gif);
	background-repeat: no-repeat;
	overflow: hidden;
}

.sa0 {
	background-position: 0px 0px;
}

.sa1 {
	background-position: 0px -119px;
} /*半颗*/
.sa2 {
	background-position: 0px -21px;
}

.sa3 {
	background-position: 0px -139px;
}

.sa4 {
	background-position: 0px -40px;
}

.sa5 {
	background-position: 0px -160px;
}

.sa6 {
	background-position: 0px -58px;
}

.sa7 {
	background-position: 0px -182px;
}

.sa8 {
	background-position: 0px -77px;
}

.sa9 {
	background-position: 0 -204px;
}

.sa10 {
	background-position: 0px -97px;
}
</style>
</head>

<body>
	<%@include file="/wap/inc/head.jsp"%>
	<div class="all">
		<table>
			<%
				int count=0;
				List<Product> pList = ((ProductManager)Tools.getManager(Product.class)).getProductListByRackcode(ps123);
				List<Product> pList1=new ArrayList<Product>();
				if(pList!=null&&pList.size()>0)
				{
					for(Product p:pList)
					{
						if(p!=null&&p.getGdsmst_validflag().longValue()!=2&&p.getGdsmst_validflag().longValue()!=4)
						{
							pList1.add(p);
						}
					}
					if(pages*10>=pList1.size())
					{
						if(pList1.size()%10>0)
						{
							pages=pList1.size()/10+1;
						}
						else
						{
							pages=pList1.size()/10;
						}
					}
				}
					if(pList1!=null&&pList1.size()>0)
					{
						for(int i=10*(pages-1);i<10*pages&&i<pList1.size();i++)
						{
							Product p=pList1.get(i);
								count++;
								long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
				    			long currentTime = System.currentTimeMillis();
				    			int score = CommentHelper.getLevelView(p.getId());
				    			int comcount=CommentHelper.getCommentLength(p.getId());
				    			String theimgurl=p.getGdsmst_recimg();
				    			 if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
				    				 theimgurl = "http://images1.d1.com.cn"+theimgurl;
				    					}else{
				    						theimgurl = "http://images.d1.com.cn"+theimgurl;
				    					}
							%>
			<tr>
				<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><%= Tools.clearHTML(p.getGdsmst_gdsname()) %></a></td>
			</tr>
			<tr>
				<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><img
						src="<%=theimgurl %>" width="120" height="120" /></a></td>
			</tr>

			<tr>
				<td>
					<%
				    			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
				    				out.print("<font color='#f00'>秒杀价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
				    				out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_oldmemberprice().longValue()+"</font>");
								    }
				    			else
				    			{
				    			out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
				    			}
				    			%>
				</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #ccc;"><span
					style="float: left;">顾客评分：</span><span class="sa<%=score %>"
					style="float: left;"></span>(已有<a
					href="/wap/comment/commentlist.jsp?productid=<%= p.getId() %>"><%= comcount%></a>人评价)</td>
			</tr>
			<%
						
					      }
					}
				
				
				%>
			<%  
		if(count>0)
		{%><tr>
				<td><a
					href="<%=request.getRequestURI() %>?productsort=<%=ps123%>&page=<%=pages-1 %>">上一页</a>
					<a
					href="<%=request.getRequestURI() %>?productsort=<%=ps123%>&page=<%=pages+1 %>">下一页</a>
					<form
						action="<%=request.getRequestURI() %>?productsort=<%=ps123%>&act=r"
						method="post">
						<input type="text" id="pages" name="pages" style="width: 50px;"
							value="<%= pages%>" />/<%= pList1.size()%10>0?pList1.size()/10+1:pList1.size()/10 %>页
						<input type="submit" value="跳转" />
					</form> <br />
				<a href="<%= backurl %>">返回上一页</a></td>
			</tr>

			<%}
			%>
		</table>
	</div>

	</div>

	<!-- 尾部 -->
	<%@ include file="/wap/inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>