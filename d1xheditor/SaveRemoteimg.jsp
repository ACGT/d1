<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator,com.d1.util.Tools"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date,java.net.URL"%>
<%@page import="java.util.UUID,java.awt.Image,java.net.HttpURLConnection,java.awt.image.BufferedImage,javax.imageio.ImageIO"%>

<%	if(session.getAttribute("shopadmin")==null&&session.getAttribute("admin_mng")==null){
	out.println("{\"err\":\"没有上传权限\",\"msg\":\"没有上传权限\"}");
    return;
}
	request.setCharacterEncoding("UTF-8");
	//response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	response.setContentType("text/html; charset=UTF-8");
%>
<%
		String baseFileDir = File.separator + "shopimg/gdsimg" + File.separator;//上传文件存储目录
		String baseURLDir = "/shopimg/gdsimg/";//上传文件目录URL
		String fileExt = "jpg,jpeg,bmp,gif,png";
		Long maxSize =  902400l;
		
		// 0:不建目录 1:按天存入目录 2:按月存入目录 3:按扩展名存目录 建议使用按天存
		String dirType = "2";
	/*获取文件上传存储的相当路径*/
		if (!StringUtils.isBlank(this.getInitParameter("baseDir"))){
			baseFileDir = this.getInitParameter("baseDir");
		}
		//System.out.println(this.getInitParameter("baseDir"));
		String realBaseDir = this.getServletConfig().getServletContext().getRealPath(baseFileDir);
		//System.out.println(realBaseDir);
		File baseFile = new File(realBaseDir);
		if (!baseFile.exists()) {
			baseFile.mkdir();
		}

		/*获取	文件类型参数*/
		//fileExt = this.getInitParameter("fileExt");
		//System.out.println(fileExt);
		//if (StringUtils.isBlank(fileExt))
			fileExt = "jpg,jpeg,gif,bmp,png";

		/*获取文件大小参数*/
		//String maxSize_str = this.getInitParameter("maxSize");
		//System.out.println(maxSize_str);
		//if (StringUtils.isNotBlank(maxSize_str)) maxSize = new Long(maxSize_str);
		
		String err = "";
		String newFileName = "";
		
		String	fileFolder = new SimpleDateFormat("yyyyMM").format(new Date());
		
		

		  String urls=request.getParameter("urls");
		
		  Image   image   =   null;   
			String[] arrurls= urls.split("\\|");
			   int arrlen=arrurls.length;
			   int width=0;
			   int height=0;
			   String urlstr="";
		 try{
			 for(int i=0;i<arrlen;i++){ //循环取路径开始
			
	      String fileitem=arrurls[i];
	     // System.out.println("urlstr==============" + urlstr);
			 if(Tools.isNull(fileitem)){
				 if(urlstr.length()==0)urlstr="null";
				 else if(urlstr.length()>0)urlstr+=urlstr+"|"+"null";
				 continue;
			 }
			/*获取文件扩展名*/
			/*索引加1的效果是只取xxx.jpg的jpg*/
			String extensionName = fileitem.substring(fileitem.lastIndexOf(".") + 1);
			//System.out.println("extensionName:" + extensionName);
			
			/*检查文件类型*/
			if (("," + fileExt.toLowerCase() + ",").indexOf("," + extensionName.toLowerCase() + ",") < 0){
				//out.println("{\"err\":\"不允许上传此类型的文件\",\"msg\":\"" + newFileName + "\"}");
				//return;
				if(urlstr.length()==0)urlstr="null";
				else if(urlstr.length()>0)urlstr=urlstr+"|"+"null";
				continue;
			}
		
			
			
			
			/*文件存储的相对路径*/
			String saveDirPath = baseFileDir + fileFolder + "/";
			//System.out.println("saveDirPath:" + saveDirPath);
			
			/*文件存储在容器中的绝对路径*/
			String pathExtension = "";
			if("swf".equals(extensionName)){
				pathExtension = "swf";
			}else if("avi".equals(extensionName)){
				pathExtension = "avi";
			}else{
				pathExtension = "image";
			}
			String saveFilePath = this.getServletConfig().getServletContext().getRealPath("") + baseFileDir + fileFolder + "/" + pathExtension + "/";
			//System.out.println("----------saveFilePath:" + saveFilePath);
			
			/*构建文件目录以及目录文件*/
			File fileDir = new File(saveFilePath);
			if (!fileDir.exists()) {fileDir.mkdirs();}
			
			/*重命名文件*/
			String filename = UUID.randomUUID().toString();
			String newurl=saveFilePath + filename + "." + extensionName;
			
			 java.net.URL url = new URL(fileitem);
//		     javax.imageio.Image src = javax.imageio.ImageIO.read(url);  
		     Image src = javax.imageio.ImageIO.read(url); 
		   HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
		   long len = urlConnection.getContentLength();
		   BufferedImage bi = null; 
		   bi = javax.imageio.ImageIO.read(url);
		   int[] a = new int[2]; 
		   if(bi!=null){
		   a[0]= bi.getWidth(); 
		   a[1] = bi.getHeight(); //获得 高度 
		
		   width=a[0];
		   height=a[1];
		   //System.out.println(width+"--------------"+height);
		   }
		   long size=0;
		   if(len>0){
		   size=len/1024;
		   }
			/*文件是否为空*/
			if (len == 0){
				//out.println("{\"err\":\"上传文件不能为空\",\"msg\":\"" + newFileName + "\"}");
				//return;
				if(urlstr.length()==0)urlstr="null";
				else if(urlstr.length()>0)urlstr=urlstr+"|"+"null";
				continue;
			}
			/*检查文件大小*/
			if (maxSize > 0 && len > maxSize){
				//out.println("{\"err\":\"上传文件的大小超出限制\",\"msg\":\"" + newFileName + "\"}");
				//return;
				if(urlstr.length()==0)urlstr="null";
				else if(urlstr.length()>0)urlstr=urlstr+"|"+"null";
				continue;
			}
			
		       //if(size<100 && a[0]<500){
		       // ImageIO.write(bi, extensionName, new File(newurl));
		       //}
		       //else{
//		     java.net.URL srcurl = new URL(srcurl);
//		     Image src = javax.imageio.ImageIO.read(temp);                      //构造Image对象
		    /* float tagsize=width;
		     int old_w=a[0];                                      //得到源图宽
		     int old_h=a[1];   
		     int new_w=0;
		     int new_h=0;                             //得到源图长
		     int tempsize;
		     float tempdouble; 
		     if(old_w>old_h){
		      tempdouble=old_w/tagsize;
		     }else{
		      tempdouble=old_h/tagsize;
		     }
		     new_w=Math.round(old_w/tempdouble);
		     new_h=Math.round(old_h/tempdouble);//计算新图长宽
		     System.out.println(new_w+"-------333-------"+new_h);*/
		     BufferedImage tag = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		     tag.getGraphics().drawImage(src,0,0,width,height,null);        //绘制缩小后的图
		    
		    // System.out.println("newurl:" + newurl);
		      String formatName = newurl.substring(newurl.lastIndexOf(".") + 1);  
		     /* FileOutputStream newimage=new FileOutputStream(newurl);           //输出到文件流
			     JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);       
			     encoder.encode(tag);                                                //近JPEG编码
			      newimage.close();   */
		    ImageIO.write(tag, /*"GIF"*/ formatName /* format desired */ , new File(newurl) /* target */ );
		       //} 
		    // if(urlstr.length()==0)urlstr=newFileName;
		     //if(urlstr.length()>0)urlstr+="|"+newFileName;
			
			String projectBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
			newFileName = "http://images1.d1.com.cn" + baseURLDir + fileFolder + "/" +pathExtension+ "/" + filename + "." + extensionName;		
			//newFileName =  baseURLDir + fileFolder + "/" +pathExtension+ "/" + filename + "." + extensionName;		

			
			//out.println("{\"err\":\"\",\"msg\":\"" + newFileName + "\"}");
			if(urlstr.length()==0)urlstr=newFileName;
			else if(urlstr.length()>0)urlstr=urlstr+"|"+newFileName;
		    // System.out.println("urlstr:" + urlstr);
			 }
			 out.println(urlstr);
		} catch (Exception ex) {
		//	System.out.println(ex.getMessage());
			//newFileName = "";
			//out.println("{\"err\":\"错误:"+ex.getMessage()+"\",\"msg\":\"" + newFileName + "\"}");
		}
%>

