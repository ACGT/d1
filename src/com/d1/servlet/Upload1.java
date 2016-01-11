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
                //扩展名格式： 
                if (name.lastIndexOf(".") >= 0) {
                    extName = name.substring(name.lastIndexOf("."));
                }                
                /*获取文件扩展名*/
    			/*索引加1的效果是只取xxx.jpg的jpg*/
    			String extensionName = name.substring(name.lastIndexOf(".") + 1);
    			//System.out.println("extensionName:" + extensionName);
    			
    			/*检查文件类型*/
    			if (("," + fileExt.toLowerCase() + ",").indexOf("," + extensionName.toLowerCase() + ",") < 0){
    				//printInfo(response, "不允许上传此类型的文件", "");
    				System.out.println("不允许上传"+extensionName+"此类型的文件");
    				response.getWriter().print("不允许上传"+extensionName+"此类型的文件");    				
    				//response.getWriter().close();
    				return;
    			}
                
    			/*检查文件大小*/
    			if (maxSize > 0 && size > maxSize){
    				//printInfo(response, "上传文件的大小超出限制", "");
    				System.out.println(maxSize+"上传文件的大小超出限制!"+size);
    				response.getWriter().print("上传文件的大小超出限制!");
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
                	//商品主图
                	if(saveFile.exists()){saveFile.delete();fname=savePath+name+"_1"+extName;}
                	String f_main=savePath + name +"_1"+ extName;
                	File sF_main = new File(f_main);
                	if(sF_main.exists()){sF_main.delete();fname=savePath + name + extName;}
                	//商品表的_200图
                	String f_200=savePath + name +"_200"+ extName;
                	File sF_200 = new File(f_200);
                	if(sF_200.exists()){sF_200.delete();}
                	//商品表的_400图
                	String f_400=savePath + name +"_400"+ extName;
                	File sF_400 = new File(f_400);
                	if(sF_400.exists()){sF_400.delete();}
                	//商品表的_260图
                	String f_160=savePath + name +"_160"+ extName;
                	File sF_160 = new File(f_160);
                	if(sF_160.exists()){sF_160.delete();}
                	//商品表的_120图
                	String f_120=savePath + name +"_120"+ extName;
                	File sF_120 = new File(f_120);
                	if(sF_120.exists()){sF_120.delete();}
                	//商品表的_80图
                	String f_80=savePath + name +"_80"+ extName;
                	File sF_80 = new File(f_80);
                	if(sF_80.exists()){sF_80.delete();}
                	//GdsCutImg表的240*300
                	String f_s300=savePath + name +"_s300"+ extName;
                	File sF_s300 = new File(f_s300);
                	if(sF_s300.exists()){sF_s300.delete();}
                	//GdsCutImg表的200*250
                	String f_s250=savePath + name +"_s250"+ extName;
                	File sF_s250 = new File(f_s250);
                	if(sF_s250.exists()){sF_s250.delete();}
                	//GdsCutImg表的160*200
                	String f_s200=savePath + name +"_s200"+ extName;
                	File sF_s200 = new File(f_s200);
                	if(sF_s200.exists()){sF_s200.delete();} 
                	//细节图800
                	String fx_800=savePath + name +"_800"+ extName;
                	File sFx_800 = new File(fx_800);
                	if(sFx_800.exists()){sFx_800.delete();}                	
                	//细节图400
                	String fx_400=savePath + name +"_400"+ extName;
                	File sFx_400 = new File(fx_400);
                	if(sFx_400.exists()){sFx_400.delete();}
                	//细节图60
                	String fx_60=savePath + name +"_60"+ extName;
                	File sFx_60 = new File(fx_60);
                	if(sFx_60.exists()){sFx_60.delete();} 
                	File saveFile1 = new File(fname); 
                    item.write(saveFile1);
                    BufferedImage image = ImageIO.read(saveFile1);  
                    width = image.getWidth();// 图片宽度  
                    height = image.getHeight();// 图片高度
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
            }
        }       
       
        response.getWriter().print(fname.replace("/opt", "")+";"+width+";"+height);
    }
}