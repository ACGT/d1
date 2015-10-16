<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>隐藏公告管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" 

type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
</style>
<script>
   function Deletegg(id)
   {
	   if(id==null) return;
	   $.confirm('确定要删除该公告吗？','提示',function(){
		   $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/deletegonggao.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("删除公告失败！");
		        },
		        success: function(json){
		        		$.alert('删除公告成功','提示',function(){
		        		this.location.href="hideNoticeM.jsp";

		        		});
		        },beforeSend: function(){
		        }
		    });		 
	   });
   }
</script>
</head>
<html>
<body>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">

    <h1 style=" font-size:25px;">隐藏公告管理</h1>
    <a href="addNoticeDir.jsp">添加公告</a><br/>
    <%
     ArrayList<NoticeDir> list=new ArrayList<NoticeDir>();
     
    //获取通知list
     List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
     clist.add(Restrictions.eq("flag",new Long(0)));
     
     List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("createdate"));
		List<BaseEntity> b_list = Tools.getManager(NoticeDir.class).getList(clist, olist, 0, 1000);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((NoticeDir)be);
			}
		}
		if(list!=null&&list.size()>0)
		{
		%>
			 <table width="900" border="0"  class="t" style=" margin:0px auto;">
			 <tr style=" color:#a25663;" height="25"><td class="d1" width="80">公告编号</td><td class="d1">公告标题</td><td class="d1" width="100">所属公告类型</td><td class="d1" width="150">创建时间</td><td class="d1" width="80">是否隐藏</td><td class="d1" width="200">操作</td></tr>
			    <% for(NoticeDir nn:list)
			       {  %>
			         <tr height="20">
			         <td><%= nn.getId() %></td><td><%= nn.getTitle() %></td>
			         <td><% 
			         switch(Tools.parseInt(nn.getParentId()))
			         {
			               case 1:
			            	   out.print("市场公告");
			            	   break;
			               case 2:
			            	   out.print("服务公告");
			            	   break;
			               case 3:
			            	   out.print("网站功能公告");
			            	   break;
			               default:
			            		   out.print("市场公告");
			            		   break;
			        }
			     %>
			     </td>
			     <td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(nn.getCreatedate()) %></td>
			     <td><% 
			     switch(Tools.parseInt(nn.getFlag().toString()))
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
                         
                         out.print("<a href=\"javascript:void(0)\" onclick=\"Deletegg("+nn.getId()+")\">删除</a>");
                     %>
                 </td>
			     </tr>
			
		<%}
			    %>
			 </table>    
		<%}
		else
		{
			out.print("还没有公告！！！<a href=\"addNoticeDir.jsp\">马上去添加</a>");
		}
     
	
  %>
  </div>
</body>
</html>