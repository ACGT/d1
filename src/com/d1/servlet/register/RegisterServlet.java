package com.d1.servlet.register;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import org.codehaus.jettison.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.d1.bean.PhoneCode;
import com.d1.bean.Ticket;
import com.d1.bean.User;
import com.d1.bean.User163;
import com.d1.bean.id.SequenceIdGenerator;
import com.d1.helper.PhoneCodeHelper;
import com.d1.helper.UserHelper;
import com.d1.util.IntfUtil;
import com.d1.util.MD5;
import com.d1.util.Tools;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final Logger LOGGER=LoggerFactory.getLogger(getClass());
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// 注册页面不需要缓存。
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma", "no-cache");
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		//String act = request.getParameter("act");
		PhoneCode pc=null;
		// if("post".equals(request.getMethod().toLowerCase()) &&
		// "regist".equals(act)){//注册
		String phone = request.getParameter("mobilephone");
		//手机注册开始
		LOGGER.info("##############手机注册开始！手机号："+phone);
		if (phone != null)
			phone = phone.trim();
		if (!Tools.isMobile(phone)) {
			out.print("{\"success\":false,\"message\":\"手机格式有误，请修改！\"}");
			out.flush();
			return;
		}
		String code=request.getParameter("code");

		User user = UserHelper.getByUsername(phone);
		if(user != null){
			out.print("{\"success\":false,\"message\":\"手机号已被注册，请更换一个！\"}");
			out.flush();
			   return;
		
		}
		else
		{
			user=UserHelper.getByUserPhone(phone);
		  if(user != null){
			  out.print("{\"success\":false,\"message\":\"手机号已被注册，请更换一个！\"}");
			  out.flush();
			   return;
		  }
			 pc=PhoneCodeHelper.getPhoneCodeByTele(phone);
			if(pc==null){
				out.print("{\"success\":false,\"message\":\"该手机号还没有发送验证码！\"}");
				out.flush();
				   return;
			}
			else if(pc.getPhonecode_status().longValue()==1){
				out.print("{\"success\":false,\"message\":\"手机号已被注册，请更换一个！\"}");
				out.flush();
				   return;
			}
			else if(!Tools.isNumber(pc.getPhonecode_code()))
			{
				out.print("{\"success\":false,\"message\":\"输入的验证码格式错误，请重新输入！\"}");
				out.flush();
				   return;
			}
			else if(!pc.getPhonecode_code().equals(code))
			{
				out.print("{\"success\":false,\"message\":\"您输入的验证码错误，请重新输入！\"}");
				out.flush();
				   return;
			}
		String sex = request.getParameter("sex");
		if (Tools.isNull(sex)) {
			out.print("{\"success\":false,\"message\":\"请选择性别！\"}");
			out.flush();
			return;
		}
		String password = request.getParameter("password");
		if (password == null) {
			out.print("{\"success\":false,\"message\":\"密码不能为空！\"}");
			out.flush();
			return;
		}
		if (password.length() < 6 || password.length() > 14) {
			out.print("{\"success\":false,\"message\":\"登录密码不能少于6个字符且不能多于14个字符！\"}");
			out.flush();
			return;
		}
		if (password.indexOf(" ") > -1) {
			out.print("{\"success\":false,\"message\":\"密码中不能包含空格！\"}");
			out.flush();
			return;
		}
		// 会员来源地址。
		String strMbrmstSrcUrl = Tools.getCookie(request, "d1.com.cn.srcurl");
		if (!Tools.isNull(strMbrmstSrcUrl)) {
			strMbrmstSrcUrl = URLDecoder.decode(strMbrmstSrcUrl, "UTF-8");
			strMbrmstSrcUrl = strMbrmstSrcUrl.replace("'", "\"");
		} else {
			strMbrmstSrcUrl = "";
		}
		String strMbrmstPeoplercm = "", strMbrmstSubad = "", strMbrmstTemp = "";
		String peoplercm = Tools.getCookie(request, "d1.com.cn.peoplercm");
		if (!Tools.isNull(peoplercm)) {
			strMbrmstPeoplercm = URLDecoder.decode(peoplercm.trim(), "UTF-8");
			strMbrmstPeoplercm = strMbrmstPeoplercm.replace("'", "\"");

			String ckeMbrmstSubad = Tools.getCookie(request, "d1.com.cn.peoplercm.subad");
			if (!Tools.isNull(ckeMbrmstSubad)) {
				strMbrmstSubad = URLDecoder.decode(ckeMbrmstSubad.trim(), "UTF-8");
				strMbrmstSubad = strMbrmstSubad.replace("'", "\"");
			}
			strMbrmstTemp = "联盟" + strMbrmstPeoplercm;
		}

		String ckeWangYi = "";
		String strLtinfo = "";

		try {
			// PLINFO
			String ckePLtinfo = Tools.getCookie(request, "PLINFO");
			if (!Tools.isNull(ckePLtinfo)) {
				String strPLtinfo = URLDecoder.decode(ckePLtinfo.trim(), "UTF-8");
				strPLtinfo = strPLtinfo.replace("'", "\"");
				if (!Tools.isNull(strPLtinfo)) {
					strMbrmstTemp = "PLINFO" + strPLtinfo;
				}
			}

			// CHANET
			String ckeChanet = Tools.getCookie(request, "CHANET");
			if (!Tools.isNull(ckeChanet)) {
				String strChanet = URLDecoder.decode(ckeChanet.trim(), "UTF-8");
				strChanet = strChanet.replace("'", "\"");
				if (!Tools.isNull(strChanet)) {
					strMbrmstTemp = "CHANET" + strChanet;
				}
			}

			// EQIFA
			String ckeEqifa = Tools.getCookie(request, "EQIFA");
			if (!Tools.isNull(ckeEqifa)) {
				String strEqifa = URLDecoder.decode(ckeEqifa.trim(), "UTF-8");
				strEqifa = strEqifa.replace("'", "\"");
				if (!Tools.isNull(strEqifa)) {
					strMbrmstTemp = "EQIFA" + strEqifa;
				}
			}

			// YIQIFA
			String ckeYiqifa = Tools.getCookie(request, "YIQIFA");
			if (!Tools.isNull(ckeYiqifa)) {
				String strYiqifa = URLDecoder.decode(ckeYiqifa.trim(), "UTF-8");
				strYiqifa = strYiqifa.replace("'", "\"");

				String ckeYiqifaCid = Tools.getCookie(request, "YIQIFA_Cid"); // YIQIFA_Cid
				String strYiqifaCid = "";
				if (!Tools.isNull(ckeYiqifaCid)) {
					strYiqifaCid = URLDecoder.decode(strYiqifaCid.trim(), "UTF-8");
					strYiqifaCid = strYiqifaCid.replace("'", "\"");
				}
				strMbrmstTemp = strYiqifaCid + "yiqifa" + strYiqifa;
			}

			// IPVGOU
			String ckeIpvgou = Tools.getCookie(request, "IPVGOU");
			if (!Tools.isNull(ckeIpvgou)) {
				strMbrmstTemp = URLDecoder.decode(ckeIpvgou.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}

			// YOYI
			String ckeYoyi = Tools.getCookie(request, "YOYI");
			if (!Tools.isNull(ckeYoyi)) {
				strMbrmstTemp = URLDecoder.decode(ckeYoyi.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}

			// SOHUVIP
			String ckeSohuvip = Tools.getCookie(request, "SOHUVIP");
			if (!Tools.isNull(ckeSohuvip)) {
				strMbrmstTemp = URLDecoder.decode(ckeSohuvip.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}

			// 51返利
			String cke51Fanli = Tools.getCookie(request, "51FANLI");
			if (!Tools.isNull(cke51Fanli)) {
				strMbrmstTemp = URLDecoder.decode(cke51Fanli.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}
			// 网易
			ckeWangYi = Tools.getCookie(request, "wangyi");
			if (!Tools.isNull(ckeWangYi)) {
				System.out.println(ckeWangYi);
				String[] str = ckeWangYi.trim().split("\\|");
				System.out.println(str[0]);
				strMbrmstTemp = URLDecoder.decode(str[0], "UTF-8");
				strMbrmstTemp = "WangYi" + strMbrmstTemp.replace("'", "\"");
			}
			// lele
			String ckeLele = Tools.getCookie(request, "lele");
			if (!Tools.isNull(ckeLele)) {
				strMbrmstTemp = URLDecoder.decode(ckeLele.trim(), "UTF-8");
				strMbrmstTemp = "lele" + strMbrmstTemp.replace("'", "\"");
			}

			// WEIYI
			String ckeWeiYi = Tools.getCookie(request, "WEIYI");
			if (!Tools.isNull(ckeWeiYi)) {
				strMbrmstTemp = URLDecoder.decode(ckeWeiYi.trim(), "UTF-8");
				strMbrmstTemp = "WEIYI" + strMbrmstTemp.replace("'", "\"");
			}

			// AigoVip
			String ckeAigoVip = Tools.getCookie(request, "AigoVip");
			if (!Tools.isNull(ckeAigoVip)) {
				strMbrmstTemp = URLDecoder.decode(ckeAigoVip.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}

			// RegaddAlipay
			String ckeRegaddAlipay = Tools.getCookie(request, "RegaddAlipay");
			if (!Tools.isNull(ckeRegaddAlipay)) {
				strMbrmstTemp = URLDecoder.decode(ckeRegaddAlipay.trim(), "UTF-8");
				strMbrmstTemp = strMbrmstTemp.replace("'", "\"");
			}

			// LTINFO
			String ckeLtinfo = Tools.getCookie(request, "LTINFO");

			if (!Tools.isNull(ckeLtinfo)) {
				strLtinfo = URLDecoder.decode(ckeLtinfo.trim(), "UTF-8");
				strLtinfo = strLtinfo.replace("'", "\"");
				strMbrmstTemp = "linktech" + strLtinfo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		Date currDate = new Date();

		user = new User();
		user.setId(SequenceIdGenerator.generate("3"));
		user.setMbrmst_uid(phone);
		user.setMbrmst_passwd(MD5.to32MD5(password));
		user.setMbrmst_pwd(MD5.to32MD5(password));
		user.setMbrmst_question("");
		user.setMbrmst_answer("");
		user.setMbrmst_createdate(currDate);
		user.setMbrmst_modidate(currDate);
		user.setMbrmst_lastdate(currDate);
		// int iAtPos = email.indexOf("@");
		// if(iAtPos >= 0){
		// user.setMbrmst_name(email.substring(0,iAtPos));
		// }else{
		user.setMbrmst_name("");
		// }
		user.setMbrmst_visittimes(new Long(1));
		user.setMbrmst_sex(new Long(sex));
		user.setMbrmst_email("");
		user.setMbrmst_hphone("");
		user.setMbrmst_usephone(phone);
		user.setMbrmst_haddr("");
		user.setMbrmst_countryid(new Long(1));
		user.setMbrmst_provinceid(new Long(0));
		user.setMbrmst_cityid(new Long(0));
		user.setMbrmst_postcode("");
		user.setMbrmst_certifiertype(new Long(0));
		user.setMbrmst_certifierno("");
		user.setMbrmst_myd1type(new Long(0));
		user.setMbrmst_myd1count(new Long(10));
		user.setMbrmst_myd1codes("");
		user.setMbrmst_specialtype(new Long(0));
		user.setMbrmst_srcurl(strMbrmstSrcUrl);
		user.setMbrmst_peoplercm(strMbrmstPeoplercm);
		user.setMbrmst_subad(strMbrmstSubad);
		user.setMbrmst_temp(strMbrmstTemp);
		user.setMbrmst_cookie(MD5.to32MD5(System.currentTimeMillis() + "#" + Math.random()));
		user.setMbrmst_bookletflag(new Long(0));
		user.setMbrmst_buyerrcount(new Long(0));
		user.setMbrmst_buyquestionid("");
		user.setMbrmst_downflag(new Long(0));
		user.setMbrmst_magazineflag(new Long(0));
		user.setMbrmst_validflag(new Long(0));
		user.setMbrmst_rcmcount(new Long(0));
		user.setMbrmst_ip("");
		user.setMbrmst_bktstep(new Long(0));
		user.setMbrmst_aliasname("");
		user.setMbrmst_src(new Long(0));
		user.setMbrmst_sendcount(new Long(0));
		user.setMbrmst_replycount(new Long(0));
		user.setMbrmst_kicktype(new Long(0));
		user.setMbrmst_bbsAlllogintimes(new Long(0));
		user.setMbrmst_bbsDaylogintimes(new Long(0));
		user.setMbrmst_allsrc(new Long(0));
		user.setMbrmst_jcsrc(new Long(0));
		user.setMbrmst_goldsrc(new Long(0));
		user.setMbrmst_goldallsrc(new Long(0));
		user.setMbrmst_birthflag(new Long(0));
		user.setMbrmst_tktmail(new Long(0));
		user.setMbrmst_phoneflag(new Long(1));// 手机验证 自从改成只用手机号注册后，这个就默认为1
		user.setMbrmst_mailflag(new Long(0));// 邮箱验证
		user.setMbrmst_ip(request.getRemoteAddr());
		user = (User) UserHelper.manager.create(user);
		if (user != null && user.getId() != null) {
			// 网易注册用户
			if (!Tools.isNull(ckeWangYi)) {
				String[] arrWangYiid = ckeWangYi.split("\\|");
				User163 userl63 = new User163();
				userl63.setWangyi_mbrid(new Long(user.getId()));
				userl63.setWangyi_regDate(new Date());
				userl63.setWangyi_unionid(arrWangYiid[0]);
				userl63.setWangyi_userid(arrWangYiid[1]);
				userl63 = (User163) Tools.getManager(User163.class).create(userl63);
				if (userl63 != null) {
					String url = "http://gouwutest.youdao.com/fanxian/cpa";
					StringBuffer str = new StringBuffer();
					str.append("wid=1102&userId=");
					str.append(arrWangYiid[1]);
					str.append("&regId=");
					str.append(phone);
					str.append("&regTime=");
					str.append(Tools.stockFormatDate(new Date()));
					str.append("&status=0");
					IntfUtil.GetPostData(url, str.toString());
				}
			}
			/*
			 * if (!Tools.isNull(strLtinfo)){ String
			 * url="http://service.linktech.cn/purchase_cpa.php"; StringBuffer
			 * str=new StringBuffer(); str.append("a_id=");
			 * str.append(strLtinfo); str.append("&m_id=d1bianli");
			 * str.append("&mbr_id=").append(email);
			 * str.append("&&o_cd=").append(email);
			 * str.append("&p_cd=d1_member"); IntfUtil.GetPostData(url,
			 * str.toString()); }
			 */
			SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date actendDate = null;
			Date tktendDate = null;
			try {
				actendDate = fmt2.parse("2013-4-30 23:59:59");
				tktendDate = fmt2.parse("2013-4-30 23:59:59");
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			String cardt = "";
			if (Tools.dateValue(actendDate) > System.currentTimeMillis()
					&& session.getAttribute("d1lianmengsubad") != null
					&& ("p1304012tmkh".equals(session.getAttribute("d1lianmengsubad"))
							|| session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay"))) {
				cardt = "ptmallqq0416";

				String cardno = cardt + user.getId();

				Ticket tktmstf = (Ticket) Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", cardno);
				if (tktmstf == null) {
					Ticket tktmst = new Ticket();
					tktmst.setTktmst_value(new Float(30));
					tktmst.setTktmst_type("002001");
					tktmst.setTktmst_mbrid(Tools.parseLong(user.getId()));
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
				}
			}
			if (session.getAttribute("url") != null
					&& session.getAttribute("url").toString().indexOf("/html/zt2013/etkt0708") > 0) {
				cardt = "paetkt130708";

				String cardno = cardt + user.getId();

				Ticket tktmstf = (Ticket) Tools.getManager(Ticket.class).findByProperty("tktmst_cardno", cardno);
				if (tktmstf == null) {
					Date endDate = null;
					try {
						endDate = Tools.addDate(new Date(), 30);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					Ticket tktmst = new Ticket();
					tktmst.setTktmst_value(new Float(30));
					tktmst.setTktmst_type("002001");
					tktmst.setTktmst_mbrid(Tools.parseLong(user.getId()));
					tktmst.setTktmst_validflag(new Long(0));
					tktmst.setTktmst_createdate(new Date());
					tktmst.setTktmst_validates(new Date());
					tktmst.setTktmst_validatee(endDate);
					tktmst.setTktmst_rackcode("017");
					tktmst.setTktmst_gdsvalue(new Float(30));
					tktmst.setTktmst_payid(new Long(-1));
					tktmst.setTktmst_cardno(cardno);
					tktmst.setTktmst_ifcrd(new Long(0));
					tktmst.setTktmst_memo("手机扑克领券！");
					Tools.getManager(Ticket.class).create(tktmst);
				}

			}

			UserHelper.setLoginUserId(session, user.getId());

			if (session.getAttribute("url") != null
					&& session.getAttribute("url").toString().indexOf("/market/1206/wydh/") > 0) {
				session.setAttribute("url", "");
				//response.sendRedirect("/market/1206/wydh/index.jsp");
				out.print("{\"success\":true,\"message\":\"/market/1206/wydh/index.jsp\"}");
				out.flush();
			} else if (session.getAttribute("url") != null
					&& session.getAttribute("url").toString().indexOf("/market/1207/wangyidh/") >= 0) {
				session.setAttribute("url", "");
				//response.sendRedirect("/market/1207/wangyidh/index.jsp");
				out.print("{\"success\":true,\"message\":\"/market/1206/wydh/index.jsp\"}");
				out.flush();
			} else if (session.getAttribute("backurl") != null
					&& session.getAttribute("backurl").equals("/market/1212/dangdang")) {
				session.setAttribute("backurl", "");
				//response.sendRedirect("/market/1212/dangdang");
				out.print("{\"success\":true,\"message\":\"/market/1212/dangdang\"}");
				out.flush();
			} else if (session.getAttribute("url") != null
					&& session.getAttribute("url").toString().indexOf("zhuanti/201303/szn0307/") > 0) {
				//response.sendRedirect("/newlogin/valitel.jsp");
				out.print("{\"success\":true,\"message\":\"/newlogin/valitel.jsp\"}");
				out.flush();
			} else {
				//response.sendRedirect("regsuccess.jsp");
				out.print("{\"success\":true,\"message\":\"/newlogin/regsuccess.jsp\"}");
				out.flush();
			}
			LOGGER.info("##########注册成功！");
			return;
		} else {
			out.print("{\"success\":false,\"message\":\"注册失败，请重新再试！\"}");
			out.flush();
			LOGGER.info("##########注册失败！");
			return;
		}

	}
	}
}
