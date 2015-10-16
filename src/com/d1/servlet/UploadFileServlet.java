package com.d1.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;

@SuppressWarnings({ "serial", "deprecation" })
public class UploadFileServlet extends HttpServlet {
	
	private static String baseFileDir = File.separator + "shopimg/gdsimg" + File.separator;//�ϴ��ļ��洢Ŀ¼
	//private static String baseFileDir = "/opt/shopimg/gdsimg/" + File.separator;//�ϴ��ļ��洢Ŀ¼
	
	private static String baseURLDir = "/shopimg/gdsimg/";//�ϴ��ļ�Ŀ¼URL
	private static String fileExt = "jpg,jpeg,bmp,gif,png";
	private static Long maxSize = 6024000l;

	// 0:����Ŀ¼ 1:�������Ŀ¼ 2:���´���Ŀ¼ 3:����չ����Ŀ¼ ����ʹ�ð����
	private static String dirType = "2";
	
	/**
	 * �ļ��ϴ���ʼ������
	 */
	public void init() throws ServletException {
		/*��ȡ�ļ��ϴ��洢���൱·��*/
		/*if (!StringUtils.isBlank(this.getInitParameter("baseDir"))){
			baseFileDir = this.getInitParameter("baseDir");
		}*/
		
		/*String realBaseDir = this.getServletConfig().getServletContext().getRealPath(baseFileDir);
		File baseFile = new File(realBaseDir);
		if (!baseFile.exists()) {
			baseFile.mkdir();
		}*/

		/*��ȡ�ļ����Ͳ���*/
		//fileExt = this.getInitParameter("fileExt");
		//if (StringUtils.isBlank(fileExt))
		//	fileExt = "jpg,jpeg,gif,bmp,png";

		/*��ȡ�ļ���С����*/
		/*String maxSize_str = this.getInitParameter("maxSize");
		if (StringUtils.isNotBlank(maxSize_str)) maxSize = new Long(maxSize_str);
		
		/*��ȡ�ļ�Ŀ¼���Ͳ���*/
		/*dirType = this.getInitParameter("dirType");
		
		if (StringUtils.isBlank(dirType))
			dirType = "1";
		if (",0,1,2,3,".indexOf("," + dirType + ",") < 0)
			dirType = "1";*/
	}

	/**
	 * �ϴ��ļ����ݴ������
	 */
	@SuppressWarnings({"unchecked" })
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String err = "";
		String newFileName = "";

		DiskFileUpload upload = new DiskFileUpload();
		try {
			List<FileItem> items = upload.parseRequest(request);
			Map<String, Serializable> fields = new HashMap<String, Serializable>();
			Iterator<FileItem> iter = items.iterator();
			
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField())
					fields.put(item.getFieldName(), item.getString());
				else
					fields.put(item.getFieldName(), item);
			}
			
			/*��ȡ�����ϴ��ļ�*/
			FileItem uploadFile = (FileItem)fields.get("filedata");
			
			/*��ȡ�ļ��ϴ�·������*/
			String fileNameLong = uploadFile.getName();
			//System.out.println("fileNameLong:" + fileNameLong);
			
			/*��ȡ�ļ���չ��*/
			/*������1��Ч����ֻȡxxx.jpg��jpg*/
			String extensionName = fileNameLong.substring(fileNameLong.lastIndexOf(".") + 1);
			//System.out.println("extensionName:" + extensionName);
			
			/*����ļ�����*/
			if (("," + fileExt.toLowerCase() + ",").indexOf("," + extensionName.toLowerCase() + ",") < 0){
				printInfo(response, "�������ϴ������͵��ļ�", "");
				return;
			}
			/*�ļ��Ƿ�Ϊ��*/
			if (uploadFile.getSize() == 0){
				printInfo(response, "�ϴ��ļ�����Ϊ��", "");
				return;
			}
			/*����ļ���С*/
	
			if (maxSize > 0 && uploadFile.getSize() > maxSize){
				printInfo(response, "�ϴ��ļ��Ĵ�С��������", "");
				return;
			}
			
			//0:����Ŀ¼, 1:�������Ŀ¼, 2:���´���Ŀ¼, 3:����չ����Ŀ¼.����ʹ�ð����.
			String fileFolder = "";
			if (dirType.equalsIgnoreCase("1"))
				fileFolder = new SimpleDateFormat("yyyyMMdd").format(new Date());;
			if (dirType.equalsIgnoreCase("2"))
				fileFolder = new SimpleDateFormat("yyyyMM").format(new Date());
			if (dirType.equalsIgnoreCase("3"))
				fileFolder = extensionName.toLowerCase();
			
			/*�ļ��洢�����·��*/
			String saveDirPath = baseFileDir + fileFolder + "/";
			//System.out.println("saveDirPath:" + saveDirPath);
			String fileFolder2 = new SimpleDateFormat("dd").format(new Date());
			saveDirPath=saveDirPath+fileFolder2+"/";
			/*�ļ��洢�������еľ���·��*/
			String saveFilePath = this.getServletConfig().getServletContext().getRealPath("") + baseFileDir + fileFolder + "/";
			//System.out.println("saveFilePath:" + saveFilePath);
			
			/*�����ļ�Ŀ¼�Լ�Ŀ¼�ļ�*/
			File fileDir = new File(saveFilePath);
			if (!fileDir.exists()) {fileDir.mkdirs();}
			
			/*�������ļ�*/
			String filename = UUID.randomUUID().toString();
			File savefile = new File(saveFilePath + filename + "." + extensionName);
			
			/*�洢�ϴ��ļ�*/
			//System.out.println(upload == null);
			uploadFile.write(savefile);
			
			String projectBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
			projectBasePath="http://images1.d1.com.cn";
			newFileName = projectBasePath + baseURLDir + fileFolder + "/" + filename + "." + extensionName;		
			//System.out.println("newFileName:" + newFileName);
			//printInfo(response, "�ϴ��ɹ�����", "");
			//return;
		} catch (Exception ex) {
			//System.out.println(ex.getMessage());
			newFileName = "";
			err = "����: " + ex.getMessage();
		}
		printInfo(response, err, newFileName);
	}
	
	/**
	 * ʹ��I/O����� json��ʽ������
	 * @param response
	 * @param err
	 * @param newFileName
	 * @throws IOException
	 */
	public void printInfo(HttpServletResponse response, String err, String newFileName) throws IOException {
		PrintWriter out = response.getWriter();
		//String filename = newFileName.substring(newFileName.lastIndexOf("/") + 1);
		 out.println("{\"err\":\"" + err + "\",\"msg\":\"" + newFileName + "\"}");
		out.flush();
		out.close();
	}
}
