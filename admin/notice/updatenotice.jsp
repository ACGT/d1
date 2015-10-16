 <%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改文章信息</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  h1{ font-size:20px; color:#f00;}
  table{ text-align:left; }
  td{ height:30px;}
</style>
<script type="text/javascript" src="/conf/ckeditor/ckeditor/ckeditor.js"></script>
<script src="/conf/ckeditor/ckeditor/_samples/sample.js" type="text/javascript"></script>
<link href="/conf/ckeditor/ckeditor/_samples/sample.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
function check()
{
	   var objtype=document.getElementById("ggsubtype");
	   var objttitle=document.getElementById("title");
	   if(objtype.value=="0"||objtype==null)
		   {
		   $.alert('您没有选择公告类型','提示');
		   return false;
		   }
	   if(objttitle.value=="")
		   {
		   $.alert('您没有填写文章标题','提示');
		   return false;
		   }
	  return true;
}

$(document).ready(function() {  
	
	   $("#type").change(function(){
		   $.ajax({
		        type: "post",
		        dataType: "html",
		        url: "/ajax/notice/bindggtype.jsp",
		        cache: false,
		        data:{typeid:$("#type option:selected").val()},
		        error: function(XmlHttpRequest){
		            alert("绑定公告类型失败");
		        },
		        success: function(strHtml){
		        		$('#ingg').empty();
		        		$(strHtml).appendTo($('#ingg'));
		        		
		        },beforeSend: function(){
		        },
		        complete: function() {}
	    });
		    });	
});

function bindtype(id)
{
	 $.ajax({
	        type: "post",
	        dataType: "html",
	        url: "/ajax/notice/bindggtype.jsp",
	        cache: false,
	        data:{typeid:$("#type option:selected").val(),nid:id},
	        error: function(XmlHttpRequest){
	            alert("绑定公告类型失败");
	        },
	        success: function(strHtml){
	        		$('#ingg').empty();
	        		$(strHtml).appendTo($('#ingg'));
	        		
	        },beforeSend: function(){
	        },
	        complete: function() {}
});
	}


</script>
</head>
<body>
<%

    String ids=request.getParameter("lblid")==null?"":request.getParameter("lblid");

    String ggType=request.getParameter("ggsubtype")==null?"":request.getParameter("ggsubtype");
    String ggtitle=request.getParameter("title")==null?"":request.getParameter("title");
    String ggflag=request.getParameter("flag")==null?"0":request.getParameter("flag");
    String ggcolor=request.getParameter("color")==null?"":request.getParameter("color");
    String ggimg=request.getParameter("img")==null?"":request.getParameter("img");
    String ggcontent=request.getParameter("editor1")==null?"":request.getParameter("editor1");
    String ggorder=request.getParameter("order")==null?"0":request.getParameter("order");
    
    if(ids.length()>0&&ggtitle.length()>0&&ggflag.length()>0&&ggcontent.length()>0)
    {
    	
    	Notice notice=new Notice();
    	notice=(Notice)Tools.getManager(Notice.class).get(ids);
    	if(notice!=null)
    	{
	    	notice.setTitle(ggtitle);
	    	//notice.setCreatedate(new Date());
	    	notice.setFlag(Tools.parseLong(ggflag));
	    	String content="";
	    	if(ggcolor.length()>0)
	    	{
	    		content="<font color='"+ggcolor+"'>"+ggtitle+"</font>";
	    	}
	    	else
	    	{
	    		content=ggtitle;
	    	}
	    	if(ggimg.length()>0)
	    	{
	    		content=content+"<img src=\""+ggimg+"\"/>";
	    	}
	    	notice.setTitle(content);
	    	notice.setContent(ggcontent);
	    	notice.setDirId(ggType);
	    	notice.setPriority(Tools.parseInt(ggorder));
	    	Tools.getManager(Notice.class).clearListCache(notice);
	    	if(Tools.getManager(Notice.class).update(notice, true))
	    	{
	    	
	    		out.print("<script>alert('更新文章成功');this.location.href='noticemanage.jsp';</script>");
	
	    	}
	    	else
	    	{
	    		out.print("<script>alert('更新文章失败');this.location.href='noticemanage.jsp';</script>");
	    	}
    	}
    	
    	
    }
    
%>
 <form id="form1" action="updatenotice.jsp" method="post">
  <div style="margin:0px auto; width:980px; text-align:center; padding-top:30px;">
 <%
          if(request.getParameter("ID")!=null&&request.getParameter("ID").length()>0)
          {
        	  String id=request.getParameter("ID");
        	  Notice nd=(Notice)Tools.getManager(Notice.class).get(id);
        	  if(nd!=null)
        	  { %>
        	  <div  style=" width:900px; border:solid 1px #c2c2c2; background:#ebebeb; margin:0px auto; margin-top:35px; padding-top:15px; padding-bottom:30px; text-align:center;">
        	      <span style=" font-size:25px;"><b>修改文章信息</b></span><br/>
        	  
        <table width="900" >
         <input type="hidden" id="lblid" name="lblid" value="<%= nd.getId() %>"></input>

           <tr><td width="120">公告类型</td><td style=" text-align:left;">
           <select id="type" name="type">
           <% for(int i=0;i<4;i++)
	           {
	        	   if(i==0)
	        	   {%>
	        	   	        <option value="0">--请选择公告类型--</option>	
	        	   <%}
	        	   else
	        	   {
	        	       NoticeDir noticedir=new NoticeDir();
	        	       noticedir=(NoticeDir)Tools.getManager(NoticeDir.class).get(nd.getDirId());
	        	       if(noticedir!=null)
	        	       {%>
	        	           <option value="<%= i%>" <% if(i==Tools.parseInt(noticedir.getParentId())) { out.print("selected");} %>>
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
	        	    	   
	        	     <%  }
	        	   %>
	        		   
	        	   <%}
	           }
        	   %></select></td></tr><script language="javascript" type="text/javascript">bindtype(<%= nd.getDirId()%>);</script>
           <tr><td>所属公告</td><td style=" text-align:left;" id="ingg" ></td></tr>
           <tr><td>文章标题</td><td style=" text-align:left;"><input type="text" id="title" name="title" style=" width:250px;" value="<%= Tools.clearHTML(nd.getTitle())%>"></input></td></tr>
           
           <tr><td>是否改变标题颜色</td><td>
           <% 
           if(nd.getTitle().indexOf("color")>=0)
              {

              %>
        	   <input type="radio" name="color" value='#b1475b' <% if(nd.getTitle().substring(nd.getTitle().indexOf("color")+7, nd.getTitle().indexOf("color")+14).equals("#b1475b")) out.print(" checked='true' "); %>>红色</input>
        	   &nbsp;&nbsp;<input type="radio" name="color" value='#1775d5' <% if(nd.getTitle().substring(nd.getTitle().indexOf("color")+7, nd.getTitle().indexOf("color")+14).equals("#1775d5")) out.print("checked='true'"); %>>蓝色&nbsp;&nbsp;<input type="radio" name="color"  value='' >无</input>
              <%}
           else
           {%>
        	   <input type="radio" name="color" value='#b1475b'>红色</input>&nbsp;&nbsp;<input type="radio" name="color" value='#1775d5'>蓝色&nbsp;&nbsp;<input type="radio" name="color" checked="true" value=''>无</input>
           <%}
        	   %>
           
           </td></tr>
           <tr><td>是否添加图片</td><td><input type="text" width="300" id="img" name="img"></input><font color='red'>&nbsp;&nbsp;（注：图片大小20*20）</font></td></tr>
           <tr><td>是否隐藏</td><td style=" text-align:left;"><select id="flag" name="flag">
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
                                   <tr><td>排序值</td><td><input type="text" width="300" id="order" name="order" value="<%= nd.getPriority()%>"></input><font color='red'>&nbsp;&nbsp;请输入数字</font></td></tr> 
                                  <tr><td colspan="2" height="30"></td></tr>
                                   <tr><td colspan="2" >文章内容</td></tr>
                                   <tr><td colspan="2"><textarea class="ckeditor" cols="80" id="editor1" name="editor1" rows="50"  ><%= nd.getContent()%></textarea>
                                   </td></tr>
                                    <tr><td colspan="2"><input type="submit" value="修改文章" onclick="return check()"></input>
                                          &nbsp;&nbsp;&nbsp;&nbsp; <a href="noticemanage.jsp">取消</a>
                                   </td></tr>
                                     </table>

        	  <%}
        	  else
              {
            	  out.print("该文章不存在！！<a href=\"noticemanage.jsp\">回到文章管理页面</a>");
              }
          }
         
         
      %>
 

  </form>
    </div>
</body>
</html>