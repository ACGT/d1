<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——商品评价</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>


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
<%@ include file="../inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
    <div style=" margin-bottom:15px;">
   <div style=" background:#FFDEAD; padding:3px; width:100%;">
    <a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的评论
    <br/>
    </div>
    <div style="padding:5px;">
     <a href="comment.jsp">待评价</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="comment.jsp?type=1">已评价</a>
     <%
     if(Tools.isNull(request.getParameter("type")))//待评价
     {
    	 ArrayList<OrderBase> nocommentlist=OrderHelper.getMyFinishOrderList(lUser.getId()) ;
					if(nocommentlist!=null && nocommentlist.size()>0){
						
						%>
						<table  border="0" cellspacing="1" cellpadding="0"  class="t" >
						<tr>
						 <td class="d1"  width="100">订单号</td> <td class="d1" >操作</td>
						</tr>
					<%for(OrderBase base:nocommentlist){
					%>
				 <tr><td  width="100"><a href="/wap/orderdetail.jsp?orderid=<%=base.getId() %>" target="_blank"><%=base.getId() %></a></td>
				   <td  ><a href="/wap/comment/addcomment.jsp?orderid=<%=base.getId() %>" target="_blank">确认收货并评价</a></td></tr>
					
<%} %>

   </table>
   <%} else{%>
   <font color='#f00'>您目前没有待评价的订单！</font><br/>
    	<a href="/wap/user">返回我的优尚</a>
   <%} }else{
	   %>
	    <form name=formpage2 method=post action="comment.jsp?type=1">
 					<input type=hidden name=pageno2 id="pageno2"/>
 					</form>
	   <%
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
							 url="/wap/goodsdetail.jsp?productid="+product.getId();
						 }
						 int score=cache.getGdscom_level().intValue();
						
						
							%>	
						 <tr ><td style=" color:#a25663;" width="80">订单号</td>
						 <td  width="80"><a href="/wap/orderdetail.jsp?orderid=<%=cache.getGdscom_odrid() %>" ><%=cache.getGdscom_odrid() %></a></td>
						 </tr>	
						
		 			   <tr>
		 			    <td style=" color:#a25663;">商品信息</td>
			
 <td><span class="sptitle" style=" display:block; "><a href="<%=url %>" target="_blank"><%=cache.getGdscom_gdsname() %></a></span></td>
 </tr>
 <tr><td style=" color:#a25663;">我的评分</td>
	   <td><font color="red"><%=score %>分</font></td>
</tr>
<tr>
<td style=" color:#a25663;">评价内容</td>
    <td  style=" text-align:left; padding:3px;"><%=cache.getGdscom_content()%>
    <br/>
     <%
	    if(cache.getGdscom_replyStatus().intValue()==1 || !Tools.isNull(cache.getGdscom_replyContent())){
	    	%>	
	    	<p style="color:#892D3D;line-height:26px;">D1优尚回复:<%=cache.getGdscom_replyContent() %></p>
	    <%}%>
    </td>
    </tr>
    <tr>
<td style=" color:#a25663;">评价时间</td>
    <td ><%=Tools.stockFormatDate(cache.getGdscom_createdate()) %></td>
    </tr>
 <% i++; }
		 	  %>
 <tr>
 <td colspan="2">
 <div class="Pager">  
         共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b> 页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b> 页&nbsp;&nbsp;&nbsp;&nbsp;
              <%if (currentPageIndex!=0) {%>
                  <a class="curr" href="javascript:gopage2(1)" >首页</a> 
                  <%}
              if (currentPageIndex>1 ){%>
              <a href="javascript:gopage2(<%=currentPageIndex-1%>)" ><font color="#666666">上一页</font></a> &nbsp;&nbsp;
              <%
		  }
          	for(int j=pBean.getStartPage();j<=pBean.getEndPage()&&j<=pBean.getTotalPages();j++){
           		if(j==currentPageIndex){
           		%><span class="curr"><%=j %></span><%
           		}else{
           		%> <a class="curr" href="javascript:gopage2(<%=j%>)" ><%=j %></a> <%
           		}
           	}
          if (currentPageIndex<pagecount ){%>
		
              <a href="javascript:gopage2(<%=currentPageIndex+1%>)">下一页</a>
             
              <%}%> 
              <a href="javascript:gopage2(<%=pagecount%>)">尾页</a>
              
          </div>
<script language="javascript">
			  var gotonum;
			  gotonum=<%=pagecount%>;
			  function gotopage2(args) {
				if(isNumber(args) && args>gotonum) gopage2(gotonum); //输入数字大于最大页数
				if(isNumber(args) && args<=gotonum && args>0) gopage2(args); //输入正确范围
				if(isNumber(args) && args<1) gopage2(1); //输入数字小于0
			  }
function gopage2(i)
{
	 if(window.document.formpage2==undefined)
	  {
	    $.alert("没有设置pageListForm，无法提交");
	    return;
	  }
	 $("#pageno2").val(i);
 document.formpage2.submit();
}
//判断是否为数字
function jumpTo2() {
  var topage = document.getElementById("gotonum2").value;
  if(topage)
	  var pattern=/^[0-9]+$/; 
  var result=pattern.exec(topage);
	if(result==null){
 		$.alert("页码只能是数字");
		return;
	}else if(topage == 0){
		$.alert("页码必须大于0");
		return;
	}else{
		gopage2(topage);
	}
}
</script>
 </td>
 </tr>
   </table>
   <%}} }%>
   </div>
     </div>
    
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
<%@ include file="../inc/userfoot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

