<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>

<%
Long size=0l;
if ("post".equals(request.getMethod().toLowerCase())) {//提交了
	
	DiskFileItemFactory  factory = new DiskFileItemFactory();
	factory.setSizeThreshold(1024 * 4);
	   ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1024 * 1024 * 10);
	   try {
	    List items = upload.parseRequest(request);
	    Iterator it = items.iterator();
	    
	    while(it.hasNext()){
		     FileItem fitem = (FileItem)it.next();
		     if(fitem.isFormField()){//如果是表单域
		    	 String fname=fitem.getFieldName();
		     
		     }
		     else{//如果是文件
		    	 size+=fitem.getSize();
		     
		     }
	    }
	    
		if(size>1024*1024*10){
			Tools.outJs(out,"您上传的附件总大小超过10M","back");
			return;
		}
		  List items2 = upload.parseRequest(request);
		    Iterator it2 = items.iterator();
		
	    while(it2.hasNext()){
	     FileItem fitem = (FileItem)it2.next();
	     if(!fitem.isFormField()){
	      if(fitem.getName() != null && !"".equals(fitem.getName())){
	    	  size+=fitem.getSize();
	    	  if(size<1024*1024*10){
	    		  String fn = fitem.getName();
					if (fn == null || fn.equals(""))
						continue;//如果文件框未选中文件
					
					String ext = ".jpg";
					if (fn.indexOf(".") > -1) {
						ext = fn.substring(fn.lastIndexOf(".")).toLowerCase();
						
					}
					if((!ext.equals(".jpg")) && (!ext.equals(".gif")) && (!ext.equals(".png"))){
						Tools.outJs(out,"请上传图片格式的文件","back");
						return;
					}
					String uploadPath = Const.PROJECT_PATH + "/upload/";
					String fileName = Tools.getDBDate()+ext;//文件名
					//String photoName = "http://d1.com.cn/upload/"+ fileName;
					//name+=fileName+",";
					
					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
					//创建一个待写文件 
					File uploadedFile = new File(uploadFileName);
					//写入 
					//out.print(uploadFileName);
					fitem.write(uploadedFile);
					out.print("<script>alert('上传成功！')</script>");
	    	  }
	    	 
	      }
	     }
	    }
	   } catch (Exception e) {
		   out.print("fail");
	       e.printStackTrace();
	    return;
	   }
}


%>



