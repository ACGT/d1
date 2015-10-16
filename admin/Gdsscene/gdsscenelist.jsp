<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%!  private static ArrayList<Gdsser> getGdseridByGdsscene()
{
	
	ArrayList<Gdsser> list=new ArrayList<Gdsser>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();	
	clist.add(Restrictions.eq("gdsser_brandid","0"));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.asc("gdsser_sort"));
	olist.add(Order.desc("gdsser_createdate"));
	List<BaseEntity> blist=Tools.getManager(Gdsser.class).getList(clist, olist, 0, 100);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((Gdsser)b);
			}
		}
	}
	return list;
	
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>场景管理</title>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
  ul{ margin:0px; padding:0px; list-style:none; margin-left:10px;}
  ul li{ height:18px;}
</style>



</head>
<body>
<h3>所有场景系列</h3>
    <%
         ArrayList<Gdsser> list=getGdseridByGdsscene();
         if(list!=null&&list.size()>0)
         {%>
        	<table border="1" style="text-align:center;">
        	<tr><td width="60">编号</td><td>系列标题</td></tr>
        	<% for(Gdsser gd:list)
        		{
        		   if(gd!=null)
        		   {%>
        			<tr><td><%= gd.getId() %></td><td><a href="/admin/Gdsscene/gmanager.jsp?sid=<%= gd.getId() %>" target="top"><%= gd.getGdsser_title() %></a></td></tr>
        		  <%}
        		}%>
        	</table>
         <%}
        
    
    %>
</body>
</html>





