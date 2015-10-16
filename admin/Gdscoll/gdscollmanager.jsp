<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%

   String sid="";
   if(request.getParameter("sid")!=null&&request.getParameter("sid").length()>0)
   {
	   sid=request.getParameter("sid");
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>搭配管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
   input{ width:250px;}
     span{ color:#f00;}
</style>

<script type="text/javascript" language="javascript">

function deleteGdscoll(id)
{
	$.confirm('确定要删除该搭配吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/deletegdscoll.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("删除失败！");
		        },
		        success: function(json){
		        		$.alert(json.message,'提示',function(){
		        		this.location.href="/admin/Gdscoll/gdscollmanager.jsp";
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}

function Search()
{
	var rc=$('#result_b').val();
	if(rc=='')
		{
		  $.alert('请输入系列编号进行搜索！');
		  return;
		}
	else if(isNaN(rc))
		{
		$.alert('输入场景编号格式不正确！');
		  return;
		}
	else
		{
		  this.location.href="gdscollmanager.jsp?sid="+rc;
		}
}
</script>

</head>
<body>

<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;">
   <h1 style=" font-size:25px;">搭配管理</h1>
   <a href="addGdscoll.jsp">添加搭配</a><br/>
   <%
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
      list=GdscollHelper.getGdscollBysceneid(sid);
      
      //分页
      int pageno1=1;
      
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
      <table style="margin:0px auto;text-align:center; border:solid 1px #f4f4f4;"  border="0" cellspcing="0" cellpadding="0">
         <tr><td colspan="9" style=" color:#f00;"><br/>请输入系列编号：<input type="text" id="result_b" name="result_b" style=" width:60px;"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="查询" onclick="Search()" style="width:60px;"/><br/><br/></td></tr>
         <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="80">系列编号</td><td width="120">系列名称</td><td width="200">搭配标题</td><td width="80">排序</td><td width="80">大图</td><td width="80">小图</td><td width="80">场景图</td><td width="80">品牌图</td><td width="80">是否显示</td><td width="90">操作</td></tr>
    	 <% 
    	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
    	  {
	    	  Gdscoll fl=list.get(i);
    		  if(fl!=null)
    		  {%>
    			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td><%= fl.getId() %></td><td><% if(fl.getGdscoll_serid()!=null) out.print(fl.getGdscoll_serid().longValue()); %></td>
    			<% if(fl.getGdscoll_serid()!=null&&fl.getGdscoll_serid().toString().length()>0) {%>
    			<% Gdsser gds=(Gdsser)Tools.getManager(Gdsser.class).get(fl.getGdscoll_serid().toString()); if(gds!=null) out.print("<td>"+gds.getGdsser_title()+"</td>"); %>
    			<%}
    			else{out.print("<td></td>");
    			}
    			%>
    			<td><%= fl.getGdscoll_title() %></td><td><%= fl.getGdscoll_sort()%></td>
    			<td><a href="http://images1.d1.com.cn<%= fl.getGdscoll_bigimgurl() %>" target="_blank">点击查看</a></td>
    			<td><a href="http://images1.d1.com.cn<%= fl.getGdscoll_smallimgurl() %>" target="_blank">点击查看</a></td>
    			<td><a href="http://images1.d1.com.cn<%= fl.getGdscoll_indextitle() %>" target="_blank">点击查看</a></td>
    			<td><a href="http://images1.d1.com.cn<%= fl.getGdscoll_brandimg() %>" target="_blank">点击查看</a></td>
    			<td>
    			<%
    			    if(fl.getGdscoll_flag().longValue()==1)
    			    {
    			    	out.print("显示");
    			    }
    			    else
    			    {
    			    	out.print("不显示");
    			    }
    			   
    			%>
    			</td>
    			
    			
    			<td><a href="gdscollupdate.jsp?id=<%=fl.getId() %>" >修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteGdscoll('<%= fl.getId() %>')">删除</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/admin/Gdscoll/addgdscolldetail.jsp?gdscollid=<%= fl.getId() %>" target="_blank">添加搭配详细</a></td>
    			</tr>  
    		  <%}
    	  }%>
    	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>1){
					           %>
					           <tr>
					   <td colspan="6" height="45">
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
      <%}
      else
      {%>
    	还没有搭配，<a href="/admin/Gdscoll/addgdsscene.jsp">马上去添加</a>  
      <%}
   
   %>
 
</div>
</body>
</html>





