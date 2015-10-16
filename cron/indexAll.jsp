<%@ page contentType="text/html; charset=UTF-8"%><%!
private static final Object LOCK = new Object();
%><%
//重建索引，每天执行一次
if("127.0.0.1".equals(request.getRemoteHost())||"localhost".equals(request.getRemoteHost())){
	synchronized(LOCK){
		com.d1.search.SearchManager.getInstance().reIndexAllProduct();
	}
}
%>