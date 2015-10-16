<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>文章管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  h1{ font-size:20px; color:#f00;}
  table{ text-align:left; }
  td{ height:30px;}
</style>

<script language="javascript" type="text/javascript">
function hidenotice(id,flag)
{
	 if(id==null)
		 {
		 return;
		 }
	 message=flag==0?'隐藏':'显示';
	 $.confirm('确定要'+message+'该文章吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/hidenotice.jsp",
		        cache: false,
		        data:{noticeid:id,flag:flag},
		        error: function(XmlHttpRequest){
		            alert(message+"文章失败！");
		        },
		        success: function(json){
		        		$.alert('文章'+message+'成功','提示',function(){
		        		this.location.reload();

		        		});
		        },beforeSend: function(){
		        }
		    });		
		 
		 
		 
			});
}




</script>

</head>
<body>
<%  //获取内容
    String content="";
    if(request.getParameter("content")!=null&&request.getParameter("content").length()>0)
    {
    	content=request.getParameter("content");
    }
   
%>

  <%
     ArrayList<Notice> list=new ArrayList<Notice>();
     
    //获取通知list
        List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
  
        List<Order> olist = new ArrayList<Order>();
        olist.add(Order.desc("priority"));
		olist.add(Order.desc("createdate"));
		List<BaseEntity> b_list = Tools.getManager(Notice.class).getList(clist, olist, 0, 1000);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Notice)be);
			}
		}
  %>
  
  <div style="margin:0px auto; width:980px; text-align:center; padding-top:30px;">
     <h1>文章管理</h1>
     <a href="addnotice.jsp">添加文章</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="noticedirManage.jsp">公告管理</a>
     <%

		
		if(list!=null)
		{%>
           <table width="900"  border="0"  class="t" style=" margin:0px auto;">
            <tr style=" color:#a25663;" height="25"><td class="d1" width="80">文章编号</td><td class="d1">文章标题</td><td class="d1" width="100">所属公告</td><td class="d1" width="150">创建时间</td><td class="d1" width="40">排序值</td><td class="d1" width="80">是否隐藏</td><td class="d1" width="200">操作</td></tr>
			    <% for(Notice notice:list)
			       {  %>
			         <tr height="20">
			         <td><%= notice.getId() %></td><td><%= notice.getTitle() %></td>
			         <td><% 
			         NoticeDir nd=new NoticeDir();
			         nd=(NoticeDir)Tools.getManager(NoticeDir.class).get(notice.getDirId());
			         if(nd!=null)
			         {
			        	 out.print(nd.getTitle());
			         }
			     %>
			     </td>
			     <td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(notice.getCreatedate()) %></td>
			     <td><%= notice.getPriority() %></td>
			     <td><% 
			     switch(Tools.parseInt(notice.getFlag().toString()))
			         {
			               case 0:
			            	   out.print("隐藏");
			            	   break;
			               case 1:
			            	   out.print("不隐藏");
			            	   break;
			               default:
			            		   out.print("隐藏");
			            		   break;
			        }
			     %></td>
			     <td>
                     <%
                         if(notice.getFlag()==1)
                         {
                        	 out.print("<a href=\"javascript:void(0)\" onclick=\"hidenotice("+ notice.getId() +",0);\" >隐藏</a>");
                         }
                         else
                         {
                        	 out.print("<a href=\"javascript:void(0)\" onclick=\"hidenotice("+ notice.getId() +",1);\" >显示</a>");
                             
                         }
                         out.print("<a href=\"updatenotice.jsp?ID="+notice.getId()+"\" >修改</a>");
                     %>
                 </td>
			     </tr>
			
		     <%}
			    %>
			
           </table>
		<%}
		else
		{
			out.print("还没有文章！！！<a href=\"addnotice.jsp\">马上去添加</a>");
		}
  
	
     
     %>
     
    
 
  </div>
</body>
</html>