<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%!
static String getUid(String str){
	if(str==null)str="";
	String x = "***"+StringUtils.getCnSubstring(str,0,6);
	x=x.replaceAll("调单", "ddan");
	return x;
}


%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-商品评论详情页</title>
<style>
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,hr,pre,form,fieldset,input,textarea,p,label,blockquote,th,td,button,span{padding:0;margin:0;}
body{ background:#fff;color:#4b4b4b; padding-bottom:15px; line-height:21px;  padding-left:5px;}
table{border-collapse:collapse;}
fieldset,img{border:none;}
address,caption,cite,code,dfn,th,var,em{font-weight:normal;}
ul{list-style:none; padding:0px;}


a {text-decoration:none;color:#4169E1}
a:hover {color:#aa2e44}
.clear {clear:both;font-size:1px;line-height:0;height:0px;*zoom:1;}

.top{ margin-top:3px; }
.top ul li{float:left;border-bottom:solid 1px #000;  }
.top ul li a{ color:#000;}
.top ul li a:hover{ color:#aa2e44;}
#search{ width:120px; height:19px; float:left}
#search1{ width:120px; height:19px; float:left}
.sa0,.sa1,.sa2,.sa3,.sa4,.sa5,.sa6,.sa7,.sa8,.sa9,.sa10{width:100px;height:18px;margin-top:2px;background-image:url(http://images.d1.com.cn/images2011/commentimg/star.gif);background-repeat:no-repeat;overflow:hidden; margin-top:5px; }
.sa0{background-position:0px 0px;}
.sa1{background-position:0px -119px;}/*半颗*/
.sa2{background-position:0px -21px;}
.sa3{background-position:0px -139px;}
.sa4{background-position:0px -40px;}
.sa5{background-position:0px -160px;}
.sa6{background-position:0px -58px;}
.sa7{background-position:0px -182px;}
.sa8{background-position:0px -77px;}
.sa9{background-position:0 -204px;}
.sa10{background-position:0px -97px;}
</style>

</head>
<body>
<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
<%

String act=request.getParameter("act");
if("post".equals(request.getMethod().toLowerCase())&&"search1".equals(act))
{
	String keyword=request.getParameter("search");
	if(keyword!=null&&keyword.length()>0)
	{
		response.sendRedirect("/wap/search.jsp?headsearchkey="+URLEncoder.encode(keyword,"utf-8"));
	}
}

String id="";
if(request.getParameter("productid")!=null&&request.getParameter("productid").length()>0)
{
 id= request.getParameter("productid");
}

Product product = ProductHelper.getById(id);
if(product == null){
	out.print("<br/>商品不存在！");
	return;
}
String skuname1=product.getGdsmst_skuname1();
//评论
int contentcount = CommentHelper.getCommentLength(id);
//显示星级
int score = CommentHelper.getLevelView(id);
%>
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="/wap/user/myorder.jsp">我的订单</a>>评价商品
    <br/>
    </div>
    <div style="background:#f00; color:#fff;">&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"  style="color:#fff;"><b>简介</b></a>&nbsp;|&nbsp;<a href="/wap/imglist.jsp?productid=<%= id %>" style="color:#fff;"><b>图片</b></a>&nbsp;|&nbsp;
     <a href="/wap/goods.jsp?productid=<%= id %>" style="color:#fff;"><b>详情</b></a>&nbsp;|&nbsp;<a href="/wap/comment/commentlist.jsp?productid=<%= id%>" style="color:#fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)</b></a>&nbsp;</div>
    
      <table>
     <tr><td>&nbsp;<b><%= product.getGdsmst_gdsname() %></b></td></tr>
     <tr><td>&nbsp;品牌：[<%= product.getGdsmst_brandname() %>]</td></tr>
     <tr><td>&nbsp;商品编码：<%= product.getId() %></td></tr>
    <tr><td style=" border-bottom:solid 1px #333;"><span style="float:left;">&nbsp;顾客评分：</span><span class="sa<%=score %>" style="float:left;" ></span></td></tr>
  
     </table>
     <%
     int currentPageIndex=1;
	 int pagesize=5;
	 int totalcount=CommentHelper.getCommentLength(id);
	 int pagecount=totalcount/pagesize;
	 if(totalcount%pagesize!=0){
		 pagecount=totalcount/pagesize+1;
	 }
	 if(!Tools.isNull(request.getParameter("pageno"))){
			currentPageIndex=Integer.valueOf(request.getParameter("pageno").trim()).intValue();
	 }
   List<Comment> commentlist=CommentHelper.getCommentList(id, (currentPageIndex-1)*pagesize, pagesize);
	 if(commentlist!=null && commentlist.size()>0){
		 %>
		  <table >
		   <%
	 for(Comment comment:commentlist){
		 User user1 = UserHelper.getById(comment.getGdscom_mbrid().toString());
			
			String hfusername = getUid(comment.getGdscom_uid());
			
		 %> 
		 <tr style=" background:#FFDEAD"><td  colspan="2">&nbsp;来自：<%=hfusername %> &nbsp;&nbsp;&nbsp;<%=Tools.stockFormatDate(comment.getGdscom_createdate()) %></td></tr>
	 <tr><td width="100px">&nbsp;评分：<%=comment.getGdscom_level() %>星    | </td><td><%=comment.getGdscom_content() %></td></tr>
	 <%}%>
	 </table>
	 <br/>
	   <form action="commentlist.jsp">
    		   <input type="hidden" name="productid" value="<%=id%>"/>
    		   <%
    		   if(currentPageIndex>1){
    			   %>
    			    <a href="<%=request.getRequestURI()%>?productid=<%=id %>&pageno=<%= currentPageIndex==1?1:currentPageIndex-1%>">上一页</a>
    		  <% }
    		  
    		  if(currentPageIndex<pagecount){
    			  %>
    			   &nbsp;<a href="<%=request.getRequestURI()%>?productid=<%=id %>&pageno=<%= currentPageIndex==pagecount?currentPageIndex:currentPageIndex+1%>">下一页</a>
        		  <%  
    		  }
    		  %>
    		  
    		   <input type="text" style="width:50px;" id="page" name="pageno" value="<%=currentPageIndex%>"/>/<%=pagecount  %>   <input type="submit" value="跳&nbsp;转" style=" padding:4px;" />
    		  
    		   
    	</form>	 
	<%}else{
	if(totalcount==0){
	%>	
	<br/>该商品暂无评论。
	<%}else{
		if(currentPageIndex>pagecount){
			%>	
			<br/>您输入的页码超出范围，请重新输入！
		<%}
		
			
	}
	%>
	
	
	<%} %>
	
	<br/>&nbsp;<a href="/wap/f_succ.jsp?id=<%=id%>">收藏</a>&nbsp;&nbsp;<a href="/wap/goods.jsp?productid=<%=id %>">返回商品详情>></a>
<div style="background:#f00; color:#fff;">&nbsp;<a href="/wap/goods.jsp?productid=<%= id %>"  style="color:#fff;"><b>简介</b></a>&nbsp;|&nbsp;<a href="/wap/imglist.jsp?productid=<%= id %>" style="color:#fff;"><b>图片</b></a>&nbsp;|&nbsp;
     <a href="/wap/goods.jsp?productid=<%= id %>" style="color:#fff;"><b>详情</b></a>&nbsp;|&nbsp;<a href="/wap/comment/commentlist.jsp?productid=<%= id%>" style="color:#fff;"><b>评论(<%=CommentHelper.getCommentLength(id)%>)</b></a>&nbsp;</div>
   <div style="background:#a52a2a; padding:2px; margin-top:2px;">
	 
     <form id="search_1" method="post" action="commentlist.jsp?act=search1">
	      <input id="search" name="search"/>
	      <input type="submit" value="搜商品 " />
	    
	   </form>
	  </div>
	  <br/>
</div>



<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->

</body>
</html>
