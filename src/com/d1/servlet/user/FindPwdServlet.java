package com.d1.servlet.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Email;
import com.d1.bean.FindPassword;
import com.d1.bean.PhoneCode;
import com.d1.bean.User;
import com.d1.helper.FindPasswordHelper;
import com.d1.helper.PhoneCodeHelper;
import com.d1.helper.UserHelper;
import com.d1.mail.SendMailByJavaMail;
import com.d1.util.MD5;
import com.d1.util.SendMessage;
import com.d1.util.Tools;

/**
 * Servlet implementation class FindPwd
 */
public class FindPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPwdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		String mobile = request.getParameter("mobile");//手机号/会员/邮箱
		String code = request.getParameter("code");
		if(!Tools.isNumber(code) || Tools.isNull(mobile)){
			out.print("{\"success\":false,\"message\":\"参数错误！\"}");
			return;
		}
		String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
		if(!(code).equals(vImageCode)){
			out.print("{\"success\":false,\"message\":\"验证码输入错误！\"}");
			return;
		}
		
		
		User user=UserHelper.getByUserPhone(mobile);
		String type="";
		//手机号，需要发验证码给他
		if(user!=null){
			type="phone";
			
		}else{//输入的是邮箱的话就发邮件
			user = UserHelper.getByUserMail2(mobile);
			if(user!=null){
				if(user.getMbrmst_usephone()!=""&&user.getMbrmst_phoneflag().longValue()==1){
					type="phone";
				}else{
				type="email";
				}
			}else{
				//输入的是用户 名
				user=UserHelper.getByUsername(mobile);
				if(user!=null){
					if(user.getMbrmst_usephone()!=""&&user.getMbrmst_phoneflag().longValue()==1){
						type="phone";
					}else{
						if(user.getMbrmst_email()!=""&&user.getMbrmst_mailflag().longValue()==1){
							type="email";
						}else{//手机/邮箱/用户 名都找不到，没有这个用户 
							out.print("{\"success\":false,\"message\":\"没此用户或没绑定手机邮箱，请拨打400-680-8666！\"}");
							return;
						}
					}
				}else{//手机/邮箱/用户 名都找不到，没有这个用户 
					out.print("{\"success\":false,\"message\":\"没此用户或没绑定手机邮箱，请拨打400-680-8666！\"}");
					return;
				}
			}
		}
		
		String mbrName = Tools.trim(user.getMbrmst_uid());
		String email = user.getMbrmst_email();
		String telephone=user.getMbrmst_usephone();
		String self_mbrUid=user.getId();
		Date self_createTime=new Date();
		Date self_validEndTime= new Date(System.currentTimeMillis()+Tools.DAY_MILLIS);
		String self_Md5Key=MD5.to32MD5(Tools.dateValue(self_createTime)/1000+"ul.^t@pgkl");
		Long self_sucFlag = new Long(0);
		
		synchronized(user){
			FindPassword fp = getByMbrid(user);
			if(fp == null){
				fp = new FindPassword();
				fp.setSelf_mbruid(self_mbrUid);
				fp.setSelf_createtime(self_createTime);
				fp.setSelf_validendtime(self_validEndTime);
				fp.setSelf_md5key(self_Md5Key);
				fp.setSelf_sucflag(self_sucFlag);
				fp = (FindPassword)FindPasswordHelper.manager.create(fp);
			}else{
				long time = Tools.dateValue(fp.getSelf_createtime());
				if(time < System.currentTimeMillis()){
					fp.setSelf_mbruid(self_mbrUid);
					fp.setSelf_createtime(self_createTime);
					fp.setSelf_validendtime(self_validEndTime);
					fp.setSelf_md5key(self_Md5Key);
					fp.setSelf_sucflag(self_sucFlag);
					FindPasswordHelper.manager.update(fp,true);
				}else{
					self_mbrUid=fp.getSelf_mbruid();
					self_createTime=fp.getSelf_createtime();
					self_Md5Key=fp.getSelf_md5key();
				}
			}
		}
		
		if("phone".equals(type)){
			//发送手机验证码
			 String SendTime=	"0";	 //即时发送	//request.getParameter("dtTime");
			   //String type=request.getParameter("apitype");    //通道选择: 0：默认通道； 2：通道2； 3：即时通道
			   //生成激活码
			  
					String random="";
					int num = new Random().nextInt(10000);
					 if (num <10) {
						  random="0"+String.valueOf(num);
					  }
					 else
					 {
						 random=String.valueOf(num);
					 }
				//创建记录(该记录已存在)	
				PhoneCode pc1=PhoneCodeHelper.getPhoneCodeByTele(telephone);
				if(pc1!=null)
				{
					Calendar c=Calendar.getInstance();
				    c.set(Calendar.YEAR,Tools.parseInt(new SimpleDateFormat("yyyy").format(new Date())));
					c.set(Calendar.MONTH,new Date().getMonth());
					c.set(Calendar.DATE,new Date().getDate());
					c.set(Calendar.HOUR_OF_DAY,0);
					c.set(Calendar.MINUTE,0);
					c.set(Calendar.SECOND,0);
					
					if(new Date().after(pc1.getPhonecode_updatetime())&& pc1.getPhonecode_updatetime().after(c.getTime())&& pc1.getPhonecode_flag().longValue()%5==0)
					{
						out.print("{\"success\":false,\"message\":\"您今天只能发送5次激活码！\"}");
						  return;
					}
					else
					{
						  // String msg="[D1优尚]请您输入激活码"+pc1.getPhonecode_code()+"，或手机访问：http://m.d1.cn/wap/regist.jsp完成验证！";
						   String msg="优宝贝，您正在进行优尚网找回密码，验证码是："+pc1.getPhonecode_code()+"";
						   if(SendMessage.sendSms(telephone,msg))//18903017255是测试用的
						   {
							   pc1.setPhonecode_flag(pc1.getPhonecode_flag().longValue()+1);
							   pc1.setPhonecode_updatetime(new Date());
							   if(Tools.getManager(PhoneCode.class).update(pc1,true))
							   {
								   out.print("{\"success\":true,\"message\":\""+ telephone +"\",\"type\":\""+ type +"\",\"mobile\":\""+ mobile +"\"}");
							      return;
							   }
						   }
						   else
						   {
							   out.print("{\"success\":false,\"message\":\"向手机"+ telephone.substring(0, 3) +"****"+ telephone.substring(telephone.length()-4, telephone.length()) +"发送验证码失败，请重试！\"}");
							   return;
						   }
						  
					}
				}
				else
				{
					   PhoneCode pc=new PhoneCode();
					   pc.setPhonecode_code(random);
					   pc.setPhonecode_tele(telephone);
					   pc.setPhonecode_status(new Long(0));
					   pc.setPhonecode_updatetime(new Date());
					   pc.setPhonecode_flag(pc.getPhonecode_flag()!=null?new Long(pc.getPhonecode_flag().longValue()+1):new Long(1));
					   pc=(PhoneCode)Tools.getManager(PhoneCode.class).create(pc);
					   if(pc!=null)
					   {//发送短信
						   String msg="优宝贝，您正在进行优尚网找回密码，验证码是："+pc.getPhonecode_code()+"";
						  
						   if(SendMessage.sendSms(telephone,msg))
						   {
							   out.print("{\"success\":true,\"message\":\""+ telephone+"\",\"type\":\""+ type +"\",\"mobile\":\""+ mobile +"\"}");
							   return;
						   }
						   else
						   {
							   out.print("{\"success\":false,\"message\":\"发送验证码失败，请稍后重试！\"}");
							   return;
						   }
					   }
					   else
					   {
						   out.print("{\"success\":false,\"message\":\"生成验证码失败，请稍后重试！\"}");
						   return;
							  
					   }
				}
		}else{
			
			//发邮件了。
			String mailbody="尊敬的<b>"+mbrName+"</b>(登录名)您好：<br>";
			mailbody = mailbody+"请您点击以下链接修改密码！这个链接24小时内有效。<br>";
			mailbody=mailbody+"<p><a href=\"http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"\">http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"</a></p>";
			mailbody=mailbody+"如果您不能点击以上按钮，请将该链接复制到浏览器地址栏中访问，也可以完成修改新密码！<br>";
			mailbody=mailbody+"如有任何疑问，请与D1优尚客服取得联系。";
			
			String mailSubject = "找回D1优尚会员密码";
			String mailSendemail = email;
			String mailFromemail = "service@d1.com.cn";
			
			Email pwEmail = new Email();
			pwEmail.setBody(mailbody);
			pwEmail.setOdrid("");
			pwEmail.setIfsend(new Long(0));
			pwEmail.setCreatetime(new Date());
			pwEmail.setSendname("");
			pwEmail.setFromemail(mailFromemail);
			pwEmail.setSendemail(mailSendemail);
			pwEmail.setSubject(mailSubject);
			
			Tools.getManager(Email.class).create(pwEmail);
			SendMailByJavaMail.sendEmail(email, mailSubject, mailbody);
			out.print("{\"success\":true,\"message\":\"邮件发送成功！\",\"type\":\""+ type +"\"}");
		}
	}
	
	/**
	 * 找出记录
	 * @param user - 用户对象
	 * @return FindPassword
	 */
	public static FindPassword getByMbrid(User user){
		if(user == null) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("self_mbruid",String.valueOf(user.getId())));
		listRes.add(Restrictions.eq("self_sucflag",new Long(0)));
		
		List list = FindPasswordHelper.manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		return (FindPassword)list.get(0);
	}

}
