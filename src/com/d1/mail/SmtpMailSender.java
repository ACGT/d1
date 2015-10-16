package com.d1.mail;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.Locale;
import java.util.regex.Pattern;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.InitialDirContext;



/**
 * SMTP�ʼ�����ϵͳ��
 * 
 * 
 * �����˺��ռ��˵���ȷ��ʽ����:
 * 
 * ��1: &quot;Sol&quot;&lt;sol@gameeden.org&gt;
 * ��2: Sol&lt;sol@gameeden.org&gt;
 * ��3: &lt;sol@gameeden.org&gt;
 * ��4: sol@gameeden.org
 * 
 * @author Sol
 * @since 1.5
 */
public final class SmtpMailSender
{
    /**
     * ���ͳɹ��ĳ�����
     */
    public final static boolean SUCCESSFUL=true;
    
    /**
     * ����ʧ�ܵĳ�����
     */
    public final static boolean FAILED=false;
    
    private final static int PORT=25;//�������˿�(SMTP���������ʼ����շ������Ķ˿ھ�Ϊ25)
    private final static int RETRY=3;//������SMTP������ʧ�ܺ����������ӵĴ���(�����ڷ���ESMTP�ʼ�)
    private final static int INTERVAL=1000;//������SMTP������ʧ�ܺ��������ӵ�ʱ����(�����ڷ���ESMTP�ʼ�)
    private final static int TIMEOUT=10000;//�������ӵĳ�ʱʱ��
    
    private final static String BOUNDARY;//MIME�ָ��
    private final static String CHARSET;//�������Ĭ�ϱ���
    private final static Pattern PATTERN;//����Ч�������ַ����ȷ��
    
    private static InitialDirContext dirContext;//���ڲ�ѯDNS��¼
    
    private final ArrayList<LogManager> logManager;//��־������
    
    private boolean isEsmtp;//��������
    
    private String smtp;//SMTP��������ַ(�����ڷ���ESMTP�ʼ�)
    private String user;//�û���(�����ڷ���ESMTP�ʼ�)
    private String password;//����(�����ڷ���ESMTP�ʼ�)
    private String sender;//����������
    private String senderAddress;//�����˵�E-Mail��ַ
    
    static
    {
        BOUNDARY="Boundary-=_hMbeqwnGNoWeLsRMeKTIPeofyStu";
        CHARSET=Charset.defaultCharset().displayName();
        PATTERN=Pattern.compile(".+@[^.@]+(\\.[^.@]+)+$");//�˴������˴�ͳƥ�䷽ʽ������Ϊ�˼��ݷ�Ӣ�������ĵ�������
        
        Hashtable<String,String> hashtable=new Hashtable<String,String>();
        hashtable.put("java.naming.factory.initial","com.sun.jndi.dns.DnsContextFactory");
        
        try
        {
            dirContext=new InitialDirContext(hashtable);
        }
        catch(NamingException e)
        {
        }
    }
    
    private SmtpMailSender(String from)
    {
        if(from==null)
        {
            throw new IllegalArgumentException("����from����Ϊnull��");
        }
        
        int leftSign=(from=from.trim()).charAt(from.length()-1)=='>'?from.lastIndexOf('<'):-1;
        
        senderAddress=leftSign>-1?from.substring(leftSign+1,from.length()-1).trim():from;
        
        if(!PATTERN.matcher(senderAddress).find())
        {
            throw new IllegalArgumentException("����from����ȷ��");
        }
        
        sender=leftSign>-1?from.substring(0,leftSign).trim():null;
        logManager=new ArrayList<LogManager>();
        isEsmtp=false;
        
        if(sender!=null)
        {
            if(sender.length()==0)
            {
                sender=null;
            }
            else if(sender.charAt(0)=='"'&&sender.charAt(sender.length()-1)=='"')
            {
                sender=sender.substring(1,sender.length()-1).trim();
            }
        }
    }
    
    private SmtpMailSender(String address,String from,String user,String password)
    {
        this(from);
        
        isEsmtp=true;
        this.smtp=address;
        this.user=Base64.encode(user.getBytes());
        this.password=Base64.encode(password.getBytes());
    }

