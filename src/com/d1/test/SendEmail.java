package com.d1.test;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class SendEmail {
	public static void main(String[] args){
		try{
			String s = getUrlContentByGet("http://www.d1.com.cn/","utf-8");
			//if(s==null||s.indexOf("京ICP证030072号")<0)throw new Exception("出错了");
                       // s = getUrlContentByGet("http://www.d1.com.cn/test2.jsp","utf-8");
			System.out.println(s );
			if(s==null||s.indexOf("优sfsdsdffs尚网")<0)throw new Exception("出错了");

		}catch(Exception ex){
			System.out.println(SendEmail.send("15011462232@139.com","resin is slow","","smtp.163.com","kk",25,"gaojunliang001@163.com","19821217111111"));
                        //System.out.println(sendmail.send("15011462232@139.com","resin is slow","","staff.d1.com.cn","kk",25,"jlgao@staff.d1.com.cn","191217"));
		}
	}
	
	public static String getUrlContentByGet(String urlStr,String encoding) throws Exception{
		  HttpClient httpClient = new HttpClient();
		  
		  httpClient.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(10000));
		  httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(10000);   
		  GetMethod getMethod = new GetMethod(urlStr);
		  getMethod.setRequestHeader("User-Agent","Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)");
		  //使用系统提供的默认的恢复策略
		  getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());
		  try{
			   //执行getMethod
			   int statusCode = httpClient.executeMethod(getMethod);
			   if (statusCode != HttpStatus.SC_OK){
			     return "";
			   }
			   //读取内容 
			   byte[] responseBody = getMethod.getResponseBody();
			   //System.out.println(new String(responseBody));
			   //处理内容
			   return new String(responseBody,encoding);
		  }catch (Exception e){
			  e.printStackTrace();
			  throw e;
		  }finally{
		   //释放连接
			  getMethod.releaseConnection();
		  }
	}
	
	public static boolean send(String targetEmail,
			String title,
			String content,
			String host,
			String sendName,
			int port,
			String mailUser,
			String pwd)
	{
		try
		{
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.auth", "true"); //这样才能通过验证
	        props.put("mail.transpost.protocol", "smtp");
	        props.put("mail.smpt.port", port+"");
	        Session session = Session.getDefaultInstance(props,new SmtpAuth(mailUser,pwd));
	        //session.setDebug(true);

	        Message msg = new MimeMessage(session);  
			msg.setFrom(new InternetAddress(mailUser,sendName));         
			msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(targetEmail));
			msg.setSentDate(new Date());
			
		    //msg.setSubject("=?GBK?B?"+enc.encode(title.getBytes("GBK"))+"?=");
			msg.setSubject(MimeUtility.encodeWord(title));
			//msg.setSubject(title);
			msg.setContent(content,"text/html;charset=gbk");
			Transport transport = session.getTransport("smtp");
			transport.connect(host,port,mailUser,pwd);
			//transport.connect(host,25,mailUser,pwd);
			Transport.send(msg);
			transport.close();
			return true;
		}
		catch (Exception ee)
		{
			ee.printStackTrace();
			return false;
		}
	}
	
	static class SmtpAuth extends javax.mail.Authenticator 
	{
		private String user,password;
		
		public SmtpAuth(String user,String password)
		{
			this.user = user;
			this.password = password;
		}
		protected javax.mail.PasswordAuthentication getPasswordAuthentication()
		{
			return new javax.mail.PasswordAuthentication(user,password);
		}
	}
}
