package com.d1.util;


import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import com.d1.bean.FeedbackMail;
/**
* 邮件接受测试
* 
*/
public class MailUtil {
   public MailUtil() {
       try {
           // 1. 设置连接信息, 生成一个 Session
           Properties props = new Properties();
           props.put("mail.transport.protocol", "pop3");// POP3 收信协议
           props.put("mail.pop.port", "110");
           // props.put("mail.debug", "true");// 调试
           Session session = Session.getInstance(props);
           // 2. 获取 Store 并连接到服务器
           Store store = session.getStore("pop3");
           store.connect("staff.d1.com.cn", "akliu@staff.d1.com.cn", "password");
           // 3. 通过 Store 打开默认目录 Folder
           Folder folder = store.getDefaultFolder();// 默认父目录
           if (folder == null) {
               System.out.println("服务器不可用");
               return;
               // System.exit(1);
           }
//           System.out.println("默认信箱名:" + folder.getName());
//
//           Folder[] folders = folder.list();// 默认目录列表
//
//           System.out.println("默认目录下的子目录数: " + folders.length);
           Folder popFolder = folder.getFolder("INBOX");// 获取收件箱
           popFolder.open(Folder.READ_WRITE);// 可读邮件,可以删邮件的模式打开目录
           // 4. 列出来收件箱 下所有邮件
           Message[] messages = popFolder.getMessages();
           // 取出来邮件数
           int msgCount = popFolder.getMessageCount();
           System.out.println("共有邮件: " + msgCount + "封");
           // FetchProfile fProfile = new FetchProfile();// 选择邮件的下载模式,
           // 根据网速选择不同的模式
           // fProfile.add(FetchProfile.Item.ENVELOPE);
           // folder.fetch(messages, fProfile);// 选择性的下载邮件
           // 5. 循环处理每个邮件并实现邮件转为新闻的功能
           for (int i = 0; i < msgCount; i++) {
        	   FeedbackMail fm = new FeedbackMail();
        	   fm.setFeedbackemail_createdtime(new Date());
        	   
               Message msg = messages[i];// 单个邮件
               
               // 发件人信息
               Address[] froms = msg.getFrom();
               if(froms != null) {
                   System.out.println("发件人:" + froms[0]);
                   //InternetAddress addr = (InternetAddress)froms[0];
                   //System.out.println("发件人地址:" + addr.getAddress());
                   //System.out.println("发件人显示名:" + addr.getPersonal());
                   
                   String from = decodeText(messages[i].getFrom()[0].toString());
                   InternetAddress ia = new InternetAddress(from);
                   System.out.println("-------------------"+ia.getAddress());
                   fm.setFeedbackemail_from(ia.getAddress());
                   
               }
               System.out.println("邮件主题:" + msg.getSubject());
               fm.setFeedbackemail_title(msg.getSubject());
               // getContent() 是获取包裹内容, Part 相当于外包装
               if(msg.getContent() instanceof Multipart){
	               Multipart multipart = (Multipart) msg.getContent();// 获取邮件的内容, 就一个大包裹,
	                                                               // MultiPart
	                                                                   // 包含所有邮件内容(正文+附件)
	               //System.out.println("邮件共有" + multipart.getCount() + "部分组成");
	               // 依次处理各个部分
	               for (int j = 0, n = multipart.getCount(); j < n; j++) {
	                   //System.out.println("处理第" + j + "部分");
	                   Part part = multipart.getBodyPart(j);//解包, 取出 MultiPart的各个部分, 每部分可能是邮件内容,
	                   // 也可能是另一个小包裹(MultipPart)
	                   // 判断此包裹内容是不是一个小包裹, 一般这一部分是 正文 Content-Type: multipart/alternative
	                   if (part.getContent() instanceof Multipart) {
	                       Multipart p = (Multipart) part.getContent();// 转成小包裹
	                       //System.out.println("小包裹中有" + p.getCount() + "部分");
	                       // 列出小包裹中所有内容
	                       for (int k = 0; k < p.getCount(); k++) {
	                           //System.out.println("小包裹内容:" + p.getBodyPart(k).getContent());
	                           //System.out.println("内容类型:"+ p.getBodyPart(k).getContentType());
	                           
	                           if(p.getBodyPart(k).getContentType().startsWith("text/plain")) {
	                               // 处理文本正文
	                               //news.setBody(p.getBodyPart(k).getContent() + "");
	                        	   //System.out.println("邮件内容:"+p.getBodyPart(k).getContent());
	                           } else {
	                               // 处理 HTML 正文
	                               //news.setBody(p.getBodyPart(k).getContent() + "");
	                        	   //System.out.println("HTML邮件内容:"+p.getBodyPart(k).getContent());
	                           }
	                           fm.setFeedbackemail_content((String)p.getBodyPart(k).getContent());
	                       }
	                   }
	                   // Content-Disposition: attachment;    filename="String2Java.jpg"
	                   
	                   String disposition = part.getDisposition();// 处理是否为附件信息
	                   if (disposition != null) {
	                       System.out.println("发现附件: " + part.getFileName());
	                       System.out.println("内容类型: " + part.getContentType());
	                       //System.out.println("附件内容:" + part.getContent());
	                       
	                       java.io.InputStream in = part.getInputStream();// 打开附件的输入流
	                       File dir = new File("d:/opt/mailattatch/");
	                       if(!dir.exists()){
	                    	   dir.mkdirs();
	                       }
	                       String fileName = "d:/opt/mailattatch/"+System.currentTimeMillis()+"_"+new Random().nextInt(10000);
	                       if(part.getFileName().indexOf(".")>-1){
	                    	   fileName+=part.getFileName().substring(part.getFileName().lastIndexOf("."));
	                       }
	                       
	                       // 读取附件字节并存储到文件中
	                       FileOutputStream out = new FileOutputStream(fileName);
	                       int data;
	                       while((data = in.read()) != -1) {
	                           out.write(data);
	                       }
	                       in.close();
	                       out.flush();
	                       out.close();
	                       String fileNames = fm.getFeedbackemail_fromattach() ;
	                       if(fileNames==null)fileNames="";
	                       fm.setFeedbackemail_fromattach(fileNames+";"+fileName);
	                       //System.out.println(part.getContentType()+"附件内容========"+Base64.encodeBytes(out.toByteArray()));
	                   }
	               }
               }else{
            	   //System.out.println("==============错啦+++++++++++++"+msg.getContent());
            	   fm.setFeedbackemail_content((String)msg.getContent());
               }
               
               // }
               // TODO newsDAO.save(news); // 将邮件所携带的信息作为新闻存储起来
               // 6. 删除单个邮件, 标记一下邮件需要删除, 不会真正执行删除操作
               // msg.setFlag(Flags.Flag.DELETED, true);
               
               Tools.getManager(FeedbackMail.class).create(fm);//创建之
               
           }
           // 7. 关闭 Folder 会真正删除邮件, false 不删除
           popFolder.close(true);
           // 8. 关闭 store, 断开网络连接
           store.close();
       } catch (NoSuchProviderException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       } catch (Exception e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
       }
   }
   
   protected static String decodeText(String text)
		   throws UnsupportedEncodingException {
		  if (text == null)
		   return null;
		  if (text.startsWith("=?GB") || text.startsWith("=?gb"))
		   text = MimeUtility.decodeText(text);
		  else
		   text = new String(text.getBytes("ISO8859_1"));
		  return text;
		 }
   /**
    * @param args
    */
   public static void main(String[] args) {
       new MailUtil();
   }
}