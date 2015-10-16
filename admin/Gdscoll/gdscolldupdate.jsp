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
	  String gi="";
	  String gt="";
	  String gs1="";
	  String gf="";
	  String gu="";
	  String ids="";
	  String gif="";
	  String endimg="";
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

	  			     if("gdscolld_gdscollid".equals(fname)){
	  			    	 gs=fitem.getString("utf-8");
	  			     }
	  			     if("gdscolld_title".equals(fname)){
	  			    	 gt=fitem.getString("utf-8");
	  			     }
	  			     if("gdscolld_gdsid".equals(fname)){
	  			    	 gi=fitem.getString("utf-8");
	  			     }
	  			     if("gdscolld_sort".equals(fname)){
	  			    	 gs1=fitem.getString("utf-8");
	  			     }
	  			     if("gdscolld_flag".equals(fname)){
	  			    	 gf=fitem.getString("utf-8");
	  			     }
	  			   if("gdscolld_url".equals(fname)){
	  			    	 gu=fitem.getString("utf-8");
	  			     }
	  			 if("gdscolld_gdsflag".equals(fname)){
  			    	 gif=fitem.getString("utf-8");
  			        }
	  			 if("id".equals(fname)){
  			    	 ids=fitem.getString("utf-8");
  			     }
	  			    
			     }
			     else{//如果是文件
			    	 size+=fitem.getSize();
			     
			     }
		    }
	  	Gdscolldetail gdscolld=(Gdscolldetail)Tools.getManager(Gdscolldetail.class).get(ids);
	  	if(gdscolld==null)
	  	{
	  		Tools.outJs(out, "搭配商品不存在", "back");
			  return;
	  	}
	  	
	  	 if(gs==null||gs.length()==0)
		  {
			  Tools.outJs(out, "搭配编号不能为空", "back");
			  return;
		  }
		  if(!Tools.isMath(gs))
		  {
			  Tools.outJs(out, "搭配编号格式不正确！", "back");
			  return;
		  }
		  if(gs!=null)
		  {
			  Gdscoll gdsscene=(Gdscoll)Tools.getManager(Gdscoll.class).get(gs);
			  if(gdsscene==null)
			  {
				  Tools.outJs(out, "该搭配为空,重新输入", "back");
				  return;
			  }
		  }
		  if(gi==null||gi.length()==0)
		  {
			  Tools.outJs(out, "该商品编号不能为空", "back");
			  return;
		  }
		  Product p=(Product)Tools.getManager(Product.class).get(gi);
		  if(p==null)
		  {
			  Tools.outJs(out, "该商品不存在", "back");
			  return;
		  }
		  if(gt==null||gt.length()==0)
		  {
			  Tools.outJs(out, "搭配商品标题不能为空", "back");
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
	  					String uploadPath =getUploadFilePath("siteadmin");
	  					File fm=new File(uploadPath);
	  					if(!fm.exists())
	  					{
	  						fm.mkdirs();
	  					}
	  					String fileName = Tools.getDBDate()+(int)(Math.random()*10)+ext;//文件名
	  					//String photoName = "http://d1.com.cn/upload/"+ fileName;
	  					//name+=fileName+",";
	  					
	  					
	  					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
	  					//Tools.outJs(out, uploadFileName, "back");
	  				     endimg=uploadFileName;
	  				   if(endimg.length()>0)
	  					{
	  					  endimg =endimg.replace("/opt", "");
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
	  	    
	  	   
	  	   //修改搭配商品
	  	 
		    gdscolld.setGdscolldetail_flag(new Long(Tools.parseLong(gf)));
		    gdscolld.setGdscolldetail_gdscrollid(new Long(Tools.parseLong(gs)));
		    gdscolld.setGdscolldetail_sort(new Long(Tools.parseLong(gs1)));
		    gdscolld.setGdscolldetail_title(gt);
		    gdscolld.setGdscolldetail_url(gu);
		    gdscolld.setGdscolldetail_gdsid(gi);
		    gdscolld.setGdscolldetail_gdsflag(new Long(Tools.parseLong(gif)));
		    
			if(endimg.length()>0)
			{
				gdscolld.setGdscolldetail_otherimg(endimg);
			}
			
		    if(Tools.getManager(Gdscolldetail.class).update(gdscolld, true)){
		    	Tools.outJs(out, "修改搭配商品成功", "/admin/Gdscoll/gdscolldetailm.jsp");
		    }else{
		    	
		    	Tools.outJs(out, "修改搭配商品失败", "back");
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
<title>修改搭配商品</title>
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
	   var gs=$("#gdscolld_gdscollid").val();
	   var gi=$("#gdscolld_gdsid").val();
	   var gt=$("#gdscolld_title").val();
	   if(gs=='')
		   {
		   $('#gdscolld_gdscollid_notice').html('搭配编号不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdscolld_gdscollid_notice').html('');
		    }
	   if(isNaN(gs))
		   {
		   $('#gdscolld_gdscollid_notice').html('搭配编号不是数字！');
		   return;
		   }
	   if(gi=='')
		   {
		   $('#gdscolld_gdsid_notice').html('商品编号不能为空！');
		   return;
		   }
	   if(gt=='')
		   {
		   $('#gdscolld_title_notice').html('搭配商品标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdscolld_title_notice').html('');
		   }
	   document.gdscolldupdate.submit();
	     }
   
   function cancle()
   {
	   $("#gdscolld_gdscollid").val('');
	   $("#gdscolld_title").val('');
	   $("#gdscolld_gdsid").val('');
	   $("#gdscolld_sort").val('');
	   $("#gdscolld_flag").val('1');
	   
	   $("#gdscolld_gdscollid").focus();
   }
</script>

</head>
<body>

<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;" >
   <h1 style=" font-size:25px;">修改搭配商品</h1>
   <a href="addgdscolldetail.jsp">添加搭配商品</a>&nbsp;&nbsp;<a href="gdscolldetailm.jsp">搭配商品管理</a><br/>
   <%
       Gdscolldetail gdscolld=(Gdscolldetail)Tools.getManager(Gdscolldetail.class).get(id);
       if(gdscolld!=null)
       {%><br/><br/>
    	   <div id="updatefl">
    	      <span>修改搭配商品信息</span>
    	      <form id="gdscolldupdate" name="gdscolldupdate" method="post" action="gdscolldupdate.jsp?id=<%= id %>"  enctype="multipart/form-data">
			   <table style=" margin:0px auto; font-size:14px;text-align:left;">
			   <input type="hidden" id="id" name="id" value="<%= gdscolld.getId() %>"/>
			    <tr><td>搭配编号：</td><td><input type="text" id="gdscolld_gdscollid" name="gdscolld_gdscollid" style="width:60px;" value="<%= gdscolld.getGdscolldetail_gdscrollid().longValue() %>"/>&nbsp;&nbsp;<span id="gdscolld_gdscollid_notice"></span></td></tr>
		        <tr><td>商品编号：</td><td><input type="text" id="gdscolld_gdsid" name="gdscolld_gdsid" value="<%= gdscolld.getGdscolldetail_gdsid() %>" style="width:60px;"/>&nbsp;&nbsp;<span id="gdscolld_gdsid_notice"></span></td></tr>
		        
		        <tr><td>搭配商品主题：</td><td><input type="text" id="gdscolld_title" value="<%= gdscolld.getGdscolldetail_title() %>" name="gdscolld_title" />&nbsp;&nbsp;<span id="gdscolld_title_notice"></span></td></tr>
		        <tr><td>搭配商品链接：</td><td><input type="text" id="gdscolld_url" name="gdscolld_url" value="<%= gdscolld.getGdscolldetail_url() %>"/>
		        </td></tr>
		        <tr><td>搭配商品图片：</td><td><input type="file" id="gdscolld_otherimg" name="gdscoll_otherimg" /><a href="http://images1.d1.com.cn<%= gdscolld.getGdscolldetail_otherimg() %>" target="_blank">查看图片</a>
		        </td></tr>
		        <tr><td>搭配商品状态：</td><td><select id="gdscolld_flag" name="gdscolld_flag">
		                                          <option value="1" <% if(gdscolld.getGdscolldetail_flag().longValue()==1) out.print("selected"); %>>可显示</option>
		                                          <option value="0" <% if(gdscolld.getGdscolldetail_flag().longValue()==0) out.print("selected"); %>>不显示</option>
		                                    </select></td></tr>
		        <tr><td>是否商品图显示：</td><td><select id="gdscolld_gdsflag" name="gdscolld_gdsflag">
                                         <option value="1" <% if(gdscolld.getGdscolldetail_gdsflag().longValue()==1) out.print("selected"); %>>可显示</option>
                                          <option value="0" <% if(gdscolld.getGdscolldetail_gdsflag().longValue()==0) out.print("selected"); %>>不显示</option>
                                   
                                    </select></td></tr>
		       <tr><td>搭配商品排序：</td><td><input type="text" id="gdscolld_sort" name="gdscolld_sort" value="<%= gdscolld.getGdscolldetail_sort().longValue() %>"/>&nbsp;&nbsp;</td></tr>
		       
                  <tr><td colspan="2"><input type="button" value="修改" style="width:80px;" onclick="Check()"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
			   </table>
     
   			</form>
    	      
    	   </div>
       <%}
       else
       {%>
    	 该搭配商品不存在，<a href="gdscolldetailm.jsp">返回搭配商品管理</a>  
       <%}
   %>
 
</div>
</body>
</html>