    /**
     * ����SMTP�ʼ�����ϵͳʵ����
     * @param from ������
     * @return SMTP�ʼ�����ϵͳ��ʵ��
     * @throws IllegalArgumentException �������fromΪnull���ʽ����ȷ
     */
    public static SmtpMailSender createSmtpMailSender(String from) throws IllegalArgumentException
    {
        return new SmtpMailSender(from);
    }
    
    /**
     * ����ESMTP�ʼ�����ϵͳʵ����
     * @param smtp SMTP��������ַ
     * @param from ������
     * @param user �û���
     * @param password ����
     * @return SMTP�ʼ�����ϵͳ��ʵ��
     * @throws IllegalArgumentException �������fromΪnull���ʽ����ȷ
     */
    public static SmtpMailSender createESmtpMailSender(String smtp,String from,String user,String password) throws IllegalArgumentException
    {
        return new SmtpMailSender(smtp,from,user,password);
    }
    
    /**
     * �����ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @param isHtml ʹ����ҳ��ʽ����
     * @param isUrgent �����ʼ�
     * @return �Ƿ��ͳɹ�
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean sendMail(String to,String subject,String content,File[] attachments,boolean isHtml,boolean isUrgent) throws IllegalArgumentException
    {
        if(to==null)
        {
            throw new IllegalArgumentException("����to����Ϊnull��");
        }
        
        int leftSign=(to=to.trim()).charAt(to.length()-1)=='>'?to.lastIndexOf('<'):-1;
        
        String addresseeAddress=leftSign>-1?to.substring(leftSign+1,to.length()-1).trim():to;//�ռ��˵�E-Mail��ַ

        if(!PATTERN.matcher(addresseeAddress).find())
        {
            throw new IllegalArgumentException("����to����ȷ��");
        }
        
        String addressee=leftSign>-1?to.substring(0,leftSign).trim():null;//�ռ�������
        boolean needBoundary=attachments!=null&&attachments.length>0;
        
        Socket socket=null;
        InputStream in=null;
        OutputStream out=null;
        byte[] data;

        try
        {   
            if(addressee!=null)
            {
                if(addressee.length()==0)
                {
                    addressee=null;
                }
                else if(addressee.charAt(0)=='"'&&addressee.charAt(addressee.length()-1)=='"')
                {
                    addressee=addressee.substring(1,addressee.length()-1).trim();
                }
            }
            
            if(isEsmtp)
            {
                for(int k=1;;k++)
                {
                    try
                    {
                        log("����: ����:\""+smtp+"\" �˿�:\""+PORT+"\"");
                        socket=new Socket(smtp,PORT);
                        break;
                    }
                    catch(IOException e)
                    {
                        log("����: ����ʧ��"+k+"��");

                        if(k==RETRY)
                        {
                            return FAILED;
                        }
                        
                        try
                        {
                            Thread.sleep(INTERVAL);
                        }
                        catch(InterruptedException ie)
                        {
                        }
                    }
                }

                in=socket.getInputStream();
                out=socket.getOutputStream();
                
                if(response(in)!=220)
                {
                    return FAILED;
                }
            }
            else
            {
                log("״̬: �����ʼ����շ������б�");
                String[] address=parseDomain(parseUrl(addresseeAddress));
                
                if(address==null)
                {
                    return FAILED;
                }
                
                for(int k=0;k<address.length;k++)
                {
                    try
                    {
                        log("����: ����:\""+address[k]+"\" �˿�:\""+PORT+"\"");

                        socket=new Socket(address[k],PORT);
    
                        in=socket.getInputStream();
                        out=socket.getOutputStream();
                        
                        if(response(in)!=220)
                        {
                            return FAILED;
                        }
                        
                        break;
                    }
                    catch(IOException e)
                    {
                        log("����: ����ʧ��");
                    }
                }
            }

            if(in==null||out==null)
            {
                return FAILED;
            }
            
            socket.setSoTimeout(TIMEOUT);
            
            sendString("HELO "+parseUrl(senderAddress),out);
            sendNewline(out);
            
            if(response(in)!=250)
            {
                return FAILED;
            }

            if(isEsmtp)
            {
                sendString("AUTH LOGIN",out);
                sendNewline(out);
                
                if(response(in)!=334)
                {
                    return FAILED;
                }
                
                sendString(user,out);
                sendNewline(out);
                
                if(response(in)!=334)
                {
                    return FAILED;
                }
                
                sendString(password,out);
                sendNewline(out);
                
                if(response(in)!=235)
                {
                    return FAILED;
                }
            }
            
            sendString("MAIL FROM: <"+senderAddress+">",out);
            sendNewline(out);

            if(response(in)!=250)
            {
                return FAILED;
            }
            
            sendString("RCPT TO: <"+addresseeAddress+">",out);
            sendNewline(out);
            
            if(response(in)!=250)
            {
                return FAILED;
            }

            sendString("DATA",out);
            sendNewline(out);

            if(response(in)!=354)
            {
                return FAILED;
            }

            sendString("From: "+(sender==null?senderAddress:getBase64String(sender)+" <"+senderAddress+">"),out);
            sendNewline(out);
            sendString("To: "+(addressee==null?addresseeAddress:getBase64String(addressee)+" <"+addresseeAddress+">"),out);
            sendNewline(out);
            sendString("Subject: "+getBase64String(subject),out);
            sendNewline(out);
            sendString("Date: "+new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss Z (z)",Locale.US).format(new Date()),out);
            sendNewline(out);
            sendString("MIME-Version: 1.0",out);
            sendNewline(out);
            
            if(needBoundary)
            {
                sendString("Content-Type: multipart/mixed; BOUNDARY=\""+BOUNDARY+"\"",out);
                sendNewline(out);
            }
            else
            {
                if(isHtml)
                {
                    sendString("Content-Type: text/html; charset=\""+CHARSET+"\"",out);
                    sendNewline(out);
                }
                else
                {
                    sendString("Content-Type: text/plain; charset=\""+CHARSET+"\"",out);
                    sendNewline(out);
                }
            }
            
            sendString("Content-Transfer-Encoding: base64",out);
            sendNewline(out);

            if(isUrgent)
            {
                sendString("X-Priority: 1",out);
                sendNewline(out);
            }
            else
            {
                sendString("X-Priority: 3",out);
                sendNewline(out);
            }
            
            sendString("X-Mailer: BlackFox Mail[Copyright(C) 2007 Sol]",out);
            sendNewline(out);
            
            log("����: ");
            sendNewline(out);

            if(needBoundary)
            {
                sendString("--"+BOUNDARY,out);
                sendNewline(out);
                
                if(isHtml)
                {
                    sendString("Content-Type: text/html; charset=\""+CHARSET+"\"",out);
                    sendNewline(out);
                }
                else
                {
                    sendString("Content-Type: text/plain; charset=\""+CHARSET+"\"",out);
                    sendNewline(out);
                }
                
                sendString("Content-Transfer-Encoding: base64",out);
                sendNewline(out);
                
                log("����: ");
                sendNewline(out);
            }
            
            data=(content!=null?content:"").getBytes();
            
            for(int k=0;k<data.length;k+=54)
            {
                sendString(Base64.encode(data,k,Math.min(data.length-k,54)),out);
                sendNewline(out);
            }

            if(needBoundary)
            {
                RandomAccessFile attachment=null;
                int fileIndex=0;
                String fileName;
                int k;
                data=new byte[54];
                
                try
                {
                    for(;fileIndex<attachments.length;fileIndex++)
                    {
                        fileName=attachments[fileIndex].getName();
                        attachment=new RandomAccessFile(attachments[fileIndex],"r");

                        sendString("--"+BOUNDARY,out);
                        sendNewline(out);
                        sendString("Content-Type: "+MimeTypeFactory.getMimeType(fileName.indexOf(".")==-1?"*":fileName.substring(fileName.lastIndexOf(".")+1))+"; name=\""+(fileName=getBase64String(fileName))+"\"",out);
                        sendNewline(out);
                        sendString("Content-Transfer-Encoding: base64",out);
                        sendNewline(out);
                        sendString("Content-Disposition: attachment; filename=\""+fileName+"\"",out);
                        sendNewline(out);
                        
                        log("����: ");
                        sendNewline(out);
                        
                        do
                        {
                            k=attachment.read(data,0,54);
                            
                            if(k==-1)
                            {
                                break;
                            }
                            
                            sendString(Base64.encode(data,0,k),out);
                            sendNewline(out);
                        }while(k==54);
                    }
                }
                catch(FileNotFoundException e)
                {
                    log("����: ����\""+attachments[fileIndex].getAbsolutePath()+"\"������");
                    return FAILED;
                }
                catch(IOException e)
                {
                    log("����: �޷���ȡ����\""+attachments[fileIndex].getAbsolutePath()+"\"");
                    return FAILED;
                }
                finally
                {
                    if(attachment!=null)
                    {
                        try
                        {
                            attachment.close();
                        }
                        catch(IOException e)
                        {
                        }
                    }
                }
                
                sendString("--"+BOUNDARY+"--",out);
                sendNewline(out);
            }
            
            sendString(".",out);
            sendNewline(out);

            if(response(in)!=250)
            {
                return FAILED;
            }

            sendString("QUIT",out);
            sendNewline(out);

            if(response(in)!=221)
            {
                return FAILED;
            }
            
            return SUCCESSFUL;
        }
        catch(SocketTimeoutException e)
        {
            log("����: ���ӳ�ʱ");
            return FAILED;
        }
        catch(IOException e)
        {
            log("����: ���ӳ���");
            return FAILED;
        }
        catch(Exception e)
        {
            log("����: "+e.toString());
            return FAILED;
        }
        finally
        {
            if(in!=null)
            {
                try
                {
                    in.close();
                }
                catch(IOException e)
                {
                }
            }
            
            if(out!=null)
            {
                try
                {
                    out.close();
                }
                catch(IOException e)
                {
                }
            }

            if(socket!=null)
            {
                try
                {
                    socket.close();
                }
                catch(IOException e)
                {
                }
            }
        }
    }
    
    /**
     * ����������˷����ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @param isHtml ʹ����ҳ��ʽ����
     * @param isUrgent �����ʼ�
     * @return ����״��
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean[] sendMail(String[] to,String subject,String content,File[] attachments,boolean isHtml,boolean isUrgent) throws IllegalArgumentException
    {
        boolean[] task=new boolean[to.length];
        
        for(int k=0;k<task.length;k++)
        {
            task[k]=sendMail(to[k],subject,content,attachments,isHtml,isUrgent);
        }
        
        return task;
    }

    /**
     * ���ʹ��ı��ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @return �Ƿ��ͳɹ�
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean sendTextMail(String to,String subject,String content) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,null,false,false);
    }
    
    /**
     * ����HTML�ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @return �Ƿ��ͳɹ�
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean sendHtmlMail(String to,String subject,String content) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,null,true,false);
    }
    
    /**
     * ����������˷��ʹ��ı��ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @return ����״��
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean[] sendTextMail(String[] to,String subject,String content) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,null,false,false);
    }
    
    /**
     * ����������˷���HTML�ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @return ����״��
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean[] sendHtmlMail(String[] to,String subject,String content) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,null,true,false);
    }
    
    /**
     * ���ʹ������Ĵ��ı��ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @return �Ƿ��ͳɹ�
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean sendTextMail(String to,String subject,String content,File[] attachments) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,attachments,false,false);
    }
    
    /**
     * ���ʹ�������HTML�ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @return �Ƿ��ͳɹ�
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean sendHtmlMail(String to,String subject,String content,File[] attachments) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,attachments,true,false);
    }
    
    /**
     * ����������˷��ʹ������Ĵ��ı��ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @return ����״��
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean[] sendTextMail(String[] to,String subject,String content,File[] attachments) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,attachments,false,false);
    }
    
    /**
     * ����������˷��ʹ�������HTML�ʼ���
     * @param to �ռ���
     * @param subject ����
     * @param content ����
     * @param attachments ����
     * @return ����״��
     * @throws IllegalArgumentException �������toΪnull���ʽ����ȷ
     */
    public boolean[] sendHtmlMail(String[] to,String subject,String content,File[] attachments) throws IllegalArgumentException
    {
        return sendMail(to,subject,content,attachments,true,false);
    }

