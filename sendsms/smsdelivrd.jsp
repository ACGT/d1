<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="
java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.io.*,
java.util.*
"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>

  <%
  WmgwLocator wmgwLocator = new WmgwLocator();
	String strArgs[] = new String[10];
	//jc2339  551251
	strArgs[0] = wmgwLocator.smsuserid;
	strArgs[1] = wmgwLocator.smspwd;		//

	//收状态报告
	try {
		System.out.println("短信获取状态报告开始");
		String[] strRet = wmgwLocator.getwmgwSoap().mongateCsGetStatusReportExEx(strArgs[0], strArgs[1]);
		
		if (strRet != null)
		{
			FileWriter fw = new FileWriter(new File("/var/delivrdlog.txt"),true);
			for(int i = 0; i < strRet.length; ++i)
			{
				System.out.println(strRet[i]);
				
				fw.write(strRet[i]+System.getProperty("line.separator"));
			}
			fw.write(System.getProperty("line.separator"));
			fw.flush();
			fw.close();
		}
		System.out.println("短信获取状态报告结束");
	} catch (RemoteException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ServiceException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	%>
  </body>
</html>
