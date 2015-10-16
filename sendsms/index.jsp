<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="
java.io.UnsupportedEncodingException,
java.rmi.RemoteException,
javax.xml.rpc.ServiceException,
org.tempuri.*,
java.util.*,
java.io.IOException
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
  try {
		int ret=Wsendsms.sendsms("D1优尚网客户您好，我们已确认您的订单，收货时请认准D1优尚专用纸箱，务必验货后再付款！有问题请致电4006808666","15011462232");
	System.out.print("d1gjlsms:"+ret);
  } catch (IOException e) {
		e.printStackTrace();
	}
  /*String smstxt=request.getParameter("smstxt");
  String smsphone=request.getParameter("phone");
  WmgwLocator wmgwLocator = new WmgwLocator();
	String strArgs[] = new String[10];
	//jc2339  551251
	strArgs[0] = wmgwLocator.smsuserid;
	strArgs[1] = wmgwLocator.smspwd;		//
	strArgs[2] = "15210397262,15010387704,13020080878,15001006044,15801097592,15247774988,13500000000,13001946180,18688449904,15501150439,13910605077,13146601767,13811734942,18666089104,13141231690,18085020183,13984138315,13678506309,15011462232,13031152305,13241838566,15210397262,13261096880,13683038061,18610198227,13011195242,18611710266,15210667886,13031032773,15810751188";//
	strArgs[3] = "尊敬的会员,D1优尚网妆品触底价,欧莱雅水精华、隔离乳79元,兰芝睡眠面膜139,满额免费领活肤露,d1.cn测试收到回复高军亮";	//
	strArgs[4] = "30";			//
	strArgs[5] = "*";			//
	//String strMsg = new String(strArgs[3].getBytes("UTF-8"));//web
	String strMsg = strArgs[3];
	System.out.println("d1gjl:"+strMsg);
	//发短信
	
	try {
		System.out.println("Test mongateCsSendSmsExNew ...");
		System.out.println("back value is :"
				+ wmgwLocator.getwmgwSoap().mongateCsSpSendSmsNew(strArgs[0],
						strArgs[1], strArgs[2], strMsg, Integer.valueOf(strArgs[4]).intValue(),strArgs[5]));
		System.out.println("send mongateCsSendSmsExNew end !");
		System.out.println();
	} catch (RemoteException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ServiceException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	//收状态报告
	try {
		System.out.println(strArgs[3]+"Test mongateCsGetStatusReportExEx ...");
		String[] strRet = wmgwLocator.getwmgwSoap().mongateCsGetStatusReportExEx(strArgs[0], strArgs[1]);
		System.out.println("back value is :");
		if (strRet != null)
		{
			for(int i = 0; i < strRet.length; ++i)
			{
				System.out.println(strRet[i]);
			}
		}
		else
		{
			System.out.println("null");
		}
		System.out.println(strArgs[3]+"send mongateCsGetStatusReportExEx end !");
		System.out.println();
	} catch (RemoteException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ServiceException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}*/
	
	%>
  </body>
</html>
