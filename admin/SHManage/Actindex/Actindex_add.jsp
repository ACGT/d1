<%@ page contentType="text/html; charset=UTF-8" %><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专题添加页面</title>
<link href="/admin/odradmin/images/odrlist.css" rel="stylesheet" type="text/css"  />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>

<script type="text/javascript" src="/d1xheditor/xheditor-zh-cn.min.js"></script>
<style type="text/css"></style>
</head>
<body style=" background:#fff;height:2500px;">
<%@include file="/admin/inc/shhead.jsp" %>
<div>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/shleftwh.jsp" %>
   </td>
   <td width="926" valign="top">
   <table width="910" border="0" style="margin-left: 15px;" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
    <td colspan="7">
		   <table width="910" border="0" cellpadding="0" cellspacing="0" class="lin">
		   <form id="form1" action="" method="post" onsubmit=" return false;">
			  <tr class="odrt" style="height:50px; font-size: 20px;">
			  	<td class="reg_info" colspan="2" >填写专题信息</td>
			  </tr>
			  <tr style="line-height: 10px;">
			  	<td width="120px;" align="center">*专题名称：</td>
			  	<td><input type="text" name="actindex_name" id="actindex_name" maxlength="180"/></td>
			  </tr>
			  <tr style="line-height: 10px;">
			  	<td width="120px;" align="center">*subad：</td>
			  	<td><input type="text" name="actindex_subad" id="actindex_subad" maxlength="180"/></td>
			  </tr>
			  <tr style="line-height: 10px;">
			  	<td width="120px;" align="center">大刊链接：</td>
			  	<td><input type="text"  style="width: 500px;"  name="actindex_gourl" id="actindex_gourl" maxlength="180"/></td>
			  </tr>
			  <tr>
			  	<td align="center">推荐位类型：</td>
			  	<td>
			  		<select id="actindex_dectype" name="actindex_dectype">
				  	<option value="0">简单模板</option>
				  	<option value="1">160*160*4/行通用模板</option>
				  	<option value="2">200*200*3/行通用模板</option>
				  	<option value="3">200*250*3/行通用模板</option>
			  	</select>&nbsp;<span style="color: orange;">注：推荐使用通用模板</span>
				</td>
			  </tr>
			  <tr>
			  	<td align="center">推荐位标题：</td>
			  	<td><input name="actindex_areatitle" id="actindex_areatitle" maxlength="14" class="inputstyle"/></td>
			  </tr>
			   <tr>
			  	<td align="center">推荐位背景色：</td>
			  	<td>#<input name="actindex_areatbgcolor" id="actindex_areatbgcolor" maxlength="14" class="inputstyle"/></td>
			  </tr>
			  <tr>
			  	<td align="center">标题颜色：</td>
			  	<td>#<input name="actindex_areatcolor" id="actindex_areatcolor" maxlength="14" class="inputstyle"/></td>
			  </tr>
			  <tr>
			  	<td align="center">*专题内容：<br /><br /><span style="color: red;">$$推荐位号$$长度$$</span></td>
			  	<td>
				   <textarea id="actindex_content" escape='false'
				    name="actindex_content" style="width:790px;height: 300px;" ></textarea>
			  	</td>
			  </tr>
			  <tr>
			  	<td align="center">*添加人：</td>
			  	<td><input name="actindex_adduser" id="actindex_adduser" maxlength="14" class="inputstyle"/></td>
			  </tr>
			  <tr>
			  <tr>
			  	<td></td>
			  	<td><div id="tishi"></div></td>
			  </tr>
			  <tr>
			  <td></td>
			  <td><img src="/admin/SHManage/images/xjsp_bcxx.jpg" onclick="save();"/></td>
			  </tr>
		  </form>
		   </table></td></tr>
</table></td>

</body>
</html>
<script type="text/javascript">

$(pageInit);
function pageInit()
{ 
 $('#actindex_content').xheditor({localUrlTest:/^https?:\/\/[^\/]*?(d1\.com.cn)\//i,remoteImgSaveUrl:'/d1xheditor/SaveRemoteimg.jsp',skin:'vista',upLinkUrl:"!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=附件文件(*.zip;*.rar;*.txt)",upImgUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=图片文件(*.jpg;*.jpeg;*.gif;*.png)',upFlashUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=Flash动画(*.swf)',upMediaUrl:'!{editorRoot}xheditor_plugins/multiupload/multiupload.html?uploadurl={editorRoot}/d1upload.jsp%3Fimmediate%3D1&ext=多媒体文件(*.wmv;*.avi;*.wma;*.mp3;*.mid)',shortcuts:{'ctrl+enter':submitForm}});
}
function submitForm(){$('#form1').submit();}
function save(){
	var actindex_name = $("#actindex_name").val();
	var actindex_subad = $("#actindex_subad").val();
	var actindex_gourl = $("#actindex_gourl").val();
	var actindex_dectype = $("#actindex_dectype").val();
	var actindex_content = $("#actindex_content").val();
	var actindex_adduser = $("#actindex_adduser").val();
	var actindex_areatbgcolor =  $("#actindex_areatbgcolor").val();
	var actindex_areatitle =  $("#actindex_areatitle").val();
	var actindex_areatcolor =  $("#actindex_areatcolor").val();
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/actindex_save.jsp',
		cache: false,
		data: {actindex_name:actindex_name,actindex_subad:actindex_subad,actindex_gourl:actindex_gourl,actindex_dectype:actindex_dectype,actindex_content:actindex_content,actindex_adduser:actindex_adduser,actindex_areatbgcolor:actindex_areatbgcolor,actindex_areatitle:actindex_areatitle,actindex_areatcolor:actindex_areatcolor},
		error: function(XmlHttpRequest){
		},success: function(json){	
			if(parseInt(json.code)==1){
				//$('#tishi').html(' <span style="color:#ff0000"> '+json.message+' </span>');
				alert(json.message);
			}else{
				//$('#tishi').html(' <span style="color:#ff0000"> '+json.message+' </span>');
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
</script>
