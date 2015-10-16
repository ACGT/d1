/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: SimpleUploaderServlet.java
 * 	Java File Uploader class.
 * 
 * Version:  2.3
 * Modified: 2005-08-11 16:29:00
 * 
 * File Authors:
 * 		Simone Chiaretta (simo@users.sourceforge.net)
 */ 
 
package com.bosheng.boxi;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.d1.Const;


/**
 * Servlet to upload files.<br>
 *
 * This servlet accepts just file uploads, eventually with a parameter specifying file type
 *
 * @author Simone Chiaretta (simo@users.sourceforge.net)
 */

public class SimpleUploaderServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static String baseDir;
	private static boolean debug=false;
	private static boolean enabled=false;
	private static Hashtable<String,ArrayList> allowedExtensions;
	private static Hashtable<String,ArrayList> deniedExtensions;
	
	/**
	 * Initialize the servlet.<br>
	 * Retrieve from the servlet configuration the "baseDir" which is the root of the file repository:<br>
	 * If not specified the value of "/UserFiles/" will be used.<br>
	 * Also it retrieve all allowed and denied extensions to be handled.
	 *
	 */
	 public void init() throws ServletException {
	 	
	 	debug=(new Boolean(getInitParameter("debug"))).booleanValue();
	 	
	 	if(debug) System.out.println("\r\n---- SimpleUploaderServlet initialization started ----");
	 	
		baseDir=getInitParameter("baseDir");
		enabled=(new Boolean(getInitParameter("enabled"))).booleanValue();
		if(baseDir==null)
			baseDir="/UserFiles/";
		String realBaseDir=getServletContext().getRealPath(baseDir);
		File baseFile=new File(realBaseDir);
		if(!baseFile.exists()){
			baseFile.mkdir();
		}
		
		allowedExtensions = new Hashtable<String,ArrayList>(3);
		deniedExtensions = new Hashtable<String,ArrayList>(3);
				
		allowedExtensions.put("File",stringToArrayList(getInitParameter("AllowedExtensionsFile")));
		deniedExtensions.put("File",stringToArrayList(getInitParameter("DeniedExtensionsFile")));

		allowedExtensions.put("Image",stringToArrayList(getInitParameter("AllowedExtensionsImage")));
		deniedExtensions.put("Image",stringToArrayList(getInitParameter("DeniedExtensionsImage")));
		
		allowedExtensions.put("Flash",stringToArrayList(getInitParameter("AllowedExtensionsFlash")));
		deniedExtensions.put("Flash",stringToArrayList(getInitParameter("DeniedExtensionsFlash")));
		
		if(debug) System.out.println("---- SimpleUploaderServlet initialization completed ----\r\n");
		
	}
	 /**
		 * 生成一个上传文件名
		 * @param ext - 后缀
		 * @return String
		 */
		public static String getUploadFileName(String ext){
			if(ext==null)return null;
			Calendar calendar = Calendar.getInstance();
			Random r = new Random();

			int m = (calendar.get(Calendar.MONTH)+1);
			String month = null;
			if(m<10)month="0"+m;
			else month=m+"";
			
			int d = calendar.get(Calendar.DAY_OF_MONTH);
			String day = null;
			if(d<10)day="0"+d;
			else day = ""+d;
				
			String dirName = String.valueOf(calendar.get(Calendar.YEAR))+"/"+month+"/"+day+"/";
			String fileName = String.valueOf(calendar.getTimeInMillis())+"_"+r.nextInt(10000)+ "." + ext.toLowerCase();
			return dirName+fileName ;

		}
		/**
		 * 得到一个上传目录名
		 * @return String
		 */
		public static String getUploadFilePath(){
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
			return Const.PROJECT_PATH+"upload/"+dirName;
		}


	/**
	 * Manage the Upload requests.<br>
	 *
	 * The servlet accepts commands sent in the following format:<br>
	 * simpleUploader?Type=ResourceType<br><br>
	 * It store the file (renaming it in case a file with the same name exists) and then return an HTML file
	 * with a javascript command in it.
	 *
	 */	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (debug) System.out.println("--- BEGIN DOPOST ---");

		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control","no-cache");
		PrintWriter out = response.getWriter();
		

		String typeStr=request.getParameter("Type");
		String currentPath=baseDir+typeStr;
		String currentDirPath=getServletContext().getRealPath(currentPath);
		currentPath=request.getContextPath()+currentPath;
		
		if (debug) System.out.println(currentDirPath);
		
		String retVal="0";
		String newName="";
		String fileUrl="";
		String errorMessage="";
		
		if(enabled) {
			DiskFileItemFactory factory = new  DiskFileItemFactory();
			factory.setSizeThreshold(1024*4);
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(1024*1024*10);
			try {
				List items = upload.parseRequest(request);
				
				Map<String,Object> fields=new HashMap<String,Object>();
				
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
				    FileItem item = (FileItem) iter.next();
				    if (item.isFormField())
				    	fields.put(item.getFieldName(),item.getString());
				    else
				    	fields.put(item.getFieldName(),item);
				}
				FileItem uplFile=(FileItem)fields.get("NewFile");
				String fileNameLong=uplFile.getName();
				fileNameLong=fileNameLong.replace('\\','/');
				String[] pathParts=fileNameLong.split("/");
				String fileName=pathParts[pathParts.length-1];
				
				String uploadPath = Const.PROJECT_PATH+"upload/";
				
				String ext=getExtension(fileName);
				File uploaddir= new File(getUploadFilePath());
					if (!uploaddir.exists()) {
					uploaddir.mkdirs();
				}
				fileName = getUploadFileName(ext);//文件名
				
				if(extIsAllowed(typeStr,ext)) {
					newName = fileUrl = "/upload/"+fileName;
					String uploadFileName = uploadPath+fileName;
					//创建一个待写文件 
		            File uploadedFile = new File(uploadFileName);
		            //写入 
		            uplFile.write(uploadedFile);
				}else {
					retVal="202";
					errorMessage="";
					if (debug) System.out.println("Invalid file type: " + ext);	
				}
			}catch (Exception ex) {
				if (debug) ex.printStackTrace();
				retVal="203";
			}
		}
		else {
			retVal="1";
			errorMessage="This file uploader is disabled. Please check the WEB-INF/web.xml file";
		}
		
		
		out.println("<script type=\"text/javascript\">");
		out.println("window.parent.OnUploadCompleted("+retVal+",'"+fileUrl+"','"+newName+"','"+errorMessage+"');");
		out.println("</script>");
		out.flush();
		out.close();
	
		if (debug) System.out.println("--- END DOPOST ---");	
		
	}
    	
	/*
	 * This method was fixed after Kris Barnhoorn (kurioskronic) submitted SF bug #991489
	 */
	private String getExtension(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".")+1);
	}



	/**
	 * Helper function to convert the configuration string to an ArrayList.
	 */
	 
	 private ArrayList stringToArrayList(String str) {
	 
	 if(debug) System.out.println(str);
	 String[] strArr=str.split("\\|");
	 	 
	 ArrayList<String> tmp=new ArrayList<String>();
	 if(str.length()>0) {
		 for(int i=0;i<strArr.length;++i) {
		 		if(debug) System.out.println(i +" - "+strArr[i]);
		 		tmp.add(strArr[i].toLowerCase());
			}
		}
		return tmp;
	 }


	/**
	 * Helper function to verify if a file extension is allowed or not allowed.
	 */
	 
	 private boolean extIsAllowed(String fileType, String ext) {
	 		
	 		ext=ext.toLowerCase();
	 		
	 		ArrayList allowList=(ArrayList)allowedExtensions.get(fileType);
	 		ArrayList denyList=(ArrayList)deniedExtensions.get(fileType);
	 		
	 		if(allowList.size()==0)
	 			if(denyList.contains(ext))
	 				return false;
	 			else
	 				return true;

	 		if(denyList.size()==0)
	 			if(allowList.contains(ext))
	 				return true;
	 			else
	 				return false;
	 
	 		return false;
	 }

}

