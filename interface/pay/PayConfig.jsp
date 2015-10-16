<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.Tools,java.util.Date"%><%!

//是否显示控制台打印调试信息
private static final boolean isDebug = true;

//打印日志
private static void logInfo(String log){
	if(isDebug) System.err.println(Tools.stockFormatDate(new Date())+"："+log);
}

%>