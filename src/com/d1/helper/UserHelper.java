package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.Const;
import com.d1.bean.Mail139User;
import com.d1.bean.PingAnUser;
import com.d1.bean.User;
import com.d1.bean.User163;
import com.d1.bean.UserVip;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.helper.proc.ProcedureParam;
import com.d1.helper.proc.UserProcedureWork;
import com.d1.util.DistributedSession;
import com.d1.util.Tools;

/**
 * 用户相关方法，比如判断用户是否登录状态，判断用户是否为白金VIP等等。
 * @author kk
 *
 */
public class UserHelper {
	
	public static final BaseManager manager = Tools.getManager(User.class);
	
	/**
	 * 通过ID找到用户对象
	 * @param id
	 * @return User
	 */
	public static User getById(String id) {
		if(Tools.isNull(id)) return null;
		return (User)manager.get(id);
	}
	
	/**
	 * 通过username找到用户对象，对应表mbrmst_uid字段。
	 * @param username - 用户名
	 * @return User
	 */
	public static User getByUsername(String username){
		if(Tools.isNull(username)) return null;
		return (User)manager.findByProperty("mbrmst_uid", username);
	}
	
	//手机验证的可直接登录
	public static User getByUserPhone(String tel){
		if(Tools.isNull(tel)) return null;
		//ArrayList<User> list=new ArrayList<User>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("mbrmst_usephone", tel));
		//listRes.add(Restrictions.eq("mbrmst_phoneflag", new Long(1)));
		List<BaseEntity> list2 = Tools.getManager(User.class).getList(listRes, null, 0, 1000);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			User user=(User)be;
			if (user.getMbrmst_phoneflag()!=null&&user.getMbrmst_phoneflag().longValue()==1){
				return user;
			}
			//list.add(user);
		
		}
		return null;
	
	}
	//判断邮箱是否验证
		public static boolean  getByUserMail(String email){
			if(Tools.isNull(email)) return false;
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("mbrmst_email", email));
			//listRes.add(Restrictions.eq("mbrmst_mailflag", new Long(1)));
			List<BaseEntity> list2 = Tools.getManager(User.class).getList(listRes, null, 0, 1000);
			if(list2==null || list2.size()==0){
				return false;
			}
			for(BaseEntity be:list2){
				User user=(User)be;
				if (user.getMbrmst_phoneflag()!=null&&user.getMbrmst_phoneflag().longValue()==1){
					return true;
				}
				//list.add(user);
			
			}
			return false;
		
		}
		//判断邮箱是否验证
		public static User  getByUserMail2(String email){
			if(Tools.isNull(email)) return null;
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("mbrmst_email", email));
			//listRes.add(Restrictions.eq("mbrmst_mailflag", new Long(1)));
			List<BaseEntity> list2 = Tools.getManager(User.class).getList(listRes, null, 0, 1000);
			if(list2==null || list2.size()==0){
				return null;
			}
			for(BaseEntity be:list2){
				User user=(User)be;
				if (user.getMbrmst_mailflag()!=null&&user.getMbrmst_mailflag().longValue()==1){
					return user;
				}
				//list.add(user);
				
			}
			return null;
			
		}
	/**
	 * 获取登录用户的userId！只要是登录状态就能获取到！！
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getLoginUserId(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		String sid = (String)session.getAttribute(Const.LOGIN_USER_ID_PREFIX);
		
		if(!Tools.isNull(sid)){
			return sid ;
		}
		//从memcached中获取登陆userId
		String loginUserId = (String)DistributedSession.getAttribute(request.getSession(), Const.LOGIN_USER_ID_PREFIX);

		//从cookie中获取登录用户id
		if(Tools.isNull(loginUserId)){
			Cookie userLoginCookie = Tools.getClientCookie(request,Const.LOGIN_USER_COOKIE_ID);
			if(userLoginCookie!=null){
				User loginUser = (User)Tools.getManager(User.class).findByProperty("mbrmst_cookie", userLoginCookie.getValue());
				if(loginUser!=null){
					loginUserId = loginUser.getId();
				}
			}
		}
		
		return loginUserId ;
	}
	
	/**
	 * 设置用户为登录状态
	 * @param session - HttpSession
	 * @param userId - 用户ID
	 */
	public static void setLoginUserId(HttpSession session , String userId){
		if(Tools.isNull(userId)) return;
		session.setAttribute(Const.LOGIN_USER_ID_PREFIX, userId);
		
		//写入memcached
		DistributedSession.setAttribute(session, Const.LOGIN_USER_ID_PREFIX, userId);
	}
	
	/**
	 * 设置用户退出登录
	 * @param request
	 * @param response
	 */
	public static void loginout(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		if(session != null){
			session.removeAttribute(Const.LOGIN_USER_ID_PREFIX);
		}
		//从memcached中获取登陆userId
		DistributedSession.removeAttribute(session, Const.LOGIN_USER_ID_PREFIX);
		Tools.removeCookie(response, Const.LOGIN_USER_COOKIE_ID);
	}
	
	/**
	 * 得到登录用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static User getLoginUser(HttpServletRequest request,HttpServletResponse response){
		String loginUserId = getLoginUserId(request,response);
		if(Tools.isNull(loginUserId))return null;
		return (User)Tools.getManager(User.class).get(loginUserId);
	}
	/**
	 * 得到平安登录用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static PingAnUser getPinganLoginUser(String mbrmstPingAn_mbrid){
		if(Tools.isNull(mbrmstPingAn_mbrid))return null;
		return (PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid",new Long(mbrmstPingAn_mbrid));
	}
	/**
	 * 是否是登录状态
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isLogin(HttpServletRequest request,HttpServletResponse response){
		return getLoginUser(request,response)==null?false:true;
	}
	
	/**
	 * 是否是白金VIP用户
	 * @param user
	 * @return
	 */
	public static boolean isPtVip(User user){
		if(user==null)return false ;
		
		//从bjvip表中读取数据，就行判断
		UserVip btvip = (UserVip)Tools.getManager(UserVip.class).get(user.getId());
		if(btvip!=null){
			return true ;
		}
		
		return false ;
	}
	
	/**
	 * 是否是白金VIP用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isPtVip(HttpServletRequest request,HttpServletResponse response){
		
		if(!isLogin(request,response))return false;
		
		User loginUser = getLoginUser(request,response);
		
		return isPtVip(loginUser);
	}
	
	/**
	 * 是否是VIP用户
	 * @param user
	 * @return
	 */
	public static boolean isVip(User user){

		if(user==null)return false ;
		
		if(user.getMbrmst_specialtype()!=null&&user.getMbrmst_specialtype().longValue()==1){//VIP用户
			return true ;
		}
		
		return false ;
	}
	
	/**
	 * 是否是VIP用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isVip(HttpServletRequest request,HttpServletResponse response){
		if(!isLogin(request,response))return false;
		
		User loginUser = (User)getLoginUser(request,response);
		
		return isVip(loginUser);
	}
	
	/**
	 * 是否是平安万里通的用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isPingAnUser(HttpServletRequest request,HttpServletResponse response){
		User loginUser = getLoginUser(request,response);
		if(loginUser==null)return false ;
		//平安用户表存在记录的就是平安用户！对应表名MbrmstPingAn
		PingAnUser pUser = (PingAnUser)Tools.getManager(PingAnUser.class).findByProperty("mbrmstpingan_mbrid", new Long(loginUser.getId()));
		if(pUser!=null)return true ;
		return false ;
		
	}
	
	/**
	 * 是否是支付宝用户
	 * @param user
	 * @return
	 */
	public static boolean isAlipayUser(User user){
		if(user==null)return false;
		if("Alipay_lmlogin".equalsIgnoreCase(user.getMbrmst_temp()))return true;
		return false ;
	}
	
	/**
	 * 是否是支付宝登陆用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isAlipayUser(HttpServletRequest request,HttpServletResponse response){
		User user = getLoginUser(request, response);
		return isAlipayUser(user);
	}
	
	/**
	 * 是否是139邮箱用户
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean is139MailUser(HttpServletRequest request,HttpServletResponse response){
		User loginUser = getLoginUser(request,response);
		if(loginUser==null)return false ;
		//平安用户表存在记录的就是平安用户！对应表名MbrmstPingAn
		Mail139User pUser = (Mail139User)Tools.getManager(Mail139User.class).findByProperty("mbr139_mbrid", new Long(loginUser.getId()));
		if(pUser!=null)return true ;
		return false ;
	}
	
	/**
	 * 获得用户的会员名称
	 * @param user - 用户对象
	 * @return String 普通/白金/VIP
	 */
	public static String getLevelText(User user){
		if(user == null) return "普通会员";
		if(UserHelper.isPtVip(user)){
			return "白金会员";
		}else{
			if(Tools.longValue(user.getMbrmst_specialtype()) == 1){
				return "VIP会员";
			}else{
				return "普通会员";
			}
		}
	}
	
	/**
	 * 获得用户的会员的头像
	 * @param level - 会员名称/普通会员/VIP会员/白金会员
	 * @return String
	 */
	public static String getLevelImage(String level){
		if(level == null) level = "普通会员";
		return userImage.get(level);
	}
	//图片
	private static Map<String,String> userImage = new HashMap<String,String>();
	
	static{
		userImage.put("普通会员", "http://images.d1.com.cn/images2012/New/hyimg.jpg");
		userImage.put("VIP会员", "http://images.d1.com.cn/images2012/New/vipimg.jpg");
		userImage.put("白金会员", "http://images.d1.com.cn/images2012/New/bjimg.jpg");
	}
	
	public static boolean createNewMbrLktQQ(String strAcct, String pwd,String nickname, String attach, String bonus, String point ){
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
			tx = session.beginTransaction() ;
			ArrayList<ProcedureParam> list=new ArrayList<ProcedureParam>();
			ProcedureParam pp1=new ProcedureParam();
			pp1.setOutParameter(false);
			pp1.setValue(strAcct);
			list.add(pp1);
			ProcedureParam pp2=new ProcedureParam();
			pp2.setValue(pwd);
			list.add(pp2);
			ProcedureParam pp3=new ProcedureParam();
			pp3.setValue(nickname);
			list.add(pp3);
			ProcedureParam pp4=new ProcedureParam();
			pp4.setValue(attach);
			list.add(pp4);
			ProcedureParam pp5=new ProcedureParam();
			pp5.setValue(bonus);
			list.add(pp5);
			ProcedureParam pp6=new ProcedureParam();
			pp6.setValue(point);
			list.add(pp6);
			
			UserProcedureWork work = new UserProcedureWork("sp_CrtNewMbr_LKTQQ",list);
			session.doWork(work);//执行work
			tx.commit();
			return true;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			ex.printStackTrace();
			return false;
		}finally{
			MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE) ;
		}
	}
	
	/**
	 * 网易用户信息
	 */
	public static ArrayList<User163> getUser163Info(Long mbrid){
		ArrayList<User163> list=new ArrayList<User163>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("wangyi_mbrid", mbrid));
		
		List<BaseEntity> list2 = Tools.getManager(User163.class).getList(listRes, null, 0, 10);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((User163)be);
		}
		return list;
	}
	
	/**
	 * 判断是否是在查询范围内注册的用户 --网易
	 */
	public static ArrayList<User163> getUser163ByRegDate(Long mbrid,Date start,Date end){
		ArrayList<User163> list=new ArrayList<User163>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("wangyi_mbrid", mbrid));
		listRes.add(Restrictions.ge("wangyi_regDate", start));
		listRes.add(Restrictions.le("wangyi_regDate", end));
		List<BaseEntity> list2 = Tools.getManager(User163.class).getList(listRes, null, 0, 10);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((User163)be);
		}
		System.out.print(list.size());
		return list;
	}
	
	
	/**
	 * 网易用户信息
	 */
	public static ArrayList<User> getUidExist(String uid){
		ArrayList<User> list=new ArrayList<User>();
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("mbrmst_uid", uid));
		
		List<BaseEntity> list2 = Tools.getManager(User.class).getList(listRes, null, 0, 10);
		if(list2==null || list2.size()==0){
			return null;
		}
		for(BaseEntity be:list2){
			list.add((User)be);
		}
		return list;
	}
}
