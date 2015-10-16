<%@page import="java.net.URL"%>
<%@ page contentType="text/html; charset=UTF-8"%><%@include file="../inc/header.jsp"%>
<%@page import="
com.d1.bean.id.SequenceIdGenerator,
java.io.UnsupportedEncodingException,
java.net.URLDecoder,
java.text.SimpleDateFormat,
java.util.Date
"%>
<%
//md5加密密钥,向成果网索取
String strKey = "1vCf7XYnkf0R4s0AwcQ6";
String queryString = request.getQueryString();
String[] qs = queryString.split("\\&");
HashMap<String,String> dmap = new HashMap<String,String>();
for(int x=0;x<qs.length;x++){
	String xxs123 = qs[x];
	dmap.put(xxs123.substring(0,xxs123.indexOf("=")), xxs123.substring(xxs123.indexOf("=")+1));
}
String strAID ="";
String strAName ="";
String strAUser ="";
String strUName ="";
String strUrl ="";
String strFUrl ="";
String strTimestamp ="";
String strSig ="";
try{
	//成果网媒体ID，B2C商家可通过此区分是来自哪个媒体的用户，媒体ID对应表请向成果网索取
	strAID =URLDecoder.decode(dmap.get("aid"),"GBK");

	//成果网媒体名称，如人人网、新浪网,可用作欢迎语中媒体名称的显示
	 strAName = URLDecoder.decode(dmap.get("aname"),"GBK");

	//媒体用户标识符
	 strAUser = URLDecoder.decode(dmap.get("auser"),"GBK");

	//媒体用户昵称，可用作欢迎语中媒体名称的显示
	 strUName = URLDecoder.decode(dmap.get("uname"),"GBK");

	//登录成功跳转URL
	 strUrl = URLDecoder.decode(dmap.get("url"),"GBK");

	//登录失败跳转URL 
	 strFUrl = URLDecoder.decode(dmap.get("furl"),"GBK");

	//时间戳
	 strTimestamp = URLDecoder.decode(dmap.get("timestamp"),"GBK");
	//签名信息
	 strSig = dmap.get("sig");
}
catch(Exception ex){
	ex.printStackTrace();}


StringBuilder stbSign = new StringBuilder();
stbSign.append("aid="+strAID+"");
stbSign.append("&auser="+strAUser+"");
stbSign.append("&timestamp="+strTimestamp+"");
stbSign.append("&key="+strKey+"");
String sign=MD5.to32MD5(stbSign.toString(), "UTF-8");

java.util.Date   nows=new   java.util.Date();   
long   lss=(System.currentTimeMillis()/1000-Tools.parseInt(strTimestamp)); 
System.out.println("d1gjlchanet"+strSig+"--"+sign+"===="+strSig);
if(strSig.equals(sign) && lss<100000){
	 ChanetUser userchanet=(ChanetUser)Tools.getManager(ChanetUser.class).findByProperty("cgmbr_auser", strAUser);
	 if(userchanet!=null){
		 if(strAID.equals(userchanet.getCgmbr_aid())){
			 UserHelper.setLoginUserId(session,userchanet.getCgmbr_mbrid().toString());
			 Tools.setCookie(response,"lhdltemp","fanxian_"+strAName,(int)(Tools.DAY_MILLIS*3/1000));
			 IntfUtil.KillsCookies(response,"lhdltemp");
			 if(strUrl.indexOf("www.d1.com.cn")>=0 || strUrl.indexOf("chanet.com.cn")>=0){
				 response.sendRedirect(strUrl);
			 }
			 else{
				 response.sendRedirect(strFUrl);
			 }
		 }
	 }
	 else{
		 String strMbrID= SequenceIdGenerator.generate("3");
		 boolean buser=IntfUtil.CreateUser(strMbrID, strUName + "@@成果网" + strAID + strAUser,MD5.to32MD5("90s5h5kd9d6n6ve690w"), strUName, "fanxian_"+strAName);
	    if (buser){
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    	 Date dTimestamp;
	    	 if(!Tools.isNull(strTimestamp)){
	    	  dTimestamp = sdf.parse(strTimestamp);//转换成功的Date对象
	    	 }
	    	 else{
	    		 dTimestamp=new Date();
	    	 }

	    	ChanetUser chanetuser=new ChanetUser();
	    	chanetuser.setCgmbr_aid(strAID);
	    	chanetuser.setCgmbr_aname(strAName);
	    	chanetuser.setCgmbr_auser(strAUser);
	    	chanetuser.setCgmbr_uname(strUName);
	    	chanetuser.setCgmbr_url(strUrl);
	    	chanetuser.setCgmbr_furl(strFUrl);
	    	chanetuser.setCgmbr_mbrid(new Long(strMbrID));
	    	chanetuser.setCgmbr_timestamp(dTimestamp);
	    	chanetuser.setCbmbr_createtime(new Date());
    		Tools.getManager(ChanetUser.class).create(chanetuser);
    		UserHelper.setLoginUserId(session,strMbrID);
			 Tools.setCookie(response,"lhdltemp","fanxian_"+strAName,(int)(Tools.DAY_MILLIS*3/1000));
			 IntfUtil.KillsCookies(response,"lhdltemp");
			 if(strUrl.indexOf("www.d1.com.cn")>=0 || strUrl.indexOf("chanet.com.cn")>=0){
				 response.sendRedirect(strUrl);
			 }
			 else{
				 response.sendRedirect(strFUrl);
			 }
	    }
	 }
 }
else{
	response.sendRedirect("http://www.d1.com.cn");
	}
%>