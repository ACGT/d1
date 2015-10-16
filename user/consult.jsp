<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——购买咨询</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
<form name=formpage method=post action="consult.jsp">
 <input type=hidden name=pageno id="pageno"/>
</form>
    <!--头部-->
   
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     <%!
      int getpagecount(int totalcount,int pagesize){
    	 int pagecount=totalcount/pagesize;
    	 if(totalcount%pagesize!=0){
    		 pagecount=totalcount/pagesize+1;
    	 }
    	 return pagecount;
     }
     
     String  getasktype(int type){
    	 String asktype="商品咨询";
    	 switch(type){
    	 case 1:
    		 asktype="商品咨询";
    		 break;
    	 case 2:
    		 asktype="库存及配送";
    		 break;
    	 case 3:
    		 asktype="支付问题";
    		 break;
    	 case 4:
    		 asktype="发票及保修";
    		 break;
    	 case 5:
    		 asktype="促销及赠品";
    		 break;
    	 }
    	 return asktype;
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
	 int askpagecount=getpagecount(cachecount,pagesize);
	 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
	 int end = pBean.getStart()+pagesize;
 	    if(end > cachecount) end = cachecount;
 	   List<GoodsAskCache> asklist2 = null;
 	  List<GoodsAsk> asklist3 = null;
 	   if(cachecount>0 && (cachecount>=(currentPageIndex-1)*pagesize)){
 		
 		  asklist2 = askcachelist.subList(pBean.getStart(),end);
 	   }
 	   if(cachecount<currentPageIndex*pagesize){
 		   if(replaycount>0){
 			 int start=(currentPageIndex-getpagecount(cachecount,pagesize)-1)*pagesize;
			  if(start<0) start=0;
 	 		 end=start+pagesize-(cachecount%pagesize);
 	 		 if(end > replaycount) end = replaycount;
 	 		 asklist3 = asklist.subList(start,end);
 	 		 
 		   }
 		
 	   }
     %>
   <!--右侧-->

   <div class="mbr_right">

		<div class="mypayrecord1">

		  &nbsp;&nbsp;<span>购买咨询</span>&nbsp;&nbsp;我的购买咨询<span style="font-weight:normal;color:#3e3e3e;">(<%=totalcount %>)</span>&nbsp;&nbsp;已回复<span style="font-weight:normal;">(<%=replaycount %>)</span>

		</div>

	 <div class="zxlist">
		<%
		   if(asklist2!=null){
			   for(GoodsAskCache ask:asklist2){
				   //out .println(ask.getGdsask_uid());
				   ///out .println(ask.getGdsask_gdsid());
				   Product product= ProductHelper.getById(ask.getGdsask_gdsid());
				   if(product!=null){
					  // out .print("****************");
					   %>
					   <table width="768" border="0" cellspacing="1" cellpadding="0" style="border:#c2c2c2 solid 1px;">

			   <tr>

			       <td width="80" height="70" style="text-align:center; background:#f7edee;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><a href="<%="/product/"+product.getId()%>" target="_blank"><img src="<%="http://images.d1.com.cn/"+product.getGdsmst_otherimg3() %>" width="50" height="50" /></a></td>

				   <td style=" padding-left:15px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b><a href="<%="/product/"+product.getId()%>"><%=product.getGdsmst_gdsname().trim() %></a></b></td>

			   </tr>

			   <tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b>我的问题</b><br/><font color="#a25663"><b><%=getasktype(ask.getGdsask_type().intValue()) %></b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><span style="word-wrap:break-word;overflow:hidden;"><%=Tools.clearHTML(ask.getGdsask_content()) %></span>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; "><%=Tools.stockFormatDate(ask.getGdsask_createdate()) %></span>

				   </td>

			   </tr>

			  <tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;"><font color="#a25663"><b>D1回复</b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;"><font color="#a25663">未回复</font>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; color:#a25663;"></span>

				   </td>

			   </tr>

			</table>

			

			<table cellspacing="0"><tr><td height="15"></td></tr></table>
					   
				  <% }
			   }
		   }
		 if(asklist3!=null){
			   for(GoodsAsk ask:asklist3){
				   Product product= ProductHelper.getById(ask.getGdsask_gdsid());
				   if(product!=null){
					   %>
					   <table width="768" border="0" cellspacing="1" cellpadding="0" style="border:#c2c2c2 solid 1px;">

			   <tr>

			       <td width="80" height="70" style="text-align:center; background:#f7edee;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><a href="" target="_blank"><img src="http://images.d1.com.cn/<%=product.getGdsmst_otherimg3() %>" width="50" height="50" /></a></td>

				   <td style=" padding-left:15px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b><a href="<%="/product/"+product.getId()%>"><%=product.getGdsmst_gdsname().trim() %></a></b></td>

			   </tr>

			   <tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b>我的问题</b><br/><font color="#a25663"><b><%=getasktype(ask.getGdsask_type().intValue()) %></b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><span style="word-wrap:break-word;overflow:hidden;"><%=Tools.clearHTML(ask.getGdsask_content()) %></span>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; "><%=Tools.stockFormatDate(ask.getGdsask_createdate()) %></span>

				   </td>

			   </tr>

			  <tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;"><font color="#a25663"><b>D1回复</b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;"><font color="#a25663" style="word-wrap:break-word;overflow:hidden;"><%=ask.getGdsask_replyContent() %></font>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; color:#a25663;"><%=Tools.stockFormatDate(ask.getGdsask_replydate()) %></span>

				   </td>

			   </tr>

			</table>

			

			<table cellspacing="0"><tr><td height="15"></td></tr></table>
					   
				  <% }
			   }}if(asklist2!=null || asklist3!=null){%>
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
	 if(window.document.formpage==undefined)
	  {
	    $.alert("没有设置pageListForm，无法提交");
	    return;
	  }
  $("#pageno").val(i);
 document.formpage.submit();
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
		   <%}if(asklist2==null && asklist3==null){%>
		   <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; " >

		   <tr  height="100">
		   <td align="center"><b style=" color:#A74254; font-size:16px;">您目前没有商品咨询。</b></td>
			
			</tr>
			</table>
	   <% }
	   %>
		   

		 </div>

		 

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

