package com.d1.servlet;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
 
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.d1.bean.Product;
import com.d1.helper.ProductHelper;
 
@SuppressWarnings("serial")
public class Upload1 extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private static String fileExt = "jpg,jpeg,bmp,gif,png";
	private static Long maxSize = 902400l;
	public void init() throws ServletException{
		//do nothing
    }
	 static String getUploadFilePath(String gdsid){
			
		 Product p=ProductHelper.getById(gdsid);
			if(p!=null)
			{
				Date createdate=p.getGdsmst_createdate();
				/*Calendar calendar = Calendar.getInstance(); 
				calendar.setTime(createdate); 
				
				int m=calendar.MONTH+1;				
				String month = null;
				if(m<10)month="0"+m;
				else month=m+"";							
				*/
				String diryear = new SimpleDateFormat("yyyy").format(createdate);
				String dirmonth = new SimpleDateFormat("MM").format(createdate);
				String dirday = new SimpleDateFormat("dd").format(createdate);
				String dirName = diryear+"/"+dirmonth+"/"+dirday+"/";
				return "/opt/shopimg/gdsimg/"+dirName;
			}
			else
			{
				return "";
			}
		}
    @SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String gdsid=request.getParameter("gdsid").substring(0,8);
    	String types=request.getParameter("gdsid").substring(9,10);
        String savePath =getUploadFilePath(gdsid);
            File f1 = new File(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        }
        DiskFileItemFactory fac = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(fac);
        upload.setHeaderEncoding("utf-8");
        List fileList = null;
        try {
            fileList = upload.parseRequest(request);
        } catch (FileUploadException ex) {
            return;
        }
        Iterator<FileItem> it = fileList.iterator();
        String name = "";
        String extName = "";
        String fname="";
        int width=0;
        int height=0;
        while (it.hasNext()) {
            FileItem item = it.next();
            if (!item.isFormField()) {
                name = item.getName();
                long size = item.getSize();
                String type = item.getContentType();
                if (name == null || name.trim().equals("")) {
                    continue;
                }
                //��չ����ʽ�� 
                if (name.lastIndexOf(".") >= 0) {
                    extName = name.substring(name.lastIndexOf("."));
                }                
                /*��ȡ�ļ���չ��*/
    			/*������1��Ч����ֻȡxxx.jpg��jpg*/
    			String extensionName = name.substring(name.lastIndexOf(".") + 1);
    			//System.out.println("extensionName:" + extensionName);
    			
    			/*����ļ�����*/
    			if (("," + fileExt.toLowerCase() + ",").indexOf("," + extensionName.toLowerCase() + ",") < 0){
    				//printInfo(response, "�������ϴ������͵��ļ�", "");
    				System.out.println("�������ϴ�"+extensionName+"�����͵��ļ�");
    				response.getWriter().print("�������ϴ�"+extensionName+"�����͵��ļ�");    				
    				//response.getWriter().close();
    				return;
    			}
                
    			/*����ļ���С*/
    			if (maxSize > 0 && size > maxSize){
    				//printInfo(response, "�ϴ��ļ��Ĵ�С��������", "");
    				System.out.println(maxSize+"�ϴ��ļ��Ĵ�С��������!"+size);
    				response.getWriter().print("�ϴ��ļ��Ĵ�С��������!");
    				//response.getWriter().close();
    				return;
    			}                
              
                File file = null;
                SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
                do {                    
                	 name =gdsid+sdf.format(new Date())+"_"+types;
                     file = new File(fname); 
                } while (file.exists());
                fname=savePath + name + extName;
                File saveFile = new File(fname);               
                try {
                	//��Ʒ��ͼ
                	if(saveFile.exists()){saveFile.delete();fname=savePath+name+"_1"+extName;}
                	String f_main=savePath + name +"_1"+ extName;
                	File sF_main = new File(f_main);
                	if(sF_main.exists()){sF_main.delete();fname=savePath + name + extName;}
                	//��Ʒ���_200ͼ
                	String f_200=savePath + name +"_200"+ extName;
                	File sF_200 = new File(f_200);
                	if(sF_200.exists()){sF_200.delete();}
                	//��Ʒ���_400ͼ
                	String f_400=savePath + name +"_400"+ extName;
                	File sF_400 = new File(f_400);
                	if(sF_400.exists()){sF_400.delete();}
                	//��Ʒ���_260ͼ
                	String f_160=savePath + name +"_160"+ extName;
                	File sF_160 = new File(f_160);
                	if(sF_160.exists()){sF_160.delete();}
                	//��Ʒ���_120ͼ
                	String f_120=savePath + name +"_120"+ extName;
                	File sF_120 = new File(f_120);
                	if(sF_120.exists()){sF_120.delete();}
                	//��Ʒ���_80ͼ
                	String f_80=savePath + name +"_80"+ extName;
                	File sF_80 = new File(f_80);
                	if(sF_80.exists()){sF_80.delete();}
                	//GdsCutImg���240*300
                	String f_s300=savePath + name +"_s300"+ extName;
                	File sF_s300 = new File(f_s300);
                	if(sF_s300.exists()){sF_s300.delete();}
                	//GdsCutImg���200*250
                	String f_s250=savePath + name +"_s250"+ extName;
                	File sF_s250 = new File(f_s250);
                	if(sF_s250.exists()){sF_s250.delete();}
                	//GdsCutImg���160*200
                	String f_s200=savePath + name +"_s200"+ extName;
                	File sF_s200 = new File(f_s200);
                	if(sF_s200.exists()){sF_s200.delete();} 
                	//ϸ��ͼ800
                	String fx_800=savePath + name +"_800"+ extName;
                	File sFx_800 = new File(fx_800);
                	if(sFx_800.exists()){sFx_800.delete();}                	
                	//ϸ��ͼ400
                	String fx_400=savePath + name +"_400"+ extName;
                	File sFx_400 = new File(fx_400);
                	if(sFx_400.exists()){sFx_400.delete();}
                	//ϸ��ͼ60
                	String fx_60=savePath + name +"_60"+ extName;
                	File sFx_60 = new File(fx_60);
                	if(sFx_60.exists()){sFx_60.delete();} 
                	File saveFile1 = new File(fname); 
                    item.write(saveFile1);
                    BufferedImage image = ImageIO.read(saveFile1);  
                    width = image.getWidth();// ͼƬ���  
                    height = image.getHeight();// ͼƬ�߶�
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
            }
        }       
       
        response.getWriter().print(fname.replace("/opt", "")+";"+width+";"+height);
    }
}