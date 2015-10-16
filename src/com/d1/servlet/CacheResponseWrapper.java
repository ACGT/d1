package com.d1.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * д��һ��Wrapper������filter��ȡjsp����<br>
 * @author kk
 */
public class CacheResponseWrapper extends HttpServletResponseWrapper{     
   private MyPrintWriter tmpWriter;
   private ByteArrayOutputStream output;
   
   public CacheResponseWrapper(HttpServletResponse httpServletResponse) {
      super(httpServletResponse);
      output = new ByteArrayOutputStream();
      tmpWriter = new MyPrintWriter(output);
   }
   
   public void finalize() throws Throwable {
      super.finalize();
      output.close();
      tmpWriter.close();
   }
   
   public String getContent() {
   	  tmpWriter.flush();   //ˢ�¸����Ļ��壬�꿴java.io.Writer.flush()
   	  return tmpWriter.getByteArrayOutputStream().toString();
   }

   /**
    * ����getWriter()������ʹ�������Լ������Writer
    */
   public PrintWriter getWriter() throws IOException {
      return tmpWriter;
   }
   
   public void close() throws IOException {
      tmpWriter.close();
   }
   
   /**
    * �Զ���PrintWriter��Ϊ���ǰ�response��д���Լ�ָ�������������У�
    * ����Ĭ�ϵ�ServletOutputStream
    */
   private static class MyPrintWriter extends PrintWriter {
      ByteArrayOutputStream myOutput;   //�˼�Ϊ���response�������Ķ���
      public MyPrintWriter(ByteArrayOutputStream output) {
         super(output);
         myOutput = output;
      }
      public ByteArrayOutputStream getByteArrayOutputStream() {
         return myOutput;
      }
   }
}