    /**
     * ���һ����־��������
     * @param manager ��־������
     */
    public void addLogManager(LogManager manager)
    {
        logManager.add(manager);
    }
    
    /**
     * �Ƴ���־��������
     * @param manager Ҫ�Ƴ�����־������
     */
    public void removeLogManager(LogManager manager)
    {
        logManager.remove(manager);
    }
    
    /**
     * ͨ�������ռ�������������DNS��¼��ȡ�ʼ����շ�������ַ��
     * @param url �ռ�����������
     * @return ������ַ�б�
     */
    private String[] parseDomain(String url)
    {
        try
        {
            NamingEnumeration records=dirContext.getAttributes(url,new String[]{"mx"}).getAll();
            
            String[] address;
            String[] tmpMx;
            MX[] tmpMxArray;
            MX tmp;

            if(records.hasMore())
            {
                url=records.next().toString();
                url=url.substring(url.indexOf(": ")+2);
                address=url.split(",");
                tmpMxArray=new MX[address.length];

                for(int k=0;k<address.length;k++)
                {
                    tmpMx=address[k].trim().split(" ");
                    tmpMxArray[k]=new MX(Integer.parseInt(tmpMx[0]),tmpMx[1]);
                }
                
                for(int n=1;n<tmpMxArray.length;n++)
                {
                    for(int m=n;m>0;m--)
                    {
                        if(tmpMxArray[m-1].pri>tmpMxArray[m].pri)
                        {
                            tmp=tmpMxArray[m-1];
                            tmpMxArray[m-1]=tmpMxArray[m];
                            tmpMxArray[m]=tmp;
                        }
                    }
                }
                
                for(int k=0;k<tmpMxArray.length;k++)
                {
                    address[k]=tmpMxArray[k].address;
                }
                
                return address;
            }//����mx��¼

            records=dirContext.getAttributes(url,new String[]{"a"}).getAll();

            if(records.hasMore())
            {
                url=records.next().toString();
                url=url.substring(url.indexOf(": ")+2).replace(" ","");
                address=url.split(",");
                
                return address;
            }//����a��¼
            
            return new String[]{url};
        }
        catch(NamingException e)
        {
            log("����: ����\""+url+"\"�޷�����");
            return null;
        }
    }
    
