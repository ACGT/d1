<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加搭配</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/head2012.css")%>" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;}
  input{ width:250px;}
  span{ color:#f00;}
</style>
<script type="text/javascript" language="javascript">
   function Check()
   {	   
	   document.gdscoll.submit();
	     }
   
   function cancle()
   {
	   $("#gdscoll_sceneid").val('');
	   $("#gdscoll_serid").val('');
	   $("#gdscoll_title").val('');
	   $("#gdscoll_tail").val('');
	   $("#gdscoll_sort").val('');
	   $("#gdscoll_flag").val('1');
	   
	 
   }
</script>

</head>
<body>
<%

  if("post".equals(request.getMethod().toLowerCase()))
  {
	  String gs="";
	  String gt="";
	  String gtail="";
	  String gs1="";
	  String gf="";
	  String gss="";
	  String gb="";
	  String g1="";
	  String g2="";
	  String g3="";
	  
	  
	  
	 
	  String bigendimg="";
	  
	  String cjimg="";
	  String smallimg="";
	  String cjimg1="";
	    String ppimg="";
	    
	    Long size=0l;
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

	  			     if("gdscoll_serid".equals(fname)){
	  			    	 gs=fitem.getString("utf-8");
	  			     }
	  			     if("gdscoll_title".equals(fname)){
	  			    	 gt=fitem.getString("utf-8");
	  			     }
	  			     if("gdsscoll_tail".equals(fname)){
	  			    	 gtail=fitem.getString("utf-8");
	  			     }
	  			     if("gdscoll_sort".equals(fname)){
	  			    	 gs1=fitem.getString("utf-8");
	  			     }
	  			     if("gdscoll_flag".equals(fname)){
	  			    	 gf=fitem.getString("utf-8");
	  			     }
	  			     if("gdscoll_imgposition".equals(fname)){
	  			    	 g1=fitem.getString("utf-8");
	  			     }
	  			     if("gdscoll_imgposition".equals(fname)){
	  			    	 g2=fitem.getString("utf-8");
	  			     }
	  			 if("gdscoll_cate".equals(fname)){
  			    	 g3=fitem.getString("utf-8");
  			     }
	  			    
	  			    
			     }
			     else{//如果是文件
			    	 size+=fitem.getSize();
			     
			     }
		    }
	  	 
		  
		  if(gss!=null&&gss.length()>0)
		  {
			  Gdsser gdsscene=(Gdsser)Tools.getManager(Gdsser.class).get(gss);
			  if(gdsscene==null)
			  {
				  Tools.outJs(out, "该系列为空,重新输入", "back");
				  return;
			  }
		  }
		  if(gt==null||gt.length()==0)
		  {
			  Tools.outJs(out, "搭配标题不能为空", "back");
			  return;
		  }
		  if(gs1!=null&&gs1.length()>0&&!Tools.isMath(gs1))
		  {
			  Tools.outJs(out, "排序格式不正确！", "back");
			  return;
		  }
	  	    
	  		if(size>1024*1024*10){
	  			Tools.outJs(out,"您上传的附件总大小超过10M","back");
	  			return;
	  		}
	  		  List items2 = upload.parseRequest(request);
	  		    Iterator it2 = items.iterator();
	  		int count=0;
	  	    while(it2.hasNext()){
	  	     FileItem fitem = (FileItem)it2.next();
	  	     if(!fitem.isFormField()){
	  	    	 count++;
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
	  					String uploadPath =getUploadFilePath("gdscoll");
	  					File fm=new File(uploadPath);
	  					if(!fm.exists())
	  					{
	  						fm.mkdirs();
	  					}
	  					
	  					String fileName = Tools.getDBDate()+(int)(Math.random()*10)+"_"+count+ext;//文件名
	  					//String photoName = "http://d1.com.cn/upload/"+ fileName;
	  					//name+=fileName+",";
	  					
	  					
	  					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
	  					//Tools.outJs(out, uploadFileName, "back");
	  					if(count==1)
	  					{
	  					   bigendimg=uploadFileName;
	  					   if(bigendimg.length()>0)
	  					   {
	  						
	  						   
	  						    bigendimg = bigendimg.replace("/opt", "");	
	  						   
	  					   }
	  					}
	  					else
	  					{
	  						cjimg=uploadFileName;
	  						 if(cjimg.length()>0)
		  					   {
		  						 cjimg =cjimg.replace("/opt", "");
		  					   }
	  					}
	  					
	  					//创建一个待写文件 
	  					File uploadedFile = new File(uploadFileName);
	  					//写入 
	  					//out.print(uploadFileName);
	  					fitem.write(uploadedFile);
	  					//out.print("<script>alert('上传成功！')</script>");
	  					 if(ImageUtil.resizeImage1(uploadFileName, "_s", 104, 150))
	  						{
						    	//System.out.print("1111");
						    	smallimg=bigendimg.substring(0,bigendimg.indexOf("."))+"_s"+ext;
	  						}
						    if(ImageUtil.resizeImage1(uploadFileName, "_p", 243, 350))
						    {
						    	ppimg=bigendimg.substring(0,bigendimg.indexOf("."))+"_p"+ext;
						    } 
						    if(ImageUtil.resizeImage1(uploadFileName, "_c", 285, 411))
						    {
						    	cjimg1=bigendimg.substring(0,bigendimg.indexOf("."))+"_c"+ext;
						    } 
						    smallimg = smallimg.replace("/opt", "");
  						    ppimg = ppimg.replace("/opt", "");
  						  cjimg1=cjimg1.replace("/opt", "");
  				  	    
	  	    	  }
	  	    	 
	  	      }
	  	     }
	  	    }
	  	   
	  	   
	  	   
	  	   //添加搭配
	  	   
		    Gdscoll gdscoll=new Gdscoll();
		    gdscoll.setGdscoll_createdate(new Date());
		    gdscoll.setGdscoll_flag(new Long(Tools.parseLong(gf)));
		    gdscoll.setGdscoll_sort(new Long(Tools.parseLong(gs1)));
		    gdscoll.setGdscoll_tail(gtail);
		    gdscoll.setGdscoll_title(gt);
		    gdscoll.setGdscoll_bigimgurl(bigendimg);
		    gdscoll.setGdscoll_smallimgurl(smallimg);
		    gdscoll.setGdscoll_indextitle(cjimg);
		    gdscoll.setGdscoll_serid(new Long(Tools.parseLong(gs)));
		    gdscoll.setGdscoll_brandimg(ppimg);
		    gdscoll.setGdscoll_czimg(cjimg1);
		    gdscoll.setGdscoll_imgposition(new Long(Tools.parseLong(g1)));
		    gdscoll.setGdscoll_textposition(new Long(Tools.parseLong(g2)));
		    gdscoll.setGdscoll_cate(new Long(Tools.parseLong(g3)));
		    gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).create(gdscoll);
		    if(gdscoll!=null){
		    	Tools.outJs(out, "添加搭配成功", "/admin/Gdscoll/addGdscoll.jsp");
		    }else{
		    	
		    	Tools.outJs(out, "添加搭配失败", "back");
		    }
		   } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
	  }


 

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加搭配</h1>
   <a href="http://www.d1.com.cn/admin/Gdscoll/gdscollmanager.jsp">搭配管理</a><br/>
   <form id="gdscoll" name="gdscoll" method="post" action="addGdscoll.jsp" enctype="multipart/form-data">
   <table style=" margin:0px auto; font-size:14px;text-align:left;">
      
        	
        <tr><td>系列编号：</td><td><input type="text" id="gdscoll_serid" name="gdscoll_serid" style="width:60px;"/></td></tr>
        <tr><td>搭配主题：</td><td><input type="text" id="gdscoll_title" name="gdscoll_title" />&nbsp;&nbsp;<span id="gdscoll_title_notice"></span></td></tr>
        <tr><td>搭配大图：</td><td><input type="file" id="gdscoll_bigimgurl" name="gdscoll_bigimgurl" /><span>搭配页面上方显示的大图（大小：767*496，背景透明）</span>
        </td></tr>
       
        <tr><td>搭配类别：<select id="gdscoll_cate" name="gdscoll_cate">
                                          <option value="1">男</option>
                                          <option value="2">女</option>
                                          <option value="3">情侣</option>
                                    </select></td></tr>
        <tr><td>搭配状态：</td><td><select id="gdscoll_flag" name="gdscoll_flag">
                                          <option value="1">可显示</option>
                                          <option value="0">不显示</option>
                                    </select></td></tr>
        <tr><td>搭配排序：</td><td><input type="text" id="gdscoll_sort" name="gdscoll_sort" />&nbsp;&nbsp;</td></tr>
        <tr><td>场景图：</td><td><input type="file" id="gdscoll_indextitle" name="gdscoll_indextitle" /><span>场景页面显示的搭配图（注：如果此搭配没有用于场景，不用添加）大小：361*413</span>
        </td></tr>
        
        <tr><td>搭配图片位置：</td><td><select id="gdscoll_imgposition" name="gdscoll_imgposition">
                                          <option value="0">左侧</option>
                                          <option value="1">右侧</option>
                                    </select></td></tr>
         <tr><td>文字描述位置：</td>
         <td><select id="gdscoll_textposition" name="gdscoll_textposition">
                                          <option value="1">右侧</option>
                                          <option value="0">左侧</option>
                                    </select></td></tr>
        <tr><td>搭配描述：</td><td><input type="text" id="gdscoll_tail" name="gdscoll_tail" style="width:300px; height:200px;"/></td></tr>
                  <tr><td colspan="2"><input type="button" value="添加" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





