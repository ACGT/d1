package com.d1.mail;
import java.io.File;



/**
 * �����ࡣ
 */
public class TestSmtpMail
{
    public static void main(String[] args)
    {
        SmtpMailSender sms=SmtpMailSender.createSmtpMailSender("\"d1����\"<service@d1.com.cn>");
    //    SmtpMailSender sms=SmtpMailSender.createESmtpMailSender("smtp.163.com","\"Object\"<java.lang.object@163.com>","java.lang.object","******");
        
        sms.addLogManager(new LogPrinter());//�����־������
        
        if(sms.sendTextMail("\"Sol\"<525141335@qq.com>","STMP�ʼ�����","����һ������ʼ���",new File[]{new File("d://01719285_400_0.jpg")})==SmtpMailSender.SUCCESSFUL)
        {
            System.out.println("�ʼ����ͳɹ���");
        }
        else
        {
            System.out.println("�ʼ�����ʧ�ܡ�");
        }
    }
}

/**
 * һ���򵥵���־��������
 */
class LogPrinter implements LogManager
{
    public void output(String info)
    {
        System.out.println(info);//����־��ӡ������̨
    }
}
