package com.d1.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

public class SendMail {
	private static String CONTENT = "";//邮件内容
	public static int threadCount = 0;//发送线程数
	public static Object LOCK = new Object();
	static{
		try{
			BufferedReader br = new BufferedReader(new FileReader(new File("/var/mbrvip2.html")));
			String line = null ;
			StringBuffer sb = new StringBuffer();
			while((line=br.readLine())!=null){
				sb.append(line).append("\r");
			}
			CONTENT = sb.toString();
			br.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public static void main(String[] args) throws Exception {
		
		BufferedReader br = new BufferedReader(new FileReader(new File("/var/mbrvip2.csv")));
		String line = null ;
		while((line=br.readLine())!=null){
			try{
				if(line.indexOf(",")>-1){
					String[] xs = line.split(",");
					if(xs!=null&&xs.length>=2){
						String email = xs[0].trim();
						String nick = xs[1].trim();
						String content=CONTENT.replaceAll("#username#", nick);
						//content = content.replaceAll("#v1#", xs[2].trim());
						//content = content.replaceAll("#v2#", xs[3].trim());
						if(email.indexOf("@")>-1){
							synchronized(SendMail.LOCK){
								while(SendMail.threadCount>10){
									try {
										SendMail.LOCK.wait();
									} catch (InterruptedException e) {
										e.printStackTrace();
									}
								}
							}
							//System.out.println(email+" "+SendMail.send(email,"D1优尚白金会员规则升级通知",content,"staff.d1.com.cn","d1优尚网",25,"service@staff.d1.com.cn","service@123456"));
							SendThread st = new SendThread(email,"D1优尚白金会员规则升级通知",content,"staff.d1.com.cn","d1优尚网",25,"service@staff.d1.com.cn","service@123456");
							st.start();
						}
					}
				}
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		br.close();
		
		
	}
public void sendemail(String email,String title,String content){
	SendThread st = new SendThread(email,title,content,"staff.d1.com.cn","d1优尚网",25,"service@staff.d1.com.cn","service@123456");
	st.start();
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

 class SendThread extends Thread{
	private String targetEmail;
	private String title;
	private String content;
	private String host;
	private String sendName;
	private int port;
	private String mailUser;
	private String pwd ;
	
	public SendThread(String targetEmail,
		String title,
		String content,
		String host,
		String sendName,
		int port,
		String mailUser,
		String pwd){
		this.targetEmail=targetEmail;
		this.title=title;
		this.content=content;
		this.host=host;
		this.sendName=sendName;
		this.port=port;
		this.mailUser=mailUser;
		this.pwd=pwd;
	}
	
	public void run(){
		synchronized(SendMail.class){
			SendMail.threadCount++;
		}
		
		try{
			System.out.println("线程数"+SendMail.threadCount+" 发送到"+targetEmail+" "+SendMail.send(targetEmail, title, content, host, sendName, port, mailUser, pwd));
		}catch(Exception ex){
			ex.printStackTrace();
		}
		synchronized(SendMail.class){
			SendMail.threadCount--;
		}
		
		synchronized(SendMail.LOCK){
			SendMail.LOCK.notifyAll();
		}
	}
}
