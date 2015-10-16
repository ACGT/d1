<%@ page contentType="text/html; charset=UTF-8" import="java.net.HttpURLConnection,java.net.URL,oauth.signpost.*,oauth.signpost.basic.*,com.d1.bean.id.SequenceIdGenerator" %><%@include file="../../inc/header.jsp"%><%!

private static final Object obj = new Object();//同步锁

%><%
String verificationCode=request.getParameter("oauth_verifier");
if(!Tools.isNull(verificationCode)){
	OAuthConsumer consumer = (OAuthConsumer)session.getAttribute("resToken");
	
	if(consumer != null){
		OAuthProvider provider = new DefaultOAuthProvider("http://api.t.sohu.com/oauth/request_token",
		        "http://api.t.sohu.com/oauth/access_token",
		        "http://api.t.sohu.com/oauth/authorize?hd=default");
		
		session.removeAttribute("resToken");
		
		provider.retrieveAccessToken(consumer,verificationCode.trim());
		
		String token = consumer.getToken();
		String tokenSecret = consumer.getTokenSecret();
		
		consumer.setTokenWithSecret(token, tokenSecret);
		
		URL url = new URL("http://api.t.sohu.com/users/show.json");
		
	    HttpURLConnection http = null;
	    InputStream stream = null;
	    InputStreamReader isr = null;
	    BufferedReader br = null;
	    
	    JSONObject json = null;
		try{
			http = (HttpURLConnection) url.openConnection();
		    consumer.sign(http);
		    http.connect();
		    
		    int statusCode = http.getResponseCode();
		    if(statusCode == 200){
		    	stream = http.getInputStream();
		    	isr = new InputStreamReader(stream, "UTF-8");
		    	br = new BufferedReader(isr);
		    	
		    	StringBuffer buf = new StringBuffer();
		    	String line;
                while (null != (line = br.readLine())) {
                    buf.append(line).append("\n");
                }
                json = JSONObject.fromObject(buf.toString());
		    }
		}catch(Exception e){
			System.err.println("sohu back " + e.getMessage());
		}finally{
			if(br != null) br.close();
			if(isr != null) isr.close();
			if(stream != null) stream.close();
			if(http != null) http.disconnect();
		}
		
		if(json != null){
			WeiboUser wb = null;
			
			String sohumbr_name = json.getString("id");
			String d1loginkey = "opi1p34u19klas09udf53gp3j24jklfe";
			String sohumbr_uid = WeiboUserHelper.createRandomCode(30);
			String sohutime = Tools.getDBDate();
			String segcode = MD5.to32MD5(sohumbr_name + sohutime + d1loginkey);
			
			synchronized(obj){
				wb = WeiboUserHelper.getByName(sohumbr_name,"sohuwb");
				if(wb == null){
					String sohu_pwd = "9EF5D4D62B8169AFCAB7D4B4DADF7C9628AC ";
					User u = UserHelper.getByUsername(sohumbr_uid);
					
					if(u == null){
						Date currDate = new Date();
						
						u = new com.d1.bean.User();
						u.setId(SequenceIdGenerator.generate("3"));
						u.setMbrmst_uid(sohumbr_uid);
						u.setMbrmst_pwd(sohu_pwd);
						u.setMbrmst_passwd(MD5.to32MD5(sohu_pwd));
						u.setMbrmst_question("");
						u.setMbrmst_answer("");
						u.setMbrmst_createdate(currDate);
						u.setMbrmst_modidate(currDate);
						u.setMbrmst_lastdate(currDate);
						u.setMbrmst_name(sohumbr_name);
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
						u.setMbrmst_temp("sohuwb");
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
						wb = new WeiboUser();
						wb.setWeibombr_mbrid(new Long(u.getId()));
						wb.setWeibombr_uid(sohumbr_uid);
						wb.setWeibombr_name(sohumbr_name);
						wb.setWeibombr_flag("sohuwb");
						wb.setWeibombr_regflag(new Long(0));
						wb.setWeibombr_createdate(new Date());
						
						WeiboUserHelper.manager.create(wb);
					}
				}
			}
			session.removeAttribute("showmsg");
			UserHelper.setLoginUserId(session,String.valueOf(wb.getWeibombr_mbrid()));
			String retstr = "wbname=" + sohumbr_name + "&wbtime=" + sohutime + "&segcode=" + segcode + "&wbflag=sohuwb";
			//response.sendRedirect("/buy/chkout_wb.asp?"+retstr);
			response.sendRedirect("/");
		}else{
			out.print("获取登录信息错误！");
		}
	}else{
		out.print("请不要重复刷新此页面！");
	}
}
%>