<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.net.*,java.security.*,com.d1.xunlei.*"%><%@include file="../../inc/header.jsp"%><%!
String httpMethod="GET";
String oauth_consumer_key=PubConfig.get("xunlei_consumerKey");
String oauth_signature=PubConfig.get("xunlei_consumerSecret");
String base_uri=PubConfig.get("xunlei_request_token");
String oauth_callback=PubConfig.get("xunlei_oauth_callback");
String oauth_nonce=set_nonce();
String  oauth_signature_method="HMAC-SHA1";
String oauth_timestamp=set_timestamp();
String oauth_version="1.0";
public String set_nonce() {
	String base = "abcdefghijklmnopqrstuvwxyz0123456789";
	Random random = new Random();
	StringBuffer sb = new StringBuffer();
	for (int i = 0; i < 18; i++) {
		int number = random.nextInt(base.length());
		sb.append(base.charAt(number));
	}
	return sb.toString();
	}
public String set_timestamp() {

Date date = new Date();
long time = date.getTime();
return (time + "").substring(0, 10);
}
public String  do_get(String strUrl) throws IOException{
	StringBuilder sb = new StringBuilder();
	URL url = new URL(strUrl);
	URLConnection cn = url.openConnection();

	BufferedReader br = new BufferedReader(new InputStreamReader(
			cn.getInputStream()));
	
	String line = null;
	while ((line = br.readLine()) != null) {
		sb.append(line);
	}
	
	return sb.toString();
}%>
<%

OAuth o=new OAuth(oauth_consumer_key,oauth_signature);
String Basestring=o.generateAuthorizationHeader(httpMethod,base_uri,new PostParameter[0],oauth_nonce,oauth_timestamp,null);

String url=base_uri+"?"+Basestring.replace("\"","").replace(",", "&");

//String relData=do_get(url);
String relData=HttpUtil.getUrlContentByGet(url, "utf-8");


String oauth_token=null;
String oauth_token_secret=null;
String oauth_callback_confirmed=null;

if(Tools.isNull(relData)){
	//relData=do_get(url);
	//out.print(relData);
	//out.print("请刷新重试！");
}
	if(!Tools.isNull(relData)){
		String[] strlist1=relData.split("&");
		for(int i=0;i<strlist1.length;i++){
			String[] strlist2=strlist1[i].split("=");
			if(strlist2.length==2){
				if(strlist2[0].equals("oauth_token")){
					oauth_token=strlist2[1];
				}
				if(strlist2[0].equals("oauth_token_secret")){
					oauth_token_secret=strlist2[1];
				}
				if(strlist2[0].equals("oauth_callback_confirmed")){
					oauth_callback_confirmed=strlist2[1];
				}
			}
		}
	}
	if(!Tools.isNull(oauth_token) && !Tools.isNull(oauth_token_secret) && !Tools.isNull(oauth_callback_confirmed)){
		if("true".equals(oauth_callback_confirmed.trim())){//请求中的oauth_callback参数被确认
			session.setAttribute("oauth_token_secret", oauth_token_secret);
			session.setAttribute("oauth_token1", oauth_token);
			String url2=PubConfig.get("xunlei_authorize")+"?oauth_token="+oauth_token;
			try{
			response.sendRedirect(url2);
			}catch(Exception e){
				
			}finally{
				out.print(relData);
				response.sendRedirect(url2);
			}
			return;
			//HttpUtil.postData(PubConfig.get("xunlei_authorize")+"?", "oauth_token="+oauth_token, "utf-8");
			//out.print("请刷新重试！");
		}
	}else{
		if(session.getAttribute("oauth_token1")!=null){
			String url2=PubConfig.get("xunlei_authorize")+"?oauth_token="+session.getAttribute("oauth_token1");
			response.sendRedirect(url2);
			return;
		}
	}



%>