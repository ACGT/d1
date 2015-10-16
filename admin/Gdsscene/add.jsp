<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加场景</title>
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
	   var gt=$('#gdsscene_title');
	   if(gt=='')
		   {
		   $('#gdsscene_title_notice').html('场景标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdsscene_title_notice').html('');
		   }
	   document.gdsscene.submit();
	     }
   
   function cancle()
   {
	   $("#gdsscene_serid").val('');
	   $("#gdsscene_title").val('');
	   $("#gdsscene_tail").val('');
	   $("#gdsscene_sort").val('');
	   $("#gdsscene_flag").val('1');
	   $("#gdscene_gdscode").val('');
	   $("#gdsscene_url").val('');
	   $("#gdscene_imgcode").val('');
	   
	   $("#gdsscene_serid").focus();
   }
</script>

</head>
<body>
<%
  String gdsserid="";
  if(request.getParameter("gdsserid")!=null&&request.getParameter("gdsserid").length()>0)
   {
	gdsserid=request.getParameter("gdsserid");
   }
  if("post".equals(request.getMethod().toLowerCase()))
  {
	  String gs="";
	  String gt="";
	  String gtail="";
	  String gs1="";
	  String gf="";
	  String gg="";
	  String gu="";
	  String gi="";
	  String gsc="";
	  String gc="";
	  String gstatus="";
	  String gscaldes="";
	  String glogo="";
	 //场景模式二下的变量
	 String gm="";
	 String bgcolor="";
	 String gdscolor="";
	 String overcolor="";
	 String modelbg="";
	  
	  String endimg="";
	  String endimg1="";
	  String endimg2="";
	  String endimgscal="";
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

	  			     if("gdsscene_serid".equals(fname)){
	  			    	 gs=fitem.getString("utf-8");
	  			     }
	  			     if("gdsscene_title".equals(fname)){
	  			    	 gt=fitem.getString("utf-8");
	  			     }
	  			     if("gdsscene_tail".equals(fname)){
	  			    	 gtail=fitem.getString("utf-8");
	  			     }
	  			     if("gdsscene_sort".equals(fname)){
	  			    	 gs1=fitem.getString("utf-8");
	  			     }
	  			     if("gdsscene_flag".equals(fname)){
	  			    	 gf=fitem.getString("utf-8");
	  			     }
		  			 if("gdsscene_url".equals(fname)){
		  			     gu=fitem.getString("utf-8");
		  			  }
			  		 if("gdscene_gdscode".equals(fname)){
		  			   	 gg=fitem.getString("utf-8");
		  			 }
		  			 if("gdscene_imgcode".equals(fname)){
	 			    	 gi=fitem.getString("utf-8");
	 			     }
		  			if("gdscene_scrollid".equals(fname)){
	 			    	 gsc=fitem.getString("utf-8");
	 			     }
		  			if("gdsscene_color".equals(fname))
		  			{
		  				gc=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_status".equals(fname))
		  			{
		  				gstatus=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_scaldes".equals(fname))
		  			{
		  				gscaldes=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_logo".equals(fname))
		  			{
		  				glogo=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_bgcolor".equals(fname))
		  			{
		  				bgcolor=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_gdscolor".equals(fname))
		  			{
		  				gdscolor=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_overcolor".equals(fname))
		  			{
		  				overcolor=fitem.getString("utf-8");
		  			}
		  			if("gdsscene_mode".equals(fname))
		  			{
		  				gm=fitem.getString("utf-8");
		  			}
		  			    
			     }
			     else{//如果是文件
			    	 size+=fitem.getSize();
			     
			     }
		    }
	  	 if(gs==null||gs.length()==0)
		  {
			  Tools.outJs(out, "系列编号不能为空", "back");
			  return;
		  }
		  if(!Tools.isMath(gs))
		  {
			  Tools.outJs(out, "系列编号格式不正确！", "back");
			  return;
		  }
		  if(gs!=null)
		  {
			  Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(gs);
			  if(gdsser==null)
			  {
				  Tools.outJs(out, "该系列为空,重新输入", "back");
				  return;
			  }
		  }
		  if(gt==null||gt.length()==0)
		  {
			  Tools.outJs(out, "场景标题不能为空", "back");
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
	  	    	
	  	    	 //System.out.print(count);
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
	  					String uploadPath =getUploadFilePath("gdscoll");
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
	  						endimg2=uploadFileName;
		  					if(endimg2.length()>0)
		  					{
		  					  endimg2 =endimg2.replace("/opt", "");
		  					}
	  					}
	  					else if(count==3)
	  					{
	  						endimgscal=uploadFileName;
	  						if(endimgscal.length()>0)
	  						{
	  							endimgscal=endimgscal.replace("/opt","");
	  						}
	  					}
	  					else
	  					{
	  						modelbg=uploadFileName;
	  						if(modelbg.length()>0)
	  						{
	  							modelbg=modelbg.replace("/opt","");
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
	  	    
	  	   
	  	   //添加场景
	  	 
		    Gdsscene gdsscene=new Gdsscene();
		    gdsscene.setGdsscene_createdate(new Date());
		    gdsscene.setGdsscene_flag(new Long(Tools.parseLong(gf)));
		    gdsscene.setGdsscene_gdserid(new Long(Tools.parseLong(gs)));
		    gdsscene.setGdsscene_sort(new Long(Tools.parseLong(gs1)));
			gdsscene.setGdsscene_tail(gtail);
			gdsscene.setGdsscene_title(gt);
            gdsscene.setGdsscene_imgurl(endimg);
            gdsscene.setGdsscene_url(gu);
            gdsscene.setGdscene_gdscode(gg);
            gdsscene.setGdsscene_gdscollid(gsc);
            gdsscene.setGdsscene_imgbg(endimg2);
            gdsscene.setGdsscene_color(gc);
            gdsscene.setGdsscene_status(new Long(Tools.parseLong(gstatus)));
            gdsscene.setGdsscene_scaldes(gscaldes);
            gdsscene.setGdsscene_scalimg(endimgscal);
            gdsscene.setGdsscene_logo(new Long(Tools.parseLong(glogo)));
            gdsscene.setGdsscene_bgcolor(bgcolor);
            gdsscene.setGdsscene_gdscolor(gdscolor);
            gdsscene.setGdsscene_overcolor(overcolor);
            gdsscene.setGdsscene_dpbgimg(modelbg);
            gdsscene.setGdsscene_mode(new Long(Tools.parseLong(gm)));
			gdsscene=(Gdsscene)Tools.getManager(Gdsscene.class).create(gdsscene);
		    if(gdsscene!=null){
		    	out.print("<script>alert('添加场景成功！');this.location.href='/admin/Gdsscene/add.jsp';</script>");
		    }else{
		    	
		    	out.print("<script>alert('添加场景失败！');this.location.href='/admin/Gdsscene/add.jsp';</script>");
		    }
		   } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
	  }


 

%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px;">
   <h1 style=" font-size:25px;">添加场景</h1>
   <a href="/admin/Gdsscene/gmanager.jsp" target="top">场景管理</a><br/>
   <form id="gdsscene" name="gdsscene" method="post" action="add.jsp" enctype="multipart/form-data">
   <table style=" margin:0px auto; font-size:14px;text-align:left;">
       <% if(gdsserid.length()>0)
    	   {%>
    	   <input type="hidden" id="gdsscene_serid" name="gdsscene_serid" value="<%= gdsserid %>"/>
    	   <tr><td>系列编号：</td><td><%= gdsserid %></td>
    	  <% }
       else
       {%>
    	   <tr><td>系列编号：</td><td><input type="text" id="gdsscene_serid" name="gdsscene_serid" style="width:60px;"/>&nbsp;&nbsp;<span id="gdsscene_serid_notice"></span></td></tr>
       <%}
    	  %>
        
        
        <tr><td>场景主题：</td><td><input type="text" id="gdsscene_title" name="gdsscene_title" />&nbsp;&nbsp;<span id="gdsser_title_notice"></span></td></tr>
        <tr><td>场景主图：</td><td><input type="file" id="gdsscene_imgurl" name="gdsscene_imgurl" /><span>场景页面上方显示的大图（大小：980*547）</span>
        </td></tr>
        <tr><td>场景状态：</td><td><select id="gdsscene_flag" name="gdsscene_flag">
                                          <option value="1">可显示</option>
                                          <option value="0">不显示</option>
                                    </select></td></tr>
       <tr><td>场景色系：</td><td><input type="text" id="gdsscene_color" name="gdsscene_color" /></td></tr>
       <tr><td>场景排序：</td><td><input type="text" id="gdsscene_sort" name="gdsscene_sort" />&nbsp;&nbsp;</td></tr>
       <tr><td>场景主图链接</td><td><input type="text" id="gdsscene_url" name="gdsscene_url" />&nbsp;&nbsp;<span>场景页面上方显示的大图跳转的页面</span></td></tr>
       <tr><td>搭配编号</td><td><input type="text" id="gdscene_scrollid" name="gdscene_scrollid"  width="200" height="100"/>&nbsp;&nbsp;<span>搭配编号，以“，”号隔开</span></td></tr>
       <tr><td>商品推荐</td><td><input type="text" id="gdscene_gdscode" name="gdscene_gdscode" />&nbsp;&nbsp;<span>场景页下面显示的商品列表</span></td></tr>
       <tr><td>场景描述：</td><td><input type="text" id="gdsscene_tail" name="gdsscene_tail" style="width:300px; height:200px;"/></td></tr>
       <tr><td>搭配背景图：</td><td><input type="file" id="gdsscene_imgbg" name="gdsscene_imgbg" /><span></span>
        </td></tr> 
       <tr><td>场景显示状态：</td><td><select id="gdsscene_status" name="gdsscene_status">
                                          <option value="0">不显示</option>
                                          <option value="1">显示</option>
                                          <option value="2">显示但不能点击</option>
                                    </select><span>场景页Logo位置控制缩略图的显示</span>
        </td></tr>        
        <tr><td>缩略图：</td><td><input type="file" id="gdsscene_scalimg" name="gdsscene_scalimg" /><span>场景的缩略图（请上传80*80的图）</span></td></tr>
        <tr><td>缩略图标题：</td><td><input type="text" id="gdsscene_scaldes" name="gdsscene_scaldes" /><span>场景的缩略图标题</span></td></tr>
        <tr><td>场景logo图的显示方式：</td><td><select id="gdsscene_logo" name="gdsscene_logo">
                                          <option value="0">美工作图</option>
                                          <option value="1">搭配浮层显示</option>
                                    </select></td></tr>
        
         <tr><td><span style="color:#f00;">以下选项是对场景模式二的控制</span></td></tr> 
         <tr><td>场景显示模式：</td><td><select id="gdsscene_mode" name="gdsscene_mode">
                                          <option value="1">模式一</option>
                                          <option value="2">模式二</option>
                                    </select></td></tr>
         <tr><td>整体背景颜色：</td><td><input type="text" id="gdsscene_bgcolor" name="gdsscene_bgcolor"/></td></tr>    
         <tr><td>商品背景颜色：</td><td><input type="text" id="gdsscene_gdscolor" name="gdsscene_gdscolor"/></td></tr> 
         <tr><td>鼠标掠过颜色：</td><td><input type="text" id="gdsscene_overcolor" name="gdsscene_overcolor"/></td></tr> 
         <tr><td>搭配背景图：</td><td><input type="file" id="gdsscene_dpbgimg" name="gdsscene_dpbgimg"/></td></tr>                       
         <tr><td colspan="2"><input type="button" value="添加" style="width:80px;" onclick="Check();"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
   </table>
     
   </form>
</div>
</body>
</html>





