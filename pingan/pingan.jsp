<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%@page import="
com.pingan.cert.Verify.*,
com.d1.bean.PingAnUser,
com.d1.bean.User,
com.d1.bean.id.SequenceIdGenerator,
com.d1.helper.UserHelper,
com.pingan.cert.Verify.VerifyCertData,
java.io.UnsupportedEncodingException,
java.net.URLDecoder,
java.text.SimpleDateFormat,
java.util.Date
"%><%!
public String sendurl(int method,String strurl){
	String Url="";
	switch(method){ 
    case 1: 
    	Url="/flowCheck.jsp";
    	break; 
    case 2: 
    	Url="/flow.jsp";
    	break; 
    case 3: 
    	Url="/user/elforder.jsp";
    	break; 
    default: 
    	Url=strurl;
              break; 
	}
	return Url;
}


%>
<%
String strMemberID=request.getParameter("MemberID");
String strEmpFlg=request.getParameter("EmpFlg");
String strUserName=request.getParameter("UserName");
String strmethod=request.getParameter("method");
String strsysDate=request.getParameter("sysDate");
String strpaSignature=request.getParameter("paSignature");
String strsign=request.getQueryString();
boolean resultTrue = VerifyCertData.chkSign(strsign);

if (!resultTrue){
	Tools.outJs(out,"验签失败!","http://www.d1.com.cn");
	return;
}
 //05/11/2009 11:24:04平安传系统时间明文格式 
try{
String strDecodeSysDate= URLDecoder.decode(strsysDate,"UTF-8");
java.util.Date   nows=new   java.util.Date();   
SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
Date dsys=format.parse(strDecodeSysDate);
long   mins=(dsys.getTime()-nows.getTime())/(60*1000);  
  if(mins>3)
  {
	    Tools.outJs(out,"验证超时!","http://www.d1.com.cn");
		return;
  }
}
catch (Exception ex)
{
	 ex.printStackTrace();
}
 String geturl=strmethod;
if(strmethod.startsWith("http")){
	geturl=URLDecoder.decode(URLDecoder.decode(strmethod,"UTF-8"),"UTF-8");
}
else{
	geturl="/pingan/index.jsp";
}
int geturlvalue=0;
if (strmethod.equals("cart")){
	geturlvalue=1;
}
else if(strmethod.equals("popcart")){
	geturlvalue=2;
}
else if(strmethod.equals("odrlist")){
	geturlvalue=3;
}
if (Tools.isNull(strMemberID) || Tools.isNull(strUserName))
{
	   Tools.setCookie(response,"PINGAN","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
	   IntfUtil.KillsCookies(response, "PINGAN");
	   IntfUtil.DelCookie(response , "pingan.login");
	   String url=sendurl(geturlvalue,geturl);
	   response.sendRedirect(url);
	   return;
}
PingAnUser pauser=(PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_memberid", strMemberID);
if (pauser==null)
{
	try{
		String strMbrID= SequenceIdGenerator.generate("3");
		 boolean buser=IntfUtil.CreateUser(strMbrID, strMemberID+"@pingan",MD5.to32MD5("kn2h3x9sd6n6ve690w"), strUserName, "pingan");
	    if (buser){
	 	 boolean bpaUser=IntfUtil.CreatePinganUser(strMemberID+"@pingan", strMemberID, strEmpFlg, strUserName, new Long(strMbrID));
	        if(bpaUser){
	     	   Tools.setCookie(response,"PINGAN","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
	     	   Tools.setCookie(response,"pingan.login","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
	     	   IntfUtil.KillsCookies(response, "PINGAN");  
	     	   UserHelper.setLoginUserId(session,strMbrID);
	     	   //System.out.print(strMbrID+"1");
	     	  String url=sendurl(geturlvalue,geturl);
	   	     response.sendRedirect(url);
	   	   return;
	        }
	        else{
	     	   Tools.setCookie(response,"PINGAN","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
		    	   IntfUtil.KillsCookies(response, "PINGAN");
		    	   IntfUtil.DelCookie(response , "pingan.login");
		    	   String url=sendurl(geturlvalue,geturl);
		    	   response.sendRedirect(url);
		    	   return;
	        }
	    }
	}
	 catch(Exception ex){
		 ex.printStackTrace();
	 } 
}
else{
	Tools.setCookie(response,"PINGAN","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
	   Tools.setCookie(response,"pingan.login","1",(int)(Tools.DAY_MILLIS/1000));//1天过期
	   IntfUtil.KillsCookies(response, "PINGAN");  
	   UserHelper.setLoginUserId(session,pauser.getMbrmstpingan_mbrid().toString());
	   String url=sendurl(geturlvalue,geturl);
	   response.sendRedirect(url);
 }

%>