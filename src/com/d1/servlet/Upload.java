package com.d1.servlet;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
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
 
@SuppressWarnings("serial")
public class Upload extends HttpServlet {
   private static final long serialVersionUID = 1L;
	private static String fileExt = "jpg,jpeg,bmp,gif,png";
	private static Long maxSize = 802400l;
	public void init() throws ServletException{
		//do nothing
    }
	 static String getUploadFilePath(){
			
			Calendar calendar = Calendar.getInstance();
			
			int m = (calendar.get(Calendar.MONTH)+1);
			String month = null;
			if(m<10)month="0"+m;
			else month=m+"";
			
			int d = calendar.get(Calendar.DAY_OF_MONTH);
			String day = null;
			if(d<10)day="0"+d;
			else day = ""+d;
			
			String dirName = String.valueOf(calendar.get(Calendar.YEAR))+"/"+month+"/"+day+"/";
			return "/opt/shopimg/sd/"+dirName;
		}
    @SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	//String odrid=request.getParameter("odrid");
    //	String gdsid=request.getParameter("gdsid");
        String savePath =getUploadFilePath();
        File f1 = new File(savePath);
        System.out.println(savePath);
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
               // System.out.println(size + " " + type);
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
    				//response.getWriter().print("�������ϴ�"+extensionName+"�����͵��ļ�");
    				//response.getWriter().close();
    				return;
    			}
                
    			/*����ļ���С*/
    			//System.out.println("maxSize====="+maxSize+"===file==="+size);
    			if (maxSize > 0 && size > maxSize){
    				//printInfo(response, "�ϴ��ļ��Ĵ�С��������", "");
    				System.out.println("�ϴ��ļ��Ĵ�С��������!");
    				//response.getWriter().print("�ϴ��ļ��Ĵ�С��������!");
    				//response.getWriter().close();
    				return;
    			}
                 fname=savePath + name + extName;
                File file = null;
                do {
                    //�����ļ�����
                    //name =odrid+"_"+gdsid+"_"+System.currentTimeMillis();
                	 name =System.currentTimeMillis()+"";
                    file = new File(fname); 
                } while (file.exists());
                fname=savePath + name + extName;
                File saveFile = new File(fname);
               
                try {
                    item.write(saveFile);
                    BufferedImage image = ImageIO.read(saveFile);  
                    width = image.getWidth();// ͼƬ���  
                    height = image.getHeight();// ͼƬ�߶�
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
       // response.getWriter().print(name + extName);
        response.getWriter().print(fname.replace("/opt", "")+";"+width+";"+height);
    }
}