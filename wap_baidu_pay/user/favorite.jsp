<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%
String backurl = request.getParameter("url");
if(Tools.isNull(backurl)){
	backurl = request.getHeader("referer");
	if(Tools.isNull(backurl)){
		backurl = "/";
	}
}

%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的收藏夹</title>
<style type="text/css">
body {
	line-height: 21px;
	background: #fff;
	padding-left: 4px;
	font-size: 16px;
	color: #333
}

a {
	text-decoration: none;
	color: #4169E1
}

a:hover {
	color: #aa2e44
}

img {
	border: none;
}
</style>
</head>
<body>
	<!-- 头部 -->
	<%@ include file="/wap/inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的收藏 <br />
		</div>
		<% 
    String msg="";
if(!Tools.isNull(request.getParameter("id"))){
	Favorite fa = FavoriteHelper.getById(request.getParameter("id"));
	if(fa!=null){
		if(!String.valueOf(fa.getGdswil_mbrid()).equals(lUser.getId())){
			msg="您没有权限进行此操作！";
			return;
		}
		if(FavoriteHelper.manager.delete(fa)){
			msg="删除成功！";
		}else{
			msg="删除失败，请重新再试！";
		}
	}
}
    
    
	int currentPage = 1 ;//当前页
	
	if(!Tools.isNull(request.getParameter("pg"))&&  StringUtils.isDigits(request.getParameter("pg"))){
		currentPage = new Integer(request.getParameter("pg")).intValue();
	}
	
	PageBean pb = new PageBean(FavoriteHelper.getLengtByUserId(lUser.getId()),5,currentPage);
    if(FavoriteHelper.getLengtByUserId(lUser.getId())==0){
         
    	    out.print("您没有收藏任何商品,<a href=\"/mindex.jsp\">去首页看看</a><br/>");
    	  }
    else
    {%>
		您共收藏了<%=FavoriteHelper.getLengtByUserId(lUser.getId()) %>件商品<br /> <span
			style="color: red;"><%=msg %></span> <br />
		<table>
			<%
			
			List<BaseEntity> list = FavoriteHelper.getByUserId(lUser.getId(), pb.getStart(), 5);
			if(list!=null&&list.size()>0){
				int i=0;
				for(BaseEntity be:list){
					Favorite f = (Favorite)be;
					Product p = (Product)Tools.getManager(Product.class).get(f.getGdswil_gdsid());
					if(p==null)continue;
					i++;
					String createstr = "";
					if(f.getGdswil_applytime()!=null){
						createstr = Tools.getFormatDate(f.getGdswil_applytime().getTime(),"yyyy-MM-dd HH:mm:ss");
					}
			%>
			<tr>
				<td colspan="2"><a
					href="/wap/goods.jsp?productid=<%= p.getId() %>"><%= Tools.clearHTML(p.getGdsmst_gdsname()) %></a></td>
			</tr>
			<tr>
				<td width="85"><a
					href="/wap/goods.jsp?productid=<%= p.getId() %>"><img
						src="<%=ProductHelper.getImageTo80(p) %>" width="80" height="80" /></a></td>
				<td>收藏时间：<%= createstr%><br /> <span
					style="display: block; float: left;">会员价:</span><span>&nbsp;￥<%= p.getGdsmst_memberprice().floatValue() %></span><br />

					<a
					href="<%  if(p.getGdsmst_skuname1()==null||p.getGdsmst_skuname1().length()==0) out.print("/wap/goodsend.jsp?gdsid="+ p.getId()); else { out.print("/wap/goods.jsp?productid="+p.getId());}%>    "
					style="background: #FF3030; color: #fff; padding: 1px; width: 75px; margin-top: 5px; display: block; text-align: center; float: left;">立即购买</a>&nbsp;&nbsp;
					<a href="favorite.jsp?id=<%=f.getId() %>&pg=<%=currentPage %>"
					style="text-decoration: underline; float: left; padding: 1px; margin-top: 5px; margin-left: 15px; dispaly: block;"
					onclick="delFav(<%=f.getId() %>,this)">删除</a>
				</td>
			</tr>

			<%}
			}	
    }
      %>
			<tr>
				<td colspan="2">
					<form action="favorite.jsp">
						<a
							href="<%=request.getRequestURI()%>?pg=<%= request.getParameter("pg")==null?1:Tools.parseInt(request.getParameter("pg"))==1?1:Tools.parseInt(request.getParameter("pg"))-1%>">上页</a>&nbsp;&nbsp;
						<a
							href="<%=request.getRequestURI()%>?pg=<%= request.getParameter("pg")==null?2:Tools.parseInt(request.getParameter("pg"))==pb.getTotalPages()?pb.getTotalPages():Tools.parseInt(request.getParameter("pg"))+1%>">下页</a>

						&nbsp;&nbsp;
						<input type="text" style="width: 50px;" id="page" name="pg"
							value="<%=currentPage%>" />/<%=pb.getTotalPages()  %>
						<input type="submit" value="跳&nbsp;转" style="padding: 4px;" />
						<br />
						<a href="<%= backurl%>">返回上一页</a>
					</form>
				</td>
			</tr>
		</table>


	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>
