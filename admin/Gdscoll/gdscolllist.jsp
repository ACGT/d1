<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%
   //判断是否有权限
   boolean flagss=false;
   if(session.getAttribute("admin_mng")!=null){
        	   String userid=session.getAttribute("admin_mng").toString();
        	   ArrayList<AdminPower> aplist=AdminPowerHelper.getAwardByGdsid(userid, "gds_sjmodi"); 
        	   if(aplist!=null&&aplist.size()>0)
        	   {
        		   flagss=true;
        	   }
   } 
   %>
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

   String gdsser="";
   if(request.getParameter("gdsser")!=null&&request.getParameter("gdsser").length()>0)
   {
	   gdsser=request.getParameter("gdsser");
   }
   ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
   list.clear();
   if(gdsser.length()==0||gdsser.equals("0"))
   {
	   list=GdscollHelper.getGdscollBysceneid("");
   }
   else
   {
	 list=  GdscollHelper.getGdscollBysceneid(gdsser);
   }
   if(list==null&&list.size()==0)
   {
	   out.print("没有满足条件的搭配！");
	   return;
   }
   String flag="";
   if(request.getParameter("gdsflag")!=null&&request.getParameter("gdsflag").length()>0)
   {
	   flag=request.getParameter("gdsflag");
   }
  
   ArrayList<Gdscoll> list2=new ArrayList<Gdscoll>();
   for(Gdscoll gdscoll:list)
   {
	   if(flag.equals("0"))
	   {		   
			   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
			   if(gdlist!=null&&gdlist.size()>0)
			   {
				   for(Gdscolldetail gdetail:gdlist)
				   {
					   if(gdetail!=null&&gdetail.getGdscolldetail_gdsid()!=null)
					   {
						   Product p=ProductHelper.getById(gdetail.getGdscolldetail_gdsid());
						   if(p!=null&&p.getGdsmst_validflag()!=null)
						   {
							   if(p.getGdsmst_validflag().longValue()==0)
							   {
								   list2.add(gdscoll);
								   break;
							   }
						   }
					   }
				   }
			   }
	   }
	   else if(flag.equals("5"))
	   {
		   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
			   if(gdlist!=null&&gdlist.size()>0)
			   {
				   for(Gdscolldetail gdetail:gdlist)
				   {
					   if(gdetail!=null&&gdetail.getGdscolldetail_gdsid()!=null)
					   {
						   Product p=ProductHelper.getById(gdetail.getGdscolldetail_gdsid());
						   if(p!=null&&p.getGdsmst_validflag()!=null)
						   {
							   if(p.getGdsmst_validflag().longValue()==5)
							   {
								   list2.add(gdscoll);
								   break;
							   }
						   }
					   }
				   }
			   }
		 
	   }
	   else if(flag.equals("11")){
		   if(gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==1)
		   {
			   list2.add(gdscoll);
		   }
	   }
	   else if(flag.equals("12")){
		   if(gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==0)
		   {
			   list2.add(gdscoll);
		   }
	   }
	   else{
		   
	   }
	   
   } 
   if((list2!=null&&list2.size()>0)||(flag.length()>0&&!flag.equals("13")))
   {
	   list.clear();
	   list.addAll(list2);
   }
   String gdsid="";
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	   gdsid=request.getParameter("gdsid");
   }
   ArrayList<Gdscoll> list3=new ArrayList<Gdscoll>();   
   if(gdsid.length()>0&&Tools.isNumber(gdsid.trim()))
   {
	   for(Gdscoll gdscoll:list)
	   {
		   if(gdscoll!=null)
		   {
			   
			   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
			   if(gdlist!=null&&gdlist.size()>0)
			   {
				   for(Gdscolldetail gdetail:gdlist)
				   {
					   if(gdetail!=null&&gdetail.getGdscolldetail_gdsid()!=null)
					   {
						   if(gdetail.getGdscolldetail_gdsid().equals(gdsid))
						   {
							   list3.add(gdscoll);
							   break;
						   }
					   }
				   }
			   }
			   
		   }
		   
	   }
	   
   }
   if((list3!=null&&list3.size()>0)||gdsid.length()>0)
   {
	   list.clear();
	   list.addAll(list3);
   }
   String gdscoll="";
   if(request.getParameter("gdscoll")!=null&&request.getParameter("gdscoll").length()>0)
   {
	   gdscoll=request.getParameter("gdscoll");
   }

   ArrayList<Gdscoll> list4=new ArrayList<Gdscoll>();   
   if(gdscoll.length()>0&&Tools.isNumber(gdscoll.trim()))
   {
	   for(Gdscoll gdscoll1:list)
	   {
		   if(gdscoll1!=null)
		   {
			   if(gdscoll1.getId().equals(gdscoll))
			   {
				   list4.add(gdscoll1);
			   }			 
			   
		   }
		   
	   }
	   
   }
   if((list4!=null&&list4.size()>0)||gdscoll.length()>0)
   {
	   list.clear();
	   list.addAll(list4);
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
function sjproduct(gid,lssum)
{
	$.confirm('确定要上架所有商品以及搭配吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/Gdscoll/productsj.jsp",
		        cache: false,
		        data:{id:gid,ls:lssum},
		        error: function(XmlHttpRequest){
		            $.alert("删除失败！");
		        },
		        success: function(json){
		            if(json.success){}
			        	$.alert(json.message,'提示',function(){
			        		$.close();
			        		});
		        }
		        ,beforeSend: function(){
		        }
		    });	
	});	
}

