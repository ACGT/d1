<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加文章</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<link type="text/css" rel="Stylesheet" href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/flowCheck.css")%>" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/conf/ckeditor/ckeditor/ckeditor.js"></script>
<script src="/conf/ckeditor/ckeditor/_samples/sample.js" type="text/javascript"></script>
<link href="/conf/ckeditor/ckeditor/_samples/sample.css" rel="stylesheet" type="text/css" />
<style type="text/css">
   .center{ margin:0px auto; text-align:center; padding-top:25px;}
   table{ margin:0px auto; font-size:14px; text-align:left;  }
   a{ font-size:12px; color:#6495ED; text-decoration:underline;}
</style>
<script type="text/javascript" language="javascript">
   function check()
   {
	   var objtype=document.getElementById("ggsubtype");
	   var objttitle=document.getElementById("notice_title");
	   var objcontent=document.getElementById("editor1");
	   if(objtype.value=="0"||objtype==null)
		   {
		   $.alert('您没有选择公告类型','提示');
		   return;
		   }
	   if(objttitle.value=="")
		   {
		   $.alert('您没有填写公告标题','提示');
		   return;
		   }

	   
	  
   }
   
   function cleargg()
   {
	   var objtype=document.getElementById("ggtype");
	   var objtitle=document.getElementById("gg_title");
	   var objflag=document.getElementById("gg_flag");
	   objtype.value=0;
	   objflag.value=0;
	   objtitle.value="";
	   objtitle.focus();
   }
   
   
   $(document).ready(function() {  
	   $("#ggtype").change(function(){
		   $.ajax({
		        type: "post",
		        dataType: "html",
		        url: "/ajax/notice/bindggtype.jsp",
		        cache: false,
		        data:{typeid:$("#ggtype option:selected").val()},
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
   

   


</script>
</head>
<body>
<%
    String ggType=request.getParameter("ggsubtype")==null?"":request.getParameter("ggsubtype");
    String ggtitle=request.getParameter("notice_title")==null?"":request.getParameter("notice_title");
    String ggflag=request.getParameter("gg_flag")==null?"0":request.getParameter("gg_flag");
    String ggcolor=request.getParameter("color")==null?"":request.getParameter("color");
    String ggimg=request.getParameter("img")==null?"":request.getParameter("img");
    String ggcontent=request.getParameter("editor1")==null?"":request.getParameter("editor1");
    String ggorder=request.getParameter("order")==null?"0":request.getParameter("order");
    
    if(ggtitle.length()>0&&ggflag.length()>0&&ggcontent.length()>0)
    {
    	Notice notice=new Notice();
    	notice.setTitle(ggtitle);
    	notice.setCreatedate(new Date());
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
    	Tools.getManager(Notice.class).create(notice);
    	if(!Tools.isNull(notice.getId()))
    	{
    		out.print("<script>alert('添加文章成功');</script>");

    	}
    	else
    	{
    		out.print("<script>alert('添加文章失败');</script>");
    	}
    	
    	
    }
    
%>
<div class="center">
   <form id="form1" action="addnotice.jsp" method="post">
        <table width="900" >
           <tr><td width="120">公告类型</td><td style=" text-align:left;"><select id="ggtype" name="ggtype">
                                      <option value="0">--请选择公告类型--</option>
                                      <option value="1">市场公告</option>
                                      <option value="2">服务公告</option>
                                      <option value="3">网站功能公告</option>
                                   </select></td></tr>
           <tr><td>所属公告</td><td style=" text-align:left;" id="ingg"></td></tr>
           <tr><td>文章标题</td><td style=" text-align:left;"><input type="text" id="notice_title" name="notice_title" style=" width:250px;"></input></td></tr>
           
           <tr><td>是否改变标题颜色</td><td><input type="radio" name="color" value='#b1475b'>红色</input>&nbsp;&nbsp;<input type="radio" name="color" value='#1775d5'>蓝色&nbsp;&nbsp;<input type="radio" name="color" checked="true" value=''>无</input></td></tr>
           <tr><td>是否添加图片</td><td><input type="text" width="300" id="img" name="img"></input><font color='red'>&nbsp;&nbsp;（注：图片大小20*20）</font></td></tr>
           <tr><td>是否隐藏</td><td style=" text-align:left;"><select id="gg_flag" name="gg_flag">
                                      <option value="0">隐藏</option>
                                      <option value="1">不隐藏</option>
                                   </select><font color='red'>&nbsp;&nbsp;（注：选择隐藏，前台将不显示；反之，则显示。）</font></td></tr>
                                   <tr><td>排序值</td><td><input type="text" width="300" id="order" name="order"></input><font color='red'>&nbsp;&nbsp;请输入数字</font></td></tr> 
                                  <tr><td colspan="2" height="30"></td></tr>
                                   <tr><td colspan="2" >文章内容</td></tr>
                                   <tr><td colspan="2"><textarea class="ckeditor" cols="80" id="editor1" name="editor1" rows="50"></textarea>
                                   </td></tr>
                                   <tr><td colspan="2"><input type="submit" value="添加文章" onclick="return check()"></input>&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' onclick="cleargg()">清空内容</a></td></tr>
        </table>
        
   </form>
</div>
</body>
</html>