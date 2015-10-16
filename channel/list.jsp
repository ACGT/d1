<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%
    String letter="";
    if(request.getParameter("l")!=null&&request.getParameter("l").length()>0)
    {
    	letter=request.getParameter("l");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-标签</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  .center{ width:978px; margin:0px auto; margin-top:10px; margin-bottom:10px; border:solid 1px #ccc; text-aling:center; padding-bottom:5px;}
  .center span{ color:#333;  font-size:14px;}
  .center table{ margin:0px auto;}
  .center table td a{ margin-right:5px; line-height:18px; font-size:13px;}
  .nt{ width:980px; margin:0px auto; background:#f6f6f6; text-align:center;}
  .nt a{ font-size:16px; line-height:35px; display:block; width:32px; float:left; }
</style>

</head>

<body>
<%@include file="/inc/headseo.jsp" %>
<div class="center">
   <span><b><% if(letter.length()>0) out.print(letter); else out.print("最新标签"); %></b></span><br/><br/>
   <table width="960">
      <tr><td>
      <%
          ArrayList<Tag> list=TagHelper.getTagsByCount(letter,1000);
    //分页
      int pageno1=1;
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 150 ;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
          if(list!=null&&list.size()>0)
          {
        	  if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
  		       {
  			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
  		       }
  	    	 
  	           for(int i=(pageno1-1)*150;i<list.size()&&i<pageno1*150;i++)
               {
                 Tag t=list.get(i);
             %>
        	<a href="http://www.d1.com.cn/channel/<%= URLEncoder.encode(t.getId(),"utf-8") %>" target="_blank"><%= t.getTag_key() %></a>  
          <%   }
  	           %>
  	            <%
					           if(pBean1.getTotalPages()>1){
					           %><br/><br/><table>
					           <tr>
					          <td colspan="7" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	    for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr></table><%}%>	
          <%}
          else
          {%>
        	该分类下没有标签！<a href="http://www.d1.com.cn/channel/list.html" style="color:#aa2e44">返回最新标签</a>  
          <%}
      %>
      
      </td></tr>
   </table>
   
</div>
 <table width="980" class="nt">
     <tr><td height="35" style="padding-left:6px;"><a href="http://www.d1.com.cn/channel/list/A" target="_blank">A</a><a href="http://www.d1.com.cn/channel/list/B" target="_blank">B</a><a href="http://www.d1.com.cn/channel/list/C" target="_blank">C</a>
     <a href="http://www.d1.com.cn/channel/list/D" target="_blank">D</a><a href="http://www.d1.com.cn/channel/list/E" target="_blank">E</a><a href="http://www.d1.com.cn/channel/list/F" target="_blank">F</a>
     <a href="http://www.d1.com.cn/channel/list/G" target="_blank">G</a><a href="http://www.d1.com.cn/channel/list/H" target="_blank">H</a><a href="http://www.d1.com.cn/channel/list/I" target="_blank">I</a>
     <a href="http://www.d1.com.cn/channel/list/J" target="_blank">J</a><a href="http://www.d1.com.cn/channel/list/K" target="_blank">K</a><a href="http://www.d1.com.cn/channel/list/L" target="_blank">L</a>
     <a href="http://www.d1.com.cn/channel/list/M" target="_blank">M</a><a href="http://www.d1.com.cn/channel/list/N" target="_blank">N</a><a href="http://www.d1.com.cn/channel/list/O" target="_blank">O</a>
     <a href="http://www.d1.com.cn/channel/list/P" target="_blank">P</a><a href="http://www.d1.com.cn/channel/list/Q" target="_blank">Q</a><a href="http://www.d1.com.cn/channel/list/R" target="_blank">R</a>
     <a href="http://www.d1.com.cn/channel/list/S" target="_blank">S</a><a href="http://www.d1.com.cn/channel/list/T" target="_blank">T</a><a href="http://www.d1.com.cn/channel/list/U" target="_blank">U</a>
     <a href="http://www.d1.com.cn/channel/list/V" target="_blank">V</a><a href="http://www.d1.com.cn/channel/list/W" target="_blank">W</a><a href="http://www.d1.com.cn/channel/list/X" target="_blank">X</a>
     <a href="http://www.d1.com.cn/channel/list/Y" target="_blank">Y</a><a href="http://www.d1.com.cn/channel/list/Z" target="_blank">Z</a></td></tr>
 </table>
 <div class="clear"></div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>