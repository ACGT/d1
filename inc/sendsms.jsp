<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,cn.b2m.eucp.sdkhttp.*"%><%!
public static boolean SendSms(String phone,String smstxt){
	String[]  phones=phone.split("@@@@");
	smstxt="【d1优尚】"+smstxt;
	int ret=SendSms.SendSMS(phones, smstxt);
	SmsSndDtl  sms=new SmsSndDtl();
	if(ret==0){
		sms.setPhone(phone);
		sms.setSmstxt(smstxt);
		sms.setIfsend(new Long(1));
		sms.setSenddate(new Date());
		Tools.getManager(SmsSndDtl.class).create(sms);
		return true;
	}else{
		sms.setPhone(phone);
		sms.setSmstxt(smstxt);
		sms.setIfsend(new Long(-1));
		sms.setSenddate(new Date());
		Tools.getManager(SmsSndDtl.class).create(sms);
		return false;
	}
}
%>
