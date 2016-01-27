<%@ page contentType="text/html; charset=GBK"%>
<%@page import="
com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,
javax.net.ssl.*,
com.pingan.cert.Verify.*,
com.pingan.cert.Interface.*,
com.d1.bean.OrderBase,
com.d1.bean.PingAnUser,
com.d1.helper.OrderHelper,
com.d1.helper.UserHelper,
com.d1.bean.PingAnScoreLog,
com.d1.bean.PingAnScorePay,
com.d1.bean.PingAnUser,
java.util.Date,
java.text.SimpleDateFormat,
java.util.ArrayList,
org.dom4j.Document,
org.dom4j.DocumentException,
org.dom4j.Element,
org.dom4j.io.SAXReader,
org.dom4j.io.XMLWriter,
org.dom4j.Node,
api10086.*,
java.io.UnsupportedEncodingException,
java.text.ParseException,
java.text.SimpleDateFormat,
java.util.Date,
java.util.UUID
"%><%!
   public String getXmlRequest() {
    	String sXmlRequest="<?xml version=\"1.0\" encoding=\"gbk\"?>" +
    						"<EMAIL>" +
    							"<HEAD>" +
    							 	"<VERSION>0200</VERSION>" +
    							 	"<PROVINCE>%s</PROVINCE>" +
    							 	"<COMEFROM>%s</COMEFROM>" +
    							 	"<COMMANDID>%s</COMMANDID>" +
    							 	"<SKEY>%s</SKEY>" +
    							 	"<REQSN>%s</REQSN>" +
    							 	"<REQTIME>%s</REQTIME>" +
    							 "</HEAD>" +
    							 "<BODY>" +
    							 	"<FROM>%s</FROM>" +
    							 	"<FROMNAME>%s</FROMNAME>" +
    							 	"<TO>%s</TO>" +
    							 	"<TONAME>%s</TONAME>" +
    							 	"<BRAND>%s</BRAND>" +
    							 	"<BUSICODE>%s</BUSICODE>" +
    							 	"<TEMPLATEID>%s</TEMPLATEID>" +
    							 	"<TITLE>%s</TITLE>" +
    							 	"<INFOTYPE>%s</INFOTYPE>%s" +
    							 "</BODY>" +
    						"</EMAIL>";
    	
    	String comefrom = Dom4J.getDocumentValue("comefrom");
    	String provice = Dom4J.getDocumentValue("provice");
    	String reqcode = UUID.randomUUID().toString().substring(0,32);	
		String key = Dom4J.getDocumentValue("key");
		String busicode = Dom4J.getDocumentValue("busicode");
				
		String from = Dom4J.getDocumentValue("from");
		String fromName = "";
				//Dom4J.getDocumentValue("fromname");
		String to = Dom4J.getDocumentValue("to");
		String toname = Dom4J.getDocumentValue("toname");
		String brand = Dom4J.getDocumentValue("brand");
		
		String templateid = "ha0001_20120501.html";
		String title = Dom4J.getDocumentValue("title");
		String infotype = Dom4J.getDocumentValue("infotype");
		String info = Dom4J.getDocumentValue("INFO");
    	String querytime = new SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new Date());
    	
    	String commandid="CMD00001";
		String skey =api10086.MD5.md5(comefrom + commandid + from + to + busicode + templateid  + key);

    	sXmlRequest = String.format(sXmlRequest,provice,comefrom,commandid,skey,reqcode,querytime,from,fromName,to,toname,brand,busicode,templateid,title,infotype,info);
    	
    	return sXmlRequest;
    }
    private long DateToValue(String DateStringValue){
    	long d = 0;
    	try {
			d = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("2000-01-01 00:00:00").getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	return d;
    }
		
%>
<%
PostXml postxml = new PostXml();
System.out.println("2=========================="+getXmlRequest());
String reqstr= postxml.PostData(getXmlRequest());

%>