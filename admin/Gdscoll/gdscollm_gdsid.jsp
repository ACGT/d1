<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%!
   //根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
   private static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
   {
	  boolean flag=false;
	  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
	  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		//clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		
		if(list!=null&&list.size()>0)
		{
			if(gdsid.length()==0)
			{
				result=list;
			}
			else
			{
				for(Gdscoll gdscoll:list)
				{
					if(gdscoll!=null)
					{
						ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
						if(gdlist!=null)
						{
							for(Gdscolldetail gd:gdlist)
							{
								if(gd.getGdscolldetail_gdsid().equals(gdsid))
								{
									flag=true;
								}
							}
						}
						if(flag)
						{
							result.add(gdscoll);
						}
						flag=false;
					}
					
				}
				return result;
			}
		}
		return result;
   }


%>
<%

   String gid="";
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	   gid=request.getParameter("gdsid");
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

function deleteGdscoll(id,sid)
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
		        		this.location.href="/admin/Gdscoll/gmanager.jsp?sid="+sid;
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}


</script>

</head>
<body>

<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;">
   <h1 style=" font-size:25px;">搭配管理</h1>
  
   <%
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
      ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
      list=null;
      list=getGdscollByGdsid(gid);
      
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
         <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="80">系列编号</td><td width="120">系列名称</td><td>预览图</td><td width="200">搭配标题</td><td width="80">排序</td><td width="80">是否显示</td><td width="90">操作</td></tr>
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
    			<% Gdsser gds=(Gdsser)Tools.getManager(Gdsser.class).get(fl.getGdscoll_serid().toString()); if(gds!=null) out.print("<td>"+gds.getGdsser_title()+"</td>"); else { out.print("<td></td>");} %>
    			<%}
    			else{out.print("<td></td>");
    			}
    			%>
    			<td><img src="http://images1.d1.com.cn<%= fl.getGdscoll_smallimgurl() %>"/></td>
    			<td><%= fl.getGdscoll_title() %></td><td><%= fl.getGdscoll_sort()%></td>
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
    			
    			
    			<td><a href="gcupdate.jsp?id=<%=fl.getId() %>&sid=<%= fl.getGdscoll_serid().toString() %>" target="bottom">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteGdscoll('<%= fl.getId() %>',<%= gid%>)">删除</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/admin/Gdscoll/agd.jsp?gdscollid=<%= fl.getId() %>" target="bottom">添加搭配详细</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= fl.getId() %>" target="_blank">预览搭配</a></td>
    			</tr>  
    		  <%}
    	  }%>
    	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
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





