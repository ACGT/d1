<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>


<%
    if("post".equals(request.getMethod().toLowerCase()))
    {
    	String tag_key=request.getParameter("tag_key");
    	String tag_title=request.getParameter("tag_title");
    	String tag_tag=request.getParameter("tag_tag");
    	String tag_des=request.getParameter("tag_description");
    	if(tag_key.length()==0)
    	{
    		Tools.outJs(out, "标签名称不能为空！", "back");
    	    return;
    	}
    	
    	else
    	{
    		Tag t=new Tag();
    		
    		t.setTag_key(tag_key);
    		t.setTag_description(tag_des);
    		t.setTag_title(tag_title);
    		t.setTag_tag(tag_tag);
    		t.setTag_letters(TagHelper.getFirstLetter(tag_key.substring(0,1)).toUpperCase());
    		t.setTag_counts(new Long(0));
    		t=(Tag)Tools.getManager(Tag.class).create(t);
            if(t!=null)
            {
            	Tools.outJs(out, "添加标签成功", "back");
            }
            else
            {
            	Tools.outJs(out, "添加标签失败", "back");
            }
    	}
    	
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加标签</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head1208.css?"+System.currentTimeMillis())%>" rel="stylesheet" type="text/css" media="screen" />

<style type="text/css">
   body{ backgroound:#fff; padding:0px; margin:0px; font-size:14px;}
   .addtag{ margin:0px auto; width:700px; text-align:left;}
   span{ color:#f00;} 
</style>
</head>
<body>
   <div class="addtag">
      <form id="addTag" method="post" action="addTag.jsp">
         <table>
               <tr><td colspan="2" style="text-align:center "><h3>添加标签</h3></td></tr>
               <tr><td colspan="2"  style="text-align:center"><a href="TagManager.jsp" target="_blank">标签管理</a></td></tr>
               <tr><td>标签名称：</td><td><input type="text" name="tag_key" id="tag_key" onblur="losefocues('key')"/><span id="keynotice"></span></td></tr>
               <tr><td>标题：</td><td><input type="text" name="tag_title" id="tag_title" /><span id="titlenotice"></span></td></tr>
               <tr><td>描述：</td><td><textarea name="tag_description" id="tag_description" style="width:400px; height:200px; word-break:break-all"></textarea></td></tr>
               <tr><td>分词标签：</td><td><input type="text" name="tag_tag" id="tag_tag" style="width:300px;"><span>可添加多个标签，以","号隔开</span></td></tr>
               <tr><td colspan="2" style="text-align:center "><input type="button" value="添加"  onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" onclick="cancel();"/></td></tr>
         </table>
      </form>
   </div>
</body>
</html>
<script type="text/javascript" language="javascript">
   function losefocues(obj)
   {
	   if(obj=="key")
		   {
		      if($('#tag_key').val()=="")
		    	  {
		    	     $('#keynotice').html('标签名称不能为空！');
		    	     return;
		    	  }
		      else
		    	  {
		    	   $('#keynotice').html('');
		    	  }
		   }
	   
   }
   
   function Check()
   {
	   if($('#tag_key').val()=="")
		   {
		   alert('标签名称不能为空！');
		   return;
		   }
	   
	   else
		   {
		   $('#addTag').submit();
		   }
   }
   function cancel()
   {
	   $('#tag_key').val('');
	   $('#tag_title').val('');
	   $('#tag_tag').val('');
	   $('#tag_description').val('');
	   $('#tag_key').focus();
   }
</script>