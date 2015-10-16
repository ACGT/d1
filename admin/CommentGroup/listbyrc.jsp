<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/CommentGroup/public.jsp" %>
<%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "CommentGroup");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品相关联的评论组</title>
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
function addcomment(gdsid,cid)
{
	$.ajax({
		type: "get",
		dataType: "json",
		url: 'add.jsp',
		cache: false,
		data: {gdsid:gdsid,cid:cid},
		error: function(XmlHttpRequest){
			alert("添加该评论组出错，请稍后重试！");
		},success: function(json){	
			if(json.succ){
			alert(json.message);
			window.close();
			}
			else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>

</head>
<body style="text-align:center;">
<%
     ArrayList<CommentGroup> cglist=new ArrayList<CommentGroup>();  
     ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();  
     ArrayList<CommentGroup> cglist2=new ArrayList<CommentGroup>(); 
     String code="";//分类号
     String gdsid="";
     String act="";
     String id="";
     if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
     {
    	 gdsid=request.getParameter("gdsid");
     }
     if(request.getParameter("id")!=null&&request.getParameter("id").length()>0&&Tools.isNumber(request.getParameter("id")))
     {
    	 id=request.getParameter("id");
     }
     if(request.getParameter("act")!=null&&request.getParameter("act").length()>0)
     {
    	 act=request.getParameter("act");
     }
     Product product=ProductHelper.getById(gdsid);
     if(product!=null&&product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>6)
     {
    	 code=product.getGdsmst_rackcode().substring(0,6);
     }
     if(act.equals("1"))
     {
    	 cglist=getCGListByGC1("",code,"");
     }
     else
     {
    	 cglist=getCGListByGC1(gdsid,"","");
     }
     
%>




<br/><br/>
   <%
       String ggURL = Tools.addOrUpdateParameter(request,null,null);
       
       if(cglist!=null&&cglist.size()>0){
    	   if(act.equals("1"))
    	     {
    	   %>
    	   <a href="<%= ggURL %>">刷新页面</a>
    	   <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="1" cellspcing="0" cellpadding="0">
    	        <tr style="background:#f4f4f4; color:#333; font-size:15px;"><td style="border-top:solid 1px #999999;border-left:solid 1px #999999;">操作</td><td width="60" style="border-top:solid 1px #999999;" >编号</td><td width="100" style="border-top:solid 1px #999999;">评论组标题</td>
    	       <td width="500" style="border-top:solid 1px #999999;">商品图片</td>
    	       <td width="70" style="border-top:solid 1px #999999;">评论组商品分类号</td><td width="80" style="border-top:solid 1px #999999;">是否有效</td>
    	        <td width="120" style="border-top:solid 1px #999999;">创建时间</td><td width="100" style="border-top:solid 1px #999999;">操作</td>
    	       <td width="100" style="border-top:solid 1px #999999;">数量/操作</td></tr>
    	   
    	   <%
    	 //分页
		   int pageno1=1;
    	   if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*50;i<cglist.size()&&i<pageno1*50;i++)
    	  {
	    	   CommentGroup cg=cglist.get(i);
    	       if(cg!=null){
    	    	   %>
    	          <tr >
    	          <td style="border-top:solid 1px #999999;border-left:solid 1px #999999;">
    	              <input type="button" onclick="addcomment('<%= gdsid %>','<%= cg.getId() %>')" value="加入该评论组" style="width:120px;"/>
    	          </td>
    	              <td style="border-top:solid 1px #999999;"><%= cg.getId() %></td><td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_title() %></td>
    	                 <td>
    	             
    	                 <%
    	                   ArrayList<CommentGroupSub> cgslist1=new ArrayList<CommentGroupSub>();
    	                   cgslist1=getCommentGroupSubList(cg.getId());
    	                   if(cgslist1!=null&&cgslist1.size()>0)
    	                   {
    	                	   int count=0;
    	                	   for(CommentGroupSub cgs:cgslist1)
    	                	   {
    	                		   if(cgs!=null&&cgs.getCommentgroupsub_gdsid()!=null&&Tools.isNumber(cgs.getCommentgroupsub_gdsid()))
    	                		   {
    	                			   Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid());
    	                			  
    	                			   if(p!=null)
    	                			   {
    	                			   count++;   
    	                			   if(count>4){    	                				   
    	                				   break;
    	                			   }
    	                			   %>
    	                			   <div style="width:100px; height:120px;float:left;">
    	                				 <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn<%=p.getGdsmst_smallimg()!=null?p.getGdsmst_smallimg():"" %>"/></a>
                                          <br/>
                                          <%= p.getId().trim() %><a href="javascript:void(0)" onclick="deleteCommentGroupSub('<%= cgs.getId() %>','<%= cg.getId() %>')">删除</a><br/>
                                          <%
                                              if(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()!=1)
                                              {
                                            	  out.print("此商品已下架");
                                              }
                                          %>
    	                			   </div>
    	                			   <%
    	                			  
    	                			   }
    	                		   }
    	                	   }
    	                	   if(count>4)
    	                	   {%>
    	                		 &nbsp;<a href="/admin/CommentGroup/subcglist.jsp?cgid=<%= cg.getId() %>"  target="bottom" style="margin-top:20px; display:block;">更多</a>  
    	                	   <%}
    	                   }
    	              %>
    	                	
    	              </td>
    	              <td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_rackcode() %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_flag().longValue()==1?"有效":"无效" %></td>
                      <td style="border-top:solid 1px #999999;"><%
                      SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      out.print(fmt.format(cg.getCommentgroup_createtime())); %></td>
                      <td style="border-top:solid 1px #999999;"><a href="/admin/CommentGroup/updatecommentgroup.jsp?id=<%= cg.getId() %>" target="bottom">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteCommentGroup('<%= cg.getId() %>')">删除</a></td>
                      <td style="border-top:solid 1px #999999;"><% ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId()); if(cgslist!=null&&cgslist.size()>0) out.print(cgslist.size()); 
                      else out.print("0");%>
                      &nbsp;&nbsp;<a href="/admin/CommentGroup/addCommentGroupSub.jsp?cgid=<%= cg.getId() %>" target="bottom">添加</a></td>
    	          </tr>   	   
    	    <%   }
    	  }
    	   
		   
		   if(ggURL != null) {
				ggURL.replaceAll("pageno1=[0-9]*","");
		   }
		   int totalLength1 = (cglist != null ?cglist.size() : 0);
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
    	   <tr>
             
				       <td colspan="9" height="45" style="border-left:solid 1px #999999;">
				       <% if(cglist!=null&&cglist.size()>0)
				       {%>
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
				    	   
				      <%} %>
				       
				          
				       </td>
				 </tr>
 
    	   </table>
       <%}
    	   else
    	   {%>
    		   <a href="<%= ggURL %>">刷新页面</a>	 
    		   <%  if(id.length()>0){
    			     for(CommentGroup cg:cglist)
    			     {
    			    	 if(cg!=null&&cg.getId().equals(id))
    			    	 {
    			    		 cglist1.add(cg);
    			    	 }
    			    	 else
    			    	 {
    			    		 cglist2.add(cg);
    			    	 }
    			     }
    		       } 
    		   
    		   %>
    		   
    		   
    		   
    	       <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="1" cellspcing="0" cellpadding="0">
    	        <tr style="background:#f4f4f4; color:#333; font-size:15px;"><td width="60" style="border-top:solid 1px #999999; border-left:solid 1px #999999;" >编号</td><td width="100" style="border-top:solid 1px #999999;">评论组标题</td>
    	       <td width="500" style="border-top:solid 1px #999999;">商品图片</td>
    	       <td width="70" style="border-top:solid 1px #999999;">评论组商品分类号</td><td width="80" style="border-top:solid 1px #999999;">是否有效</td>
    	        <td width="120" style="border-top:solid 1px #999999;">创建时间</td><td width="100" style="border-top:solid 1px #999999;">操作</td>
    	       <td width="100" style="border-top:solid 1px #999999;">数量/操作</td></tr>
    	   
    	   <%
    	       if(cglist1.size()>0)
    	       {%>
    	    	   <tr >
    	           <td style="border-top:solid 1px #999999;"><%= cglist1.get(0).getId() %></td><td style="border-top:solid 1px #999999;"><%= cglist1.get(0).getCommentgroup_title() %></td>
    	                 <td>
    	             
    	                 <%
    	                   ArrayList<CommentGroupSub> cgslistn=new ArrayList<CommentGroupSub>();
    	                   cgslistn=getCommentGroupSubList(cglist1.get(0).getId());
    	                   if(cgslistn!=null&&cgslistn.size()>0)
    	                   {
    	                	   int count=0;
    	                	   for(CommentGroupSub cgs:cgslistn)
    	                	   {
    	                		   if(cgs!=null&&cgs.getCommentgroupsub_gdsid()!=null&&Tools.isNumber(cgs.getCommentgroupsub_gdsid()))
    	                		   {
    	                			   Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid());
    	                			  
    	                			   if(p!=null)
    	                			   {
    	                			   count++;   
    	                			   if(count>4){    	                				   
    	                				   break;
    	                			   }
    	                			   %>
    	                			   <div style="width:100px; height:120px;float:left;">
    	                				 <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn<%=p.getGdsmst_smallimg()!=null?p.getGdsmst_smallimg():"" %>"/></a>
                                          <br/>
                                          <%= p.getId().trim() %><a href="javascript:void(0)" onclick="deleteCommentGroupSub('<%= cgs.getId() %>','<%= cglist1.get(0).getId() %>')">删除</a><br/>
                                          <%
                                              if(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()!=1)
                                              {
                                            	  out.print("此商品已下架");
                                              }
                                          %>
    	                			   </div>
    	                			   <%
    	                			  
    	                			   }
    	                		   }
    	                	   }
    	                	   if(count>4)
    	                	   {%>
    	                		 &nbsp;<a href="/admin/CommentGroup/subcglist.jsp?cgid=<%= cglist1.get(0).getId() %>"  target="bottom" style="margin-top:20px; display:block;">更多</a>  
    	                	   <%}
    	                   }
    	              %>
    	                	
    	              </td>
    	              <td style="border-top:solid 1px #999999;"><%= cglist1.get(0).getCommentgroup_rackcode() %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cglist1.get(0).getCommentgroup_flag().longValue()==1?"有效":"无效" %></td>
                      <td style="border-top:solid 1px #999999;"><%
                      SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      out.print(fmt.format(cglist1.get(0).getCommentgroup_createtime())); %></td>
                      <td style="border-top:solid 1px #999999;"><a href="/admin/CommentGroup/updatecommentgroup.jsp?id=<%= cglist1.get(0).getId() %>" target="bottom">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteCommentGroup('<%= cglist1.get(0).getId() %>')">删除</a></td>
                      <td style="border-top:solid 1px #999999;"><% ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cglist1.get(0).getId()); if(cgslist!=null&&cgslist.size()>0) out.print(cgslist.size()); 
                      else out.print("0");%>
                      &nbsp;&nbsp;<a href="/admin/CommentGroup/addCommentGroupSub.jsp?cgid=<%= cglist1.get(0).getId() %>" target="bottom">添加</a></td>
    	          </tr>  
    	          <%  if(cglist2!=null&&cglist2.size()>0){ %> 
    	          <tr><td colspan="9" style="color:#f00;">&nbsp;&nbsp;其他评论组</td></tr>
    	          <%} %>
    	    <%   }
    	   
    	 //分页
		   int pageno1=1;
    	   if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*50;i<cglist2.size()&&i<pageno1*50;i++)
    	  {
	    	   CommentGroup cg=cglist2.get(i);
    	       if(cg!=null){
    	    	   %>
    	          <tr >
    	           <td style="border-top:solid 1px #999999;"><%= cg.getId() %></td><td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_title() %></td>
    	                 <td>
    	             
    	                 <%
    	                   ArrayList<CommentGroupSub> cgslistm=new ArrayList<CommentGroupSub>();
    	                   cgslistm=getCommentGroupSubList(cg.getId());
    	                   if(cgslistm!=null&&cgslistm.size()>0)
    	                   {
    	                	   int count=0;
    	                	   for(CommentGroupSub cgs:cgslistm)
    	                	   {
    	                		   if(cgs!=null&&cgs.getCommentgroupsub_gdsid()!=null&&Tools.isNumber(cgs.getCommentgroupsub_gdsid()))
    	                		   {
    	                			   Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid());
    	                			  
    	                			   if(p!=null)
    	                			   {
    	                			   count++;   
    	                			   if(count>4){    	                				   
    	                				   break;
    	                			   }
    	                			   %>
    	                			   <div style="width:100px; height:120px;float:left;">
    	                				 <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank" ><img src="http://images.d1.com.cn<%=p.getGdsmst_smallimg()!=null?p.getGdsmst_smallimg():"" %>"/></a>
                                          <br/>
                                          <%= p.getId().trim() %><a href="javascript:void(0)" onclick="deleteCommentGroupSub('<%= cgs.getId() %>','<%= cg.getId() %>')">删除</a><br/>
                                          <%
                                              if(p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()!=1)
                                              {
                                            	  out.print("此商品已下架");
                                              }
                                          %>
    	                			   </div>
    	                			   <%
    	                			  
    	                			   }
    	                		   }
    	                	   }
    	                	   if(count>4)
    	                	   {%>
    	                		 &nbsp;<a href="/admin/CommentGroup/subcglist.jsp?cgid=<%= cg.getId() %>"  target="bottom" style="margin-top:20px; display:block;">更多</a>  
    	                	   <%}
    	                   }
    	              %>
    	                	
    	              </td>
    	              <td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_rackcode() %></td>
    	              <td style="border-top:solid 1px #999999;"><%= cg.getCommentgroup_flag().longValue()==1?"有效":"无效" %></td>
                      <td style="border-top:solid 1px #999999;"><%
                      SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                      out.print(fmt.format(cg.getCommentgroup_createtime())); %></td>
                      <td style="border-top:solid 1px #999999;"><a href="/admin/CommentGroup/updatecommentgroup.jsp?id=<%= cg.getId() %>" target="bottom">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteCommentGroup('<%= cg.getId() %>')">删除</a></td>
                      <td style="border-top:solid 1px #999999;"><% ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId()); if(cgslist!=null&&cgslist.size()>0) out.print(cgslist.size()); 
                      else out.print("0");%>
                      &nbsp;&nbsp;<a href="/admin/CommentGroup/addCommentGroupSub.jsp?cgid=<%= cg.getId() %>" target="bottom">添加</a></td>
    	          </tr>   	   
    	    <%   }
    	  }
    	   
		   
		   if(ggURL != null) {
				ggURL.replaceAll("pageno1=[0-9]*","");
		   }
		   int totalLength1 = (cglist != null ?cglist.size() : 0);
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
    	   <tr>
             
				       <td colspan="9" height="45" style="border-left:solid 1px #999999;">
				       <% if(cglist!=null&&cglist.size()>0)
				       {%>
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
				    	   
				      <%} %>
				       
				          
				       </td>
				 </tr>
 
    	   </table>  
    	   <%}
       }
       else
       {%>
    	对不起，没有您要找的数据！
       <%}
   %>


</body>
</html>
