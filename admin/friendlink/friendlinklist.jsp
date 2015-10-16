<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%

   if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "friendlink");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
   } 
   else {return;}


   String id="";
   if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
   {
	   id=request.getParameter("id");
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>友情链接管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
   input{ width:250px;}
     span{ color:#f00;}
</style>

<script type="text/javascript" language="javascript">
function Check()
{
	   var kw=$("#keyword").val();
	   var ws=$("#website").val();
	   if(kw=='')
		   {
		   $('#keyword_notice').html('关键字不能为空！');
		   return false;
		   }
	   else
		   {
		   $('#keyword_notice').html('');
		   }
	   if(ws=='')
		   {
		   $('#website_notice').html('网址不能为空！');
		   return false;
		   }
	   else
		   {
		   $('#website_notice').html('');
		   }
	   return true;
	     }

function cancle()
{
	   $("#keyword").val('');
	   $("#website").val('');
	   $("#qq").val('');
	   $("#page").val('');
	   $("#nofollow").val('0');
	   $("#keyword").focus();
}

function deleteFriendLink(id)
{
	$.confirm('确定要删除该友情链接吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/deletefriendlink.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("删除失败！");
		        },
		        success: function(json){
		        		$.alert(json.message,'提示',function(){
		        		this.location.href="friendlinklist.jsp";
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}
</script>

</head>
<body>
<%
  if("post".equals(request.getMethod().toLowerCase()))   
  {
	  String keyword=request.getParameter("keyword");
	  String website=request.getParameter("website");
	  String qq=request.getParameter("qq");
	  String pages=request.getParameter("page");
	  String nofollow=request.getParameter("nofollow");
	  String counterids= request.getParameter("counterid");
	  if(keyword==null||keyword.length()==0)
	  {
		  Tools.outJs(out, "关键字不能为空", "back");
		  return;
	  }
	  if(website==null||website.length()==0)
	  {
		  Tools.outJs(out, "网址不能为空", "back");
		  return;
	  }
	  if(qq!=null&&qq.length()>0&&!Tools.isMath(qq))
	  {
		  Tools.outJs(out, "qq格式不正确！", "back");
		  return;
	  }
	  if(Tools.isNull(counterids)){
		  counterids="0";
	  }
	  String ids=request.getParameter("id");
	  FriendLink fl=(FriendLink)Tools.getManager(FriendLink.class).get(ids);
	  if(fl!=null)
	  {
		  fl.setFriendlink_keword(keyword);
		  fl.setFriendlink_website(website);
		  fl.setFriendlink_page(pages);
		  fl.setFriendlink_type(new Long(counterids));
		  fl.setFriendlink_qq(qq);
		  fl.setFriendlink_nofollow(new Long(nofollow));
		  if(Tools.getManager(FriendLink.class).update(fl,true))
		  {
			  Tools.outJs(out, "修改成功！", "/admin/friendlink/friendlinklist.jsp");
		  }
		  else
		  {
			  Tools.outJs(out, "修改失败！", "/admin/friendlink/friendlinklist.jsp");
		  }
	  }
	  else
	  {
		  Tools.outJs(out, "该友情链接不存在，不能修改！", "/admin/friendlink/friendlinklist.jsp");
	  }
  }


%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;">
   <h1 style=" font-size:25px;">友情链接管理</h1>
   <a href="addfriendlink.jsp">添加友情链接</a><br/>
   <%
      ArrayList<FriendLink> list=new ArrayList<FriendLink>();
      list=FriendLinkHelper.getFriendLinkList();
      
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
      <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="0" cellspcing="0" cellpadding="0">
         <tr><td width="80">编号</td><td width="150">关键字</td><td width="200">网址</td><td width="120">联系QQ</td><td width="250">显示页面</td><td width="80">是否nofollow</td><td width="90">操作</td></tr>
    	 <% 
    	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
    	  {
	    	  FriendLink fl=list.get(i);
    		  if(fl!=null)
    		  {%>
    			<tr><td><%= fl.getId() %></td><td><%= fl.getFriendlink_keword() %></td>
    			<td><a href="<%= fl.getFriendlink_website().trim() %>" target="_blank"><%= fl.getFriendlink_website().trim() %></a></td><td><%= fl.getFriendlink_qq() %></td>
    			<td>
    			<%
    			    if(fl.getFriendlink_page().trim().equals("1"))
    			    {
    			    	out.print("首页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_1"))
    			    {
    			    	out.print("二级页-化妆品");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_2"))
    			    {
    			    	out.print("二级页-男装");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_3"))
    			    {
    			    	out.print("二级页-女装");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_4"))
    			    {
    			    	out.print("二级页-饰品");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_5"))
    			    {
    			    	out.print("二级页-女包");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("2_6"))
    			    {
    			    	out.print("二级页-名表");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("3"))
    			    {
    			    	out.print("搜索页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("4"))
    			    {
    			    	out.print("result页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("5"))
    			    {
    			    	out.print("特卖会列表页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("5_1"))
    			    {
    			    	out.print("特卖会专题页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("6"))
    			    {
    			    	out.print("品牌馆页");
    			    }
    			    else if(fl.getFriendlink_page().trim().equals("7"))
    			    {
    			    	out.print("专题页");
    			    }
    			    else{
    			    	out.print("首页");
    			    	}
    			
    			%>
    			
    			</td>
    			<td><% if(fl.getFriendlink_nofollow().longValue()==0) out.print("否"); else { out.print("是");} %></td>
    			<td><a href="friendlinklist.jsp?id=<%=fl.getId() %>" >修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteFriendLink('<%= fl.getId() %>')">删除</a></td>
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
   
   %>
 
 
   
   <%
       FriendLink fl=(FriendLink)Tools.getManager(FriendLink.class).get(id);
       if(fl!=null)
       {%><br/><br/>
    	   <div id="updatefl">
    	      <span>修改友情链接信息</span>
    	      <form id="friendlink" method="post" action="friendlinklist.jsp" onsubmit="Check();">
			   <table style=" margin:0px auto; font-size:14px;text-align:left;">
			   <input type="hidden" id="id" name="id" value="<%= fl.getId() %>"/>
			   <tr><td>编号：</td><td><%= fl.getId() %></td></tr>
			        <tr><td>关键字：</td><td><input type="text" id="keyword" name="keyword" onblur="Check();" value="<%= fl.getFriendlink_keword() %>"/>&nbsp;&nbsp;<span id="keyword_notice"></span></td></tr>
			        <tr><td>网址：</td><td><input type="text" id="website" name="website" onblur="Check();" value="<%= fl.getFriendlink_website() %>"/>&nbsp;&nbsp;<span id="website_notice">链接地址</span></td></tr>
			        <tr><td>联系QQ：</td><td><input type="text" id="qq" name="qq" value="<%= fl.getFriendlink_qq() %>"/>&nbsp;&nbsp;</td></tr>
			         <tr><td>品牌馆ID：</td><td><input type="text" id="counterid" name="counterid"/ value=<%=fl.getFriendlink_type() %>>&nbsp;&nbsp;</td></tr>
			        <tr><td>显示页面：</td><td>
			        <select id="page" name="page">
                                          <option value="1" <% if("1".equals(fl.getFriendlink_page())) out.print("selected"); %>>首页</option>
                                          <option value="2_1" <% if("2_1".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-化妆品</option>
                                          <option value="2_2" <% if("2_2".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-男装</option>
                                          <option value="2_3" <% if("2_3".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-女装</option>
                                          <option value="2_4" <% if("2_4".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-饰品</option>
                                          <option value="2_5" <% if("2_5".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-女包</option>
                                          <option value="2_6" <% if("2_6".equals(fl.getFriendlink_page())) out.print("selected"); %>>二级页-名表</option>
                                          <option value="3" <% if("3".equals(fl.getFriendlink_page())) out.print("selected"); %>>搜索页</option>
                                          <option value="4" <% if("4".equals(fl.getFriendlink_page())) out.print("selected"); %>>result页</option>
                                          <option value="5" <% if("5".equals(fl.getFriendlink_page())) out.print("selected"); %>>特卖会列表页</option>
                                          <option value="5-1" <% if("5_1".equals(fl.getFriendlink_page())) out.print("selected"); %>>特卖会专题页</option>
                                          <option value="6" <% if("6".equals(fl.getFriendlink_page())) out.print("selected"); %>>品牌馆页</option>
                                          <option value="7" <% if("7".equals(fl.getFriendlink_page())) out.print("selected"); %>>专题页</option>
                                    </select>
			        
			        </td></tr>
			        <tr><td>是否nofollow：</td><td><select id="nofollow" name="nofollow">
			                                          <option value="0" <% if(0==fl.getFriendlink_nofollow().longValue()) out.print("selected"); %>>否</option>
			                                          <option value="1" <% if(1==fl.getFriendlink_nofollow().longValue()) out.print("selected"); %>>是</option>
			                                       </select></td></tr>
			                  <tr><td colspan="2"><input type="submit" value="修改" style="width:80px;"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
			   </table>
     
   			</form>
    	      
    	   </div>
       <%}
   %>
     
      
  
     
</div>
</body>
</html>





