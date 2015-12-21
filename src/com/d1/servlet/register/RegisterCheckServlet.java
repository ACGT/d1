package com.d1.servlet.register;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.document.DateTools.Resolution;

import com.d1.bean.User;
import com.d1.helper.UserHelper;
import com.d1.util.Tools;

/**
 * Servlet implementation class RegisterCheckServlet
 */
public class RegisterCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String act = request.getParameter("act");
		PrintWriter out =response.getWriter();
		if("is_mobilephone".equals(act)){//ºÏ≤ÈEmail
			String email = request.getParameter("mobilephone");
			if(email!= null && email.length()<12){
				if(Tools.isMobile(email)){
					User user = UserHelper.getByUsername(email);
					if(user == null){
			  			out.print("true");
						return;
					}
				}
			}
			
			out.print("false");
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
}