    /**
     * �����Ӧ�롣
     * @param in ������
     * @return ��Ӧ��
     * @throws IOException ������� I/O ����
     */
    private int response(InputStream in) throws IOException
    {
        byte[] buffer=new byte[1024];
        int k=in.read(buffer);
        
        if(k==-1)
        {
            return -1;
        }
        
        String response=new String(buffer,0,k).trim();
        log("��Ӧ: "+response);
        return Integer.parseInt(response.substring(0,3));
    }
    
    /**
     * ����ַ�����
     * @param str �ַ���
     * @param out �����
     * @throws IOException ������� I/O ����
     */
    private void sendString(String str,OutputStream out) throws IOException
    {
        log("����: "+str);

        if(str==null)
        {
            str="";
        }
        
        out.write(str.getBytes());
        out.flush();
    }
    
    /**
     * д��־��
     * @param info ��Ϣ
     */
    private void log(String info)
    {
        for(int n=0,m=logManager.size();n<m;n++)
        {
            logManager.get(n).output(info);
        }
    }

    /**
     * ���һ�����з���
     * @param out �����
     * @throws IOException ������� I/O ����
     */
    private static void sendNewline(OutputStream out) throws IOException
    {
        out.write('\r');
        out.write('\n');
        out.flush();
    }
    
