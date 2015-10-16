package com.d1.util;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import com.d1.bean.PingAnUser;
import com.d1.bean.User;
import com.d1.helper.UserHelper;


public class IntfUtil {
	//ɱcookies
		public static void KillsCookies(HttpServletResponse response , String CookieName){
			if (!"lianmeng".equals(CookieName)){  //����
				DelCookie(response , "d1.com.cn.peoplercm");
				DelCookie(response , "d1.com.cn.peoplercm.subad");
			}
			if (!"LTINFO".equals(CookieName)){ //�����
				DelCookie(response , "LTINFO");
			}
			if (!"PLINFO".equals(CookieName)){ //pluslink
				DelCookie(response , "PLINFO");
			}
			if (!"CHANET".equals(CookieName)){ //chanet
				DelCookie(response , "CHANET");
			}
			if (!"EQIFA".equals(CookieName)){ //����
				DelCookie(response , "EQIFA");
				DelCookie(response , "EQIFAsrc");
			}
			if (!"LELE".equals(CookieName)){ //����
				DelCookie(response , "LELE");
				DelCookie(response , "LELE_S");
			}
			if (!"YEEDOU".equals(CookieName)){ //һ��
				DelCookie(response , "YEEDOU");
			}
			if (!"WEIYI".equals(CookieName)){ //Ψһ
				DelCookie(response , "WEIYI");
			}
			if (!"AIGOVIP".equals(CookieName)){ //�����(aigovip)
				DelCookie(response , "AIGOVIP");
			}
			if (!"PINGAN".equals(CookieName)){ //ƽ��
				DelCookie(response , "PINGAN");
			}
			if (!"YIQIFA".equals(CookieName)){ //����
				DelCookie(response , "YIQIFA");
				DelCookie(response , "YIQIFA_Cid");
			}
			if (!"YOYI".equals(CookieName)){ //����
				DelCookie(response , "YOYI");
			}
			if (!"IPVGOU".equals(CookieName)){ //��ͨ
				DelCookie(response , "IPVGOU");
			}
			if (!"SOHUVIP".equals(CookieName)){ //SOHUVIP
				DelCookie(response , "SOHUVIP");
			}
			if (!"51FANLI".equals(CookieName)){ //51����
				DelCookie(response , "51FANLI");
			}
			if (!"HZLY".equals(CookieName)){ //��������
				DelCookie(response , "HZLY");
			}
			if (!"LHDLTEMP".equals(CookieName)){ //���ϵ�½
				DelCookie(response , "LHDLTEMP");
			}
			if (!"YIGAO".equals(CookieName)){ //����cpc�ڸ�
				DelCookie(response , "YIGAO");
			}
			if (!"lhdltemp".equals(CookieName)){ //�������ϵ�½
				DelCookie(response , "lhdltemp");
			}
			if (!"wangyi".equals(CookieName)){ //����
				DelCookie(response , "wangyi");
			}
			if (!"yijifen".equals(CookieName)){ //�׻���
				DelCookie(response , "yijifen");
			}
			if (!"CPS360".equals(CookieName)){ //360
				DelCookie(response , "CPS360");
			}
			if (!"C2345".equals(CookieName)){ //2345����
				DelCookie(response , "C2345");
			}
		}
		public static void KillsCookiesWap(HttpServletResponse response , String CookieName){
			if (!"lianmeng".equals(CookieName)){  //����
				DelCookie(response , "d1.com.cn.peoplercm");
				DelCookie(response , "d1.com.cn.peoplercm.subad");
			}
			if (!"WAPLTINFO".equals(CookieName)){ //�����
				DelCookie(response , "WAPLTINFO");
			}
			
		}
		public static void setCookieWap(HttpServletResponse response , String name , String value , int expireTime){
			Cookie userIdCookie = new Cookie(name, value);
			userIdCookie.setPath("/");
			userIdCookie.setDomain("d1.cn");
			userIdCookie.setMaxAge(expireTime);
			response.addCookie(userIdCookie);
		}
		/**
		 * 
		 * @param response
		 * @param strCookieName
		 */
		//ɾ��cookie
		public static void DelCookie(HttpServletResponse response , String strCookieName){
			Cookie userIdCookie = new Cookie(strCookieName, null);
			userIdCookie.setPath("/");
			userIdCookie.setMaxAge(0);//ֱ�ӹ���
			response.addCookie(userIdCookie);
		}
		
		 /**
		  * postData��A=a&B=b&C=c�����Ĳ���
		  * @param url
		  * @param postData
		  * @return
		  */
	     public static String GetPostData(String url,String postData)
	     {
	      return HttpUtil.postData(url, postData,"GBK");
	     }
	     /**
	      * ���˴�����Ա��
	      * @param id
	      * @param mbruid
	      * @param mbrpwd
	      * @param mbrname
	      * @param mbrtemp
	      * @return
	      */
	     public static boolean CreateUser(String id,String mbruid,String mbrpwd,String mbrname,String mbrtemp)
	     {
	    	 User user=new User();
	    	 user.setId(id);
	    	 user.setMbrmst_uid(mbruid);
	    	 user.setMbrmst_pwd(mbrpwd);
	    	 user.setMbrmst_question("");
	    	 user.setMbrmst_answer("");
	    	 user.setMbrmst_name(mbrname);
	    	 user.setMbrmst_sex(new Long(0));
	    	 user.setMbrmst_email("");
	    	 user.setMbrmst_usephone("");
	    	 user.setMbrmst_haddr("");
	    	 user.setMbrmst_countryid(new Long(1));
	    	 user.setMbrmst_provinceid(new Long(0));
	    	 user.setMbrmst_cityid(new Long(0));
	    	 user.setMbrmst_postcode("");
	    	 user.setMbrmst_temp(mbrtemp);
	    	 user.setMbrmst_createdate(new Date());
	    	 user.setMbrmst_modidate(new Date());
	    	 user.setMbrmst_lastdate(new Date());
	    	 user.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis()+"#"+Math.random()));
	    	 user = (User)UserHelper.manager.create(user);
	    	 if(user != null && user.getId()!=null){
	    			return true;
	    		}else{
	    			return false;
	    		}

	     }
	     public static boolean CreatePinganUser(String uid,String memberid,String flag,String username,long mbrid)
	     {

	    	 PingAnUser pauser=new PingAnUser();
	    	 pauser.setMbrmstpingan_mbrmstuid(uid);
	    	 pauser.setMbrmstpingan_memberid(memberid);
	    	 pauser.setMbrmstpingan_empflg(flag);
	    	 pauser.setMbrmstpingan_username(username);
	    	 pauser.setMbrmstpingan_mbrid(new Long(mbrid));
	    	 pauser.setMbrmstPingAn_createdate(new Date());
	    	 pauser = (PingAnUser)Tools.getManager(PingAnUser.class).create(pauser);
	    	 if(pauser != null && pauser.getId()!=null){
	    			return true;
	    		}else{
	    			return false;
	    		}
	     }
	    
	     

}
