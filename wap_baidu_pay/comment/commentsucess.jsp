<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%><%@include
	file="../inc/islogin.jsp"%><%!
 List getD1Comment(Long mbrid,String sessionid,String orderid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("sessionid", sessionid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	return Tools.getManager(D1Comment.class).getList(listRes, null, 0, 10);
}
static ArrayList<OrderScore> getFxScore(String mbrid,String orderid){
	ArrayList<OrderScore> rlist = new ArrayList<OrderScore>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdscomscore_mbrid", new Long(mbrid)));
	clist.add(Restrictions.eq("gdscomscore_status", new Long(0)));
	clist.add(Restrictions.eq("gdscomscore_orderid", orderid));
	List<BaseEntity> list = Tools.getManager(OrderScore.class).getList(clist, null, 0, 10);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((OrderScore)be);
	}
	return rlist ;
}
%>
<%
if(!Tools.isNull(request.getParameter("orderid"))){
	//判断订单是否属于改用户
	OrderBase obase=OrderHelper.getById(request.getParameter("orderid"));
	 if(obase!=null){
		  if(!lUser.getId().equals(String.valueOf(obase.getOdrmst_mbrid()))){
			  out.print("你没有权限进行操作！");
				return;
		  }
	 }
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>商品评价 - D1优尚</title>
<style type="text/css">
body {
	background: #fff;
	font: 14px Arial, "微软雅黑";
	color: #4b4b4b;
	padding-bottom: 15px;
	line-height: 18px;
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

.clear {
	clear: both;
	font-size: 1px;
	line-height: 0;
	height: 0px;
	*zoom: 1;
}

img {
	border: none;
}

input {
	width: 150px;
}
</style>
</head>
<body>

	<%@ include file="../inc/head.jsp"%>

	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>评价预览 <br />
		</div>


		<form>

			<%
     if((!Tools.isNull(request.getParameter("sessionid"))) &&  !Tools.isNull(request.getParameter("orderid"))){
    	  List<Comment> list=CommentHelper.getMyNewCommentList(new Long(lUser.getId()),request.getParameter("orderid"));
    	  ArrayList<OrderScore> scorelist= getFxScore(lUser.getId(),request.getParameter("orderid"));
    	  int score=0;
    	  if(scorelist!=null && scorelist.size()>0){
    		  score=scorelist.get(0).getGdscomscore_score().intValue();
    	  }
    	  if(list!=null && list.size()>0){
  %>
			<table border="0">

				<tr>
					<td class="peisong_body" align="center" valign="middle"
						height="40px">
						<%
			if(!Tools.isNull(Tools.getCookie(request,"PINGAN"))){
				%> <span style="font-size: 14px; font-weight: bold">评价已成功</span> <%}else{
			%> <span style="font-size: 14px; font-weight: bold">评价已成功，您获得了<%=score %>个积分
					</span> <%} %>
					</td>
				</tr>
				<tr>
					<td class="peisong_body" align="center" valign="middle"
						height="30px" style="background-color: #FEEEF1;"><b
						style="font-size: 16px;">我的评价</b></td>
				</tr>
			</table>
			<table border="0">
				<tr>
					<td style="color: #a25663; width: 80px;">订单号</td>
					<td><a
						href="/wap/orderdetail.jsp?orderid=<%=request.getParameter("orderid") %>"><%=request.getParameter("orderid") %></a></td>
				</tr>
				<% 
    		 for(Comment comment:list){
    			
    			 Product product= ProductHelper.getById(comment.getGdscom_gdsid());
				
				 String linkurl="";
				 if(product!=null){
					
					 linkurl="/wap/goodsdetail.jsp?productid="+product.getId();
				 } %>


				<tr>
					<td style="color: #a25663;">商品信息</td>

					<td><span class="sptitle" style="display: block;"><a
							href="<%=linkurl %>" target="_blank"><%=comment.getGdscom_gdsname() %></a></span></td>
				</tr>
				<tr>
					<td style="color: #a25663;">我的评分</td>
					<td><font color="red"><%=comment.getGdscom_level() %>分</font></td>
				</tr>
				<tr>
					<td style="color: #a25663;">使用心得</td>
					<td style="text-align: left; padding: 3px;"><%=comment.getGdscom_content()%>
						<br /></td>
				</tr>
				<tr>
					<td style="color: #a25663;">评价时间</td>
					<td><%=Tools.stockFormatDate(comment.getGdscom_createdate()) %></td>
				</tr>
				<%}
		 	  %>

			</table>
			<%}}
         
    	%>

		</form>
		<a href="/wap/user/comment1.jsp">返回我的评价</a>
	</div>


	<div class="clear"></div>
	<%@ include file="../inc/userfoot.jsp"%>

</body>
</html>