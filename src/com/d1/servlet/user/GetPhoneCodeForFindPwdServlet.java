package com.d1.servlet.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.d1.bean.PhoneCode;
import com.d1.bean.SmsSndDtl;
import com.d1.bean.User;
import com.d1.helper.PhoneCodeHelper;
import com.d1.helper.UserHelper;
import com.d1.util.SendMessage;
import com.d1.util.Tools;

import cn.b2m.eucp.sdkhttp.SendSms;

/**
 * Servlet implementation class GetPhoneCodeServlet
 */
public class GetPhoneCodeForFindPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPhoneCodeForFindPwdServlet() {
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
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		out.print(SendMessage.sendPhoneCodeForFindPwd(request,response));
	}
	public static boolean sendSms(String phone,String smstxt){
		String[]  phones=phone.split("@@@@");
		smstxt="°æd1”≈…–°ø"+smstxt;
		int ret=SendSms.SendSMS(phones, smstxt);
		SmsSndDtl  sms=new SmsSndDtl();
		if(ret==0){
			sms.setPhone(phone);
			sms.setSmstxt(smstxt);
			sms.setIfsend(new Long(1));
			sms.setSenddate(new Date());
			Tools.getManager(SmsSndDtl.class).create(sms);
			return true;
		}else{
			sms.setPhone(phone);
			sms.setSmstxt(smstxt);
			sms.setIfsend(new Long(-1));
			sms.setSenddate(new Date());
			Tools.getManager(SmsSndDtl.class).create(sms);
			return false;
		}
	}
}
