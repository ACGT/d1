package serverlet;

import baifubao.BfbSdkComm;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PayWapServlet extends HttpServlet {
 
	
	private ServletConfig scon = null;
	
	public PayWapServlet() {
		super();
	}
	
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		request.setCharacterEncoding("gbk");
		//response.setCharacterEncoding("gbk");
		response.setContentType("text/html;charset=gbk");  
		response.setHeader("content-type","text/html;charset=gbk");
		PrintWriter out = response.getWriter();
	
		Logger logger =new  baifubao.BfbSdkComm().printLog("PayWapServlet");
	    String  service_code=
	    		"service_code="+scon.getServletContext().getInitParameter("BFB_PAY_INTERFACE_SERVICE_ID");
	    String sp_no="sp_no=" +scon.getServletContext().getInitParameter("SP_NO");
	    Calendar   c   =   Calendar.getInstance(); 
	    c.add(Calendar.DAY_OF_MONTH, 2);  
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");  
        String mDateTime=formatter.format(c.getTime());  
	    String strExpire=mDateTime.substring(0, 14);//
	    String expire_time=
	    		"expire_time=" +strExpire;
	    String order_create_time1=formatter.format(System.currentTimeMillis()); 
	    String order_no="order_no=" +order_create_time1+(int)(Math.random() * 100); ;
	    String order_create_time="order_create_time=" +order_create_time1;
	    String currency="currency=" +scon.getServletContext().getInitParameter("BFB_INTERFACE_CURRENTCY");
	    String input_charset="input_charset=" +scon.getServletContext().getInitParameter("BFB_INTERFACE_ENCODING");
	    String version="version=" +scon.getServletContext().getInitParameter("BFB_INTERFACE_VERSION");
	    String sign_method="sign_method=" +scon.getServletContext().getInitParameter("SIGN_METHOD_MD5");
	    String SP_KEY=scon.getServletContext().getInitParameter("SP_KEY");
	    String BFB_PAY_WAP_DIRECT_URL=scon.getServletContext().getInitParameter("BFB_PAY_WAP_DIRECT_URL");
	    String tempgoods_name=request.getParameter("goods_name");
	    String goods_name ="goods_name="+tempgoods_name;
	    String goods_name1="goods_name="+ URLEncoder.encode(request.getParameter("goods_name"),"gbk");
	    //String goods_ame1 ="goods_name="+tempgoods_name;
	    String tempgoods_desc=request.getParameter("goods_desc");
	    String goods_desc ="goods_desc="+tempgoods_desc;
	    String goods_desc1= "goods_desc="+URLEncoder.encode(request.getParameter("goods_desc"),"gbk");
	    //String goods_desc1 ="goods_desc="+tempgoods_desc;
	    String goods_url ="goods_url="+request.getParameter("goods_url");
	    String goods_url1="goods_url="+URLEncoder.encode(request.getParameter("goods_url"),"gbk");
	    String unit_amount ="unit_amount="+request.getParameter("unit_amount");
	    String unit_count ="unit_count="+request.getParameter("unit_count");
	    String transport_amount ="transport_amount="+request.getParameter("transport_amount");
	    String total_amount ="total_amount="+request.getParameter("total_amount");
	    String tempSPUserName=request.getParameter("buyer_sp_username");
	    String buyer_sp_username ="buyer_sp_username="+tempSPUserName;
        String buyer_sp_username1 ="buyer_sp_username="+URLEncoder.encode(tempSPUserName,"gbk");
	    String return_url ="return_url="+request.getParameter("return_url");
	    String return_url1="return_url="+URLEncoder.encode(request.getParameter("return_url"),"gbk");
	    String page_url ="page_url="+request.getParameter("page_url");
	    String page_url1="page_url="+URLEncoder.encode(request.getParameter("page_url"),"gbk");
	    String pay_type ="pay_type="+request.getParameter("pay_type");
	    String bank_no ="bank_no="+request.getParameter("bank_no");
	    String sp_uno ="sp_uno="+request.getParameter("sp_uno");
	    String tempextra=request.getParameter("extra");
	    String extra ="extra="+tempextra;
	    String extra1="extra="+URLEncoder.encode(tempextra,"gbk");
	    String sp_pass_through  = "sp_pass_through="+"%7B%22offline_pay%22%3A1%7D";
	    String sp_pass_through1 ="sp_pass_through="+URLEncoder.encode("%7B%22offline_pay%22%3A1%7D", "gbk");
		String[]array={
			    service_code,
				sp_no,
				order_create_time,
				order_no,
				goods_name,
				goods_desc,
				goods_url,
				unit_amount,
				unit_count,
				transport_amount,
				total_amount,
				currency,
				buyer_sp_username ,
				return_url,
				page_url,
				pay_type,
				bank_no,
				expire_time,
				input_charset,
				version,
				sign_method
				,extra,
				sp_pass_through
				};
		String[]array1={
			    service_code,
				sp_no,
				order_create_time,
				order_no,
				goods_name1,
				goods_desc1,
				goods_url1,
				unit_amount,
				unit_count,
				transport_amount,
				total_amount,
				currency,
				buyer_sp_username1,
				return_url1,
				page_url1,
				pay_type,
				bank_no,
				expire_time,
				input_charset,
				version,
				sign_method
				,extra1,
				sp_pass_through1
				};
		String getURL=new BfbSdkComm().create_baifubao_pay_order_url(array,array1,BFB_PAY_WAP_DIRECT_URL);
		logger.log(Level.INFO, "aaaaaaaaaa"+getURL);
		logger.setLevel(Level.OFF);
		response.sendRedirect(getURL); 
	    out.flush();
	    out.close();	
	}
	public String getServletInfo() {
		return "pay_wapServlet";
	}
	public void init(ServletConfig config) throws ServletException {
		scon = config;
	}

}
