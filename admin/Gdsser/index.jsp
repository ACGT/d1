<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系列列表</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
</style>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script language="javascript" type="text/javascript">
function deleteGdsser(id)
{
	$.confirm('确定要删除该系列吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/deletegdsser.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("删除失败！");
		        },
		        success: function(json){
		        		$.alert(json.message,'提示',function(){
		        		this.location.href="/admin/Gdsser/index.jsp";
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}
</script>
</head>
<body style="padding-left:10px;">
<h3>FeelMind</h3><br/>
<%
ArrayList<Gdsser> list=new ArrayList<Gdsser>();
list=GdsserHelper.getGdsserByBrandid("987");
if(list!=null&&list.size()>0)
{
    for(Gdsser gdsser:list)
    {
    	if(gdsser!=null)
    	{%>
    		<a href="/admin/Gdscoll/gmanager.jsp?sid=<%= gdsser.getId() %>" target="top"><%= gdsser.getGdsser_title() %></a>&nbsp;&nbsp;
    		<!--  <a href="javascript:void(0)" onclick="deleteGdsser('<%= gdsser.getId() %>')" style='color:#f00'>删除</a>
    		-->
    		<br/>
    	<%}
    }
}

%>
<h3>小栗舍</h3><br/>
<%
ArrayList<Gdsser> list1=new ArrayList<Gdsser>();
list1=GdsserHelper.getGdsserByBrandid("1690");
if(list1!=null&&list1.size()>0)
{
    for(Gdsser gdsser:list1)
    {
    	if(gdsser!=null)
    	{%>
    		<a href="/admin/Gdscoll/gmanager.jsp?sid=<%= gdsser.getId() %>" target="top"><%= gdsser.getGdsser_title() %></a>&nbsp;&nbsp;
    		<!--  
    		<a href="javascript:void(0)" onclick="deleteGdsser('<%= gdsser.getId() %>')" style='color:#f00'>删除</a>
    		-->
    		<br/>
    	<%}
    }
}

%>
<h3>诗若漫</h3><br/>
<%
ArrayList<Gdsser> list2=new ArrayList<Gdsser>();
list2=GdsserHelper.getGdsserByBrandid("1969");
if(list2!=null&&list2.size()>0)
{
    for(Gdsser gdsser:list2)
    {
    	if(gdsser!=null)
    	{%>
    		<a href="/admin/Gdscoll/gmanager.jsp?sid=<%= gdsser.getId() %>" target="top"><%= gdsser.getGdsser_title() %></a>&nbsp;&nbsp;
    		    		<!--  
    		    		<a href="javascript:void(0)" onclick="deleteGdsser('<%= gdsser.getId() %>')" style='color:#f00'>删除</a>
    		    		-->
    		    		<br/>
    	<%}
    }
}

%>
<h3>YouSoo</h3><br/>
<%
ArrayList<Gdsser> list3=new ArrayList<Gdsser>();
list3=GdsserHelper.getGdsserByBrandid("1864");
if(list3!=null&&list3.size()>0)
{
    for(Gdsser gdsser:list)
    {
    	if(gdsser!=null)
    	{%>
    		<a href="/admin/Gdscoll/gmanager.jsp?sid=<%= gdsser.getId() %>" target="top"><%= gdsser.getGdsser_title() %></a>&nbsp;&nbsp;
    		    		<!--  <a href="javascript:void(0)" onclick="deleteGdsser('<%= gdsser.getId() %>')" style='color:#f00'>删除</a>
    		    		-->
    		    		<br/>
    	<%}
    }
}

%>

<br/>
<a href="/admin/Gdsser/ag.jsp" target="top">添加系列</a>

<div  style="backgrond:#f00">

<br/>
<br/>
<form id="search" name="search" method="post" action="/admin/Gdscoll/gdscolllist.jsp" target="top">
<font style="font-size:16px; color:#f00;">搜索选项：</font><br/>
请选择系列：<br/>
         <select id="gdsser" name="gdsser">
            <option value="0">请选择系列</option>
            <option value="1">FEEL MIND-北美风南加州系列</option>
    	    <option value="3">FEEL MIND-西部/户外经典系列</option>
    	    <option value="4">FEEL MIND-新英格兰/学院系列</option>
    	    <option value="5">小栗舍-精致甜美系列</option>
    	    <option value="7">小栗舍-俏女孩系列</option>
    	    <option value="6">小栗舍-优雅淑女系列</option>
    	    <option value="9">诗若漫-知性OL系列</option>
    	    <option value="10">诗若漫-丹宁风尚系列</option>
    	    <option value="11">诗若漫-国际经典系列</option>
    		</select>
<br/><br/>
搭配状态：<br/>
       <select id="gdsflag" name="gdsflag">
            <option value="13" >全部搭配</option>
            <option value="0">含待审核商品的搭配</option>
    	    <option value="5">含已审核，待上架的商品搭配</option>
    	    <option value="11">全部显示的搭配</option>
    	    <option value="12">全部不显示的搭配</option>
    	    
    		</select>
<br/><br/>
请输入商品编号：<input type="tetx" id="gdsid" name="gdsid" style="width:60px;"/>
<br/><br/>
请输入搭配编号：<input type="tetx" id="gdscoll" name="gdscoll" style="width:60px;"/>
<br/><br/>
<input type="submit" value="搜索" style="width:80px;"/>
<br/><br/>
</form>
<form id="search1" name="search1" method="post" action="/admin/Gdscoll/gdsmstlist.jsp" target="top">
<font style="font-size:16px; color:#f00;">商品搜索选项：</font><br/>
商品名称：<input type="tetx" id="gdsname" name="gdsname" style="width:200px;"/>
<br/>
<br/>
商品编号：<input type="tetx" id="id" name="id" style="width:60px;"/>
<br/><br/>
上下架标志：<select  id="validflag" name="validflag" >
           <option value="" >全部</option> 
           <option value="-1">被打回的申请</option>
           <option value="0">录入待上架</option>
		   <option value="5">已审核,待上架</option>
           <option value="1">上架</option>
           <option value="2">下架</option>
           <option value="4">隐藏</option>
            </select>
<br/><br/>
录入时间：<br/>
起始时间：<input type="tetx" id="startime" name="startime" style="width:100px;"/>
<br/><br/>
结束时间：<input type="tetx" id="endtime" name="endtime" style="width:100px;"/>
<br/>
(时间格式为：<br/>2012-1-1)
<br/>
<input type="submit" value="搜索" style="width:80px;"/>
</form>
</div>


</div>
</body>
</html>




