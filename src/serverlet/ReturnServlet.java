package serverlet;

import java.awt.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import baifubao.BfbSdkComm;

import com.d1.dbcache.core.BaseEntity;
import com.d1.util.*;
import com.d1.helper.*;
import com.d1.bean.*;
import com.d1.service.*;
import java.util.*;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

public class ReturnServlet extends HttpServlet {

	public ReturnServlet() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			 /**
	         * 1�����ñ���
	         */
			request.setCharacterEncoding("gbk");
			response.setContentType("text/html;charset=gbk");
			//response.setCharacterEncoding("gbk");

			PrintWriter out = response.getWriter(); 
			//��ӡ��־
			Logger logger =new  baifubao.BfbSdkComm().printLog("ReturnServlet");
			logger.log(Level.INFO, "response���룺"+response.getCharacterEncoding());
			
		    
		    /**
		    * 2��֧�����ش�,�鿴������Щ�ֶΣ����ص��ֶβ����Ƿ�Ϊ�գ�������ǩ��
		    */
		    String getStrPre=request.getQueryString();
	    	//url����
		    String getStr=java.net.URLDecoder.decode(getStrPre, "gbk");
		    logger.log(Level.INFO,"�������ַ���У�������ַ���:"+getStr+";��ӡ����");
		    //�ѷ��صĲ�����splitȡ����
		    String  []resultStrTemp=getStr.split("&");
		    String  []resultStr=new String[resultStrTemp.length-1];
		    //ȡǩ����
		    String signtemp=resultStrTemp[resultStrTemp.length-1];
		    String sign=signtemp.substring(signtemp.indexOf("=")+1,signtemp.length());

		    for(int i=0;i<resultStrTemp.length-1;i++){ 
		    	resultStr[i]=resultStrTemp[i];
		    	System.out.println(resultStr[i]);
		    }
			/**
			 *3�� ����bfb_sdk_comm��make_sign��������ǩ����
			 * 
			 */
	        
			//ǩ��ƴ�ӣ���Ҫȥ�����ص�ǩ�����ֶ�sign
			String  Localsign=new BfbSdkComm().make_sign(resultStr);
			logger.log(Level.INFO,"����ǩ����            ��"+Localsign);
			logger.log(Level.INFO,"�ٸ�������ǩ������"+sign+"<br/>");
			//��ӡ��ɹر���־
			//logger.setLevel(Level.OFF);
			//�ȶ�ǩ��
			//out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
			
			if(request.getParameter("pay_result").equals("1"))
			{
				
				if(sign.trim().equalsIgnoreCase(Localsign.trim()))
				{    
					
					String strOrderID = request.getParameter("extra");
					
					OrderBase order = OrderHelper.getById(strOrderID);
					
					String subAd = order.getOdrmst_subad();
					
					if(order != null){
						if(Tools.longValue(order.getOdrmst_orderstatus()) == 0){
							String total_fee = request.getParameter("fee_amount");
							double r3_amount = Tools.parseDouble(total_fee)/100;
							
							OrderService os = (OrderService)Tools.getService(OrderService.class);
							int reValue = os.updateOrderStatus(order,r3_amount);
							
							logger.log(Level.INFO,"reValue="+Integer.toString(reValue)+"<br/>r3_amount="+Double.toString(r3_amount));
							
							logger.setLevel(Level.OFF);
							
					        if(reValue == 0){
					        	//logInfo("�ٶ�֧������ʱ������������"+strOrderID+"֧���ɹ���");
					        	if (subAd=="phone") {
					        		//response.sendRedirect("/wap/user_orderlist.html");
					        	}
					        	else {
					        		//response.sendRedirect("/user/selforder.jsp");
					        	}
								return;
					        }else{
					        	//response.sendRedirect("/user/selforder.jsp");
					        	if (subAd=="phone") {
					        		//response.sendRedirect("/wap/user_orderlist.html");
					        	}
					        	else {
					        		//response.sendRedirect("/user/selforder.jsp");
					        	}
								return;
					        }
						}else{
							if (subAd=="phone") {
				        		//response.sendRedirect("/wap/user_orderlist.html");
				        	}
				        	else {
				        		//response.sendRedirect("/user/selforder.jsp");
				        	}
							return;
						}
					}else{
						out.println("������"+strOrderID+"δstrOrderID��");
					}
					
					
					/**
					 * ֧��֪ͨ����Ļ�ִ
					 * ���ã�	�յ�֪ͨ������֤ͨ������ٸ��������ִ���ٸ���GET�����̻���return_urlҳ�棬�̻���ߵ���Ӧ
					 * 		�б���������²��֣��ٸ���ֻ�н��յ��ض�����Ӧ��Ϣ�󣬲���ȷ���̻��Ѿ��յ�֪ͨ������֤ͨ��������
					 * 		�ٸ����Ų��������̻�����֧�����֪ͨ
					 */
					out.println("<HTML><head>");
					out.println("<meta name=\"VIP_BFB_PAYMENT\" content=\"BAIFUBAO\">");
					out.println("</head>");
					out.println("<body>");
					out.println("֧���ɹ�����ǩͨ��"+"�����ţ�"+request.getParameter("order_no")+"<br/>");
					out.println("�ٸ������ص�ǩ���� :"+sign+"<br/>");
					out.println("�������ɵ�ǩ����     :"+Localsign+"<br/>");
					out.println("</body></html>");
					
					
					
					/**
					*   1����Ҫ�����յ��ٶ�Ǯ���ĺ�̨֪ͨ���̻��뷵���ض���HTMLҳ�档��ҳ��Ӧ����������Ҫ��
					*	2����Ҫ��HTMLͷ�������<meta name="VIP_BFB_PAYMENT" content="BAIFUBAO">
					*	3����Ҫ�� �̻�����ͨ���ٸ���������ѯ�ӿ��ٴβ�ѯ����״̬������У��
					*	4����Ҫ�� �ò�ѯ�ӿڴ���һ�����ӳ٣��̻����Բ��ö���У�飬���κ�̨��֧�����֪ͨ����
					* */
				}else if(!sign.trim().equalsIgnoreCase(Localsign.trim()))
				{
					out.println("֧���ɹ�����ǩʧ��"+"<br/>");
				}   
			}else{
				out.println("֧��ʧ��"+"<br/>");
			}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public String getServletInfo() {
		return "returnServlet";
	}


	public void init() throws ServletException {
	}

}
