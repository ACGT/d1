<%@ page contentType="text/html; charset=UTF-8"%><%!
private static final Object LOCK = new Object();
%><%
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	synchronized(LOCK){
		com.d1.search.SearchManager.getInstance().batchUpdateProductIndex();
		com.d1.helper.CartItemHelper.deleteRecordBeforeOneHour();//删除超过1小时的购物车记录
	}
}
%>