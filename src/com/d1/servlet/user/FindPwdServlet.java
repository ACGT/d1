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
		String mobile = request.getParameter("mobile");//�ֻ���/��Ա/����
		String code = request.getParameter("code");
		if(!Tools.isNumber(code) || Tools.isNull(mobile)){
			out.print("{\"success\":false,\"message\":\"��������\"}");
			return;
		}
		String vImageCode = (String)session.getAttribute("USER_IMAGE_CHECK_CODE");
		if(!(code).equals(vImageCode)){
			out.print("{\"success\":false,\"message\":\"��֤���������\"}");
			return;
		}
		
		
		User user=UserHelper.getByUserPhone(mobile);
		String type="";
		//�ֻ��ţ���Ҫ����֤�����
		if(user!=null){
			type="phone";
			
		}else{//�����������Ļ��ͷ��ʼ�
			user = UserHelper.getByUserMail2(mobile);
			if(user!=null){
				if(user.getMbrmst_usephone()!=""&&user.getMbrmst_phoneflag().longValue()==1){
					type="phone";
				}else{
				type="email";
				}
			}else{
				//��������û� ��
				user=UserHelper.getByUsername(mobile);
				if(user!=null){
					if(user.getMbrmst_usephone()!=""&&user.getMbrmst_phoneflag().longValue()==1){
						type="phone";
					}else{
						if(user.getMbrmst_email()!=""&&user.getMbrmst_mailflag().longValue()==1){
							type="email";
						}else{//�ֻ�/����/�û� �����Ҳ�����û������û� 
							out.print("{\"success\":false,\"message\":\"û���û���û���ֻ����䣬�벦��400-680-8666��\"}");
							return;
						}
					}
				}else{//�ֻ�/����/�û� �����Ҳ�����û������û� 
					out.print("{\"success\":false,\"message\":\"û���û���û���ֻ����䣬�벦��400-680-8666��\"}");
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
			//�����ֻ���֤��
			 String SendTime=	"0";	 //��ʱ����	//request.getParameter("dtTime");
			   //String type=request.getParameter("apitype");    //ͨ��ѡ��: 0��Ĭ��ͨ���� 2��ͨ��2�� 3����ʱͨ��
			   //���ɼ�����
			  
					String random="";
					int num = new Random().nextInt(10000);
					 if (num <10) {
						  random="0"+String.valueOf(num);
					  }
					 else
					 {
						 random=String.valueOf(num);
					 }
				//������¼(�ü�¼�Ѵ���)	
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
						out.print("{\"success\":false,\"message\":\"������ֻ�ܷ���5�μ����룡\"}");
						  return;
					}
					else
					{
						  // String msg="[D1����]�������뼤����"+pc1.getPhonecode_code()+"�����ֻ����ʣ�http://m.d1.cn/wap/regist.jsp�����֤��";
						   String msg="�ű����������ڽ����������һ����룬��֤���ǣ�"+pc1.getPhonecode_code()+"";
						   if(SendMessage.sendSms(telephone,msg))//18903017255�ǲ����õ�
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
							   out.print("{\"success\":false,\"message\":\"���ֻ�"+ telephone.substring(0, 3) +"****"+ telephone.substring(telephone.length()-4, telephone.length()) +"������֤��ʧ�ܣ������ԣ�\"}");
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
					   {//���Ͷ���
						   String msg="�ű����������ڽ����������һ����룬��֤���ǣ�"+pc.getPhonecode_code()+"";
						  
						   if(SendMessage.sendSms(telephone,msg))
						   {
							   out.print("{\"success\":true,\"message\":\""+ telephone+"\",\"type\":\""+ type +"\",\"mobile\":\""+ mobile +"\"}");
							   return;
						   }
						   else
						   {
							   out.print("{\"success\":false,\"message\":\"������֤��ʧ�ܣ����Ժ����ԣ�\"}");
							   return;
						   }
					   }
					   else
					   {
						   out.print("{\"success\":false,\"message\":\"������֤��ʧ�ܣ����Ժ����ԣ�\"}");
						   return;
							  
					   }
				}
		}else{
			
			//���ʼ��ˡ�
			String mailbody="�𾴵�<b>"+mbrName+"</b>(��¼��)���ã�<br>";
			mailbody = mailbody+"����������������޸����룡�������24Сʱ����Ч��<br>";
			mailbody=mailbody+"<p><a href=\"http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"\">http://www.d1.com.cn/findpwd.jsp?uid="+self_mbrUid+"&sign="+MD5.to32MD5(self_mbrUid+self_Md5Key)+"</a></p>";
			mailbody=mailbody+"��������ܵ�����ϰ�ť���뽫�����Ӹ��Ƶ��������ַ���з��ʣ�Ҳ��������޸������룡<br>";
			mailbody=mailbody+"�����κ����ʣ�����D1���пͷ�ȡ����ϵ��";
			
			String mailSubject = "�һ�D1���л�Ա����";
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
			out.print("{\"success\":true,\"message\":\"�ʼ����ͳɹ���\",\"type\":\""+ type +"\"}");
		}
	}
	
	/**
	 * �ҳ���¼
	 * @param user - �û�����
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
