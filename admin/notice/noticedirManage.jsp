<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>

<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "notice");
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
<title>公告管理</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
</style>
<script type="text/javascript" >
    function hidegonggao(id,flag)
    {
    	 if(id==null)
    		 {
    		 return;
    		 }
    	 message=flag==0?'隐藏':'显示';
    	 $.confirm('确定要'+message+'该公告吗？','提示',function(){
    		 $.ajax({
    		        type: "post",
    		        dataType: "json",
    		        url: "/ajax/notice/hidegonggao.jsp",
    		        cache: false,
    		        data:{noticedirid:id,flag:flag},
    		        error: function(XmlHttpRequest){
    		            alert(message+"公告失败！");
    		        },
    		        success: function(json){
    		        		$.alert('公告'+message+'成功','提示',function(){
    		        		this.location.reload();

    		        		});
    		        },beforeSend: function(){
    		        }
    		    });		
    		 
    		 
    		 
    			});
    }
    function updategonggao(id)
    {
    	 if(id==null)
    		 {
    		 return;
    		 }
       var objtype=document.getElementById("ggtype");
  	   var objttitle=document.getElementById("gg_title");
  	   var objflag=document.getElementById("gg_flag");
	   var order=document.getElementById("order");
	   var fvalue=objflag.value;
	   var ovalue=order.value;
    	 $.confirm('确定要更新该公告吗？','提示',function(){
    		 $.ajax({
    		        type: "post",
    		        dataType: "json",
    		        url: "/ajax/notice/hidegonggao.jsp",
    		        cache: false,
    		        data:{noticedirid:id,u:"update",ggtype:objtype.value,gg_title:objttitle.value,gg_flag:fvalue,orders:ovalue},
    		        error: function(XmlHttpRequest){
    		            alert("更新公告失败！");
    		        },
    		        success: function(json){
    		        		$.alert(json,'提示',function(){
    		        		this.location.href="noticedirManage.jsp";

    		        		});
    		        },beforeSend: function(){
    		        }
    		    });		
    		 
    		 
    		 
    			});
    }
    
    function check(id)
    {
 	   var objtype=document.getElementById("ggtype");
 	   var objttitle=document.getElementById("gg_title");
 	   if(objtype.value=="0")
 		   {
 		   $.alert('您没有选择公告类型','提示');
 		   }
 	   if(objttitle.value=="")
 		   {
 		   $.alert('您没有填写公告标题','提示');
 		   }
 	  updategonggao(id);
    }
</script>

</head>
<body>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">公告管理</h1>
   <a href="addNoticeDir.jsp">添加公告</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="noticemanage.jsp">文章管理</a><br/>
  <%
     ArrayList<NoticeDir> list=new ArrayList<NoticeDir>();
     
    //获取通知list
    List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
  
     List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("createdate"));
		List<BaseEntity> b_list = Tools.getManager(NoticeDir.class).getList(clist, olist, 0, 1000);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((NoticeDir)be);
			}
		}
		if(list!=null)
		{%>
			 <table width="900" border="0"  class="t" style=" margin:0px auto;">
			 <tr style=" color:#a25663;" height="25"><td class="d1" width="80">公告编号</td><td class="d1">公告标题</td><td class="d1" width="100">所属公告类型</td><td class="d1" width="150">创建时间</td><td class="d1" width="80">是否隐藏</td><td class="d1" width="80">排序值</td><td class="d1" width="200">操作</td></tr>
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
			     <td><%= nn.getPriority().toString() %></td>
			     <td>
                     <%
                         if(nn.getFlag()==1)
                         {
                        	 out.print("<a href=\"javascript:void(0)\" onclick=\"hidegonggao("+ nn.getId() +",0);\" >隐藏</a>");
                         }
                         else
                         {
                        	 out.print("<a href=\"javascript:void(0)\" onclick=\"hidegonggao("+ nn.getId() +",1);\" >显示</a>");
                             
                         }
                         out.print("<a href=\"noticedirManage.jsp?ID="+nn.getId()+"\" >修改</a>");
                     %>
                 </td>
			     </tr>
			
		<%}
			    %>
			 </table>    
		<%}
		else
		{
			out.print("还没有公告！！！<a href=\"addnoticedir.jsp\">马上去添加</a>");
		}
     
	
  %>
   <%
          if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
          {
        	  String id=request.getParameter("ID");
        	  NoticeDir nd=(NoticeDir)Tools.getManager(NoticeDir.class).get(id);
        	  if(nd!=null)
        	  { %>
        	  <div  style=" width:900px; border:solid 1px #c2c2c2; background:#ebebeb; margin:0px auto; margin-top:35px; padding-top:15px; padding-bottom:30px; text-align:center;">
        	      <span style=" font-size:25px;"><b>修改公告信息</b></span><br/>
        	  
        <table width="500" >
           <tr height="30"><td width="80">公告类型</td><td style=" text-align:left;">
           
           <select id="ggtype" name="ggtype">
           <% 
               for(int i=1;i<=3;i++)
               {
            	   %>
            	   <option value="<%=i %>" <% if(i==Tools.parseInt(nd.getParentId())) { out.print("selected");} %>>
            	   <%  switch(i)
            	   {
            	   case 1: out.print("市场公告");
            	        break;
            	   case 2: out.print("服务公告");
            	   break;
            	   case 3: out.print("网站功能公告");
            	   break;
            	   default: out.print("市场公告");
            	   break;
            	   }
            	   %>
            	   </option>
            	   <%
            	   
               }
        	      
        	%> </select></td></tr>
           <tr height="30"><td>公告标题</td><td style=" text-align:left;"><input type="text" id="gg_title" name="gg_title" style=" width:250px;" value="<%= nd.getTitle() %>"></input></td></tr>
           <tr height="30"><td>是否隐藏</td><td style=" text-align:left;"><select id="gg_flag" name="gg_flag">
           <%
               for(int j=0;j<=1;j++)
               {%>
            	   <option value="<%=j %>" <% if(j==nd.getFlag()) { out.print("selected");} %>>
            	   <%  switch(j)
            	   {
            	   case 0: out.print("隐藏");
            	   break;
            	   case 1: out.print("不隐藏");
            	   break;
            	   default: out.print("隐藏");
            	   break;
            	   }
            	   %>
            	   </option>
               <%}
           %>
                                  
                                   </select><font color='red'>&nbsp;&nbsp;（注：选择隐藏，前台将不显示；反之，则显示。）</font></td></tr>
                                  <tr height="30"><td>排序值</td><td style=" text-align:left;"><input type="text" id="order" name="order" style=" width:200px;" value="<%= nd.getPriority() %>"></input></td></tr>
          
                                   <tr><td colspan="2" height="30"></td></tr>
                                   <tr><td colspan="2"><input type="button" value="修改公告" onclick="check(<%= id%>)"></input>
                                          &nbsp;&nbsp;&nbsp;&nbsp; <a href="noticedirManage.jsp">取消</a>
                                   </td></tr>
        </table>
        	  <%}
          }
         
      %>
  
        	  </div>
  </div>
  
     
  
</body>
</html>





