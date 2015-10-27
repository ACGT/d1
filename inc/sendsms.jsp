<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,cn.b2m.eucp.sdkhttp.*"%><%!
public static boolean SendSms(String phone,String smstxt){
	String[]  phones=phone.split("@@@@");
	int ret=SendSms.SendSMS(phones, "【d1优尚】"+smstxt);
	if(ret==0){
		return true;
	}else{
		return false;
	}
}
%>
