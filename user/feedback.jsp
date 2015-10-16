<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%>
     <%!
     //获取我的全部反馈
     ArrayList<Feedback> getMyFeedBack(String mbrid){
		ArrayList<Feedback> rlist = new ArrayList<Feedback>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("feedback_mbrid", mbrid));
	
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.desc("feedback_createdtime"));
		List<BaseEntity> list = Tools.getManager(Feedback.class).getList(clist, olist, 0, 1000);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Feedback)be);
		}
		return rlist ;
     }
      int getpagecount(int totalcount,int pagesize){
    	 int pagecount=totalcount/pagesize;
    	 if(totalcount%pagesize!=0){
    		 pagecount=totalcount/pagesize+1;
    	 }
    	 return pagecount;
     }
     
     String  getasktype(int type){
    	 String asktype="商品咨询";
    	 if(type==1) asktype="商品咨询";
    	 else if(type==2)  asktype="物流/配送 ";
    	 else if(type==3)  asktype="支付问题 ";
    	 else if(type==10)  asktype="其他问题 ";
    	 else if(type>=4 && type<10)  asktype="退换货问题 ";
    	
    	 return asktype;
     }
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——意见反馈 </title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<body>
<form name=formpage method=post action="feedback.jsp">
 <input type=hidden name=pageno id="pageno"/>
</form>
    <!--头部-->
   
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>

     <%
     ArrayList<Feedback> feedlist= getMyFeedBack(lUser.getId());
     List<Feedback> list=null;
   
    int currentPageIndex=1;
	 int pagesize=5;
	 int totalcount=0;
	int replaycount=0;
	int pagecount=0;
	 if(!Tools.isNull(request.getParameter("pageno"))){
			currentPageIndex=Integer.valueOf(request.getParameter("pageno")).intValue();
		}
    if(feedlist!=null && feedlist.size()>0){
    	totalcount=feedlist.size();
    	for(Feedback feed:feedlist){
    		if(feed.getFeedback_replaystatus().intValue()==1){
    			replaycount++;
    		}
    	}
   
      pagecount=getpagecount(totalcount,pagesize);
	
	 PageBean pBean = new PageBean(totalcount,pagesize,currentPageIndex);
	 int end = pBean.getStart()+pagesize;
 	    if(end > totalcount) end = totalcount;
 	   list =feedlist.subList(pBean.getStart(), end);
 	  
    }
     %>
   <!--右侧-->

   <div class="mbr_right">

		<div class="mypayrecord1">

		  &nbsp;&nbsp;<span>意见反馈</span>&nbsp;&nbsp;我的意见反馈<span style="font-weight:normal;color:#3e3e3e;">(<%=totalcount %>)</span>&nbsp;&nbsp;已回复<span style="font-weight:normal;">(<%=replaycount %>)</span>

		</div>

	 <div class="zxlist">
		<%
		   if(list!=null){
			   for(Feedback feed:list){
				   String replaytype="D1回复";
				   String replaycontent="未回复";
				   if(feed.getFeedback_isceo().intValue()==1){
					   replaytype="CEO回复";
				   }
				   if(feed.getFeedback_replaystatus().intValue()==1){
					   replaycontent=feed.getFeedback_replaycontent();
				   }
				  %>
				<table width="768" border="0" cellspacing="1" cellpadding="0" style="border:#c2c2c2 solid 1px;">
					<tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b>我的反馈</b><br/><font color="#a25663"><b><%=getasktype(feed.getFeedback_type().intValue()) %></b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><span style="word-wrap:break-word;overflow:hidden;"><%=feed.getFeedback_content() %></span>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; "><%=Tools.stockFormatDate(feed.getFeedback_createdtime()) %></span>

				   </td>

			   </tr>
			   <%
			    if((!Tools.isNull(feed.getFeedback_attach())) && (!feed.getFeedback_attach().trim().equals(","))){
			    	String attach=feed.getFeedback_attach();
			    	String[] attachlist=attach.split("\\,");
			    	%>	
			    	<tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;"><b>我的附件</b>
			       </td>

				   <td style=" padding-left:15px;padding-right:10px;border-bottom:solid; border-bottom-color:#c2c2c2; border-bottom-width:1px;">
					<%
					 for(int i=0;i<attachlist.length;i++){
						 %>		
						 <a href="/upload/<%=attachlist[i]%>">    <%=attachlist[i]%></a> 
					<% }
					%>
				   
				   </td>

			   </tr>
			    <% }
			   %>

			  <tr>

			       <td  height="100" style="text-align:center; background:#f7edee; line-height:20px;"><font color="#a25663"><b><%=replaytype %></b></font></td>

				   <td style=" padding-left:15px;padding-right:10px;"><font color="#a25663"><%=replaycontent %></font>

				   <br/><br/>

				   <span style=" float:right; margin-right:10px; display:block; color:#a25663;"></span>

				   </td>

			   </tr>

			</table>

			

			<table cellspacing="0"><tr><td height="15"></td></tr></table>
					   
				  <% 
			   }
		   }
		 if(feedlist!=null && feedlist.size()>0){
			 %> 
			  <div class="Pager">  
            共&nbsp;<b class="eng"><font color="#FF0000"><%=totalcount%></font></b>&nbsp;条记录 &nbsp;&nbsp;共 <b class="eng"><font color="#FF0000"><%=pagecount%></font></b> 页,当前第 <b class="eng"><font color="#FF0000"><%=currentPageIndex%></font></b> 页&nbsp;&nbsp;&nbsp;&nbsp;
              <%if (currentPageIndex!=0) {%>
                  <a class="curr" href="javascript:gopage(1)" >1</a> 
                  <%}
              if (pagecount>1 ){
            	  int count=4;
            	  if( pagecount<=5){
            		  count= pagecount-1;
            	  }
              for(int i=2;i<count+2;i++){
            	  if(i==currentPageIndex){ %>  
            		   
                       <a class="curr" href="javascript:gopage(<%=i%>)" ><%=i %></a> 
                      
            	 <%  }else{
            	  %>  
            	  
              	<a href="javascript:gopage(<%=i%>)" ><%=i %></a> 
             	
              <%  }
              }
              
		  }
          if (currentPageIndex<pagecount ){
		%>
		
              <a href="javascript:gopage(<%=currentPageIndex+1%>)">下一页</a>
             
              <%}
		  if (currentPageIndex!=pagecount){
		%> 
              <a href="javascript:gopage(<%=pagecount%>)">末页</a>
            
              <%}%>
                <input name="gotonum" type="text" id="gotonum" value="<%=currentPageIndex%>" style="border:1px solid #CCC;width:25px; height:20px;text-align:center;"/>
                   <input type="button"  class="btngo" name="gobtn" value="Go" onclick="javascript:gotopage(document.getElementById('gotonum').value);"/>
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
		<%  }else{%>
			<table width="768" border="0" cellspacing="1" cellpadding="0" style="border:#c2c2c2 solid 1px;">
				<tr>
				 <td  align="center" valign="middle" height="100px;"><b style=" color:#A74254; font-size:16px;">您目前没有意见反馈。</b></td>
				</tr>
					
			</table>		
			<%}
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

