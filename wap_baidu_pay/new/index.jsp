<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%>
<%
String backurl = request.getParameter("url");
	if(Tools.isNull(backurl)){
		backurl = request.getHeader("referer");
		if(Tools.isNull(backurl)){
			backurl = "/";
		}
	}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-新品速递</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<style>
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
	padding-left: 3px
}

ul {
	list-style: none;
}

img {
	border: none
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

#search {
	width: 120px;
	height: 19px;
	float: left
}

#search1 {
	width: 120px;
	height: 19px;
	float: left
}

.center {
	margin: 0px auto;
	width: 980px;
}

.sele {
	background: #ccc;
	color: #f00
}
</style>
</head>
<body>

	<!-- 头部开始 -->
	<%@include file="/wap/inc/head.jsp"%>
	<!-- 头部结束 -->

	<%
   
       String productsort="";
       if(request.getParameter("productsort")!=null)
       {
    	   productsort=request.getParameter("productsort").trim();
       }
    
	   ArrayList<Product> lall=new ArrayList<Product>();//商品集合
	   String rackcode="";
       int count=0;
       if(!Tools.isNull(productsort)&&productsort.length()>0)
       {
    	   rackcode=productsort;
       }
      
       String[] rackcodes=null;
       if(rackcode.length()>0)
       {
    	  
    	   if(rackcode.indexOf(",")>0)
    	   {
    		   rackcodes=rackcode.split(",");
    		   for(int i=0;i<rackcodes.length;i++)
    		   {
    			   ArrayList<Product> subl=ProductHelper.getProductListByRCode(rackcodes[i], 1000);
    			   if(subl!=null&&subl.size()>0)
    			   {
    				   lall.addAll(subl);
    			   }
    			   //count=count+ProductHelper.getPageTotal_rackcode(rackcodes[i]);
    		   }
    		  
    	   }
    	   else
    	   {
    		   ArrayList<Product> sl=ProductHelper.getProductListByRCode(rackcode, 1000);
    		
    			   lall=sl;

    	   }
       } 
       else
       {
    	   ArrayList<Product> sl=ProductHelper.getProductListByRCode(rackcode, 1000);
    	  
    		   lall=sl;
    	  
       }
	
       if(lall!=null)
       Collections.sort(lall,new com.d1.comp.SalesComparator());

       String ggURL = Tools.addOrUpdateParameter(request,null,null);
       if(ggURL != null) ggURL=ggURL.replaceAll("pageno=[0-9]*","");
       System.out.print(ggURL);
      //翻页
        int totalLength = (lall != null ?lall.size() : 0);
		
		int PAGE_SIZE = 10 ;
 	    int currentPage = 1 ;
 	    String pg ="1";
 	    if(request.getParameter("pageno")!=null)
 	    {
 	    	pg= request.getParameter("pageno");
 	    }
 	    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
 	    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
 	   
 	    int end = pBean.getStart()+PAGE_SIZE;
 	    if(end > totalLength) end = totalLength;
		
		//String pageURL = ggURL.replaceAll("pageno=[^&]*","");
		String pageURL = ggURL;
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    
	 	  int pagez=Tools.parseInt(pg);
	 	  if(pagez<=0)
		 	  {
		 	  	pagez=1;
		 	  }
	 	 String act=request.getParameter("act");
	 	 if("post".equals(request.getMethod().toLowerCase())&&"search1".equals(act))
	 	    {
	 	    	String keyword=request.getParameter("search");
	 	    	if(keyword!=null&&keyword.length()>0)
	 	    	{
	 	    		response.sendRedirect("/wap/search.jsp?headsearchkey="+URLEncoder.encode(keyword,"utf-8"));
	 	    	}
	 	    }
 	    if("post".equals(request.getMethod().toLowerCase())&&(act==null||!"search1".equals(act)))
 	    {
 	    	if(Tools.isNumber(request.getParameter("page")))
 	       {
 	    	   pagez=Tools.parseInt(request.getParameter("page"));
 	    	   
 	    	   if(pagez>pBean.getTotalPages())
 	    	   {
 	    		   pagez=pBean.getTotalPages();
 	    	   }
 	    	   
 	       }
 	       else
 	       {
 	    	   pagez=1;
 	       }
 	    	String newurl=pageURL.replaceAll("&page=[0-9]*","");
 	       response.sendRedirect(newurl+"pageno="+pagez);
 	    }
 	    
 	   
 	    
   %>
	<div>
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>>新品 <br />
		</div>
		<div>
			热搜新品：<a href="/wap/new/index.jsp?">全部</a>
		</div>
		<table>
			<tr>
				<td width="60"><A href="index.jsp?productsort=014001"
					<%if(rackcode.equals("014001")){%> class="sele" <%}%>>护肤品</A></td>
				<td width="50"><A href="index.jsp?productsort=014003"
					<%if(rackcode.equals("014003")){%> class="sele" <%}%>>彩妆</A></td>
				<td><A href="index.jsp?productsort=014002"
					<%if(rackcode.equals("014002")){%> class="sele" <%}%>>香水</A></td>
			</tr>
			<tr>
				<td><A href="index.jsp?productsort=020"
					<%if(rackcode.equals("020")){%> class="sele" <%}%>>女装</A></td>
				<td><A href="index.jsp?productsort=021"
					<%if(rackcode.equals("021")){%> class="sele" <%}%>>女鞋</A></td>
				<td><A href="index.jsp?productsort=023"
					<%if(rackcode.equals("023")){%> class="sele" <%}%>>女包</A></td>
			</tr>
			<tr>
				<td><A href="index.jsp?productsort=015009,015002014"
					<% if(rackcode.equals("015009")||rackcode.equals("015002014")){%>
					class="sele" <%}%>>饰品</A></td>
				<td><A href="index.jsp?productsort=030"
					<%if(rackcode.equals("030")){%> class="sele" <%}%>>男装</A></td>
				<td><A href="index.jsp?productsort=015002004"
					<%if(rackcode.equals("015002004")){%> class="sele" <%}%>>名表</A></td>
			</tr>
			<tr>
				<td><A href="index.jsp?productsort=033"
					<%if(rackcode.equals("033")){%> class="sele" <%}%>>皮具</A></td>
				<td><A href="index.jsp?productsort=014001018"
					<%if(rackcode.equals("014001018")){%> class="sele" <%}%>>男士护肤</A></td>
			</tr>
		</table>
		共有<span style="color: #F85F00;"><%= lall.size() %></span>件商品
		<% if(lall!=null&&lall.size()>0)
	           {
	        	    out.print("<table>");
	        	    int num=0;
	        	    int Page=1;
	        	    if(request.getParameter("pageno")!=null)
	        	    {
	        	    	Page=Tools.parseInt(request.getParameter("pageno"));
	        	    }
	        	    for(int i=((Page-1)*10);i<Page*10&&i<lall.size();i++)
	        	    {
	        	    	Product p=lall.get(i);
	        	    //}
	        	    //for(Product p:lall)
	        	    //{
	        	    	if(p==null)
	        	    	{
	        	    		continue;
	        	    	}
	        	    	num++;
	        	    	String gdsid=p.getId();
		    			
		    			String  theimgurl=p.getGdsmst_recimg();
			 			
			 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
			 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
			 			}else{
			 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
			 			}
			 			boolean	msflag= CartHelper.getmsflag(p);
			 			 
			   	           
				    			%>
		<tr>
			<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><%= Tools.clearHTML(p.getGdsmst_gdsname()) %></a></td>
		</tr>

		<tr>
			<td><a href="/wap/goods.jsp?productid=<%= p.getId() %>"><img
					src="<%= theimgurl %>" width="120" height="120" /></a></td>
		</tr>
		<tr>
			<td style="border-bottom: solid 1px #ccc;">
				<%
		    					if(msflag){
					   	        
		    				out.print("<font color='#f00'>秒杀价：￥"+p.getGdsmst_msprice().longValue()+"</font>");
		    				out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
						    }
		    			else
		    			{
		    			out.print("<font color='#f00'>会员价：￥"+p.getGdsmst_memberprice().longValue()+"</font>");
		    			}
		    			%>
			</td>
		</tr>

		<% }
	        	    if(pBean.getTotalPages()>=1)
	        	    {
	        	    	%>
		<tr>
			<td colspan="3"><a
				href="<%=pageURL%>pageno=<%= pBean.getCurrentPage()==1?1:pBean.getPreviousPage()%>">上一页</a>
				<a
				href="<%=pageURL%>pageno=<%= pBean.getCurrentPage()==pBean.getTotalPages()?pBean.getTotalPages():pBean.getNextPage()%>">下一页</a>
				<form id="pagess" action="<%=pageURL%>" method="post">
					<input type="text" id="page" name="page" style="width: 50px;"
						value="<%=pBean.getCurrentPage()%>" />/<%=pBean.getTotalPages() %>页
					<input type="submit" value="跳转" />
					<br />
					<a href="<%= backurl%>">返回上一页</a>
				</form></td>
		</tr>

		<%
	        	    }%>




		<%
	        	    out.print("</table>");
	           }	
	        	
	        %>

		<div style="background: #a52a2a; padding: 2px; margin-top: 2px;">
			<form id="search_1" method="post" action="index.jsp?act=search1">
				<input id="search" name="search" />
				<input type="submit" value="搜商品 " />

			</form>
		</div>
		<br />

	</div>

	<!-- 尾部开始 -->
	<%@include file="/wap/inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>
