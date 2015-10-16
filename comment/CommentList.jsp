<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%
String productId=request.getParameter("goodsid");
Product product = ProductHelper.getById(productId);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=product!=null?Tools.clearHTML(product.getGdsmst_gdsname()):"" %></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/comment.css")%>" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

</head>
<body>
<center>

 <div style="font-size:12px;">
 <div style="padding-top:10px;padding-bottom:10px;  font-size:14px; font-weight:bold; color:#000; float:left;">
	<img src="http://images.d1.com.cn/Index/images/gkpl_star.jpg" style="vertical-align:text-bottom" />顾客评论
 </div><br></br>
<%

 if(product != null){
	%>
	 <form name=formpage method=post action="commentlist.jsp?goodsid=<%=productId%>">
          <input type=hidden name=pageno id="pageno"/>
        </form>
	<% 
	 int currentPageIndex=1;
	 int pagesize=5;
	 int totalcount=CommentHelper.getCommentLength(productId);
	 int pagecount=totalcount/pagesize;
	 if(totalcount%pagesize!=0){
		 pagecount=totalcount/pagesize+1;
	 }
	 if(!Tools.isNull(request.getParameter("pageno"))){
		// out.print("<script>alert('"+request.getParameter("pageno")+"')</script>");
			currentPageIndex=Integer.valueOf(request.getParameter("pageno").trim()).intValue();
	//out.print(request.getParameter("pageno"));	
	 }
	 List<Comment> commentlist=CommentHelper.getCommentList(productId, (currentPageIndex-1)*pagesize, pagesize);
	 if(commentlist!=null && commentlist.size()>0){
		 int avgscore=CommentHelper.getLevelView(productId);
		 %>
		 <div style="background-color:#F4F4F4;">
			<table cellpadding="0" cellspacing="0" style="margin-left:10px; margin-right:20px; margin-top:10px; margin-bottom:10px; width:95%; line-height:28px;">
				<tr>
                  <td><div style="float:left">
                        <div style="float:left;font-size:12px">购买过的顾客评分 |</div>
                         <div class="sa<%=avgscore %>" style="float:left;" ></div>
                       </div></td>
                     <td  align="right"></td>
                 </tr>
			</table>
		</div>
		<div style="padding-top:10px">
			<table cellpadding="0" cellspacing="0" style="font-size:12px; width:100%">
					    	
	 <%
	 for(Comment comment:commentlist){
		 User user = UserHelper.getById(String.valueOf(comment.getGdscom_mbrid()));
			if(user == null) continue;
			String hfusername = CommentHelper.GetCommentUid(comment.getGdscom_uid());
			String level = UserHelper.getLevelText(user);
		 %>
		 <tr>
			<td>
			<div id="comment" class="m" >
                <div class="mc" >
                    <div id="divitem" class="item">
                        <div class="user">
                            <div class="u-icon">
                               <img src="<%=UserHelper.getLevelImage(level) %>" width="70" height="70" />                      
                            </div>
                            <div class="u-name">
                             <span><%=hfusername %></span><br></br>
                             <span><%=level %></span>
                            </div>
                       
                        </div>
                        <div class="i-item">
                        <div class="o-topic">
                          <div style="float:left"><strong class="topic">
                            <label style="font-weight:bold">评分：</label>
                            </strong>
                            <img src="http://images.d1.com.cn/images2012/New/gds_star<%=comment.getGdscom_level() %>.gif" /></div>
                            
                            <div style="float:right"><span class="date-comment">
                           <%=Tools.stockFormatDate(comment.getGdscom_createdate()) %>
                            </span></div>
                            
                        </div>
                        <div class="o-topic"  >
                             <div style="line-height:26px;" class="comment-content">
                                 <dl>
                                    <dd><%=comment.getGdscom_content() %></dd>
                                  </dl>
                             </div>
                            
                        </div>
                       
                        <div class="comment-content">
                           <dl>
                           <dd>
                            <%
                            if(!Tools.isNull(comment.getGdscom_replyContent())){
                            	 %>	
                            	 <p style="color:#892D3D;line-height:26px;" >D1优尚回复：<%=comment.getGdscom_replyContent() %></p>
                          <%  }
                           %>
                           </dd>
                           </dl>    
                        </div>
                        </div>
                        <div class="corner tl"></div>
                     
                    </div>
                </div>

        </div>
			
			</td>
		</tr><%
	} %>
	</table>
	
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
	<% }else{ %>
		<div style="background-color:#F4F4F4;">
			 <span style="font-size:12px">暂时还没有顾客评分 </span>
             <a href="###">马上去评论</a>                      		
		</div>
	 <%}
 
 }
%>
</div>

   </center> 
</body>
</html>