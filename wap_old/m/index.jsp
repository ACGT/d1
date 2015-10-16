<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*,com.d1.bean.id.SequenceIdGenerator,java.util.Hashtable,com.todaynic.client.mobile.*"%><%@include file="/inc/header.jsp"%>

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
if(request.getMethod().toLowerCase().equals("post"))
{
	String tele="";
	if(request.getParameter("tele")!=null&&request.getParameter("tele").length()>0)
	{
		tele=request.getParameter("tele");
	}
	else
	{
		Tools.outJs(out, "手机号码不能为空！", "back");
	}
	if(!Tools.isMobile(tele))
	{
		Tools.outJs(out, "手机号码格式不正确！", "back");
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
		   Tools.outJs(out,"发送失败，请稍后重试！","index.jsp");
	   }
	}
	else
	{
		Tools.outJs(out,"请十分钟之后再获取短信！","back");
	}
}
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网--手机版 （m.d1.cn）</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/PublicFunction.js")%>"></script>
<style type="text/css">
.center{ margin:0px auto;background:#fff; width:980px; background:url('http://images.d1.com.cn/wap/wapbj2013-2.jpg'); width:980px; height:1120px;}
   </style>
<script type="text/javascript">
function Check()
{
	var tele=$("#tele").val();
	if(tele=='')
		{
		$.alert('手机号码不能为空！');
		return;
		}
	else if(!isMobile(tele))
		{
		$.alert('手机号码格式有误，请重新输入！');
		return;
		}
	else
		{
		this.getlink.submit();
		}
	}
</script>
</head>

<body style="background:#fff; ">
<%@ include file="/inc/head.jsp" %>
<div class="center" >
    <table>
    <tr><td height="98" style=" width:10px; width:9px\0; _width:8px; +width:10px;"></td>
    <img src="http://images.d1.com.cn/images2012/bgbgbg.gif" usemap="#maptele" style="position:absolute;  width:980px; height:98px;"/>
    <td></td></tr>
    <tr><td></td><td height="660">
         <table><tr><td>
         <div style="background:url('http://images.d1.com.cn/images2012/telephones.gif') ; width:303px; height:593px; text-align:center; z-index:9999;">
            <iframe src ="/mindex.jsp" scrolling="yes" frameborder="0" width="246" height="374" style=" margin-top:113px; ">
               
            </iframe>
         </div></td></tr>
            <tr><td height="67"></td></tr>
         </table>
         </td>
   
        <td width="700">
            <table style=" width:100%">
               <tr><td height="170" colspan="2"></td></tr>
               <tr><td height="120" colspan="2" valign="top" style=" font-size:80px; line-heihgt:120px; text-align:center; font-family:'微软雅黑'; color:#fff; "><table width="100%" border="0" cellpadding="0" cellspacing="0">
                 <tr>
                   <td width="62%"><font style="color:#333333">m.d1</font><font style="color:#f00">.cn</font></td>
                   <td width="38%" valign="top"><img src="http://images.d1.com.cn/wap/wapurl.png" alt="" width="105" height="105" /></td>
                 </tr>
               </table>
                 </td>
               </tr>
               <tr><td height="190" colspan="2" ></td></tr>
               <tr><td height="180" width="315"></td>
               <td width="326" align="center" valign="top"><table width="96%" height="159" border="0" cellpadding="0" cellspacing="0">
                 <tr>
                   <td height="44">&nbsp;</td>
                 </tr>
                 <tr>
                   <td height="115" align="center" bgcolor="#F2F2F2"><img src="http://images.d1.com.cn/wap/wapurl.png" alt="" width="115" height="115" /></td>
                 </tr>
               </table></td>
               </tr>
               <tr><td></td></tr>
            </table>
        </td>
    </tr>
    </table>

</div>

<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>


</body>
</html>