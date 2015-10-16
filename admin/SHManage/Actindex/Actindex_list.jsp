<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
/**
 * 审核列表--actindex
 */
 public static ArrayList<ActIndex> getActIndexList(HttpServletRequest request,HttpServletResponse response){
	   ArrayList<ActIndex> list=new ArrayList<ActIndex>();
	   List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	   String user_id = request.getSession().getAttribute("shopcodelog").toString();//获取后台商户的id值
	   if(null != user_id){
	   	   listRes.add(Restrictions.eq("actindex_shopcode", user_id));
	   }
	   String act= request.getParameter("act");//专题名称
	   if("form_search".equals(act)){
		   String actindex_name= request.getParameter("actindex_name");//专题名称
		   String actindex_subad= request.getParameter("actindex_subad");//专题名称
		   String actindex_dectype= request.getParameter("actindex_dectype");//推荐位类型
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");

		   if(!Tools.isNull(actindex_name)){
			   listRes.add(Restrictions.like("actindex_name", "%"+actindex_name+"%"));
		   }
		   if(!Tools.isNull(actindex_subad)){
			   listRes.add(Restrictions.eq("actindex_subad", actindex_subad));
		   }
		   if(Tools.parseInt(actindex_dectype) > -1){
			   listRes.add(Restrictions.eq("actindex_dectype", new Long(actindex_dectype)));
		   }
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		   Date start = null;
		   Date end = null;
		   try{
			   if(!Tools.isNull(orderdate_s)){
				 start = sdf.parse(orderdate_s);
			   	 listRes.add(Restrictions.ge("actindex_createdate", start));
			   }
			   if(!Tools.isNull(orderdate_e)){
				 end = sdf.parse(orderdate_e);
				 listRes.add(Restrictions.le("actindex_createdate", end));
			   }
		   }catch(Exception e){
			   e.printStackTrace();
			   System.out.println("字符串转换日期失败!");
		   }
		  
	   }
	   listRes.add(Restrictions.eq("actindex_delflag", new Long(0)));//为1时代表删除
   	   List<Order> olist=new ArrayList<Order>();
	   olist.add(Order.desc("actindex_createdate"));
	   List<BaseEntity> list2 = Tools.getManager(ActIndex.class).getList(listRes, olist, 0, 500);
	   if(list2==null || list2.size()==0){
			return null;
	   }
	   for(BaseEntity be:list2){
			list.add((ActIndex)be);
	   }
	return list;
 }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>专题列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/ShopMJS.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<style type="text/css">
