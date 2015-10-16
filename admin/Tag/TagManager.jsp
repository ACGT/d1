<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%
    String id="";
    String name="";
    if(request.getParameter("ids")!=null&&request.getParameter("ids").length()>0&&Tools.isNumber(request.getParameter("ids"))){
    	id=request.getParameter("ids");
    }
    if(request.getParameter("title")!=null&&request.getParameter("title").length()>0){
    	name=request.getParameter("title").trim();
    }


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标签管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head1208.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
   body{ backgroound:#fff; padding:0px; margin:0px; font-size:14px;}
   .addtag{ margin:0px auto; width:980px;}
   span{ color:#f00;} 
   td{ border:solid 1px #333;} 
   a{ color:#00f;}
</style>
</head>
<body>
   <div class="addtag">
      
         <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="0" cellspcing="0" cellpadding="0">
               <tr><td colspan="8" style="text-align:center "><h3>标签管理</h3></td></tr>
               <tr><td colspan="8"  style="text-align:center"><a href="addTag.jsp" target="bottom">添加标签</a></td></tr>
               <%
                   ArrayList<Tag> list=new ArrayList<Tag>();
                   list=TagHelper.getTags(name,id);
                 //分页
                   int pageno1=1;
                   String ggURL = Tools.addOrUpdateParameter(request,null,null);
                   if(ggURL != null) 
                   	   {
                   	     ggURL.replaceAll("pageno1=[0-9]*","");
                   	   }
                   //翻页
                     int totalLength1 = (list != null ?list.size() : 0);
                     int PAGE_SIZE = 15 ;
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
                   {%>
                   <tr><td>编号</td><td width="80">标签名称</td><td width="150">标题</td><td width="200">描述</td><td width="200">分词标签</td><td>所属字母</td><td>点击量</td><td>操作</td></tr>
                	  <% 
                	  if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
           		       {
           			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
           		       }
           	    	 
           	           for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
                	   {
           	        	   Tag t=list.get(i);
                		   if(t!=null)
                		   {%>
                			 <tr><td><%= t.getId() %></td><td><a href="/channel/<%= t.getId() %>" target="_blank"><%= t.getTag_key() %></a></td>
                			     <td><%= t.getTag_title() %></td><td><%= t.getTag_description() %></td>
                			     <td><%= t.getTag_tag() %></td><td><%= t.getTag_letters() %></td>
                			     <td><%= t.getTag_counts().longValue() %></td>
                			     <td><a href="updatetag.jsp?id=<%=t.getId() %>" target="bottom">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteTag('<%= t.getId() %>')">删除</a></td>
                			 </tr>  
                		   <%}
                	   }
           	           
                   }
                   else{%>
                	   <tr><td colspan="8" style="text-align:center;width:700px; height:40px; line-height:40px; font-size:16px; color:#f00; ">对不起，没有满足条件的标签！</td></tr>
                   <%}
               %>
                <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>1){
					           %>
					           <tr>
					          <td colspan="8" height="45">
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
				     </tr><%}%>	
         </table>
         
         
         
         
        
     
   </div>
</body>
</html>
<script type="text/javascript" language="javascript">
   function losefocues(obj)
   {
	   if(obj=="key")
		   {
		      if($('#tag_key').val()=="")
		    	  {
		    	     $('#keynotice').html('标签名称不能为空！');
		    	     return;
		    	  }
		      else
		    	  {
		    	   $('#keynotice').html('');
		    	  }
		   }
	   
   }
   
   function Check()
   {
	   if($('#tag_key').val()=="")
		   {
		   alert('标签名称不能为空！');
		   return;
		   }
	   else if($('#tag_title').val()=="")
		   {
		   alert('标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#addTag').submit();
		   }
   }
   function deleteTag(id)
   {
   	$.confirm('确定要删除该标签吗？','提示',function(){
   		 $.ajax({
   		        type: "post",
   		        dataType: "json",
   		        url: "/ajax/notice/deletetag.jsp",
   		        cache: false,
   		        data:{id:id},
   		        error: function(XmlHttpRequest){
   		            alert("删除失败！");
   		        },
   		        success: function(json){
   		        		$.alert('删除成功！','提示',function(){
   		        		this.location.href="TagManager.jsp";
   		        		});
   		        },beforeSend: function(){
   		        }
   		    });	
   	});
   }
   function cancel()
   {
	   window.location.href="TagManager.jsp";
   }
</script>