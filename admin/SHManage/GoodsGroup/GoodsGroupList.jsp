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
public static List<GoodsGroup> getGroupList(String shopcode){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdsgrpmst_shopcode", shopcode));
	List<Order> olist= new ArrayList<Order>();
	olist.add(Order.desc("gdsgrpmst_createtime"));
	List list = Tools.getManager(GoodsGroup.class).getList(listRes, olist, 0, 200);	
	if(list == null || list.isEmpty()) return null;	
	return list;
}



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
.GPager{ width:100%; height:50px;; text-align:center; line-height:50px;}
.GPager a{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px; color:#333;}
.curr{background:#f7f7f7;border:1px solid #73bdfc;padding:5px; margin:2px;}
.GPager a:visited{ background:#deefff;border:1px solid #73bdfc; padding:5px; margin:2px;}
a img{ border:none;}
a{ text-decoration:none; color:#3A5FCD;} 
</style>
<script>
function deletes(id)
{
if(id==''){alert('参数不正确！');}
   if(confirm('您确定要删除吗？')){
	   $.ajax({
			type: "post",
			dataType: "json",
			url: '/admin/ajax/GoodsGroup/delete.jsp',
			cache: false,
			data: {id:id},
			error: function(XmlHttpRequest,textStatus,erroeThrown){			
				alert("删除组商品出错，请稍后重试或者联系客服处理！");
			},success: function(json){
				if(json.succ){
					alert('删除成功！');
					location.reload();
				}else{
					alert(json.message);
				}
			},beforeSend: function(){
			},complete: function(){
			}
		});
   }else{
	   return;
   }
	   
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
	<a href="Add.jsp" style="font-size:16px; color:#F00; text-decoration:none;">添加组商品</a>
	  <%  
	        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String ggURL = Tools.addOrUpdateParameter(request,null,null);
	        List<GoodsGroup> gglist=getGroupList(session.getAttribute("shopcodelog").toString());
		    int totalLength = (gglist != null ?gglist.size() : 0);
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
		    if(gglist!=null){
		    List<GoodsGroup> glist=gglist.subList(pBean.getStart(),end);
		    if(glist!=null&&glist.size()>0){%>
		    <table width="100%" border="1" cellpadding="0" cellspacing="0"><tr><th height="25">编号</th><th>名称</th><th>标题</th><th>商品列表</th><th>创建时间</th><th>操作</th></tr>
		    <%
		    	   for(GoodsGroup gg : glist)
		    	   {
		    		   if(gg!=null)
		    		   {%>
		    			<tr>
		    			<td width="5%" valign="middle">&nbsp;<%= gg.getId() %></td>
		    			<td width="25%" valign="middle">&nbsp;<%= Tools.clearHTML(gg.getGdsgrpmst_stdname()) %></td>
		    			<td width="15%" valign="middle">&nbsp;<%= Tools.clearHTML(gg.getGdsgrpmst_title()) %></td>
		    			<td width="25%">&nbsp;
		    			<%
		    			    List<GoodsGroupDetail> ggdlist=getGroupDetail(gg);
		    			    if(ggdlist!=null&&ggdlist.size()>0)
		    			    {%>
		    			    	<table>
		    			    <%  for(GoodsGroupDetail ggd:ggdlist)
		    			    	{
		    			    	   if(ggd!=null)
		    			    	   {%>
		    			    		   <tr><td><%= ggd.getGdsgrpdtl_gdsid() %></td>
		    			    		   <td><%
		    			    		   Product p=ProductHelper.getById(ggd.getGdsgrpdtl_gdsid());
		    			    		   if(p!=null)
		    			    		   {%>
		    			    		   <a href="http://www.d1.com.cn/Product/<%=p.getId() %>" target="_blank"><img src="<%= !Tools.isNull(p.getGdsmst_midimg())&&p.getGdsmst_midimg().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn" %><%= Tools.isNull(p.getGdsmst_midimg())?"":p.getGdsmst_midimg() %>" width="50" height="50"/></a>
		    			    		   <%}%></td>
		    			    		   <td><%= ggd.getGdsgrpdtl_stdvalue() %></td></tr>
		    			    		   
		    			    	   <%}
		    			    	}%>
		    			   
		    			    	</table>
		    			    <%}
		    			
		    			%>
		    			</td>
		    			<td width="15%">&nbsp;<%= format.format(gg.getGdsgrpmst_createtime()) %></td>
		    			<td width="10%">&nbsp;<a href="Update.jsp?id=<%= gg.getId() %>">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deletes('<%= gg.getId() %>')">删除</a></td>
		    			</tr>
		    		    
		    		   <%
		    		   }
		    	   }
                    if(pBean.getTotalPages()>1){
   			        %>
   			        <tr><td colspan="13" height="50" width="100%" style="text-align:center;">
   			        <div class="GPager">
   			        	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
   			        	<%if(pBean.getCurrentPage()>1){ %>
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
   			          
		    </table>
		    <%}
		    }
	  %>
	  </td>
	  </tr>
	  </table>
	  
	</div>
</body>

