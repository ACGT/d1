<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
if(session.getAttribute("type_flag")!=null){
	String userid = "";
	if(session.getAttribute("admin_mng") != null){
		userid = session.getAttribute("admin_mng").toString();
	}
	boolean is_edit = chk_admpower(userid,"d1shop_gdsedit");
	if(!is_edit){
		out.print("对不起，您没有操作权限！");
		return;	
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>组管理</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
body{ font-size:12px; text-align:center; }
a{ text-decoration:none; color:#3A5FCD;} 
</style>
<script type="text/javascript" language="javascript">
function AddGoodsGroup()
{   
   var name=$('#name').val();
   if(name==''){
	   alert('名称不能为空！');
	   return;
   }
   var title=$('#title').val();
   if(title==''){
	   alert('标题不能为空！');
	   return;
   }
   
   $.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/GoodsGroup/AddMain.jsp',
		cache: false,
		data: {name:name,title:title},
		error: function(XmlHttpRequest,textStatus,erroeThrown){			
			alert("添加组商品出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){
				alert('添加成功！');
				$('#id').val(json.val);
				//$('#title').val('');
				//$('#name').val('');
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function AddSub(obj){
	var ids=$('#id').val();
	if(ids==''){alert('参数不正确，请先添加主表信息！');return;}
	if($(obj).length>0){
		var gdsid='';
		var value='';
		$(obj).parent().parent().find('td').each(function(i){
			if(i==0){
				gdsid=$(this).find("input:text").val();
			}
			if(i==1){
				value=$(this).find("input:text").val();
			}
		});
		if(gdsid==''){alert('商品编码不能为空！'); return;};
		if(value==''){alert('显示名称不能为空！');return;}
		 $.ajax({
				type: "post",
				dataType: "json",
				url: '/admin/ajax/GoodsGroup/AddSub.jsp',
				cache: false,
				data: {id:ids,gid:gdsid,val:value},
				error: function(XmlHttpRequest,textStatus,erroeThrown){			
					alert("添加信息出错，请稍后重试或者联系客服处理！");
				},success: function(json){
					if(json.succ){
						alert('添加成功！');
					}else{
						alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
		}
		

	else{
		alert('参数不正确！');return;
	}
}
function continueAdd()
{
	var strRet='<tr><td height="32"><input type="text" value=""></input></td><td align="left"><input type="text"  value=""></input></td><td><a href="javascript:void(0)" onclick="AddSub(this)">添加</a></td></tr>';
	$('#gdsTable tr:last'). prev().after(strRet); 
}
</script>
</head>
<body>
<div>
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:980px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="806" valign="top">
    <h3 style=" font-size:18px; color:#f00;">添加组商品</h3>
    <table id="gdsTable" width="600" style="margin:0px auto;" border="1">
        <tr><td width="30%" height="32">名称</td><td colspan="2" align="left">&nbsp;&nbsp;<input type="text" id="name" value="" style="width:400px;"></input></td></tr>
        <tr><td height="32">标题</td><td  colspan="2"  align="left">&nbsp;&nbsp;<input type="text" id="title" value="" style="width:300px;"></input> </td></tr>
    <tr><td colspan="3" height="40"><input type="button" onclick="AddGoodsGroup()" value="添加" ></input></td></tr>
    <tr><td colspan="3" style="color:#f00; font-size:14px;" height="35" align="left">&nbsp;&nbsp;组商品详细信息<input type="hidden" id="id" name="id" value="1"></input></td></tr>
    	<tr><td height="32">商品编码</td><td>显示名称</td><td>操作</td></tr>
    	<tr>
    			<td height="32"><input type="text" value=""></input></td>
    			<td align="left"><input type="text"  value=""></input></td>
    			<td><a href="javascript:void(0)" onclick="AddSub(this)">添加</a></td>
    	</tr>
    	<tr><td colspan="3" height="30"><a href="javascript:void(0)" onclick="continueAdd();">点击继续添加</a>&nbsp;&nbsp;&nbsp;<a href="GoodsGroupList.jsp" >返回组商品管理</a></td></tr>
    </table>
   </td>
   </tr>
   </table> 
</div>
</body>
</html>