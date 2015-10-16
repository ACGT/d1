<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
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
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的商品咨询</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>" rel="stylesheet" type="text/css" media="screen" />


</head>

<body>

<!-- 头部 -->
<%@ include file="../inc/head.jsp" %>
<!-- 头部结束 -->
     <%!
      int getpagecount(int totalcount,int pagesize){
    	 int pagecount=totalcount/pagesize;
    	 if(totalcount%pagesize!=0){
    		 pagecount=totalcount/pagesize+1;
    	 }
    	 return pagecount;
     }

     %>
     <%
     ArrayList<GoodsAsk> asklist=GoodsAskHelper.getMyCommentList(new Long(lUser.getId()));
     ArrayList<GoodsAskCache> askcachelist=GoodsAskHelper.getMyCommentCacheList(new Long(lUser.getId()));
    int replaycount=0;
    int currentPageIndex=1;
	 int pagesize=2;
	 int totalcount=0;
	 int cachecount=0;
	 if(!Tools.isNull(request.getParameter("pageno"))){
			currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
		}
     if(asklist!=null && asklist.size()>0){
    	 replaycount+=asklist.size();
    	 totalcount+=asklist.size();
     }
     if(askcachelist!=null && askcachelist.size()>0){
    	 totalcount+=askcachelist.size(); 
    	 cachecount+=askcachelist.size(); 
     }
     int pagecount=getpagecount(totalcount,pagesize);
	// int askpagecount=getpagecount(cachecount,pagesize);
	 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
	 int end = pBean.getStart()+pagesize;
 	    if(end > replaycount) end = replaycount;
 	   List<GoodsAskCache> asklist2 = null;
 	  List<GoodsAsk> asklist3 = null;
 	   if(replaycount>0 && (replaycount>(currentPageIndex-1)*pagesize)){
 		
 		  asklist3 = asklist.subList(pBean.getStart(),end);
 	   }
 	   if(replaycount<currentPageIndex*pagesize){
 		   if(cachecount>0){
 			  int start=(currentPageIndex-getpagecount(replaycount,pagesize)-1)*pagesize;
 			  if(start<0) start=0;
 			 //out.print(start+">>>>>>>>>"+replaycount);
 	 		 end=start+pagesize-(replaycount%pagesize);
 	 		 //out.print(start+">>>>>>>>>"+end);
 	 		 if(end > cachecount) end = cachecount;
 	 		
 	 		 asklist2 = askcachelist.subList(start,end);
 	 		 
 		   }
 		
 	   }
 	  %>
<div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的商品咨询
    <br/>
    </div>
    <form action="consult.jsp">
    <%  if((asklist!=null&&asklist.size()>0)||(askcachelist!=null&&askcachelist.size()>0))
    {%>
    	&nbsp;共<font color='#f00'><%= totalcount %></font>条咨询，<font color='#f00'><%= replaycount %></font>条已回复
    	<br/>
    	<table>
    	<%  
    	 if(asklist3!=null){
			   for(GoodsAsk goodsask:asklist3){
	    		    %>
	    		    		<tr><td><b>&nbsp;<a href="/wap/goods.jsp?productid=<%= goodsask.getGdsask_gdsid() %>"><%= goodsask.getGdsask_gdsname() %></a></b></td></tr>
	    		    		<tr><td>&nbsp;<font color="#f00"><%=Tools.clearHTML( goodsask.getGdsask_content())%></font></td></tr>
	    		    		<tr><td>&nbsp;D1回复：<%= goodsask.getGdsask_replyContent() %></td></tr>
	    		    	<%
	    		    }
    	 }
    	  if(asklist2!=null){
			   for(GoodsAskCache goodsaskcache:asklist2){
		    		    	%>
		    		    		<tr><td><b>&nbsp;<a href="/wap/goods.jsp?productid=<%= goodsaskcache.getGdsask_gdsid() %>"><%= goodsaskcache.getGdsask_gdsname() %></a></b></td></tr>
		    		    		<tr><td>&nbsp;<font color="#f00"><%=Tools.clearHTML( goodsaskcache.getGdsask_content())%></font></td></tr>
		    		    		<tr><td>&nbsp;未回复</td></tr>
		    		    	<%
	    		    	}
	    		    	
	    		    }
	    
    	    
        %>
    	<tr>
    	<td></td>
    	</tr>
    	</table>
    	
   <div class="Pager">  
        
              <%if (currentPageIndex!=0) {%>
                  <a class="curr" href="consult.jsp?pageno=1" >首页</a> 
                  <%}
              if (currentPageIndex>1 ){%>
              <a href="consult.jsp?pageno=<%=currentPageIndex-1%>" ><font color="#666666">上一页</font></a> &nbsp;&nbsp;
              <%
		  }
          if (currentPageIndex<pagecount ){%>
		
              <a href="consult.jsp?pageno=<%=currentPageIndex+1%>">下一页</a>
             
              <%}%> 
              <a href="consult.jsp?pageno=<%=pagecount%>">尾页</a>
                &nbsp;&nbsp;<input type="text" name="pageno" style="width:50px;" id="page" value="<%=currentPageIndex%>"/>/<%=pagecount %>
				&nbsp;&nbsp;<input type="submit" value="跳转" style="padding:3px;" />
          </div>
    <%}
    else
    {%>
    	<font color='#f00'>您还没有进行商品咨询！</font><br/>
    
    <%}
    	%>
    	<a href="/wap/user">返回我的优尚</a>
    	</form>
</div>

<!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
<!-- 尾部结束 -->
</body>
</html>
