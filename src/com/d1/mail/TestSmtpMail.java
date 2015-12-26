package com.d1.mail;
import java.io.File;



/**
 * 测试类。
 */
public class TestSmtpMail
{
    public static void main(String[] args)
    {
        SmtpMailSender sms=SmtpMailSender.createSmtpMailSender("\"d1优尚\"<service@d1.com.cn>");
    //    SmtpMailSender sms=SmtpMailSender.createESmtpMailSender("smtp.163.com","\"Object\"<java.lang.object@163.com>","java.lang.object","******");
        
        sms.addLogManager(new LogPrinter());//添加日志管理器
        
        if(sms.sendTextMail("\"Sol\"<525141335@qq.com>","STMP邮件测试","这是一封测试邮件。",new File[]{new File("d://01719285_400_0.jpg")})==SmtpMailSender.SUCCESSFUL)
        {
            System.out.println("邮件发送成功。");
        }
        else
        {
            System.out.println("邮件发送失败。");
        }
    }
}

/**
 * 一个简单的日志管理器。
 */
class LogPrinter implements LogManager
{
    public void output(String info)
    {
        System.out.println(info);//将日志打印到控制台
    }
}
