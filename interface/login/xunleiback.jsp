<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.net.*,java.security.*,com.d1.xunlei.*,com.d1.bean.id.SequenceIdGenerator"%><%@include file="../../inc/header.jsp"%><%!
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
}
private static final Object obj = new Object();//同步锁
 static XunleiUser getByUserNo(String xunlei_userno){
	if(Tools.isNull(xunlei_userno) ) return null;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("xunlei_userno", xunlei_userno));
	listRes.add(Restrictions.eq("xunlei_accesstoken", xunlei_userno));
	List list = Tools.getManager(XunleiUser.class).getList(listRes, null, 0, 1);
	if(list == null || list.isEmpty()) return null;
	return (XunleiUser)list.get(0);
}
 static boolean isExist(String userno){
	return getByUserNo(userno) != null?true:false;
}
%><%
String oauth_token=request.getParameter("oauth_token");
String oauth_verifier=request.getParameter("oauth_verifier");

if(!Tools.isNull(oauth_token) && !Tools.isNull(oauth_verifier)){
	String request_token_secret=session.getAttribute("oauth_token_secret").toString();
	String httpMethod="GET";
	String oauth_consumer_key=PubConfig.get("xunlei_consumerKey");
	String oauth_nonce=set_nonce();
	String  oauth_signature_method="HMAC-SHA1";
	String oauth_timestamp=set_timestamp();
	String oauth_version="1.0";
	String oauth_signature=PubConfig.get("xunlei_consumerSecret")+"&"+request_token_secret;
	//(String method, String url, String oauth_token,String oauth_verifier, PostParameter[] params, String nonce, String timestamp, OAuthToken otoken) {
	OAuth o=new OAuth(oauth_consumer_key,oauth_signature);
	String Basestring=o.generateaccesstokenHeader(httpMethod,PubConfig.get("xunlei_access_token"),oauth_token,oauth_verifier,new PostParameter[0],oauth_nonce,oauth_timestamp,new RequestToken(PubConfig.get("xunlei_consumerSecret"),request_token_secret));
	
	String url=PubConfig.get("xunlei_access_token")+"?"+Basestring.replace("\"","").replace(",", "&");

	String relData=do_get(url);
	String oauth_token3=null;
	String oauth_token_secret=null;
	String[] strlist1=relData.split("&");
		for(int i=0;i<strlist1.length;i++){
			String[] strlist2=strlist1[i].split("=");
			if(strlist2.length==2){
				if(strlist2[0].equals("oauth_token")){
					oauth_token3=strlist2[1];
				}
				if(strlist2[0].equals("oauth_token_secret")){
					oauth_token_secret=strlist2[1];
				}
			}
		}
	
		if(!Tools.isNull(oauth_token3) && !Tools.isNull(oauth_token_secret)){
			
			    oauth_nonce= set_nonce();
			    oauth_signature_method = "HMAC-SHA1";
			    oauth_token= oauth_token3;
			    oauth_timestamp = set_timestamp();
			    oauth_version = "1.0";
			    oauth_signature=PubConfig.get("xunlei_consumerSecret")+"&"+oauth_token_secret;
		//out.print(oauth_token3);
		
			    OAuth o2=new OAuth(oauth_consumer_key,oauth_signature);
				String Basestring2=o2.generateUserHeader(httpMethod,PubConfig.get("xunlei_userinfo"),oauth_token,new PostParameter[0],oauth_nonce,oauth_timestamp,new RequestToken(PubConfig.get("xunlei_consumerSecret"),oauth_token_secret));
		//out.print(Basestring2.replace("\"","").replace(",", "&"));
		String url2=PubConfig.get("xunlei_userinfo")+"?"+Basestring2.replace("\"","").replace(",", "&");

		String relData2=do_get(url2);
		JSONObject json =  JSONObject.fromObject(relData2);

		String userno = json.getString("userno");
		String nickname=json.getString("nickname");
		String uservip=json.getString("uservip");
		String d1loginkey = "opi1p34u19klas09udf53gp3j24jklfe";
		String xunleimbr_uid = userno+"xunlei";
		String xunleitime = Tools.getDBDate();
		String segcode = MD5.to32MD5(userno + xunleitime + d1loginkey);
		
		session.removeAttribute("oauth_token_secret");
		XunleiUser xl=null;
		synchronized(obj){
			xl = getByUserNo(userno);
			if(xl == null){
				User u = UserHelper.getByUsername(xunleimbr_uid);
				
				if(u == null){
					Date currDate = new Date();
					
					u = new com.d1.bean.User();
					u.setId(SequenceIdGenerator.generate("3"));
					u.setMbrmst_uid(xunleimbr_uid);
					u.setMbrmst_pwd(segcode);
					u.setMbrmst_passwd(segcode);
					u.setMbrmst_question("");
					u.setMbrmst_answer("");
					u.setMbrmst_createdate(currDate);
					u.setMbrmst_modidate(currDate);
					u.setMbrmst_lastdate(currDate);
					u.setMbrmst_name(nickname);
					u.setMbrmst_visittimes(new Long(0));
					u.setMbrmst_sex(new Long(0));
					u.setMbrmst_email("");
					u.setMbrmst_hphone("");
					u.setMbrmst_usephone("");
					u.setMbrmst_haddr("");
					u.setMbrmst_countryid(new Long(1));
					u.setMbrmst_provinceid(new Long(1));
					u.setMbrmst_cityid(new Long(1));
					u.setMbrmst_postcode("");
					u.setMbrmst_certifiertype(new Long(0));
					u.setMbrmst_certifierno("");
					u.setMbrmst_myd1type(new Long(0));
					u.setMbrmst_myd1count(new Long(10));
					u.setMbrmst_myd1codes("");
					u.setMbrmst_specialtype(new Long(0));
					u.setMbrmst_srcurl("");
					u.setMbrmst_peoplercm("");
					u.setMbrmst_subad("");
					u.setMbrmst_temp("xunlei");
					u.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
					u.setMbrmst_bookletflag(new Long(0));
					u.setMbrmst_buyerrcount(new Long(0));
					u.setMbrmst_buyquestionid("");
					u.setMbrmst_downflag(new Long(0));
					u.setMbrmst_magazineflag(new Long(0));
					u.setMbrmst_validflag(new Long(0));
					u.setMbrmst_rcmcount(new Long(0));
					u.setMbrmst_ip("");
					u.setMbrmst_bktstep(new Long(0));
					u.setMbrmst_aliasname("");
					u.setMbrmst_src(new Long(0));
					u.setMbrmst_sendcount(new Long(0));
					u.setMbrmst_replycount(new Long(0));
					u.setMbrmst_kicktype(new Long(0));
					u.setMbrmst_bbsAlllogintimes(new Long(0));
					u.setMbrmst_bbsDaylogintimes(new Long(0));
					u.setMbrmst_allsrc(new Long(0));
					u.setMbrmst_jcsrc(new Long(0));
					u.setMbrmst_goldsrc(new Long(0));
					u.setMbrmst_goldallsrc(new Long(0));
					u.setMbrmst_birthflag(new Long(0));
					u.setMbrmst_tktmail(new Long(0));
					u.setMbrmst_ip(request.getRemoteAddr());
					u = (com.d1.bean.User)UserHelper.manager.create(u);
				}
				if(u != null && u.getId() != null){
					xl = new XunleiUser();
					xl.setXunlei_mbrid(new Long(u.getId()));
					xl.setXunlei_userno(userno);
					xl.setXunlei_nickname(nickname);
					xl.setXunlei_createtime(new Date());
					xl.setXunlei_uservip(new Long(uservip));
					xl.setXunlei_accesstoken(oauth_token);
					Tools.getManager(XunleiUser.class).create(xl);
				}
			}
		}
		session.removeAttribute("showmsg");
		Tools.setCookie(response,"showmsg", URLEncoder.encode(nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
		UserHelper.setLoginUserId(session,String.valueOf(xl.getXunlei_mbrid()));
		
		response.sendRedirect("/");
		}
		
	//out.print(relData);
	//response.sendRedirect("test2.jsp?"+relData);
	}
		
		
		
%>