</script>

</head>
<body>

<div style="margin:0px auto; text-align:center; padding-top:25px; font-size:14px;">
   <h1 style=" font-size:25px;">搭配管理</h1>
  
   <%
      String ggURL = Tools.addOrUpdateParameter(request,null,null);
            
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
         <tr style="background:#f4f4f4; color:#333"><td width="65">编号</td><td width="60">系列编号</td><td width="120">系列名称</td><td>预览图</td><td width="210" >详细</td><td width="200">搭配标题</td><td width="80">排序</td><td width="80">是否显示</td><td width="170">操作</td></tr>
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
    			<td><img src="http://images1.d1.com.cn<%= fl.getGdscoll_smallimgurl() %>"/></td>
    			<td style="text-align:left">
    			    <%
    			        ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(fl.getId());
    			       if(gdlist!=null&&gdlist.size()>0){
    			    	   int lssum=1;
    			    	   int dsh=0;
    			    	   int ysh=0;
    			    	   for(Gdscolldetail gd:gdlist)
    			    	   {
    			    		   if(gd!=null&&gd.getGdscolldetail_gdsid()!=null)
    			    		   {
    			    		       Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
    			    		       if(p!=null&&p.getGdsmst_validflag()!=null){  
    			    		       %>
    			    		    	  <a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank"><%=gd.getGdscolldetail_title() %></a> 
    			    		    	  &nbsp;&nbsp;&nbsp;
    			    		    	  <%
    			    		    	      if(p.getGdsmst_validflag().longValue()==0)
    			    		    	      {
    			    		    	    	  out.print("刚录入，未审核");
    			    		    	    	  dsh++;
    			    		    	      }
    			    		    	      else if(p.getGdsmst_validflag().longValue()==1)
    			    		    	      {
    			    		    	    	  out.print("已上架");
    			    		    	      }
    			    		    	      else if(p.getGdsmst_validflag().longValue()==2)
    			    		    	      {
    			    		    	    	  out.print("已下架");
    			    		    	      }
    			    		    	      else if(p.getGdsmst_validflag().longValue()==4)
    			    		    	      {
    			    		    	    	  out.print("隐藏");
    			    		    	      }
    			    		    	      else if(p.getGdsmst_validflag().longValue()==5)
    			    		    	      {
    			    		    	    	  out.print("已审核，待上架");
    			    		    	    	  ysh++;
    			    		    	      }
    			    		    	      else{
    			    		    	    	  out.print("已下架");
    			    		    	      }
    			    		    	  %>
    	    			    			
    	    			    				  <a href="http://admin.d1.com.cn:322/gdsadmin_new/gdsinfo.asp?req_gdsid=<%= p.getId() %>" target="bottom">维护</a>
    	    			    				  <br/>
    	    			    		<% 
    			    		       }
    			    		   }
    			    	   }    			    	 
    			    	   if(dsh<=0&&ysh>0&&flagss)
    			    	   {
    			    	   %>
    			    	       <input type="button" onclick="sjproduct('<%= fl.getId() %>','<%= lssum%>')" value="一键式上架" style="width:80px;"/>  
    			       <%  }
    			       }
    			    %>
    			</td>
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
    			
    			
    			<td><a href="gcupdate.jsp?id=<%=fl.getId() %>&sid=<%= fl.getGdscoll_serid().toString() %>" target="bottom">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteGdscoll('<%= fl.getId() %>',<%= fl.getGdscoll_serid().toString()%>)">删除</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/admin/Gdscoll/agd.jsp?gdscollid=<%= fl.getId() %>" target="bottom">添加搭配详细</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/admin/Gdscoll/gdmanager.jsp?gid=<%= fl.getId() %>" target="bottom">搭配详细管理</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%= fl.getId() %>" target="_blank">预览搭配</a></td>
    			</tr>  
    		  <%}
    	  }%>
    	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="7" height="45">
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
    	没有满足条件的搭配！！！
      <%}
   
   %>
 
</div>
</body>
</html>





