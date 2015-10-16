<%@ page contentType="text/html; charset=UTF-8" import="com.todaynic.client.mobile.*"%><%@include file="../../inc/header.jsp" %>
<%


Date date=null;
String edate="";
if(request.getParameter("date")!=null&&request.getParameter("date").length()>0)
{
	edate=request.getParameter("date");
	//Tools.outJs(out,edate,"back");
	SimpleDateFormat df1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	date=df1.parse(edate);
    
}

	String tele="";
	if(request.getParameter("tele")!=null&&request.getParameter("tele").length()>0)
	{
		tele=request.getParameter("tele");
	}
	else
	{
		out.print("{\"success\":false,\"message\":\"手机号码不能为空！\"}");
	 }
	if(!Tools.isMobile(tele))
	{
		out.print("{\"success\":false,\"message\":\"手机号码格式不正确！\"}");
	   
	}
	
	String filename="/opt/d1web"+File.separator+"WEB-INF"+File.separator+"classes"+File.separator+"VCPConfig.ini";
	String SendTime=	"0";
	Properties prop=new Properties();
	try{
		File fp = new File(filename);
		if(!fp.exists()){
			out.println("读取不到配置文件"+filename);
			out.close();
		}
		prop.load(new FileInputStream(fp));
		fp=null;
	}catch(Exception e){
		out.println("read file error");
	}
	
	Hashtable configTable=new Hashtable();
	configTable.put("VCPSERVER",prop.getProperty("VCPSERVER"));
	configTable.put("VCPSVPORT",prop.getProperty("VCPSVPORT"));
	configTable.put("VCPUSERID",prop.getProperty("VCPUSERID"));
	configTable.put("VCPPASSWD",prop.getProperty("VCPPASSWD"));
	String msg="D1优尚网手机版链接地址： http://m.d1.cn （点击此链接即可访问）。";

	 //获取一个月前的时间
    
	
	 
	if(date==null||(date!=null&&new Date().after(date)))
	{
		
	   SMS smssender=new SMS(configTable);
	   smssender.sendSMS(tele,msg,SendTime,"2");
	   String sendXml=smssender.getSendXml();
	   Hashtable recTable=smssender.getRespData();
	   String receiveXml=smssender.getRecieveXml();
	   String code=smssender.getCode();
	   String recmsg=smssender.getMsg();
	   session.setAttribute("SmsSendXml", sendXml);
	   session.setAttribute("SmsRecXml", receiveXml);
	   
	   if(code.equals("2000"))
	   {
		     String dates="";
		     SimpleDateFormat df1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		     Calendar c=Calendar.getInstance();
		     c.add(Calendar.MINUTE,10);
		     dates=df1.format(c.getTime());
		     
		     Tools.outJs(out,"信息已发送，请注意查收！","index.jsp?date="+dates);
	   } 
	   else
	   {
		   out.print("{\"success\":false,\"message\":\"发送失败，稍后重试！\"}");
	   }
	}
	else
	{
		out.print("{\"success\":false,\"message\":\"请在十分钟之后重新发送短信！\"}");
	}

%>