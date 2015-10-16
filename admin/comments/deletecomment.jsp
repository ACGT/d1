<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>删除评论</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/search.css")%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="/admin/comments/del.js"></script>
<script type="text/javascript">
$(document).ready(function(){
		$("#selectAll").click(function() {
		if ($(this).attr("checked") == true) { // 全选
		   $("input[name='cbox']").each(function() {
		   $(this).attr("checked", true);
		  });
		} else { // 取消全选
		   $("input[name='cbox']").each(function() {
		   $(this).attr("checked", false);
		  });
		}
		});
});

function del(){
	var i=0;
	$("input[name='cbox']:checkbox:checked").each(function(){ 
		if($.trim($(this).val()).length!=0){i++;}
		
		//alert($(this).val());
		$.ajax({
			type: "POST",
			url: "deletefunction.jsp",
			data:"commentid="+$(this).val(), 
			//contentType: "application/json; charset=utf-8",
			success: function(msg) {
				if(msg==0){
					return false;
				}else{
					//return true;
				}
			},
			error: function(xhr,msg,e) {
				return false;
			}
			});
	});
	if(i==0){alert("请选择您要删除的评论")}
	else{
		alert("删除成功！");
		window.location.href=$("#hurl").val();
		}
	
}
</script>
</head>
<body>
<center>
<%@include file="deletehead.jsp"%>

<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date rdate = new Date(System.currentTimeMillis()-(long)(3*Tools.MONTH_MILLIS*Math.random())); 
	String s = request.getParameter("txtstart");
	String e = request.getParameter("txtend");
	String gdsid = request.getParameter("txtgdsid");
	if(Tools.isNull(s) && Tools.isNull(e) && Tools.isNull(gdsid)){
		out.println("由于评论太多，请先输入查询条件检索！");
}else{
	 ArrayList<Comment>	 list=new  ArrayList<Comment>();
	 List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	 listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
	 if(!Tools.isNull(s)){
		 if(s.indexOf(":")<=0){
			 s=s+" 00:00:00"; 
		 }
		 listRes.add(Restrictions.ge("gdscom_createdate",sdf.parse(s)));
	 }
	
	 if(!Tools.isNull(e)){
		 if(e.indexOf(":")<=0){
			 e=e+" 23:59:59"; 
		 }
		 listRes.add(Restrictions.le("gdscom_createdate",sdf.parse(e)));
	 }
	if(!Tools.isNull(gdsid)){	
		listRes.add(Restrictions.eq("gdscom_gdsid", gdsid));
	}
	int pagesize=80;
	int currentPage=1;
	int totalcount=Tools.getManager(Comment.class).getLength(listRes);
	int pagecount=totalcount/pagesize;
	if(totalcount%pagesize!=0){
		pagecount++;
	}
	if(!Tools.isNull(request.getParameter("pg"))){
		currentPage=Integer.parseInt(request.getParameter("pg"));
	}
	String pgQueryString = "txtstart="+s+"&txtend="+e+"&txtgdsid="+gdsid;
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdscom_createdate"));
		List<BaseEntity> mxlist= Tools.getManager(Comment.class).getList(listRes, listOrder, (currentPage-1)*pagesize, pagesize);
		for(BaseEntity be:mxlist){
			list.add((Comment)be);
		}
	if(list!=null && list.size()>0){
		%>
		<table width="980" border="0" cellspacing="0" cellpadding="0">
		<tr>
		<td colspan="6"><input type="hidden" id="hurl" value="deletecomment.jsp?<%=pgQueryString%>"/><input type="button" value="删除" onclick="del();"/></td>
		</tr>
		<tr>
		<td width="60px"><input type="checkbox" value="all" id="selectAll" name="selectAll"/>全选</td>
		<td>评论编号</td>
		<td>商品编号</td>
		<td>订单号</td>
		<td width="450px">评论内容</td>
		<td>评论时间</td>
		</tr>
		
	<%	for(Comment comment:list){
		%>	
		<tr>
		<td><input type="checkbox" name="cbox" value="<%=comment.getId() %>" /></td>
		<td><%=comment.getId() %></td>
		<td><%=comment.getGdscom_gdsid() %></td>
		<td><%=comment.getGdscom_odrid() %></td>
		<td><%=comment.getGdscom_content() %></td>
		<td><%=comment.getGdscom_createdate()%></td>
		</tr>
		<%}%>	
		</table>
		         <div style="width:980px; text-align:center; border:solid 1px #fff;">
		    <table width="980" border="0" cellspacing="0" cellpadding="0" align="center" class="main" height="35"><%
		   if(pagecount>1){ %>
            <tr style='display:block'>
              <td width="131" >共<b><font color="#FF0000"><%=pagecount%></font></b>页，当前第<font color="#CC0000"><b><font color="#FF0000"><%=currentPage%></font></b></font>页 </td>
              <td ><%if(currentPage>1){ %> <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>&pg=1" class="pag1">首页</a> &nbsp;<%} %>
              <%
              	if(currentPage>1){
              %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>&pg=<%=currentPage-1 %>" class="pag1">上一页</a>&nbsp;
				<%}
				for(int i=currentPage;i<=pagecount;i++){
					if(currentPage == i){
						%><span class="curr1"><%=i %></span>&nbsp;<%
					}else{
						%><a href="<%=request.getRequestURI() %>?<%=pgQueryString%>&pg=<%=i%>" class="pag1"><%=i%></a>&nbsp;<%
					}
				}//end for
				if(currentPage<pagecount){
              %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>&pg=<%=currentPage+1 %>" class="pag1">下一页</a>&nbsp; 
              <%} %><%if(currentPage!=pagecount){ %>
              <a href="<%=request.getRequestURI() %>?<%=pgQueryString%>&pg=<%=pagecount%>" class="pag1">尾页</a><%} %></td>
              </tr><%
            } %>
          </table>
		        
        </div>
	<%
	}
	}
%>
</center>
</body>
</html>