<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkshop.jsp"%>
<%!
/**
 * 专题列表
 */
 public static ArrayList<ShopInfo> getActIndexList(HttpServletRequest request,HttpServletResponse response){
	   ArrayList<ShopInfo> list=new ArrayList<ShopInfo>();
	   //List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	   List<Criterion> listRes = new ArrayList<Criterion>();
	   String shop_code = request.getSession().getAttribute("shopcodelog").toString();//获取后台商户的id值
	   if(null != shop_code){
	   	   listRes.add(Restrictions.eq("shopinfo_shopcode", shop_code));
	   }
	   String act= request.getParameter("act");//专题名称
	   String indexflag = request.getParameter("indexflag");
	   
	   if("form_search".equals(act)){
		   String actindex_name= request.getParameter("actindex_name");//专题名称
		   String orderdate_s= request.getParameter("orderdate_s");
		   String orderdate_e= request.getParameter("orderdate_e");
		   
		   
		   if(!Tools.isNull(actindex_name)){
			   listRes.add(Restrictions.like("shopinfo_title", "%"+actindex_name+"%"));
		   }
		   //System.out.println(actindex_name+">>>>>>>>>>>>>>>>>>>>");
	 
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		   Date start = null;
		   Date end = null;
		   try{
			   if(!Tools.isNull(orderdate_s)){
				 start = sdf.parse(orderdate_s);
			   	 listRes.add(Restrictions.ge("shopinfo_createdate", start));
			   }
			   if(!Tools.isNull(orderdate_e)){
				 end = sdf.parse(orderdate_e);
				 listRes.add(Restrictions.le("shopinfo_createdate", end));
			   }
		   }catch(Exception e){
			   e.printStackTrace();
			   System.out.println("字符串转换日期失败!");
		   }
		  
	   }
	   listRes.add(Restrictions.eq("shopinfo_del", new Long(0)));//删除状态 0未删除1已删除
	    if(!Tools.isNull(indexflag)&&indexflag.equals("3")){
		  listRes.add(Restrictions.eq("shopinfo_indexflag", new Long(3)));
	  }else if(!Tools.isNull(indexflag)&&indexflag.equals("1")){
		  listRes.add(Restrictions.eq("shopinfo_indexflag", new Long(1)));
	  }
	   //listRes.add(Restrictions.eq("shopinfo_indexflag", new Long(1)));
   	   List<Order> olist=new ArrayList<Order>();
	   olist.add(Order.desc("shopinfo_createdate"));
	   //List<BaseEntity> list2 = Tools.getManager(ShopInfo.class).getList(listRes, olist, 0, 500);
	   List<BaseEntity> list2 = Tools.getManager(ShopInfo.class).getListCriterion(listRes, olist, 0, 500);
	   if(list2==null || list2.size()==0){
			return null;
	   }
	   for(BaseEntity be:list2){
			list.add((ShopInfo)be);
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
function del(id){
	var b = window.confirm('确定要删除id为'+id+'的记录吗？')
	if(b){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/Shop/zt_del.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
						//$('#tishi').html(json.message);
						$('#sel_del_'+id).hide();
						alert(json.message);
					}else{
						alert(json.message);
						//$('#tishi').html(json.message);
					}
		        },beforeSend: function(){
		        }
		    });	
	}else{
		return false;
	}
}
//设为首页
function setShop(id,indexflag){
	if(indexflag == 3){
		var b = window.confirm('确定要设置id为'+id+'的记录为首页吗？')
	}else{
		var b = window.confirm('确定要恢复id为'+id+'的记录为专题吗？')
	}
	if(b){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/admin/ajax/Shop/set_shop.jsp",
		        cache: false,
		        data:{id:id,indexflag:indexflag},
		        error: function(XmlHttpRequest){
		            alert("操作失败！");
		        },
		        success: function(json){
		        	if(parseInt(json.code)==1){
						alert(json.message);
						if(indexflag == 3){
							//$('#sel_shop_'+id).hide();
							//$('#cancel_shop_'+id).show();
						}else{
							//$('#cancel_shop_'+id).hide();
							//$('#sel_shop_'+id).show();
						}
						
					}else{
						alert(json.message);
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

<form id="search1" name="search1" method="post" action="zhuanti_list.jsp?act=form_search" >
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
String orderdate_s = "";
if(request.getParameter("orderdate_s")!=null){
	orderdate_s = request.getParameter("orderdate_s");
}
String orderdate_e = "";
if(request.getParameter("orderdate_e")!=null){
	orderdate_e = request.getParameter("orderdate_e");
}
String indexflag = "";
if(request.getParameter("indexflag")!=null){
	indexflag = request.getParameter("indexflag");
}

%>
    &nbsp;&nbsp;&nbsp;&nbsp;专题名称：<input type="text" id="actindex_name" name="actindex_name"style=" color:#333; line-height:25px;width:150px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%= actindex_name%>"></input>  
	&nbsp;&nbsp;时间：<input type="text" id="orderdate_s" name="orderdate_s" onClick="WdatePicker()" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=orderdate_s%>"></input>
   &nbsp; 至&nbsp;<input type="text" id="orderdate_e" name="orderdate_e" onclick="WdatePicker();" style=" color:#333; line-height:25px;width:80px;border:solid 1px #d4d4d4;background:#f8f8f8; height:25px;" value="<%=orderdate_e%>"></input>
 &nbsp;&nbsp;
 是否设置成首页：<select  name="indexflag">
 	   <option value=""  <%if (indexflag.equals("")){ out.print("selected");}%>>全部</option>
       <option value="3"  <%if (indexflag.equals("3")){ out.print("selected");}%>>是</option>
	   <option value="1" <%if (indexflag.equals("1")){ out.print("selected");}%>>否</option>
    </select>
</td></tr>
<tr>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<span id="tishi"  style="color:#ff0000"></span></td>
</tr>
<tr>
<td colspan="2"  style="text-align:right;">
<input type="image" src="/admin/SHManage/images/search.png" style="margin-right: 20px;">
</td>
</tr>


<table width="100%" height="142" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
<span style="color: red; font-size: 12pt;">注：设置首页功能只能设置一个专题，且设置完之后，页面维护中的首页将失效。</span>
  <tr>
    <td width="3%" height="40" align="center" valign="middle">ID</td>
    <td width="35%" align="center" valign="middle">专题名称</td>
    <td width="15%" align="center" valign="middle">创建时间</td>
    <td width="35%" align="center" valign="middle">操作</td></tr>
  </tr>
  <%

  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String ggURL = Tools.addOrUpdateParameter(request,null,null);
    ArrayList<ShopInfo> productList =new ArrayList<ShopInfo>();
    productList=getActIndexList(request,response);
    int totalLength = (productList != null ?productList.size() : 0);
    int PAGE_SIZE = 10 ;
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
 	   List<ShopInfo> gList = productList.subList(pBean.getStart(),end);
 	   if(gList != null && !gList.isEmpty()){
	   %>
   <%
   //遍历商品
   int count=2;
   for(ShopInfo act_list:gList)
   {
 	  if(act_list!=null)
 	  { count++;
 	 ShpMst shpmst = (ShpMst)Tools.getManager(ShpMst.class).get(act_list.getShopinfo_shopcode());
 	  %>
  <tr style="line-height:30px;" id="sel_del_<%= act_list.getId()%>">
   <td align="center" valign="middle"><%= act_list.getId()%></td>
    <td align="center" valign="middle"><%= act_list.getShopinfo_title()==null?"":act_list.getShopinfo_title()%></td>
    <td align="center" valign="middle"><%= sdf.format(act_list.getShopinfo_createdate())%></td>
    <td align="center" valign="middle">
    	<a href="/admin/SHManage/Shop/SetIndex.jsp?index_flag=2&zt_id=<%=act_list.getId() %>">编辑</a>
    	<a href="javascript:void(0);" onclick="del('<%= act_list.getId()%>');">删除</a>
    	<%if(act_list.getShopinfo_indexflag()!=null&&act_list.getShopinfo_indexflag()==1){ %>
    	<a href="/shop/<%=act_list.getId() %>/2" target="_blank">预览</a>
    	<%}else{ 
    		if(shpmst != null && !Tools.isNull(shpmst.getShpmst_shopsname())){
    	%>
    	<a href="/shop/<%=shpmst.getShpmst_shopsname() %>" target="_blank">预览</a>
    	<%}} %>
    	<%if(act_list.getShopinfo_indexflag()!=null&&act_list.getShopinfo_indexflag()==1){ %>
    	<a id="sel_shop_<%= act_list.getId()%>" href="javascript:void(0);" onclick="setShop('<%= act_list.getId()%>',3);">设为首页</a>
    	<%}else{ %>
    	<a id="cancel_shop_<%= act_list.getId()%>" href="javascript:void(0);" onclick="setShop('<%= act_list.getId()%>',1);">设为专题</a>
    	<%} %>
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
  });
 </script>