<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——商品评价</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />

</head>
<body>
	<%!
      int getpagecount(int totalcount,int pagesize){
    	 int pagecount=totalcount/pagesize;
    	 if(totalcount%pagesize!=0){
    		 pagecount=totalcount/pagesize+1;
    	 }
    	 return pagecount;
     }
String getlevel(int score){
	 String value = "";
     switch (score)
     {
         case 5:
             value = "非常喜欢";
             break;
         case 4:
             value = "很喜欢";
             break;
         case 3:
             value = "还不错";
             break;
         case 2:
             value = "一般";
             break;
         case 1:
             value = "不喜欢";
             break;

     }
     return value;
}
%>
	<!--头部-->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束-->
	<!-- 中间内容 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的评论 <br />
		</div>
		<div style="padding: 5px;">
			<a href="comment1.jsp">待评价</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
				href="comment1.jsp?type=1">已评价</a>
			<%
     if(Tools.isNull(request.getParameter("type"))) {//待评价
    	 ArrayList<OrderBase> nocommentlist=OrderHelper.getMyFinishOrderList(lUser.getId()) ;
			if(nocommentlist!=null && nocommentlist.size()>0){
				 int currentPageIndex=1;
				 int pagesize=8;
				 int totalcount=nocommentlist.size();
				 if(!Tools.isNull(request.getParameter("pageno"))){
						currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
					}
				  int pagecount=getpagecount(totalcount,pagesize);
				  PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
					 int end = pBean.getStart()+pagesize;
				 	    if(end > totalcount) end = totalcount;
				 	   List<OrderBase> nocommentlist2=nocommentlist.subList(pBean.getStart(), end);
				
						
						%>
			<table border="0" cellspacing="1" cellpadding="0" class="t">
				<tr>
					<td class="d1">订单号</td>
					<td class="d1">操作</td>
				</tr>
				<%for(OrderBase base:nocommentlist2){
					%>
				<tr>
					<td><a
						href="/wap/user/orderdetail.jsp?orderid=<%=base.getId() %>"><%=base.getId() %></a></td>
					<td><a
						href="/wap/comment/addcomment1.jsp?orderid=<%=base.getId() %>">确认收货并评价</a></td>
				</tr>

				<%} %>

			</table>
			<div class="Pager">
				共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b>
				页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b>
				页&nbsp;&nbsp;&nbsp;&nbsp;
				<%if (currentPageIndex!=0) {%>
				<a class="curr" href="comment1.jsp?pageno=1">首页</a>
				<%}
              if (currentPageIndex>1 ){%>
				<a href="comment1.jsp?pageno=<%=currentPageIndex-1%>"><font
					color="#666666">上一页</font></a> &nbsp;&nbsp;
				<%
		  }
          	for(int j=pBean.getStartPage();j<=pBean.getEndPage()&&j<=pBean.getTotalPages();j++){
           		if(j==currentPageIndex){
           		%><span class="curr"><%=j %></span>
				<%
           		}else{
           		%>
				<a class="curr" href="comment1.jsp?pageno=<%=j%>"><%=j %></a>
				<%
           		}
           	}
          if (currentPageIndex<pagecount ){%>

				<a href="comment1.jsp?pageno=<%=currentPageIndex+1%>">下一页</a>

				<%}%>
				<a href="comment1.jsp?pageno=<%=pagecount%>">尾页</a>

			</div>
			<%} else{%>
			<br /> <font color='#f00'>您目前没有待评价的订单！</font><br /> <a
				href="/wap/user">返回我的优尚</a>
			<%} }else{
	  
	   List<Comment> list1=CommentHelper.getMyCommentList(new Long(lUser.getId()));
		  // List<CommentCache> list2=CommentHelper.getMyCacheCommentList(new Long(lUser.getId()));
		  
		   if((list1!=null && list1.size()>0)){
			   int replaycount=0;
			    int currentPageIndex=1;
				 int pagesize=2;
				 int totalcount=0;
				
				 if(!Tools.isNull(request.getParameter("pageno2"))){
					// out.print(">>>>>>>>>>>>>>>>>>>>>>>>");
						currentPageIndex=Integer.valueOf(request.getParameter("pageno2")).intValue();
					}
				// out.print(currentPageIndex);
			     if(list1!=null){
			    	totalcount+=list1.size();
			     }
			     //if(list2!=null){
			    	// totalcount+=list2.size(); 
			    	 //cachecount+=list2.size(); 
			    // }
			     int pagecount=getpagecount(totalcount,pagesize);
				
				 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
				 int end = pBean.getStart()+pagesize;
			 	    if(end > totalcount) end = totalcount;
			 	 
			 	  List<Comment> list =list1.subList(pBean.getStart(),end);
			 	 
			 	   if(list!=null && list.size()>0){
			   %>
			<table>

				<% 
			   for(Comment cache:list){
				   int i=0;
		 			  Product product= ProductHelper.getById(cache.getGdscom_gdsid());
		 			  String url="";
						
						 if(product!=null){
							 url="/wap/goods.jsp?productid="+product.getId();
						 }
						 int score=cache.getGdscom_level().intValue();
						
						
							%>
				<tr>
					<td style="color: #a25663;">订单号</td>
					<td><a
						href="/wap/orderdetail.jsp?orderid=<%=cache.getGdscom_odrid() %>"><%=cache.getGdscom_odrid() %></a></td>
				</tr>

				<tr>
					<td style="color: #a25663;">商品信息</td>

					<td><span class="sptitle" style="display: block;"><a
							href="<%=url %>"><%=cache.getGdscom_gdsname() %></a></span></td>
				</tr>
				<tr>
					<td style="color: #a25663;">我的评分</td>
					<td><font color="red"><%=score %>分</font></td>
				</tr>
				<tr>
					<td style="color: #a25663;">评价内容</td>
					<td style="text-align: left; padding: 3px;"><%=cache.getGdscom_content()%>
						<br /> <%
	    if(cache.getGdscom_replyStatus().intValue()==1 || !Tools.isNull(cache.getGdscom_replyContent())){
	    	%>
						<p style="color: #892D3D; line-height: 26px;">
							D1优尚回复:<%=cache.getGdscom_replyContent() %></p> <%}%></td>
				</tr>
				<tr>
					<td style="color: #a25663;">评价时间</td>
					<td><%=Tools.stockFormatDate(cache.getGdscom_createdate()) %></td>
				</tr>
				<% i++; }
		 	  %>
				<tr>
					<td colspan="2">
						<div class="Pager">
							共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b>
							页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b>
							页&nbsp;&nbsp;&nbsp;&nbsp;
							<%if (currentPageIndex!=0) {%>
							<a class="curr" href="comment1.jsp?pageno2=1&type=1">首页</a>
							<%}
              if (currentPageIndex>1 ){%>
							<a href="comment1.jsp?pageno2=<%=currentPageIndex-1%>&type=1"><font
								color="#666666">上一页</font></a> &nbsp;&nbsp;
							<%
		  }
          	for(int j=pBean.getStartPage();j<=pBean.getEndPage()&&j<=pBean.getTotalPages();j++){
           		if(j==currentPageIndex){
           		%><span class="curr"><%=j %></span>
							<%
           		}else{
           		%>
							<a class="curr" href="comment1.jsp?pageno2=<%=j%>&type=1"><%=j %></a>
							<%
           		}
           	}
          if (currentPageIndex<pagecount ){%>

							<a href="comment1.jsp?pageno2=<%=currentPageIndex+1%>&type=1">下一页</a>

							<%}%>
							<a href="comment1.jsp?pageno2<%=pagecount%>&type=1">尾页</a>

						</div>

					</td>
				</tr>
			</table>
			<%}} }%>
		</div>
	</div>

	<div class="clear"></div>
	<!--中间内容结束-->
	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