    /**
     * ����ַ�����Base64������ʽ��
     * @param str �ַ���
     * @return ���ܺ���ַ���
     */
    private static String getBase64String(String str)
    {
        if(str==null||str.length()==0)
        {
            return "";
        }
        
        StringBuffer tmpStr=new StringBuffer();
        byte[] bytes=str.getBytes();
        
        for(int k=0;k<bytes.length;)
        {
            if(k!=0)
            {
                tmpStr.append(' ');
            }
            
            tmpStr.append("=?");
            tmpStr.append(CHARSET);
            tmpStr.append("?B?");
            tmpStr.append(Base64.encode(bytes,k,Math.min(bytes.length-k,30)));
            tmpStr.append("?=");
            
            k+=30;
            
            if(k<bytes.length)
            {
                tmpStr.append('\r');
                tmpStr.append('\n');
            }
        }

        return tmpStr.toString();
    }
    
    /**
     * ��������������
     * @param address E-Mail��ַ
     * @return ��������
     */
    private static String parseUrl(String address)
    {
        return address.substring(address.lastIndexOf('@')+1);
    }
    
    /**
     * MX��¼��
     */
    private class MX
    {
        final int pri;
        final String address;
        
        MX(int pri,String host)
        {
            this.pri=pri;
            this.address=host;
        }
    }
}
