<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——商品评价</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#view").val()==null){
		setview1();
	}else{
		if( $("#view").val()==0){
			setview1();
		}else{
			setview2();
		}
	}
	});
	
 function nocomment(){
	 $("#view").val("0");
	 setview1();
 }
 function setview1(){
	 $("#com_content_list1").show();
	 $("#com_content_list2").hide();
	 document.getElementById("yh_tags").className="tags1";
	 $("#a1").css("color","white");
	 $("#a2").css("color","#828282");
 }
 function setview2(){
	 $("#com_content_list1").hide();
	 $("#com_content_list2").show();
	 
	 $("#a2").css("color","white");
	 $("#a1").css("color","#828282");
	 document.getElementById("yh_tags").className="tags2";
 }
 function comment(){
	 $("#view").val("1");
	 setview2();
 }
</script>
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
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->

   <div class="mbr_right">

		<div class="myyhq">

		  &nbsp;&nbsp;<span>我的商品评价</span>

		</div>

		<table border="0" width="769" height="10"><tr><td></td></tr>

		</table>

		<div class="yhqlist">

		    <div id="yh_tags" class="yh_tag">

		      	    <a id="a1" href="javascript:nocomment();" style="color:white" >待评价</a><a id="a2" href="javascript:comment();" style=" margin-left:17px;"  >已评价</a>

			</div>

			<div class="clear"></div>
			
			   <div id="yh_content_list" class="com_content_list">
				<form name=formpage1 method=post action="comment.jsp?view=0">
 					<input type=hidden name=pageno id="pageno"/>
			
			       <div  id="com_content_list1" >

		  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33">

				   <td class="d1"  width="80">订单号</td>

				   <td  class="d1" width="320">商品信息</td>

				   <td class="d1" width="60">收货人</td>

				   <td class="d1" width="100">订单金额</td>

				   <td class="d1" width="100">订购时间</td> 

				   <td class="d1" >操作</td></tr>

				   </table>
				   <%
				   String view="0";
				  if(!Tools.isNull(request.getParameter("view"))){
					   view=request.getParameter("view");
					   %>
					   <input type="hidden" id="view" value="<%=view %>" />
				  <% }
					ArrayList<OrderBase> nocommentlist=OrderHelper.getMyFinishOrderList2(lUser.getId()) ;
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
						
						
						<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					<%for(OrderBase base:nocommentlist2){
						
					
					%>
				

				    <tr><td  width="80"><a href="orderdetail.jsp?orderid=<%=base.getId() %>" target="_blank"><%=base.getId() %></a></td><td width="320" style=" text-align:center; padding-bottom:10px;">
					<%
					ArrayList<OrderItemBase> itemlist=OrderItemHelper.getMyOrderDetail2(base.getId());
					if(itemlist!=null && itemlist.size()>0){
						for(OrderItemBase itembase:itemlist){
							 Product product= ProductHelper.getById(itembase.getOdrdtl_gdsid());
							 String imgurl="http://images.d1.com.cn/images2012/New/user/imgtext.jpg";
							 if(product!=null){
								 imgurl="http://images.d1.com.cn/"+product.getGdsmst_otherimg3();
							 }
							%>	
							<span style=" display:block; border-bottom:dashed 1px #ccc; height:60px; width:310px; margin-left:5px; padding-top:10px;">

					

					<img src="<%=imgurl %>" width="50" height="50" style=" float:left; vertical-align:bottom" />

		           <span class="sptitle" style=" display:block; width:233px;"><a href="/product/<%=itembase.getId()%>" target="_blank"><%=itembase.getOdrdtl_gdsname() %></a></span>

				     </span>
						<%}
					}
					%>

				 </td><td width="60"><%=base.getOdrmst_rname() %></td><td  width="100"><span><b>￥<%=Tools.getDouble(base.getOdrmst_ordermoney().doubleValue(), 2) %></b></span></td><td width="100"><%=Tools.stockFormatDate(base.getOdrmst_orderdate()) %></td> <td  ><a href="/comment/addcomment.jsp?orderid=<%=base.getId() %>" target="_blank"><img src="http://images.d1.com.cn/images2012/New/user/qrshsppj.jpg" /></a></td></tr>

				   
					<%}%>
					<tr>

					   <td colspan="6">
					     <div class="Pager">  
 共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b> 页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b> 页&nbsp;&nbsp;&nbsp;&nbsp;
              <%if (currentPageIndex!=0) {%>
                  <a class="curr" href="javascript:gopage(1)" >首页</a> 
                  <%}
              if (currentPageIndex>1 ){%>
              <a href="javascript:gopage(<%=currentPageIndex-1%>)" ><font color="#666666">上一页</font></a> &nbsp;&nbsp;
              <%
		  }
          	for(int j=pBean.getStartPage();j<=pBean.getEndPage()&&j<=pBean.getTotalPages();j++){
           		if(j==currentPageIndex){
           		%><span class="curr"><%=j %></span><%
           		}else{
           		%> <a class="curr" href="javascript:gopage(<%=j%>)" ><%=j %></a> <%
           		}
           	}
          if (currentPageIndex<pagecount ){%>
		
              <a href="javascript:gopage(<%=currentPageIndex+1%>)">下一页</a>
             
              <%}%> 
              <a href="javascript:gopage(<%=pagecount%>)">尾页</a>
              
          </div>
