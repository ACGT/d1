<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%@include file="../islogin.jsp" %><%
String id = request.getParameter("id");

Product product = ProductHelper.getById(id);
if(product == null){
	out.print("{\"success\":false,\"message\":\"找不到您要收藏的物品信息！\"}");
	return;
}
//防止刷页面
/*Long lastPostTime = (Long)Const.LIMIT_HASH_MAP.get(new Long(lUser.getId()));
if(lastPostTime!=null){
	if(System.currentTimeMillis()-lastPostTime.longValue()<Const.LIMIT_MILLSECONDS){
		out.print("{\"success\":false,\"message\":\"您操作得太快了，请稍息一会！\"}");
		return;
	}
}
Const.LIMIT_HASH_MAP.put(new Long(lUser.getId()),new Long(System.currentTimeMillis()));*/

Favorite fa = FavoriteHelper.addFavorite(lUser,product);
if(fa != null){
	out.print("{\"success\":true,\"message\":\"收藏成功！\"}");
	return;
}else{
	out.print("{\"success\":false,\"message\":\"参数传递错误！\"}");
	return;
}
%>