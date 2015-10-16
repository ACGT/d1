<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>

<%

   String id="";
   if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
   {
	   id=request.getParameter("id");
   }
   if(id.length()<=0)
   {
	   return;
   }


  if("post".equals(request.getMethod().toLowerCase()))
  {
	  
	  String gs="";
	  String gt="";
	  String gtail="";
	  String gs1="";
	  String gf="";
	  String ids="";
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
		  			if("gdscene_color".equals(fname)){
	  			    	 gc=fitem.getString("utf-8");
	  			     }
	  			    if("id".equals(fname)){
	  			    	 ids=fitem.getString("utf-8");
	  			     }
	  			    if("gdscene_gdscollid".equals(fname)){
	 			    	 gsc=fitem.getString("utf-8");
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
	  	
	  	  Gdsscene gdsscene=(Gdsscene)Tools.getManager(Gdsscene.class).get(ids);
		  if(gdsscene==null)
		  {
			  Tools.outJs(out, "场景不存在", "back");
			  return;
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
	  					//System.out.print(count);
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
	  	    
	  	   
	  	   //修改场景
	  	 
		    
		    gdsscene.setGdsscene_flag(new Long(Tools.parseLong(gf)));
		    gdsscene.setGdsscene_gdserid(new Long(Tools.parseLong(gs)));
		    gdsscene.setGdsscene_sort(new Long(Tools.parseLong(gs1)));
			gdsscene.setGdsscene_tail(gtail);
			gdsscene.setGdsscene_title(gt);
			gdsscene.setGdscene_gdscode(gg);
			gdsscene.setGdsscene_url(gu);
			gdsscene.setGdsscene_gdscollid(gsc);
			gdsscene.setGdsscene_color(gc);
			gdsscene.setGdsscene_status(new Long(Tools.parseLong(gstatus)));
			gdsscene.setGdsscene_logo(new Long(Tools.parseLong(glogo)));
	        gdsscene.setGdsscene_scaldes(gscaldes);
	        gdsscene.setGdsscene_bgcolor(bgcolor);
            gdsscene.setGdsscene_gdscolor(gdscolor);
            gdsscene.setGdsscene_overcolor(overcolor);
            gdsscene.setGdsscene_mode(new Long(Tools.parseLong(gm)));
			if(endimg.length()>0)
			{
               gdsscene.setGdsscene_imgurl(endimg);
			}
			if(endimg2.length()>0)
			{
				gdsscene.setGdsscene_imgbg(endimg2);
			}
			if(endimgscal.length()>0)
			{
				gdsscene.setGdsscene_scalimg(endimgscal);
			}
			if(modelbg.length()>0)
			{
				gdsscene.setGdsscene_dpbgimg(modelbg);
			}
		    if(Tools.getManager(Gdsscene.class).update(gdsscene, false)){
		    	out.print("<script>alert('修改场景成功！');this.location.href='/admin/Gdsscene/gu.jsp?id="+id+"';</script>");
		    }else{
		    	
		    	out.print("<script>alert('修改场景成功！');this.location.href='/admin/Gdsscene/gu.jsp?id="+id+"';</script>");
		    }
		   } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
	  }


 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改场景</title>
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
	   var gs=$("#gdsscene_serid").val();
	   var gt=$("#gdsscene_title").val();
	   if(gs=='')
		   {
		   $('#gdsscene_serid_notice').html('系列编号不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdsscene_serid_notice').html('');
		    }
	   if(isNaN(gs))
		   {
		   $('#gdsscene_serid_notice').html('系列编号不是数字！');
		   return;
		   }
	   if(gt=='')
		   {
		   $('#gdsscene_title_notice').html('场景标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdsscene_title_notice').html('');
		   }
	   document.gdssceneupdate.submit();
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

<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;" >
   <h1 style=" font-size:25px;">修改场景</h1>
   <a href="add.jsp" target="bottom">添加场景</a>&nbsp;&nbsp;<a href="gmanager.jsp" target="top">场景管理</a><br/>
   <%
       Gdsscene gdsscene=(Gdsscene)Tools.getManager(Gdsscene.class).get(id);
       if(gdsscene!=null)
       {%><br/><br/>
    	   <div id="updatefl">
    	      <span>修改场景信息</span>
    	      <form id="gdssceneupdate" name="gdssceneupdate" method="post" action="gu.jsp?id=<%= id %>"  enctype="multipart/form-data">
			   <table style=" margin:0px auto; font-size:14px;text-align:left;">
			   <input type="hidden" id="id" name="id" value="<%= gdsscene.getId() %>"/>
			  <tr><td>系列编号：</td><td><input type="text" id="gdsscene_serid" name="gdsscene_serid" style="width:60px;" value="<%= gdsscene.getGdsscene_gdserid() %>"/>&nbsp;&nbsp;<span id="gdsscene_serid_notice"></span></td></tr>
		        <tr><td>场景主题：</td><td><input type="text" id="gdsscene_title" name="gdsscene_title" value="<%= gdsscene.getGdsscene_title() %>"/>&nbsp;&nbsp;<span id="gdsser_title_notice"></span></td></tr>
		        <tr><td>场景主图：</td><td><input type="file" id="gdsscene_imgurl" name="gdsscene_imgurl" /><a href="http://shopimg.d1.com.cn<%= gdsscene.getGdsscene_imgurl() %>" target="_blank">查看主图</a>
		        </td></tr>
		        <tr><td>场景状态：</td><td><select id="gdsscene_flag" name="gdsscene_flag">
		                                          <option value="1" <% if(gdsscene.getGdsscene_flag().longValue()==1) out.print("selected"); %>>可显示</option>
		                                          <option value="0" <% if(gdsscene.getGdsscene_flag().longValue()==0) out.print("selected"); %>>不显示</option>
		                                    </select></td></tr>
		        <tr><td>场景色系：</td><td><input type="text" id="gdscene_color" name="gdscene_color" value="<%= gdsscene.getGdsscene_color()%>"/></td></tr>
		         <tr><td>场景排序：</td><td><input type="text" id="gdsscene_sort" name="gdsscene_sort" value="<%= gdsscene.getGdsscene_sort() %>"/>&nbsp;&nbsp;</td></tr>
		         <tr><td>场景主图链接</td><td><input type="text" id="gdsscene_url" name="gdsscene_url" value="<%=gdsscene.getGdsscene_url() %>"/>&nbsp;&nbsp;</td></tr>
                 <tr><td>商品推荐</td><td><input type="text" id="gdscene_gdscode" name="gdscene_gdscode" value="<%= gdsscene.getGdscene_gdscode() %>"/>&nbsp;&nbsp;<span>场景页下面显示的商品列表</span></td></tr>
                 <tr><td>搭配编号</td><td><input type="text" id="gdscene_gdscollid" name="gdscene_gdscollid" width="200" height="100" value="<%= gdsscene.getGdsscene_gdscollid() %>"/>&nbsp;&nbsp;<span>搭配编号，以“，”号隔开</span></td></tr>
                 <tr><td>搭配背景图：</td><td><input type="file" id="gdsscene_imgbg" name="gdsscene_imgbg" /><span></span>
                 <tr><td>场景显示状态：</td><td><select id="gdsscene_status" name="gdsscene_status">
                                          <option value="0" <% if(gdsscene.getGdsscene_status().longValue()==0) out.print("selected"); %>>不显示</option>
                                          <option value="1" <% if(gdsscene.getGdsscene_status().longValue()==1) out.print("selected"); %>>显示</option>
                                          <option value="2" <% if(gdsscene.getGdsscene_status().longValue()==2) out.print("selected"); %>>显示但不能点击</option>
                                          </select><span>场景页Logo位置控制缩略图的显示</span>
                </td></tr>        
                <tr><td>缩略图：</td><td><input type="file" id="gdsscene_scalimg" name="gdsscene_scalimg" /><a href="http://shopimg.d1.com.cn<%= gdsscene.getGdsscene_scalimg() %>">查看缩略图</a><span>场景的缩略图（请上传80*80的图）</span></td></tr>
                <tr><td>缩略图标题：</td><td><input type="text" id="gdsscene_scaldes" name="gdsscene_scaldes" value="<%= gdsscene.getGdsscene_scaldes() %>"/><span>场景的缩略图标题</span></td></tr>
                <tr><td>场景logo图的显示方式：</td><td><select id="gdsscene_logo" name="gdsscene_logo">
                                          <option value="0" <% if(gdsscene.getGdsscene_logo().longValue()==0) out.print("selected"); %>>美工作图</option>
                                          <option value="1" <% if(gdsscene.getGdsscene_logo().longValue()==1) out.print("selected"); %>>搭配浮层显示</option>
                                    </select></td></tr>
                <tr><td>场景描述：</td><td><input type="text" id="gdsscene_tail" name="gdsscene_tail" style="width:300px; height:200px;" value="<%= gdsscene.getGdsscene_tail() %>"/></td></tr>
				 <tr><td><span style="color:#f00;">以下选项是对场景模式二的控制</span></td></tr> 
				 <tr><td>场景显示模式：</td><td><select id="gdsscene_mode" name="gdsscene_mode">
                                          <option value="1" <% if(gdsscene.getGdsscene_mode().longValue()==1) out.print("selected"); %>>模式一</option>
                                          <option value="2" <% if(gdsscene.getGdsscene_mode().longValue()==2) out.print("selected"); %>>模式二</option>
                                    </select></td></tr>
	         <tr><td>整体背景颜色：</td><td><input type="text" id="gdsscene_bgcolor" name="gdsscene_bgcolor" value="<%= gdsscene.getGdsscene_bgcolor() %>"/></td></tr>    
	         <tr><td>商品背景颜色：</td><td><input type="text" id="gdsscene_gdscolor" name="gdsscene_gdscolor" value="<%= gdsscene.getGdsscene_gdscolor() %>"/></td></tr> 
	         <tr><td>鼠标掠过颜色：</td><td><input type="text" id="gdsscene_overcolor" name="gdsscene_overcolor" value="<%= gdsscene.getGdsscene_overcolor() %>"/></td></tr> 
	         <tr><td>搭配背景图：</td><td><input type="file" id="gdsscene_dpbgimg" name="gdsscene_dpbgimg"/><a href="http://images1.d1.com.cn<%=gdsscene.getGdsscene_dpbgimg() %>" target="_blank">查看图片</a></td></tr>                       
	      
			 <tr><td colspan="2"><input type="button" value="修改" style="width:80px;" onclick="Check()"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
			   </table>
     
   			</form>
    	      
    	   </div>
       <%}
   %>
 
</div>
</body>
</html>





