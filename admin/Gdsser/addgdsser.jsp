<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加系列</title>
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
	  
	   var gt=$("#gdsser_title").val();	   
	   
	   if(gt=='')
		   {
		   $('#gdsser_title_notice').html('系列标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdsser_title_notice').html('');
		   }
	   document.gdsser.submit();
	     }
   
   function cancle()
   {
	  
	   $("#gdsser_title").val('');
	   $("#gdsser_tail").val('');
	   $("#gdsser_sort").val('');
	   $("#gdsser_flag").val('1');
	   $("#gdsser_brand").focus();
   }
</script>

</head>
<body>
<%
  if("post".equals(request.getMethod().toLowerCase()))   
  {
	 
	  String gb="";
	  String gt="";
	  String gtail="";
	  String gs="";
	  String gf="";
	  String endimg="";
	  String endimg1="";
	  String endimg2="";
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

	  			     if("gdsser_brandid".equals(fname)){
	  			    	 gb=fitem.getString("utf-8");
	  			     }
	  			     if("gdsser_title".equals(fname)){
	  			    	 gt=fitem.getString("utf-8");
	  			     }
	  			     if("gdsser_tail".equals(fname)){
	  			    	 gtail=fitem.getString("utf-8");
	  			     }
	  			     if("gdsser_sort".equals(fname)){
	  			    	 gs=fitem.getString("utf-8");
	  			     }
	  			     if("gdsser_flag".equals(fname)){
	  			    	 gf=fitem.getString("utf-8");
	  			     }
		  			 
			     }
			     else{//如果是文件
			    	 size+=fitem.getSize();
			     
			     }
		    }
	  	 
		  
		  if(gt==null||gt.length()==0)
		  {
			  Tools.outJs(out, "系列标题不能为空", "back");
			  return;
		  }
		  if(gs!=null&&gs.length()>0&&!Tools.isMath(gs))
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
	  					//上传图片路径
	  					String uploadPath =getUploadFilePath("siteadmin");
	  					File fm=new File(uploadPath);
	  					if(!fm.exists())
	  					{
	  						fm.mkdirs();
	  					}
	  					
	  					String fileName = Tools.getDBDate()+(int)(Math.random()*10)+count+ext;//文件名
	  					//String photoName = "http://d1.com.cn/upload/"+ fileName;
	  					//name+=fileName+",";
	  					
	  					
	  					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
	  					//Tools.outJs(out, uploadFileName, "back");
	  					if(count==1)
	  					{
		  					endimg=uploadFileName;
		  					if(endimg.length()>0)
		  					{
		  					  endimg =endimg.replace("/opt", "");
		  					}
	  					}
	  					else if(count==2) 
	  					{
	  						endimg1=uploadFileName;
		  					if(endimg1.length()>0)
		  					{
		  					  endimg1 =endimg1.replace("/opt", "");
		  					}
	  					}
	  					else
	  					{
	  						endimg2=uploadFileName;
		  					if(endimg2.length()>0)
		  					{
		  					  endimg2 =endimg2.replace("/opt", "");
		  					}
	  					}
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
	  	  Gdsser g=new Gdsser();
		  g.setGdsser_brandid(gb);
		  g.setGdsser_createdate(new Date());
		  g.setGdsser_flag(new Long(Tools.parseLong(gf)));
		  g.setGdsser_sort(new Long(Tools.parseLong(gs)));
		  g.setGdsser_tail(gtail);
		  g.setGdsser_title(gt);
		  g.setGdsser_img(endimg);
		  g.setGdsser_timg(endimg1);
		  g.setGdsser_imgbg(endimg2);
		  g=(Gdsser)Tools.getManager(Gdsser.class).create(g);
		  if(g!=null)
		  {
			  Tools.outJs(out, "添加系列成功！", "/admin/Gdsser/addgdsser.jsp");
		  }
	  	 } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
}


%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加系列</h1>
   <a href="gdssermanager.jsp">系列管理</a><br/>
   <form id="gdsser" name="gdsser" method="post" action="addgdsser.jsp" enctype="multipart/form-data">
   <table style=" margin:0px auto; font-size:14px;text-align:left;">
        <tr><td>品牌编号：</td><td>
        <select id="gdsser_brandid" name="gdsser_brandid">
                                          <option value="987">FeelMind</option>
                                          <option value="1690">小栗舍</option>
                                          <option value="1969">诗若漫</option>
                                          <option value="1864">YOUSOO</option>
                                    </select>
        &nbsp;&nbsp;<span id="gdsser_brandid_notice"></span></td></tr>
        <tr><td>系列主题：</td><td><input type="text" id="gdsser_title" name="gdsser_title" />&nbsp;&nbsp;<span id="gdsser_title_notice"></span></td></tr>
        <tr><td>系列排序：</td><td><input type="text" id="gdsser_sort" name="gdsser_sort" style="width:40px;"/>&nbsp;&nbsp;</td></tr>
        <tr><td>系列状态：</td><td><select id="gdsser_flag" name="gdsser_flag">
                                          <option value="1">可显示</option>
                                          <option value="0">不显示</option>
                                    </select></td></tr>
         <tr><td>系列背景图：</td><td><input type="file" id="gdsser_img" name="gdsser_img"/><span>搭配页面右侧显示的大图（大小：767*496）</span></td></tr>
         <tr><td>系列标题图：</td><td><input type="file" id="gdsser_timg" name="gdsser_timg"/><span>搭配页面左侧上方显示的图（大小：286*231）</span></td></tr>
         <tr><td>所属系列商品背景图：</td><td><input type="file" id="gdsser_imgbg" name="gdsser_imgbg"/><span>品牌馆的商品背景图</span></td></tr>
        
         <tr><td>系列描述：</td><td><input type="text" id="gdsser_tail" name="gdsser_tail" style="width:300px; height:200px;"/></td></tr>
                  <tr><td colspan="2"><input type="button" value="添加" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