<script language="javascript">
			  var gotonum;
			  gotonum=<%=pagecount%>;
			  function gotopage(args) {
				if(isNumber(args) && args>gotonum) gopage(gotonum); //输入数字大于最大页数
				if(isNumber(args) && args<=gotonum && args>0) gopage(args); //输入正确范围
				if(isNumber(args) && args<1) gopage(1); //输入数字小于0
			  }
function gopage(i)
{
	 if(window.document.formpage1==undefined)
	  {
	    $.alert("没有设置pageListForm，无法提交");
	    return;
	  }
  $("#pageno").val(i);
 document.formpage1.submit();
}
//判断是否为数字
function jumpTo() {
  var topage = document.getElementById("gotonum").value;
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
		gopage(topage);
	}
}
</script>
					   
					   </td>

				   </tr>

				   </table>
					<% }else{%>
					  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2;" >

				   <tr  height="100">
				   <td><b style=" color:#A74254; font-size:16px;">您目前没有待评价的订单。</b></td>
					
					</tr>
					</table>
						
					<%}
					%>
					</div>
					</form>
 			<!--下面开始已评价>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-->
					 <form name=formpage2 method=post action="comment.jsp?view=1">
 					<input type=hidden name=pageno2 id="pageno2"/>
					 <div id="com_content_list2" >

					  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33"><td class="d1"  width="80">订单号</td><td  class="d1">商品信息</td><td class="d1" width="240">我的评分</td><td class="d1" width="140">评论时间</td></tr>

				   </table>
				   
				   <%
				   List<Comment> list1=CommentHelper.getMyCommentList(new Long(lUser.getId()));
				  // List<CommentCache> list2=CommentHelper.getMyCacheCommentList(new Long(lUser.getId()));
				  
				   if((list1!=null && list1.size()>0)){
					   %>
					   <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					   
					   <%int replaycount=0;
					    int currentPageIndex=1;
						 int pagesize=5;
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
					 		   for(Comment cache:list){
					 			  Product product= ProductHelper.getById(cache.getGdscom_gdsid());
					 			  String url="";
									 String imgurl="http://images.d1.com.cn/images2012/New/user/imgtext.jpg";
									 if(product!=null){
										 imgurl="http://images.d1.com.cn/"+product.getGdsmst_otherimg3();
									 url="/product/"+product.getId();
									 }
									 int score=cache.getGdscom_level().intValue();
									 String starimg="http://images.d1.com.cn/images2012/New/user/star" + score + ".jpg";
									 String value =getlevel(score);
					 			  %>
					 			    <tr><td  width="80" rowspan="2"><a href="orderdetail.jsp?orderid=<%=cache.getGdscom_odrid() %>" target="_blank"><%=cache.getGdscom_odrid() %></a></td><td style=" padding-top:10px; padding-bottom:10px; padding-left:10px; width:230px;">
						<table  border="0" cellspacing="0" cellpadding="0"   >
						<tr>
						 <td><img src="<%=imgurl %>" width="50" height="50" style=" float:left; vertical-align:bottom" /></td>
						 <td><span class="sptitle" style=" display:block; width:213px;"><a href="<%=url %>" target="_blank"><%=cache.getGdscom_gdsname() %></a></span></td>
						</tr>
						</table>
					  </td>

				   <td width="240"><img src="<%=starimg %>" style=" vertical-align:text-bottom" />&nbsp;&nbsp;<font color="red"><%=score %>分</font>-<%=value %></td>

		           <td width="140" rowspan="2"><%=Tools.stockFormatDate(cache.getGdscom_createdate()) %></td></tr>

				   <tr><td colspan="2" style=" text-align:left; padding:10px;"><%=cache.getGdscom_content() %><br></br>
				   <%
				    if(cache.getGdscom_replyStatus().intValue()==1 || !Tools.isNull(cache.getGdscom_replyContent())){
				    	%>	
				    	<p style="color:#892D3D;line-height:26px;">D1优尚回复:<%=cache.getGdscom_replyContent() %></p>
				    <%}
				   %>
				   </td></tr>

				    
					 		 <%  }
					 	   }
					 	  %>
					 	<tr>

					   <td colspan="4">  <div class="Pager">  
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
</script></td>

				   </tr>

				   </table>   
				    <% }else{%>
					   <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; " >

					   <tr  height="100">
					   <td><b style=" color:#A74254; font-size:16px;">您目前没有已评价的商品。</b></td>
						
						</tr>
						</table>
				   <% }
				   %>


					 </div>
				</form>
			   </div>

		</div>

		

		<table width="769" height="20"><tr><td></td></tr></table>

		

  </div>

 
	  <!-- 右侧结束 -->
         
     </div>
    
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>

