<%@ page contentType="text/html; charset=UTF-8" import="org.dom4j.Element,org.dom4j.DocumentException,org.dom4j.io.SAXReader,org.dom4j.Document,java.security.*,com.qq.connect.*,com.qq.util.*,com.d1.bean.id.SequenceIdGenerator" %><%@include file="../../inc/header.jsp"%><%!

private static final Object obj = new Object();//同步锁

%><%
HttpSession sessionh = request.getSession();
String oauth_token_secret = (String)sessionh.getAttribute("resToken");

if(oauth_token_secret != null){
	String oauth_token = request.getParameter("oauth_token");
    String oauth_signature = request.getParameter("oauth_signature");
    String oauth_vericode = request.getParameter("oauth_vericode");
    String timestamp = request.getParameter("timestamp");
	String openid = request.getParameter("openid");
	
	session.removeAttribute("resToken");
	System.out.println("openid="+openid+"+++timestamp="+timestamp+"++++oauth_signature="+oauth_signature);
	try {
        if (!Verify.verifyOpenID(openid, timestamp, oauth_signature)) {
            out.print("获得信息出错，请重新登录！");
            return;
        }
    } catch (InvalidKeyException e1) {
        e1.printStackTrace();
        return;
    } catch (NoSuchAlgorithmException e1) {
        e1.printStackTrace();
        return;
    }
    
    AccessToken token = new AccessToken();
    String access_token = null;
    try {
        access_token = token.getAccessToken(oauth_token, oauth_token_secret, oauth_vericode);
    } catch (InvalidKeyException e1) {
        e1.printStackTrace();
        return;
    } catch (NoSuchAlgorithmException e1) {
        e1.printStackTrace();
        return;
    }
    
    HashMap<String, String> tokens = ParseString.parseTokenString(access_token);
    if (tokens.get("error_code") != null) {
        out.println("获取信息出错！"+tokens.get("error_code"));
        return;
    }
    
 	// 获取access token成功后也会返回用户的openid
    // 我们强烈建议第三方使用此openid
    // 检查返回的openid是否是合法id
    try {
        if(!Verify.verifyOpenID(tokens.get("openid"), tokens.get("timestamp"), tokens.get("oauth_signature"))) {
        	out.print("获得用户信息出错，请重新登录！");
            return;
        }
    } catch (InvalidKeyException e1) {
        e1.printStackTrace();
        return;
    } catch (NoSuchAlgorithmException e1) {
        e1.printStackTrace();
        return;
    }
    
 	//将access token，openid保存!!
    oauth_token = tokens.get("oauth_token");
    oauth_token_secret = tokens.get("oauth_token_secret");
    openid = tokens.get("openid");

    InfoToken infotoken = new InfoToken();
    String info_xml = null;
    try {
        info_xml = infotoken.getInfo(oauth_token, oauth_token_secret, openid, "xml");
        System.out.println("info_xml="+info_xml);
    } catch (IOException e) {
        e.printStackTrace();
        return;
    } catch (InvalidKeyException e) {
        e.printStackTrace();
        return;
    } catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
        return;
    }
    if(info_xml == null){
    	out.print("获取登录信息错误！");
    	return;
    }
   // System.out.println("d1gjlxml:"+info_xml);
    HashMap<String, String> userinfo = null;
    InputStream in = null;
    try {
    	in = new ByteArrayInputStream(info_xml.getBytes("UTF-8"));
    	SAXReader reader = new SAXReader();
		Document doc = reader.read(in);
		
		Element root = doc.getRootElement();
		
		List es = root.elements();
		if(es != null && !es.isEmpty()){
			userinfo = new HashMap<String,String>();
			int size = es.size();
			for(int i=0;i<size;i++){
				Element el = (Element)es.get(i);
				userinfo.put(el.getName(),URLDecoder.decode(el.getTextTrim(),"UTF-8"));
				System.out.println(el.getName()+"=========="+URLDecoder.decode(el.getTextTrim(),"UTF-8")+"====="+el.getTextTrim());
			}
		}
    }catch(UnsupportedEncodingException e){
		e.printStackTrace();
	}catch (DocumentException e){
		e.printStackTrace();
	} finally{
		try{
			if(in != null) in.close();
		} catch(IOException e){
			System.err.println("chanet close inputstream error!");
		}
	}
	
	if(userinfo == null || userinfo.isEmpty()){
		out.print("获取登录信息错误！");
    	return;
	}
    
    String nickname = userinfo.get("nickname");
    
    String bakurl="";
    
    QQLogin qq = null;
    synchronized(obj){
    	qq = QQLoginHelper.getByUid(openid);
    	
    	if(qq == null){
        	//不存在则添加新的数据。
        	User u = UserHelper.getByUsername("");
        	if(u == null){
        		Date currDate = new Date();
        		String pwd = MD5.to32MD5(String.valueOf(System.currentTimeMillis()),"UTF-8");
				
				u = new com.d1.bean.User();
				u.setId(SequenceIdGenerator.generate("3"));
				u.setMbrmst_uid(openid+"qqlogin");
				u.setMbrmst_pwd(pwd);
				u.setMbrmst_passwd(MD5.to32MD5(pwd));
				u.setMbrmst_question("");
				u.setMbrmst_answer("");
				u.setMbrmst_createdate(currDate);
				u.setMbrmst_modidate(currDate);
				u.setMbrmst_lastdate(currDate);
				u.setMbrmst_name("QQ登录用户");
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
				u.setMbrmst_temp("QQLOGIN");
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
				u = (User)UserHelper.manager.create(u);
        	}
        	if(u != null && u.getId() != null){
				qq = new QQLogin();
				qq.setQqloginmbr_createdate(new Date());
				qq.setQqloginmbr_mbrid(new Long(u.getId()));
				qq.setQqloginmbr_name(nickname);
				qq.setQqloginmbr_regflag(new Long(0));
				qq.setQqloginmbr_uid(openid);
				
				QQLoginHelper.manager.create(qq);
		
				session.setAttribute("showmsg","QQ用户："+nickname);
				Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ用户："+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
				UserHelper.setLoginUserId(session,u.getId());
			}
        	SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		     Date actendDate=null;
		     Date tktendDate=null;
		     try{
		    	 actendDate=fmt2.parse("2013-4-30 23:59:59");
		     	 tktendDate=fmt2.parse("2013-4-30 23:59:59");
		     	 }
		     catch(Exception ex){
		     	ex.printStackTrace();
		     }
		     String cardt="";
		     if(Tools.dateValue(actendDate)>System.currentTimeMillis()&&session.getAttribute("d1lianmengsubad")!=null&&("p1304012tmkh".equals(session.getAttribute("d1lianmengsubad"))
		    		 ||session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay"))){
		    	 cardt="ptmallqq0416";

		     String cardno=cardt+qq.getQqloginmbr_mbrid();
		    	 Ticket tktmstf= (Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", cardno);
		    	 if(tktmstf==null){
			    	  Ticket tktmst=new Ticket();
				 tktmst.setTktmst_value(new Float(30));
				 tktmst.setTktmst_type("002001");
				 tktmst.setTktmst_mbrid(qq.getQqloginmbr_mbrid());
				 tktmst.setTktmst_validflag(new Long(0));
				 tktmst.setTktmst_createdate(new Date());
				 tktmst.setTktmst_validates(new Date());
				 tktmst.setTktmst_validatee(tktendDate);
				 tktmst.setTktmst_rackcode("000");
		         tktmst.setTktmst_gdsvalue(new Float(200));
		         tktmst.setTktmst_payid(new Long(-1));
		         tktmst.setTktmst_cardno(cardno);
		         tktmst.setTktmst_ifcrd(new Long(0));
		         tktmst.setTktmst_memo("淘宝聚会新会员激活！");
		         Tools.getManager(Ticket.class).create(tktmst);
		         bakurl="http://www.d1.com.cn/user/ticket.jsp";
		    	 }
		     }
        }else{//用QQ登录过
        	//如果昵称更改，会员表做相应更改
        	if(nickname != null && !nickname.equals(qq.getQqloginmbr_name())){
        		qq.setQqloginmbr_name(nickname);
        		QQLoginHelper.manager.update(qq,false);
        	}
        	session.setAttribute("showmsg","QQ用户："+nickname);
        	Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ用户："+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1天过期
			UserHelper.setLoginUserId(session,qq.getQqloginmbr_mbrid()+"");
			SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		     Date actendDate=null;
		     Date tktendDate=null;
		     try{
		    	 actendDate=fmt2.parse("2013-4-30 23:59:59");
		     	 tktendDate=fmt2.parse("2013-4-30 23:59:59");
		     	 }
		     catch(Exception ex){
		     	ex.printStackTrace();
		     }
		     String cardt="";
		     if(Tools.dateValue(actendDate)>System.currentTimeMillis()&&session.getAttribute("d1lianmengsubad")!=null&&("p1304012tmkh".equals(session.getAttribute("d1lianmengsubad"))
		    		 ||session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay"))){
		    	 cardt="ptmallqq0416";

		     String cardno=cardt+qq.getQqloginmbr_mbrid();
  		    	 Ticket tktmstf= (Ticket)Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", cardno);
		    	 if(tktmstf==null){
		    	  Ticket tktmst=new Ticket();
				 tktmst.setTktmst_value(new Float(30));
				 tktmst.setTktmst_type("002001");
				 tktmst.setTktmst_mbrid(qq.getQqloginmbr_mbrid());
				 tktmst.setTktmst_validflag(new Long(0));
				 tktmst.setTktmst_createdate(new Date());
				 tktmst.setTktmst_validates(new Date());
				 tktmst.setTktmst_validatee(tktendDate);
				 tktmst.setTktmst_rackcode("000");
		         tktmst.setTktmst_gdsvalue(new Float(200));
		         tktmst.setTktmst_payid(new Long(-1));
		         tktmst.setTktmst_cardno(cardno);
		         tktmst.setTktmst_ifcrd(new Long(0));
		         tktmst.setTktmst_memo("淘宝聚会新会员激活！");
		         Tools.getManager(Ticket.class).create(tktmst);
		         bakurl="http://www.d1.com.cn/user/ticket.jsp";
		    	 }
		     }
        }
	}
   // out.print(qq.getQqloginmbr_mbrid());
   //System.out.println("d1gjlQQsession:"+session.getAttribute("QQReferer"));
   if(Tools.isNull(bakurl)){
   if (session.getAttribute("QQReferer")!=null){
		response.sendRedirect(session.getAttribute("QQReferer").toString());
   }else{
		response.sendRedirect("http://www.d1.com.cn/");
   }
   }else{
	   response.sendRedirect(bakurl);
   }

	return;
}else{
	out.print("请不要重复刷新此页面！");
}

%>