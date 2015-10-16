<%@ page contentType="text/html; charset=UTF-8"%><%@page import="java.io.*"%><%
//这个jsp是用来接收淘宝sessinkey的，并把这个key存在硬盘上，这样TaobaoClient就可以用这个key连上
//淘宝商城数据，用来做订单同步和库存同步了。
//这个key目前淘宝给我们的有效期是30天，过期淘宝API将取不到数据，需要手动访问
//http://container.api.taobao.com/container?appkey=12383931，用d1商城的淘宝帐户登陆授权才可使用。
//授权成功后的key就会返回到这个jsp，并存在硬盘上
//返回到这个地址的配置在淘宝开放平台后台配置，也要用d1商城的淘宝帐户登陆才可以修改！
 String sessionKey = request.getParameter("top_session");

 if(sessionKey!=null&&sessionKey.trim().length()>0){
  	FileWriter fw = new FileWriter(new File("/var/taobao_session_key2.txt"),false);
  	fw.write(sessionKey);
  	fw.flush();
  	fw.close();
  }
 
  if("true".equals(request.getParameter("get"))){
	  BufferedReader br = new BufferedReader(new FileReader(new File("/var/taobao_session_key2.txt")));
	  String line = br.readLine();
	  br.close();
	  out.print(line);
  }
%>