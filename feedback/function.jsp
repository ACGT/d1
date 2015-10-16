<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%!
/**
 * 判断是否是座机号码
 * @param str - String
 * @return true or false

 boolean isTel(String str){
	if(str == null || str.length()!=11) return false;
	return Pattern.matches("^(\\d{3}\\-\\d{8})|(\\d{4}\\-\\d{7})$", str);
} */
%>
<%
String name="";
Long size=0l;
String username="";
String orderid="";
String tel="";
String email="";
String type="";
String content="";
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
		     if("huid".equals(fname)){
		    	 username=fitem.getString("utf-8");
		     }
		     if("txtorderid".equals(fname)){
		    	 orderid=fitem.getString("utf-8");
		     }
		     if("txttele".equals(fname)){
		    	 tel=fitem.getString("utf-8");
		     }
		     if("txtemail".equals(fname)){
		    	 email=fitem.getString("utf-8");
		     }
		     if("htype".equals(fname)){
		    	 type=fitem.getString("utf-8");
		     }
		     if("txtcontent".equals(fname)){
		    	 content=fitem.getString("utf-8");
		     }
		    
		     }
		     else{//如果是文件
		    	 size+=fitem.getSize();
		     
		     }
	    }
	    if(Tools.isNull(username)){
	    	Tools.outJs(out,"用户名/Email不能为空！","back");
			return;
	    }
	    User user = UserHelper.getByUsername(username);
		if(user == null){
			Tools.outJs(out,"此用户名/Email不存在！","back");
			return;
		}
		if(!Tools.isNull(orderid)){
			if(orderid.trim().length()!=12 || (!Tools.isMath(orderid))){
				Tools.outJs(out,"订单号12位数！","back");
				return;	
			}
		}
		 if(tel != null) tel = tel.trim();
		 /*
			if((!Tools.isMobile(tel)) && (!isTel(tel))){
				Tools.outJs(out,"联系电话输入不正确!","back");
				return;
			}
		 */
	    if(!Tools.isNull(email)){
			if(!Tools.isEmail(email)){
				Tools.outJs(out,"邮箱地址格式有误，请修改","back");
				return;
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
					if((!ext.equals(".jpg")) && (!ext.equals(".jepg")) && (!ext.equals(".gif")) && (!ext.equals(".png")) && (!ext.equals(".bmp")) && (!ext.equals(".psd") && (!ext.equals(".tiff")))){
						Tools.outJs(out,"请上传图片格式的文件","back");
						return;
					}
					String uploadPath = Const.PROJECT_PATH + "upload/";
					String fileName = Tools.getDBDate()+ext;//文件名
					//String photoName = "http://d1.com.cn/upload/"+ fileName;
					name+=fileName+",";
					
					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
					//创建一个待写文件 
					File uploadedFile = new File(uploadFileName);
					//写入 
					//out.print(uploadFileName);
					fitem.write(uploadedFile);
					//out.print("<script>alert('上传成功！')</script>");
	    	  }
	    	 
	      }
	     }
	    }
	    if(name.endsWith(",")){
	    	name=name.substring(0,name.length()-1);
	    }
	    Feedback feedback=new Feedback();
	    String mbrid="";
		if(lUser!=null){
			mbrid=lUser.getId();
		}
		//out.print(content);
		feedback.setFeedback_mbrid(mbrid);
	    feedback.setFeedback_uid(username);
	    feedback.setFeedback_orderid(orderid);
	    feedback.setFeedback_phone(tel);
	    feedback.setFeedback_email(email);
	    feedback.setFeedback_type(new Long(type));
	    feedback.setFeedback_content(content);
	    feedback.setFeedback_attach(name);
	    feedback.setFeedback_isceo(new Long(0));
	    feedback.setFeedback_createdtime(new Date());
	    feedback.setFeedback_replaystatus(new Long(0));
	    feedback.setFeedback_operater("");
	    feedback.setFeedback_replaycontent("");
	    feedback.setFeedback_replaydate(null);

	   feedback=(Feedback)Tools.getManager(Feedback.class).create(feedback);
	    if(feedback!=null){
	    	// out.print("<script>window.open('sucess.jsp?sucesstype=yhfk')<script>");
	    	response.sendRedirect("sucess.jsp?sucesstype=yhfk");
	    	out.print("sucess");
	    }else{
	    	
	    	 out.print("fail"); 
	    }
	   } catch (Exception e) {
		   out.print("fail");
	    e.printStackTrace();
	    return;
	   }
}


%>



