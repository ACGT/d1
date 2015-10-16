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
* �ʼ����ܲ���
* 
*/
public class MailUtil {
   public MailUtil() {
       try {
           // 1. ����������Ϣ, ����һ�� Session
           Properties props = new Properties();
           props.put("mail.transport.protocol", "pop3");// POP3 ����Э��
           props.put("mail.pop.port", "110");
           // props.put("mail.debug", "true");// ����
           Session session = Session.getInstance(props);
           // 2. ��ȡ Store �����ӵ�������
           Store store = session.getStore("pop3");
           store.connect("staff.d1.com.cn", "akliu@staff.d1.com.cn", "password");
           // 3. ͨ�� Store ��Ĭ��Ŀ¼ Folder
           Folder folder = store.getDefaultFolder();// Ĭ�ϸ�Ŀ¼
           if (folder == null) {
               System.out.println("������������");
               return;
               // System.exit(1);
           }
//           System.out.println("Ĭ��������:" + folder.getName());
//
//           Folder[] folders = folder.list();// Ĭ��Ŀ¼�б�
//
//           System.out.println("Ĭ��Ŀ¼�µ���Ŀ¼��: " + folders.length);
           Folder popFolder = folder.getFolder("INBOX");// ��ȡ�ռ���
           popFolder.open(Folder.READ_WRITE);// �ɶ��ʼ�,����ɾ�ʼ���ģʽ��Ŀ¼
           // 4. �г����ռ��� �������ʼ�
           Message[] messages = popFolder.getMessages();
           // ȡ�����ʼ���
           int msgCount = popFolder.getMessageCount();
           System.out.println("�����ʼ�: " + msgCount + "��");
           // FetchProfile fProfile = new FetchProfile();// ѡ���ʼ�������ģʽ,
           // ��������ѡ��ͬ��ģʽ
           // fProfile.add(FetchProfile.Item.ENVELOPE);
           // folder.fetch(messages, fProfile);// ѡ���Ե������ʼ�
           // 5. ѭ������ÿ���ʼ���ʵ���ʼ�תΪ���ŵĹ���
           for (int i = 0; i < msgCount; i++) {
        	   FeedbackMail fm = new FeedbackMail();
        	   fm.setFeedbackemail_createdtime(new Date());
        	   
               Message msg = messages[i];// �����ʼ�
               
               // ��������Ϣ
               Address[] froms = msg.getFrom();
               if(froms != null) {
                   System.out.println("������:" + froms[0]);
                   //InternetAddress addr = (InternetAddress)froms[0];
                   //System.out.println("�����˵�ַ:" + addr.getAddress());
                   //System.out.println("��������ʾ��:" + addr.getPersonal());
                   
                   String from = decodeText(messages[i].getFrom()[0].toString());
                   InternetAddress ia = new InternetAddress(from);
                   System.out.println("-------------------"+ia.getAddress());
                   fm.setFeedbackemail_from(ia.getAddress());
                   
               }
               System.out.println("�ʼ�����:" + msg.getSubject());
               fm.setFeedbackemail_title(msg.getSubject());
               // getContent() �ǻ�ȡ��������, Part �൱�����װ
               if(msg.getContent() instanceof Multipart){
	               Multipart multipart = (Multipart) msg.getContent();// ��ȡ�ʼ�������, ��һ�������,
	                                                               // MultiPart
	                                                                   // ���������ʼ�����(����+����)
	               //System.out.println("�ʼ�����" + multipart.getCount() + "�������");
	               // ���δ����������
	               for (int j = 0, n = multipart.getCount(); j < n; j++) {
	                   //System.out.println("�����" + j + "����");
	                   Part part = multipart.getBodyPart(j);//���, ȡ�� MultiPart�ĸ�������, ÿ���ֿ������ʼ�����,
	                   // Ҳ��������һ��С����(MultipPart)
	                   // �жϴ˰��������ǲ���һ��С����, һ����һ������ ���� Content-Type: multipart/alternative
	                   if (part.getContent() instanceof Multipart) {
	                       Multipart p = (Multipart) part.getContent();// ת��С����
	                       //System.out.println("С��������" + p.getCount() + "����");
	                       // �г�С��������������
	                       for (int k = 0; k < p.getCount(); k++) {
	                           //System.out.println("С��������:" + p.getBodyPart(k).getContent());
	                           //System.out.println("��������:"+ p.getBodyPart(k).getContentType());
	                           
	                           if(p.getBodyPart(k).getContentType().startsWith("text/plain")) {
	                               // �����ı�����
	                               //news.setBody(p.getBodyPart(k).getContent() + "");
	                        	   //System.out.println("�ʼ�����:"+p.getBodyPart(k).getContent());
	                           } else {
	                               // ���� HTML ����
	                               //news.setBody(p.getBodyPart(k).getContent() + "");
	                        	   //System.out.println("HTML�ʼ�����:"+p.getBodyPart(k).getContent());
	                           }
	                           fm.setFeedbackemail_content((String)p.getBodyPart(k).getContent());
	                       }
	                   }
	                   // Content-Disposition: attachment;    filename="String2Java.jpg"
	                   
	                   String disposition = part.getDisposition();// �����Ƿ�Ϊ������Ϣ
	                   if (disposition != null) {
	                       System.out.println("���ָ���: " + part.getFileName());
	                       System.out.println("��������: " + part.getContentType());
	                       //System.out.println("��������:" + part.getContent());
	                       
	                       java.io.InputStream in = part.getInputStream();// �򿪸�����������
	                       File dir = new File("d:/opt/mailattatch/");
	                       if(!dir.exists()){
	                    	   dir.mkdirs();
	                       }
	                       String fileName = "d:/opt/mailattatch/"+System.currentTimeMillis()+"_"+new Random().nextInt(10000);
	                       if(part.getFileName().indexOf(".")>-1){
	                    	   fileName+=part.getFileName().substring(part.getFileName().lastIndexOf("."));
	                       }
	                       
	                       // ��ȡ�����ֽڲ��洢���ļ���
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
	                       //System.out.println(part.getContentType()+"��������========"+Base64.encodeBytes(out.toByteArray()));
	                   }
	               }
               }else{
            	   //System.out.println("==============����+++++++++++++"+msg.getContent());
            	   fm.setFeedbackemail_content((String)msg.getContent());
               }
               
               // }
               // TODO newsDAO.save(news); // ���ʼ���Я������Ϣ��Ϊ���Ŵ洢����
               // 6. ɾ�������ʼ�, ���һ���ʼ���Ҫɾ��, ��������ִ��ɾ������
               // msg.setFlag(Flags.Flag.DELETED, true);
               
               Tools.getManager(FeedbackMail.class).create(fm);//����֮
               
           }
           // 7. �ر� Folder ������ɾ���ʼ�, false ��ɾ��
           popFolder.close(true);
           // 8. �ر� store, �Ͽ���������
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