.GPager{ width:100%; height:50px;; text-align:center; line-height:50px;}
.GPager a{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px; color:#333;}
.curr{background:#f7f7f7;border:1px solid #73bdfc;padding:5px; margin:2px;}
.GPager a:visited{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px;}
</style>

<script type="text/javascript">
function del(id)
{
	var b = window.confirm('确定要删除id为'+id+'的记录吗？')
	if(b){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/actindex_del.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
						$('#tishi').html(json.message);
						$('#sel_del_'+id).hide();
					}else{
						$('#tishi').html(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	
	}else{
		return false;
	}
}
</script>

</head>

<body style=" background:#fff;">
<%@include file="/res/js/date.js"%>
<%@include file="/admin/inc/shhead.jsp" %>

<form id="search1" name="search1" method="post" action="Actindex_list.jsp?act=form_search" >
<div>
<br/>
<br/>
<table style="width:1000px; margin:0px auto;" border="0" cellpadding="0" cellspacing="0">
   <tr><td width="174" style="text-align:center;" valign="top">
     <%@include file="/admin/inc/shleftwh.jsp" %>
   </td>
   <td width="926" valign="top">
   <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#464646">
<tr><td>
<% 
String actindex_name = "";
if(request.getParameter("actindex_name")!=null){
	actindex_name = request.getParameter("actindex_name");
}
String actindex_subad = "";
if(request.getParameter("actindex_subad")!=null){
	actindex_subad = request.getParameter("actindex_subad");
}

String orderdate_s = "";
if(request.getParameter("orderdate_s")!=null){
	orderdate_s = request.getParameter("orderdate_s");
}
String orderdate_e = "";
if(request.getParameter("orderdate_e")!=null){
	orderdate_e = request.getParameter("orderdate_e");
}
String t_type = "";
if(request.getParameter("actindex_dectype")!=null){
	t_type = request.getParameter("actindex_dectype");
}
%>
<input type="hidden" value="<%= t_type%>" id="t_type"/>
    &nbsp;&nbsp;&nbsp;&nbsp;专题名称：<input type="text" id="actindex_name" name="actindex_name"style=" color:#333; line-height:25px;width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= actindex_name%>"></input>  
	&nbsp;&nbsp;时间：<input type="text" id="orderdate_s" name="orderdate_s" onClick="WdatePicker()" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=orderdate_s%>"></input>
   &nbsp; 至&nbsp;<input type="text" id="orderdate_e" name="orderdate_e" onclick="WdatePicker();" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=orderdate_e%>"></input>
 &nbsp;&nbsp;格式&nbsp;(2013-10-15)
</td></tr>
<tr><td colspan="2"  height="40">
&nbsp;&nbsp;&nbsp;&nbsp;subid：<input type="text" id="actindex_subad" name="actindex_subad"style=" color:#333; line-height:25px;width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= actindex_subad%>"></input>  
&nbsp;&nbsp;&nbsp;&nbsp;推荐位类型：
<select id="actindex_dectype" name="actindex_dectype">
	<option value="-2">--请选择--</option>
	<option value="0">简单模板</option>
	<option value="1">160*160*4/行通用模板</option>
	<option value="2">200*200*3/行通用模板</option>
	<option value="3">200*250*3/行通用模板</option>
</select>

</td>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<span id="tishi"  style="color:#ff0000"></span></td>
</tr>
<tr>
<td colspan="2"  style="text-align:right;">
<input type="image" src="/admin/SHManage/images/search.png" style="margin-right: 20px;">
</td>
</tr>


<table width="100%" height="142" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
  <tr>
    <td width="3%" height="40" align="center" valign="middle">ID</td>
    <td width="30%" align="center" valign="middle">专题名称</td>
    <td width="15%" align="center" valign="middle">推荐位类型</td>
    <td width="10%" align="center" valign="middle">subad</td>
    <td width="15%" align="center" valign="middle">添加人</td>
    <td width="10%" align="center" valign="middle">创建时间</td>
    <td width="15%" align="center" valign="middle">操作</td></tr>
  </tr>
  <%

  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String ggURL = Tools.addOrUpdateParameter(request,null,null);
    ArrayList<ActIndex> productList =new ArrayList<ActIndex>();
    productList=getActIndexList(request,response);
    int totalLength = (productList != null ?productList.size() : 0);
    int PAGE_SIZE = 20 ;
    int currentPage = 1 ;
    String pg = request.getParameter("pageno");
    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);   
    int end = pBean.getStart()+PAGE_SIZE;
    if(end > totalLength) end = totalLength;  
    String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
    pageURL = pageURL.replaceAll("&+", "&");    
    if(productList != null && !productList.isEmpty()){  	  
 	   List<ActIndex> gList = productList.subList(pBean.getStart(),end);
 	   if(gList != null && !gList.isEmpty()){
	   %>
   <%
   //遍历商品
   int count=2;
   for(ActIndex act_list:gList)
   {
 	  if(act_list!=null)
 	  { count++;
 	  %>
  <tr style="line-height:30px;" id="sel_del_<%= act_list.getId()%>">
   <td align="center" valign="middle"><%= act_list.getId()%></td>
    <td align="center" valign="middle"><%= act_list.getActindex_name()%></td>
  
    <td align="center" valign="middle">
	    <%  String actindex_dectype="";
	        if(act_list.getActindex_dectype()==0){
	        	actindex_dectype="简单模板";
	        }else if(act_list.getActindex_dectype()==1){
	        	actindex_dectype="160*160*4/行通用模板";
	        }else if(act_list.getActindex_dectype()==2){
	        	actindex_dectype="200*200*3/行通用模板";
	        }else if(act_list.getActindex_dectype()==3){
	        	actindex_dectype="200*250*3/行通用模板";
	        }
	        out.print(actindex_dectype);
	     %>
	</td>
	<td align="center" valign="middle"><%= act_list.getActindex_subad()!= null ? act_list.getActindex_subad():""%></td>
    <td align="center" valign="middle"><%= act_list.getActindex_adduser()!= null ? act_list.getActindex_adduser():""%></td>
    <td align="center" valign="middle"><%= sdf.format(act_list.getActindex_createdate())%></td>
    <td align="center" valign="middle">
    	<a href="/admin/SHManage/Actindex/Actindex_update.jsp?id=<%=act_list.getId() %>">编辑</a>
    	<a href="javascript:void(0);" onclick="del('<%= act_list.getId()%>');">删除</a>
    	<a href="/html/zhuanti/email_index.jsp?id=<%=act_list.getId() %>" target="_blank">预览</a>
    </td>
  </tr tyle="line-height:20px;">
   <%}
	      }	 
       if(pBean.getTotalPages()>1){
       %>
       <tr><td colspan="13" height="50" width="100%" style="text-align:center;">
       <div class="GPager">
       	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
       	<%
      	
       	if(pBean.getCurrentPage()>1){ %>
       	<a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%>
       	<%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%>
       	<%
     
       	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
       		
       		if(i==currentPage){
       		%><span class="curr"><%=i %></span><%
       		}else{
       			if(i==1)
       			{%>
       				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
       			<%}
       			else
       			{
       		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
       		    }
       		}
       	}%>
       	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
       	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
       </div></td></tr><%}%>
       
       <%}
    
    }
    else{%>
		 <div>没有满足条件的商品！！！</div>  
	<%}%>
     
    </td>
  	</tr>
  	<tr>
      <td colspan="7">&nbsp;</td>
    </tr>
</table>
</table>  
</table>
</div>
</form>
</body>
</html>
<script type="text/javascript">
  $(document).ready(function(){
	  var t_type = $("#t_type").val();
	  $("#actindex_dectype option[value='"+t_type+"']").attr("selected", true); 
  });
 </script>