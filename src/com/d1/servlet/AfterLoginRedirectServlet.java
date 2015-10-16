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
 * Time: ����4:36
 */
public class AfterLoginRedirectServlet extends HttpServlet {
	//private static final Object obj = new Object();//ͬ����
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        System.out.println("11111�ǳƣ�===openID:");
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);

            String accessToken   = null,
                   openID        = null;
            long tokenExpireIn = 0L;




            if (accessTokenObj.getAccessToken().equals("")) {
//                ���ǵ���վ��CSRF�����˻����û�ȡ������Ȩ
//                ��һЩ����ͳ�ƹ���
                System.out.print("û�л�ȡ����Ӧ����");
            } else {
                accessToken = accessTokenObj.getAccessToken();
                tokenExpireIn = accessTokenObj.getExpireIn();

                request.getSession().setAttribute("demo_access_token", accessToken);
                request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

                // ���û�ȡ����accessToken ȥ��ȡ��ǰ�õ�openid -------- start
               OpenID openIDObj =  new OpenID(accessToken);
                openID = openIDObj.getUserOpenID();
               /* System.out.println("��ӭ�㣬����Ϊ " + openID + " ���û�!"+accessToken);
                out.println("��ӭ�㣬����Ϊ " + openID + " ���û�!");
                request.getSession().setAttribute("demo_openid", openID);
                out.println("<a href=" + "/shuoshuoDemo.html" +  " target=\"_blank\">ȥ��������˵˵��demo��</a>");
               */ // ���û�ȡ����accessToken ȥ��ȡ��ǰ�û���openid --------- end


               // out.println("<p> start -----------------------------------���û�ȡ����accessToken,openid ȥ��ȡ�û���Qzone���ǳƵ���Ϣ ---------------------------- start </p>");
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                String nickname =userInfoBean.getNickname();
 
                System.out.println("�ǳƣ�"+nickname+"===openID:"+openID);
                String bakurl="";
                
                QQLogin qq = null;
               // synchronized(obj){
                	qq = QQLoginHelper.getByUid(openID);
                	
                	if(qq == null){
                    	//������������µ����ݡ�
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
            				u.setMbrmst_name("QQ��¼�û�");
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
            		
            				session.setAttribute("showmsg","QQ�û���"+nickname);
            				Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ�û���"+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1�����
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
            		         tktmst.setTktmst_memo("�Ա��ۻ��»�Ա���");
            		         Tools.getManager(Ticket.class).create(tktmst);
            		         bakurl="http://www.d1.com.cn/user/ticket.jsp";
            		    	 }
            		     }
                    }else{//��QQ��¼��
                    	//����ǳƸ��ģ���Ա������Ӧ����
                    	if(nickname != null && !nickname.equals(qq.getQqloginmbr_name())){
                    		qq.setQqloginmbr_name(nickname);
                    		QQLoginHelper.manager.update(qq,false);
                    	}
                    	session.setAttribute("showmsg","QQ�û���"+nickname);
                    	Tools.setCookie(response,"showmsg", URLEncoder.encode("QQ�û���"+nickname,"GBK"),(int)(Tools.DAY_MILLIS/1000*1));//1�����
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
            		         tktmst.setTktmst_memo("�Ա��ۻ��»�Ա���");
            		         Tools.getManager(Ticket.class).create(tktmst);
            		         bakurl="http://www.d1.com.cn/user/ticket.jsp";
            		    	 }
            		     }
                    }
            	//}
               // out.print(qq.getQqloginmbr_mbrid());
               //System.out.println("d1gjlQQsession:"+session.getAttribute("QQReferer"));
                System.out.println("d1gjlQQsession�ƣ�"+session.getAttribute("QQReferer"));
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
                    out.println("����ȼ��� " + userInfoBean.getLevel() + "<br/>");
                    out.println("��Ա : " + userInfoBean.isVip() + "<br/>");
                    out.println("�����Ա�� " + userInfoBean.isYellowYearVip() + "<br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                } else {
                    out.println("�ܱ�Ǹ������û����ȷ��ȡ��������Ϣ��ԭ���ǣ� " + userInfoBean.getMsg());
                }
                out.println("<p> end -----------------------------------���û�ȡ����accessToken,openid ȥ��ȡ�û���Qzone���ǳƵ���Ϣ ---------------------------- end </p>");



                out.println("<p> start ----------------------------------- ��֤��ǰ�û��Ƿ�Ϊ��֤�ռ�ķ�˿------------------------------------------------ start <p>");
                PageFans pageFansObj = new PageFans(accessToken, openID);
                PageFansBean pageFansBean = pageFansObj.checkPageFans("97700000");
                if (pageFansBean.getRet() == 0) {
                    out.println("<p>��֤��" + (pageFansBean.isFans() ? "��" : "����")  + "QQ�ռ�97700000�ٷ���֤�ռ�ķ�˿</p>");
                } else {
                    out.println("�ܱ�Ǹ������û����ȷ��ȡ��������Ϣ��ԭ���ǣ� " + pageFansBean.getMsg());
                }
                out.println("<p> end ----------------------------------- ��֤��ǰ�û��Ƿ�Ϊ��֤�ռ�ķ�˿------------------------------------------------ end <p>");


                *//*
                out.println("<p> start -----------------------------------���û�ȡ����accessToken,openid ȥ��ȡ�û���΢�����ǳƵ���Ϣ ---------------------------- start </p>");
                com.qq.connect.api.weibo.UserInfo weiboUserInfo = new com.qq.connect.api.weibo.UserInfo(accessToken, openID);
                com.qq.connect.javabeans.weibo.UserInfoBean weiboUserInfoBean = weiboUserInfo.getUserInfo();
                if (weiboUserInfoBean.getRet() == 0) {
                    //��ȡ�û���΢��ͷ��----------------------start
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                    //��ȡ�û���΢��ͷ�� ---------------------end

                    //��ȡ�û���������Ϣ --------------------start
                    out.println("<p>�𾴵��û�����������ǣ� " + weiboUserInfoBean.getBirthday().getYear()
                                +  "��" + weiboUserInfoBean.getBirthday().getMonth() + "��" +
                                weiboUserInfoBean.getBirthday().getDay() + "��");
                    //��ȡ�û���������Ϣ --------------------end

                    StringBuffer sb = new StringBuffer();
                    sb.append("<p>���ڵ�:" + weiboUserInfoBean.getCountryCode() + "-" + weiboUserInfoBean.getProvinceCode() + "-" + weiboUserInfoBean.getCityCode()
                             + weiboUserInfoBean.getLocation());

                    //��ȡ�û��Ĺ�˾��Ϣ---------------------------start
                    ArrayList<Company> companies = weiboUserInfoBean.getCompanies();
                    if (companies.size() > 0) {
                        //�й�˾��Ϣ
                        for (int i=0, j=companies.size(); i<j; i++) {
                            sb.append("<p>�����۹��Ĺ�˾����˾ID-" + companies.get(i).getID() + " ����-" +
                            companies.get(i).getCompanyName() + " ��������-" + companies.get(i).getDepartmentName() + " ��ʼ������-" +
                            companies.get(i).getBeginYear() + " ����������-" + companies.get(i).getEndYear());
                        }
                    } else {
                        //û�й�˾��Ϣ
                    }
                    //��ȡ�û��Ĺ�˾��Ϣ---------------------------end

                    out.println(sb.toString());

                } else {
                    out.println("�ܱ�Ǹ������û����ȷ��ȡ��������Ϣ��ԭ���ǣ� " + weiboUserInfoBean.getMsg());
                }

                out.println("<p> end -----------------------------------���û�ȡ����accessToken,openid ȥ��ȡ�û���΢�����ǳƵ���Ϣ ---------------------------- end </p>");
                 */


            }
        } catch (QQConnectException e) {
        	e.printStackTrace();
        }
    }
}
