package com.d1.servlet.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.d1.bean.PhoneCode;
import com.d1.bean.User;
import com.d1.helper.PhoneCodeHelper;
import com.d1.helper.UserHelper;
import com.d1.util.MD5;
import com.d1.util.Tools;

/**
 * Servlet implementation class FindPwdCofirmServlet
 */
public class FindPwdCofirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FindPwdCofirmServlet() {
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
		String code = request.getParameter("codeStr");
		String pwd = request.getParameter("pwd");
		String phone = request.getParameter("phone");
		String uid=request.getParameter("uid");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (phone == null || phone.length() == 0) {
			out.print("{success:false,message:\"�ֻ����벻��Ϊ�գ�\"}");
		} else if (!Tools.isMobile(phone)) {
			out.print("{success:false,message:\"�ֻ������ʽ����ȷ��\"}");
		} else if (code == null || code.length() == 0) {
			out.print("{success:false,message:\"��֤�벻��Ϊ�գ�\"}");
		} else if (pwd == null || pwd.length() == 0) {
			out.print("{success:false,message:\"���벻��Ϊ�գ�\"}");
		} else if (pwd.length() < 6 || pwd.length() > 14) {
			out.print("{success:false,message:\"���볤�Ȳ���ȷ��\"}");
		} else if (pwd.indexOf(" ") >= 0) {
			out.print("{success:false,message:\"�����в��ܰ����ո�\"}");
		} else {
			User user = UserHelper.getByUsername(uid);
			if (user == null) {
				user=UserHelper.getByUserMail2(uid);
				if(user==null){
					out.print("{success:false,message:\"���ֻ�û��ע��Ϊ��Ա��\"}");
				}else{
					PhoneCode pc = PhoneCodeHelper.getPhoneCodeByTele(phone);
					if (pc == null) {
						out.print("{success:false,message:\"���ֻ��Ż�û�л�ȡ��֤�룡\"}");
					} else {
						if (!pc.getPhonecode_code().equals(code)) {
							out.print("{success:false,message:\"��֤�����벻��ȷ��\"}");
						} else {
							user.setMbrmst_passwd(MD5.to32MD5(pwd));
							user.setMbrmst_pwd(MD5.to32MD5(pwd));
							if (Tools.getManager(User.class).update(user, true)) {
								out.print("{success:true,message:\"�޸ĳɹ���\"}");
							} else {
								out.print("{success:false,message:\"�޸�ʧ�ܣ������ԣ�\"}");
							}
						}

					}
				}
			} else {
				PhoneCode pc = PhoneCodeHelper.getPhoneCodeByTele(phone);
				if (pc == null) {
					out.print("{success:false,message:\"���ֻ��Ż�û�л�ȡ��֤�룡\"}");
				} else {
					if (!pc.getPhonecode_code().equals(code)) {
						out.print("{success:false,message:\"��֤�����벻��ȷ��\"}");
					} else {
						user.setMbrmst_passwd(MD5.to32MD5(pwd));
						user.setMbrmst_pwd(MD5.to32MD5(pwd));
						if (Tools.getManager(User.class).update(user, true)) {
							out.print("{success:true,message:\"�޸ĳɹ���\"}");
						} else {
							out.print("{success:false,message:\"�޸�ʧ�ܣ������ԣ�\"}");
						}
					}

				}
			}
		}

	}
}
