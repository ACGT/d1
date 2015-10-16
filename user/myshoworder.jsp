<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include file="/ShowOrder/myshow.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——晒单</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sdshow.css")%>" type="text/css" rel="stylesheet"/>

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
 function sdimg_over2(showid){
	 $("#floatdp"+showid).show(); 
 }
 function sdimg_over(showid)
 {
	 var obj=$("#floatdp"+showid);
	 if(!isNaN){
		 $.alert("参数错误");return;
	 }else{
		 $(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
		 obj.show(); 
		 $.ajax({
				type: "get",
				dataType: "json",
				url: '/ajax/product/getsdimg.jsp',
				cache: false,
				data: {showid:showid},
				error: function(XmlHttpRequest){
				},success: function(json){
					if(json.succ){
						//alert(json.message);
						$(obj).html(json.message);
					}else{
						$.alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
	 }
 	
 }
 function sdimg_out(showid)
 {
 	 $("#floatdp"+showid).hide();
 	
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

%>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left1.jsp" %>
     
  <!--右侧-->

   <div class="mbr_right">

		<div class="myyhq">

		  &nbsp;&nbsp;<span>我的晒单</span>

		</div>

		<table border="0" width="769" height="10"><tr><td></td></tr>

		</table>

		<div class="yhqlist">

		    <div id="yh_tags" class="yh_tag">

		      	    <a id="a1" href="javascript:nocomment();" style="color:white" >待晒单</a><a id="a2" href="javascript:comment();" style=" margin-left:17px;"  >已晒单</a>

			</div>

			<div class="clear"></div>
			
			   <div id="yh_content_list" class="com_content_list">
				<form name=formpage1 method=post action="myshoworder.jsp?view=0">
 					<input type=hidden name=pageno id="pageno"/>
			
			       <div  id="com_content_list1" >

		  <table id="thead" width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33">

				   <td class="d1"  width="150">订单号</td>

				   <td  class="d1" width="320">商品信息</td>
				 <td class="d1" width="150">订购时间</td> 

				   <td class="d1" >操作</td></tr>

				   </table>
				   <%
				   String view="0";
				  if(!Tools.isNull(request.getParameter("view"))){
					   view=request.getParameter("view");
					   %>
					   <input type="hidden" id="view" value="<%=view %>" />
				  <% }
				  ArrayList<OrderItemBase> itemlist=getOdrDtlIn4Months(lUser.getId()) ;
					if(itemlist!=null && itemlist.size()>0){
						 int currentPageIndex=1;
						 int pagesize=10;
						 int totalcount=itemlist.size();
						 if(!Tools.isNull(request.getParameter("pageno"))){
								currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
							}
						  int pagecount=getpagecount(totalcount,pagesize);
						  PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
							 int end = pBean.getStart()+pagesize;
						 	    if(end > totalcount) end = totalcount;
						 	   List<OrderItemBase> itemlist2=itemlist.subList(pBean.getStart(), end);
						
						%>
						
						
						<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					<%for(OrderItemBase itembase:itemlist2){
					%>
				<tr><td  width="150"><a href="orderdetail.jsp?orderid=<%=itembase.getOdrdtl_odrid() %>" target="_blank"><%=itembase.getOdrdtl_odrid() %></a></td>
				<td width="320" style=" text-align:center; padding-bottom:10px;">
					<%
					
							 Product product= ProductHelper.getById(itembase.getOdrdtl_gdsid());
							 String imgurl="http://images.d1.com.cn/images2012/New/user/imgtext.jpg";
							 if(product!=null){
								 imgurl="http://images.d1.com.cn/"+product.getGdsmst_otherimg3();
							 }
							%>	
							<span style=" display:block; border-bottom:dashed 1px #ccc; height:60px; width:310px; margin-left:5px; padding-top:10px;">

					<img src="<%=imgurl %>" width="50" height="50" style=" float:left; vertical-align:bottom" />

		           <span class="sptitle" style=" display:block; width:233px;"><a href="/product/<%=itembase.getOdrdtl_gdsid()%>" target="_blank"><%=itembase.getOdrdtl_gdsname() %></a></span>
				     </span>
					

				 </td>
				 
				 <td width="150"><%=Tools.stockFormatDate(itembase.getOdrdtl_creatdate()) %></td> 
				 <td  ><a href="/ShowOrder/showorder.jsp?odtlid=<%=itembase.getId() %>" target="_blank">我要晒单</a></td></tr>
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
				   <td><b style=" color:#A74254; font-size:16px;">您目前没有待晒单的商品。</b></td>
					
					</tr>
					</table>
						
					<%}
					%>
					</div>
					</form>
 			<!--下面开始已评价>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-->
					 <form name=formpage2 method=post action="myshoworder.jsp?view=1">
 					<input type=hidden name=pageno2 id="pageno2"/>
					 <div id="com_content_list2" >

				   
				   <%
				   ArrayList<MyShow> showlist=ShowOrderHelper. getAllMyShow(lUser.getId());
				  // List<CommentCache> list2=CommentHelper.getMyCacheCommentList(new Long(lUser.getId()));
				  
				   if((showlist!=null && showlist.size()>0)){
					   %>
					   <table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					  
					   <%int replaycount=0;
					    int currentPageIndex=1;
						 int pagesize=15;
						 int totalcount=0;
						
						 if(!Tools.isNull(request.getParameter("pageno2"))){
							
								currentPageIndex=Integer.valueOf(request.getParameter("pageno2")).intValue();
							}
					
					     if(showlist!=null){
					    	totalcount+=showlist.size();
					     }
					    
					     int pagecount=getpagecount(totalcount,pagesize);
						
						 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
						 int end = pBean.getStart()+pagesize;
					 	    if(end > totalcount) end = totalcount;
					 	 
					 	  List<MyShow> list =showlist.subList(pBean.getStart(),end);
					 	 int size=list.size();
					 	   if(list!=null && size>0){
					 		%>
					 		<tr><td><div style="width:750px;">
					 		<%   
					 		   int row=size/3;//得到行数,及每列个数
					 		   int last=size%3;
					 		   int l1=0; int l2=0; 
					 		   if(last==1){
					 			   l1=1;
					 		   }else if(last==2){
					 			  l1=1;
					 			  l2=1;
					 		   }
					 		   for(int i=0;i<size;i++){
					 			  MyShow show1=list.get(i); 
				 				  Product p=ProductHelper.getById(show1.getMyshow_gdsid());
				 				
				 				 String uid=show1.getMyshow_mbruid();
				 				 if(uid.trim().length()<6){
				 					 uid="***"+uid+"***";
				 				 }else{
				 					 uid="***"+uid.substring(0, 5)+"***";
				 				 }
					 			   if(i==0){
					 					%>   
					 					<div style="float:left; padding-left:15px;">
					 				  <% }else if(i==row+l1){
					 					 %>   
					 					 </div>
					 					  <div style="float:left; ">
					 				   <% }else if(i==2*row+l1+l2){
						 					 %>   
						 					 </div>
						 					  <div style="float:left;">
						 				   <% }
						 				    if(p!=null){
						 				    	String imgurl="http://images1.d1.com.cn";
						 				    	if(show1.getMyshow_img400500().indexOf("/uploads/sd/")>=0){
						 				    		imgurl="http://d1.com.cn";
						 				    	}
				 				  %>   
				 				   <div  class="poster_grid poster_wall pins" > 
									<div class="new_poster"> 
									<div class="np_pic hover_pic">   
									<a target="_blank" href="/product/<%=p.getId() %>" class="pic_load">
									<img width="200" title="" src="<%=imgurl %><%=show1.getMyshow_img240300() %>" onmouseover="sdimg_over('<%= show1.getId()%>')" onmouseout="sdimg_out('<%= show1.getId()%>')" class="goods_pic" /></a> 
					 
									</div> 
									<div class="comm_box"> 
									<p class="l18_f posterContent"><table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr><td align="left"><b><%=uid %></b></td><td align="right" width="100"><%= new SimpleDateFormat("yyyy-MM-dd").format(show1.getMyshow_createdate())  %></td></tr><tr><td colspan="2" align="left"><%=Tools.clearHTML(show1.getMyshow_content()) %></td></tr></tr>
									</table>
									</p> 
									</div>
									  <div style="clear:both;"></div>
									<div class="comm_share c_f" style="text-align:right;"> 
									<div style="float:left; font-size:12px;">
									<%
									Long c=show1.getMyshow_status();
									String str="正在审核";
									if(c==0){
										 str="正在审核";
									}
									else if(c==1 || c==3){
										 str="审核通过";
									}else if(c==2){
										 str="审核未通过";
									}
									
									%>
									
									<span style="color:#666;"><%=str %></span>
									</div>
									<div style="float:left; text-align:right;width:130px;"><a target="_blank" href="http://d1.com.cn/product/<%=p.getId()%>"> 查看商品详情</a> </div>
									</div>  
									<%
									if(c!=0 && !Tools.isNull(show1.getMyshow_reason())){
									%>	
									  <div class="comm_share commentHover" style="text-align:left;"> 
									   <p class="ml40_f" style="text-align:left;">
									  <span class="gray_f" style="text-align:left;">编辑评论：<%=show1.getMyshow_reason() %></span></p>
									   <div class="clear_f"></div> </div> 	
										<%}
									%>
									   
									  </div>
									  </div>
									  <div style="clear:both;"></div>
									   <div class="floatdp" id="floatdp<%=show1.getId() %>" style="display:none;" >
									  
									   </div>
					 			  <%  }
						 				    if(i==size-1){
						 				    	%>
						 				    	</div>
						 				   <%  }
					 		  }
					 		   
					 		%>
					 		</div>
					 		 <div style="clear:both;height:15px;">&nbsp;</div>
					 		  
					 		</td></tr>  
					 	  <%  }
					 	  %>
					 	  
					 	<tr>

					   <td >  <div class="Pager">  
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
					   <td><b style=" color:#A74254; font-size:16px;">您目前没有已晒单的商品。</b></td>
						
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

