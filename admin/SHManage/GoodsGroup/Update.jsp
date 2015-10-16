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
<%!
/**
 * 根据分组对象获得此物品的所在分组的列表
 * @param GoodsGroup - 分组对象
 * @return List<GoodsGroupDetail>
 */
public static List<GoodsGroupDetail> getGroupDetail(GoodsGroup gg){
	if(gg == null) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpdtl_mstid", new Long(gg.getId())));
	
	List list = Tools.getManager(GoodsGroupDetail.class).getList(listRes, null, 0, 100);
	
	if(list == null || list.isEmpty()) return null;
	
	int size = list.size();
	
	List<GoodsGroupDetail> ggdList = new ArrayList<GoodsGroupDetail>();
	for(int i=0;i<size;i++){
		GoodsGroupDetail ggd = (GoodsGroupDetail)list.get(i);
		Product goods = ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		if(goods == null) continue;
		
		ggdList.add(ggd);
	}		
	return ggdList;
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
function UGoodsGroup(ids)
{
   if(ids==''){
	   alert('参数不正确！');
	   return;
   }
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
		url: '/admin/ajax/GoodsGroup/UpdateMain.jsp',
		cache: false,
		data: {id:ids,name:name,title:title},
		error: function(XmlHttpRequest,textStatus,erroeThrown){			
			alert("修改组商品出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){
				alert('修改成功！');
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}
function DeleteSub(ids,obj){
	if(ids==''){alert('参数不正确！');return;}
	if($(obj).length>0){
		if(confirm('您确定要删除吗？')){
		 $.ajax({
				type: "post",
				dataType: "json",
				url: '/admin/ajax/GoodsGroup/DeleteSub.jsp',
				cache: false,
				data: {id:ids},
				error: function(XmlHttpRequest,textStatus,erroeThrown){			
					alert("删除信息出错，请稍后重试或者联系客服处理！");
				},success: function(json){
					if(json.succ){
						alert('删除成功！');
						$(obj).parent().parent().remove();
					}else{
						alert(json.message);
					}
				},beforeSend: function(){
				},complete: function(){
				}
			});
		}
		else
			{
			return;
			}
	}
	else{
		alert('参数不正确！');return;
	}
}
function UpdateSub(ids,obj)
{
	if(ids==''){
		alert('参数不正确！');
		return;
	}
	if($(obj).length<=0){
		alert('参数不正确！');
		return;
	}
	var value='';
	$(obj).parent().parent().find('td').each(function(i){
		if(i==1){
			value=$(this).find("input:text").val();
		}
	});
	if(value==''){
		alert('参数不正确！');
		return;
	}
	//获取修改的新值
	$.ajax({
		type: "post",
		dataType: "json",
		url: '/admin/ajax/GoodsGroup/UpdateSub.jsp',
		cache: false,
		data: {id:ids,val:value},
		error: function(XmlHttpRequest,textStatus,erroeThrown){			
			alert("修改信息出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.succ){
				alert('修改成功！');
			}else{
				alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});	
}
function continueAdd(id)
{
	var strRet='<tr><td height="32"><input type="text" value=""></input></td><td align="left"><input type="text"  value=""></input></td><td><a href="javascript:void(0)" onclick="AddSub2(this,'+id+')">添加</a></td></tr>';
	$('#gdsTable tr:last'). prev().after(strRet); 
}
function AddSub2(obj,id){
	var ids=id;
	if(ids==''){alert('参数不正确！');return;}
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
						$(obj).parent().parent().find('td:first').html(gdsid);
						$(obj).parent().parent().find('td:last').html('<a href="javascript:void(0)" onclick="UpdateSub('+json.id+',this)">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="DeleteSub('+json.id+',this)">删除</a>');
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

function AddSub(ids){
	if(ids==''){alert('参数不正确，请先添加主表信息！');return;}
	var gdsid=$("#shop_code").val();
	var value=$("#shop_name").val();
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
</script>
</head>
<body>
<%@include file="/admin/inc/shhead.jsp" %>
<br/>
<br/>
<table style="width:980px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/SHleftPM.jsp" %>
   </td>
   <td width="806" valign="top">
<%  
if(request.getParameter("id")==null)
{
   out.print("参数不正确！");
   return;
}
String id=request.getParameter("id").toString();
GoodsGroup gg=(GoodsGroup)Tools.getManager(GoodsGroup.class).get(id);
if(gg!=null)
{
%>
<div>

    <h3 style=" font-size:18px; color:#f00;">修改组商品</h3>
    <table width="600" style="margin:0px auto;" border="1" id="gdsTable">
        <tr><td width="30%" height="32">名称</td><td colspan="2" align="left">&nbsp;&nbsp;<input type="text" id="name" value="<%=gg.getGdsgrpmst_stdname() %>" style="width:400px;"></input></td></tr>
        <tr><td height="32">标题</td><td  colspan="2"  align="left">&nbsp;&nbsp;<input type="text" id="title" value="<%=gg.getGdsgrpmst_title() %>" style="width:300px;"></input> </td></tr>
    <tr><td colspan="3" height="40"><input type="button" onclick="UGoodsGroup('<%=gg.getId() %>')" value="修改" ></input></td></tr>
    <%
    List<GoodsGroupDetail> ggdlist=getGroupDetail(gg);
    if(ggdlist!=null&&ggdlist.size()>0)
    {%>
    	<tr><td colspan="3" style="color:#f00; font-size:14px;" height="35" align="left">&nbsp;&nbsp;组商品详细信息</td></tr>
    	<tr><td height="32">商品编码</td><td>显示名称</td><td>操作</td></tr>
    	<%
    	for(GoodsGroupDetail ggd:ggdlist)
    	{
    		if(ggd!=null)
    		{%>
    			<tr>
    			<td height="32"><%= ggd.getGdsgrpdtl_gdsid() %></td>
    			<td align="left"><input type="text" id="dtl_<%=ggd.getId() %>" value="<%= ggd.getGdsgrpdtl_stdvalue() %>"></input></td>
    			<td><a href="javascript:void(0)" onclick="UpdateSub('<%= ggd.getId() %>',this)">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="DeleteSub('<%= ggd.getId() %>',this)">删除</a></td>
    			</tr>
    		<%}
    	}
    	%>
    	<tr><td colspan="3" height="30"><a href="javascript:void(0)" onclick="continueAdd('<%= gg.getId() %>');">点击继续添加</a></td></tr>
    <%}else{
    	%>
    	<tr><td colspan="3" style="color:#f00; font-size:14px;" height="35" align="left">&nbsp;&nbsp;组商品详细信息</td></tr>
    	<tr><td height="32">商品编码</td><td>显示名称</td><td>操作</td></tr>
			<tr>
			<td height="32"><input type="text" value="" id="shop_code"></input></td>
			<td align="left"><input type="text" value="" id="shop_name"></input></td>
			<td><a href="javascript:void(0)" onclick="AddSub(<%= gg.getId() %>)">添加</a></td>
			</tr>
    	
    	<tr><td colspan="3" height="30"><a href="javascript:void(0)" onclick="continueAdd('<%= gg.getId() %>');">点击继续添加</a></td></tr>
    <%
    	
    }
    
    %>
    </table>
</div>
<%} %>
</td>
</tr>
</table>

</body>
</html>