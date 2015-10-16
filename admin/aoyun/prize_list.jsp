<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
</head>
<style type="text/css">
<!--
body,td,th {
	font-size: 13px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

-->
</style>
<%

String ggURL = Tools.addOrUpdateParameter(request,null,null);
SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd");
String mbruid=request.getParameter("mbruid");
String content=request.getParameter("content");
String typeid=request.getParameter("typeid");
if(mbruid!=null||content!=null||typeid!=null)   
{
	  
  

	ArrayList<AYPrize> list=new ArrayList<AYPrize>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	if(mbruid!=null&&mbruid.length()>0)
	{
	  clist.add(Restrictions.like("prize_muid",mbruid));
	}
	if(content!=null&&content.length()>0)
	{
	  clist.add(Restrictions.like("prize_content",content));
	}
	if(typeid!=null&&typeid.length()>0)
	{
	  clist.add(Restrictions.eq("prize_type",Tools.parseInt(typeid)));
	}
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("id"));
	List<BaseEntity> blist=Tools.getManager(AYPrize.class).getList(clist, olist, 0, 1000);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((AYPrize)b);
			}
		}
	}
		
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
       
       <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="180">会员名</td><td width="80">中奖信息</td><td width="100">类型</td><td width="200">创建时间</td><td width="120">操作</td></tr>
  	 <% 
  	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
  	  {
	    	  AYPrize fl=list.get(i);
  		  if(fl!=null)
  		  {%>
  			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td><%= fl.getId() %></td>
  			<td><a href="prize_modi.jsp?id=<%= fl.getId()%>" target="rbottom"><%=fl.getPrize_muid()%></a></td>
  			<td><%=fl.getPrize_content() %></td>
  			<td><%=fl.getPrize_createdate() %></td>
  			<td><%if(fl.getPrize_type()==1){
  				out.print("T恤");
  			}else{
  				out.print("免单");
  			}
  			%></td>
  			<td><a href="prize_modi.jsp?id=<%=fl.getId() %>" target="rbottom">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteTag('<%= fl.getId() %>')">删除</a>
  			</td>
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

<%	
}
}
%>
<script type="text/javascript" language="javascript">
    function deleteTag(id)
   {
   	$.confirm('确定要删除该标签吗？','提示',function(){
   		 $.ajax({
   		        type: "post",
   		        dataType: "json",
   		        url: "/ajax/admin/deleteprize.jsp",
   		        cache: false,
   		        data:{id:id},
   		        error: function(XmlHttpRequest){
   		            alert("删除失败！");
   		        },
   		        success: function(json){
   		        		$.alert(json.message,'提示',function(){
   		        		this.location.href="prize_list.jsp";
   		        		});
   		        },beforeSend: function(){
   		        }
   		    });	
   	});
   }
  </script>