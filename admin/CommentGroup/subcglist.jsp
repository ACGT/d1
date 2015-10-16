<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/CommentGroup/public.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>评论子组列表</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline; padding:4px; margin:4px;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;border-bottom:solid 1px #999999;border-right:solid 1px #999999; text-align:center;}
  input{ width:250px;}
  span{ color:#f00;}
</style>
<script type="text/javascript" language="javascript">
  function deleteCommentGroup(id,cgid)
  {
	$.confirm('确定要删除该记录吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/CommentGroup/deletecommentgroupsub.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            $.alert("删除失败！");
		        },
		        success: function(json){
		        		$.alert(json.message,'提示',function(){
		        		this.location.href="/admin/CommentGroup/subcglist.jsp?cgid="+cgid;
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}
</script>

</head>
<body style="text-align:center;">
<br/><br/>
   <%
       String cgid="";
	   if(request.getParameter("cgid")!=null&&request.getParameter("cgid").length()>0)
	   {
		   cgid=request.getParameter("cgid");
	   }
       String ggURL = Tools.addOrUpdateParameter(request,null,null);
       CommentGroup nd=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgid);
       if(nd==null)
       {
    	   out.print("记录不存在！");
    	   return;
       }
       ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cgid);
       if(cgslist!=null&&cgslist.size()>0){
    	   %>
    	   <a href="<%= ggURL %>">刷新页面</a>
    	   <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="1" cellspcing="0" cellpadding="0">
    	       <tr style="background:#f4f4f4; color:#333; font-size:15px;"><td width="100" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">商品图片</td><td width="80" style="border-top:solid 1px #999999;" >编号</td>
    	       <td width="200" style="border-top:solid 1px #999999;">评论主组编号</td>
    	       <td width="150" style="border-top:solid 1px #999999;">商品id</td>
    	       <td width="80" style="border-top:solid 1px #999999;">是否有效</td>
    	       <td width="120" style="border-top:solid 1px #999999;">创建时间</td>
    	       <td width="100" style="border-top:solid 1px #999999;">操作</td>
    	   
    	   <%
    	 //分页
		   int pageno1=1;
    	   if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*50;i<cgslist.size()&&i<pageno1*50;i++)
    	  {
	    	   CommentGroupSub cgs=cgslist.get(i);
    	       if(cgs!=null){
    	    	   %>
    	          <tr >
    	              <td style="border-top:solid 1px #999999;border-left:solid 1px #999999;">
    	              <%
    	           if(cgs.getCommentgroupsub_gdsid()!=null&&Tools.isNumber(cgs.getCommentgroupsub_gdsid()))
           		   {
           			   Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid());
           			  
           			   if(p!=null)
           			   {%>
           				<a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn<%=p.getGdsmst_smallimg()!=null?p.getGdsmst_smallimg():"" %>"/></a>
           			   <%}
           		   }
    	              %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cgs.getId() %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cgs.getCommentgroupsub_cgid() %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cgs.getCommentgroupsub_gdsid()%></td>
    	              <td style="border-top:solid 1px #999999;"><%= cgs.getCommentgroupsub_flag().longValue()==1?"有效":"无效" %></td>
                      <td style="border-top:solid 1px #999999;"><%
                      SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      out.print(fmt.format(cgs.getCommentgroupsub_createtime())); %></td>
                      <td style="border-top:solid 1px #999999;"><a href="/admin/CommentGroup/updatecommentgroupsub.jsp?id=<%= cgs.getId() %>" target="bottom">修改</a>
                      &nbsp;&nbsp;&nbsp;
                      <a href="javascript:void(0)" onclick="deleteCommentGroup('<%= cgs.getId() %>','<%= cgs.getCommentgroupsub_cgid() %>')">删除</a></td>
                      
    	          </tr>   	   
    	    <%   }
    	  }
    	   
		   
		   if(ggURL != null) {
				ggURL.replaceAll("pageno1=[0-9]*","");
		   }
		   int totalLength1 = (cgslist != null ?cgslist.size() : 0);
		   int PAGE_SIZE = 50 ;
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
		   if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
		 %>
		 <% if(cgslist!=null&&cgslist.size()>0&&totalLength1>2)
				       {%>
    	   <tr>
             
				       <td colspan="7" height="45" style="border-left:solid 1px #999999;">
				       
				    	    <span class="Pager" style="margin:0px auto; overflow:hidden;">
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
				           </span>
				    	   
				    
				       
				          
				       </td>
				 </tr>
				   <%} %>
 
    	   </table>
    	   <br/>
    	   <a href="/admin/CommentGroup/addCommentGroupSub.jsp?cgid=<%= cgid %>" target="bottom">新增记录>></a>
       <%}
       else
       {%>
    	 &nbsp;&nbsp;对不起，还没有评论组的详细记录，<a href="/admin/CommentGroup/addCommentGroupSub.jsp?cgid=<%= cgid %>" target="bottom">立即添加>></a>  
    	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%= ggURL %>">刷新页面</a>
       <%}
   %>


</body>
</html>





