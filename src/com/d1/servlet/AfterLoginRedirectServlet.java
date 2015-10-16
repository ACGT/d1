package com.d1.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.d1.bean.QQLogin;
import com.d1.bean.Ticket;
import com.d1.bean.User;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.QQLoginHelper;
import com.d1.helper.UserHelper;
import com.d1.util.MD5;
import com.d1.util.Tools;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.PageFans;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.PageFansBean;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.javabeans.weibo.Company;
import com.qq.connect.oauth.Oauth;

/**
 * Date: 12-12-4
 * Time: 下午4:36
 */
public class AfterLoginRedirectServlet extends HttpServlet {
	//private static final Object obj = new Object();//同步锁
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        System.out.println("11111昵称：===openID:");
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);

            String accessToken   = null,
                   openID        = null;
            long tokenExpireIn = 0L;




            if (accessTokenObj.getAccessToken().equals("")) {
//                我们的网站被CSRF攻击了或者用户取消了授权
//                做一些数据统计工作
                System.out.print("没有获取到响应参数");
            } else {
                accessToken = accessTokenObj.getAccessToken();
                tokenExpireIn = accessTokenObj.getExpireIn();

                request.getSession().setAttribute("demo_access_token", accessToken);
                request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

                // 利用获取到的accessToken 去获取当前用的openid -------- start
               OpenID openIDObj =  new OpenID(accessToken);
                openID = openIDObj.getUserOpenID();
               /* System.out.println("欢迎你，代号为 " + openID + " 的用户!"+accessToken);
                out.println("欢迎你，代号为 " + openID + " 的用户!");
                request.getSession().setAttribute("demo_openid", openID);
                out.println("<a href=" + "/shuoshuoDemo.html" +  " target=\"_blank\">去看看发表说说的demo吧</a>");
               */ // 利用获取到的accessToken 去获取当前用户的openid --------- end


               // out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- start </p>");
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                String nickname =userInfoBean.getNickname();
 
                System.out.println("昵称："+nickname+"===openID:"+openID);
                String bakurl="";
                
                QQLogin qq = null;
               // synchronized(obj){
                	qq = QQLoginHelper.getByUid(openID);
                	
                	if(qq == null){
                    	//不存在则添加新的数据。
                    	User u = UserHelper.getByUsername("");
                    	if(u == null){
                    		Date currDate = new Date();
                    		String pwd = MD5.to32MD5(String.valueOf(System.currentTimeMillis()),"UTF-8");
            				
            				u = new com.d1.bean.User();
            				u.setId(SequenceIdGenerator.generate("3"));
            				u.setMbrmst_uid(openID+"qqlogin");
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
            				qq.setQqloginmbr_uid(openID);
            				
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
            	//}
               // out.print(qq.getQqloginmbr_mbrid());
               //System.out.println("d1gjlQQsession:"+session.getAttribute("QQReferer"));
                System.out.println("d1gjlQQsession称："+session.getAttribute("QQReferer"));
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
                
              // out.println("<br/>");
              /*  if (userInfoBean.getRet() == 0) {
                    out.println(userInfoBean.getNickname() + "<br/>");
                    out.println(userInfoBean.getGender() + "<br/>");
                    out.println("黄钻等级： " + userInfoBean.getLevel() + "<br/>");
                    out.println("会员 : " + userInfoBean.isVip() + "<br/>");
                    out.println("黄钻会员： " + userInfoBean.isYellowYearVip() + "<br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + userInfoBean.getMsg());
                }
                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- end </p>");



                out.println("<p> start ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ start <p>");
                PageFans pageFansObj = new PageFans(accessToken, openID);
                PageFansBean pageFansBean = pageFansObj.checkPageFans("97700000");
                if (pageFansBean.getRet() == 0) {
                    out.println("<p>验证您" + (pageFansBean.isFans() ? "是" : "不是")  + "QQ空间97700000官方认证空间的粉丝</p>");
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + pageFansBean.getMsg());
                }
                out.println("<p> end ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ end <p>");


                *//*
                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- start </p>");
                com.qq.connect.api.weibo.UserInfo weiboUserInfo = new com.qq.connect.api.weibo.UserInfo(accessToken, openID);
                com.qq.connect.javabeans.weibo.UserInfoBean weiboUserInfoBean = weiboUserInfo.getUserInfo();
                if (weiboUserInfoBean.getRet() == 0) {
                    //获取用户的微博头像----------------------start
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                    //获取用户的微博头像 ---------------------end

                    //获取用户的生日信息 --------------------start
                    out.println("<p>尊敬的用户，你的生日是： " + weiboUserInfoBean.getBirthday().getYear()
                                +  "年" + weiboUserInfoBean.getBirthday().getMonth() + "月" +
                                weiboUserInfoBean.getBirthday().getDay() + "日");
                    //获取用户的生日信息 --------------------end

                    StringBuffer sb = new StringBuffer();
                    sb.append("<p>所在地:" + weiboUserInfoBean.getCountryCode() + "-" + weiboUserInfoBean.getProvinceCode() + "-" + weiboUserInfoBean.getCityCode()
                             + weiboUserInfoBean.getLocation());

                    //获取用户的公司信息---------------------------start
                    ArrayList<Company> companies = weiboUserInfoBean.getCompanies();
                    if (companies.size() > 0) {
                        //有公司信息
                        for (int i=0, j=companies.size(); i<j; i++) {
                            sb.append("<p>曾服役过的公司：公司ID-" + companies.get(i).getID() + " 名称-" +
                            companies.get(i).getCompanyName() + " 部门名称-" + companies.get(i).getDepartmentName() + " 开始工作年-" +
                            companies.get(i).getBeginYear() + " 结束工作年-" + companies.get(i).getEndYear());
                        }
                    } else {
                        //没有公司信息
                    }
                    //获取用户的公司信息---------------------------end

                    out.println(sb.toString());

                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + weiboUserInfoBean.getMsg());
                }

                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- end </p>");
                 */


            }
        } catch (QQConnectException e) {
        	e.printStackTrace();
        }
    }
}
