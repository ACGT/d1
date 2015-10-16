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
   String brandid="";
   if(request.getParameter("bid")!=null&&request.getParameter("bid").length()>0)
   {
	   brandid=request.getParameter("bid");
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系列管理</title>
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
	   document.gdsserupdate.submit();
	     }
function cancle()
{
	$("#gdsser_brandid").val('');
	   $("#gdsser_title").val('');
	   $("#gdsser_tail").val('');
	   $("#gdsser_sort").val('');
	   $("#gdsser_flag").val('1');
	   $("#gdsser_brand").focus();
}

function deleteGdsser(id)
{
	$.confirm('确定要删除该系列吗？','提示',function(){
		 $.ajax({
		        type: "post",
		        dataType: "json",
		        url: "/ajax/notice/deletegdsser.jsp",
		        cache: false,
		        data:{id:id},
		        error: function(XmlHttpRequest){
		            alert("删除失败！");
		        },
		        success: function(json){
		        		$.alert(json.message,'提示',function(){
		        		this.location.href="/admin/Gdsser/gdssermanager.jsp";
		        		});
		        },beforeSend: function(){
		        }
		    });	
	});
}


</script>

</head>
<body>
<%
String ggURL = Tools.addOrUpdateParameter(request,null,null);
  if("post".equals(request.getMethod().toLowerCase()))   
  {
	  String gb="";
	  String gt="";
	  String gtail="";
	  String gs="";
	  String gf="";
	  String ids="";
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
	  			     if("id".equals(fname))
	  			     {
	  			    	 ids=fitem.getString("utf-8");
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
	  	  
	  	  //System.out.print(ids);
		  Gdsser gg=(Gdsser)Tools.getManager(Gdsser.class).get(ids);
		  if(gg!=null)
		  {
			  gg.setGdsser_brandid(gb);
			  gg.setGdsser_flag(new Long(Tools.parseLong(gf)));
			  gg.setGdsser_sort(new Long(Tools.parseLong(gs)));
			  gg.setGdsser_tail(gtail);
			  gg.setGdsser_title(gt);
			  if(endimg!=null&&endimg.length()>0)
			  {
				  gg.setGdsser_img(endimg);
			  }
			  if(endimg1!=null&&endimg1.length()>0)
			  {
				  gg.setGdsser_timg(endimg1);
			  }
			  if(endimg2!=null&&endimg2.length()>0)
			  {
				  gg.setGdsser_imgbg(endimg2);
			  }
			  String locations="";
			  if(brandid.length()>0)
			  {
				  locations="/admin/Gdsser/gdssermanager.jsp"+"?&bid="+brandid;
			  }
			  else
			  {
				  locations="/admin/Gdsser/gdssermanager.jsp";
			  }
			  if(Tools.getManager(Gdsser.class).update(gg,true))
			  {
				  Tools.outJs(out, "修改成功！",locations);
			  }
			  else
			  {
				  Tools.outJs(out, "修改失败！",locations);
			  }
		  }
		  else
		  {
			  Tools.outJs(out, "该系列不存在，不能修改！","/admin/Gdsser/gdssermanager.jsp");
		  }
	  	 } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
	 
  }


%>
<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;">
   <h1 style=" font-size:25px;">系列管理</h1>
   <a href="addgdsser.jsp">添加系列</a><br/>
   <%
      ArrayList<Gdsser> list=new ArrayList<Gdsser>();
      list=GdsserHelper.getGdsserByBrandid("");
      
      //分页
      int pageno1=1;
      
      if(ggURL != null) 
      	   {
      	     ggURL.replaceAll("pageno1=[0-9]*","");
      	   }
      //翻页
        int totalLength1 = (list != null ?list.size() : 0);
        int PAGE_SIZE = 15 ;
        int currentPage1 = 1 ;
        String pg1 ="1";
        if(request.getParameter("pageno1")!=null)
        {
        	pg1= request.getParameter("pageno1");
        }
      
        if(StringUtils.isDigits(pg1))currentPage1 = Integer.parseInt(pg1);
        PageBean pBean1 = new PageBean(totalLength1,PAGE_SIZE,currentPage1);
        int end1 = pBean1.getStart()+PAGE_SIZE;
        if(end1 > totalLength1) end1 = totalLength1;
        
      	String pageURL1 = ggURL.replaceAll("pageno1=[^&]*","");
      	if(!pageURL1.endsWith("&")) pageURL1 = pageURL1 + "&";
      if(list!=null&&list.size()>0)
      {%>
      <table style="margin:0px auto;text-align:center; border:solid 1px #f4f4f4;"  border="0" cellspcing="0" cellpadding="0">
         
         <tr style="background:#f4f4f4; color:#333"><td width="80">编号</td><td width="80">品牌编号</td><td width="100">品牌标题</td><td width="200">系列标题</td><td width="120">排序</td><td width="80">是否显示</td><td width="80">系列背景图</td><td width="80">系列标题图</td><td width="80">商品背景图</td><td width="90">操作</td></tr>
    	 <% 
    	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
    	  {
	    	  Gdsser fl=list.get(i);
    		  if(fl!=null)
    		  {%>
    			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td><%= fl.getId() %></td>
    			<%
    			    if(fl.getGdsser_brandid()!=null&&fl.getGdsser_brandid().length()>0)
    			    {
    			    	Brand b=(Brand)Tools.getManager(Brand.class).get(fl.getGdsser_brandid().toString());
    			    	if(b!=null)
    			    	{
    			    		out.print("<td>"+b.getId()+"</td><td>"+b.getBrand_name()+"</td>");
    			    	}
    			    	else
    			    	{
    			    		out.print("<td></td><td></td>");
    			    	}
    			    }
    			    else
			    	{
			    		out.print("<td></td><td></td>");
			    	}
    			%>
    			<td><%= fl.getGdsser_title() %></td><td><%= fl.getGdsser_sort() %></td>
    			<td>
    			<%
    			    if(fl.getGdsser_flag().longValue()==1)
    			    {
    			    	out.print("显示");
    			    }
    			    else
    			    {
    			    	out.print("不显示");
    			    }
    			   
    			%>
    			</td>
    			<td><a href="http://images1.d1.com.cn/<%= fl.getGdsser_img() %>" target="_blank">查看图片</a></td>
    			<td><a href="http://images1.d1.com.cn/<%= fl.getGdsser_timg() %>" target="_blank">查看图片</a></td>
    			<td><a href="http://images1.d1.com.cn/<%= fl.getGdsser_imgbg() %>" target="_blank">查看图片</a></td>
    			
    			<td><a href="gdssermanager.jsp?id=<%=fl.getId() %><% if(brandid.length()>0) out.print("&bid="+brandid); %>" >修改</a>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="deleteGdsser('<%= fl.getId() %>')">删除</a>
    			</td>
    			</tr>  
    		  <%}
    	  }%>
    	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="6" height="45">
					           <span class="GPager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
					           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
					           		if(i==currentPage1){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean1.hasNextPage()){%><a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
					           </span> </td>
				     </tr><%}%>	
     </table>
      <%}
      else
      {%>
    	  还没有系列，<a href="/adming/Gdsser/addgdsser.jsp">马上去添加</a>  
      <%}
   
   %>
 
 
   
   <%
       Gdsser gdsser=(Gdsser)Tools.getManager(Gdsser.class).get(id);
       if(gdsser!=null)
       {%><br/><br/>
    	   <div id="updatefl">
    	      <span>修改系列信息</span>
    	      <form id="gdsserupdate" name="gdsserupdate" method="post" action="gdssermanager.jsp<% if(brandid.length()>0) out.print("?bid="+brandid); %>" onsubmit="Check();" enctype="multipart/form-data">
			   <table style=" margin:0px auto; font-size:14px;text-align:left;">
			   <input type="hidden" id="id" name="id" value="<%= gdsser.getId() %>"/>
			        <tr><td>编号：</td><td><%= gdsser.getId() %></td></tr>
			        <tr><td>品牌编号：</td><td>
			         <select id="gdsser_brandid" name="gdsser_brandid">
                                          <option value="987" <% if(gdsser.getGdsser_brandid().equals("987")) out.print("selected"); %>>FeelMind</option>
                                          <option value="1690" <% if(gdsser.getGdsser_brandid().equals("1690")) out.print("selected"); %>>小栗舍</option>
                                          <option value="1969" <% if(gdsser.getGdsser_brandid().equals("1969")) out.print("selected"); %>>诗若漫</option>
                                          <option value="1864" <% if(gdsser.getGdsser_brandid().equals("1864")) out.print("selected"); %>>YOUSOO</option>
                                    </select>
			        &nbsp;&nbsp;<span id="gdsser_brandid_notice"></span></td></tr>
			        <tr><td>系列主题：</td><td><input type="text" id="gdsser_title" name="gdsser_title" value="<%= gdsser.getGdsser_title() %>"/>&nbsp;&nbsp;<span id="gdsser_title_notice"></span></td></tr>
                    <tr><td>系列排序：</td><td><input type="text" id="gdsser_sort" name="gdsser_sort" style="width:40px;" value="<%= gdsser.getGdsser_sort() %>"/>&nbsp;&nbsp;</td></tr>
                    <tr><td>系列状态：</td><td><select id="gdsser_flag" name="gdsser_flag">
                                          <option value="1" <% if(gdsser.getGdsser_flag().longValue()==1) out.print("selected"); %>>可显示</option>
                                          <option value="0" <% if(gdsser.getGdsser_flag().longValue()==0) out.print("selected"); %>>不显示</option>
                                    </select></td></tr>
                     <tr><td>系列背景图：</td><td><input type="file" id="gdsser_img" name="gdsser_img"/><a href="http://images1.d1.com.cn/<%= gdsser.getGdsser_img() %>" target="_blank">查看图片</a></td></tr>
                      <tr><td>系列标题图：</td><td><input type="file" id="gdsser_timg" name="gdsser_timg"/><a href="http://images1.d1.com.cn/<%= gdsser.getGdsser_timg() %>" target="_blank">查看图片</a></td></tr>
                     <tr><td>所属系列商品背景图：</td><td><input type="file" id="gdsser_imgbg" name="gdsser_imgbg"/><a href="http://images1.d1.com.cn/<%= gdsser.getGdsser_imgbg() %>" target="_blank">查看图片</a></td></tr>
        
                    <tr><td>系列描述：</td><td><input type="text" id="gdsser_tail" name="gdsser_tail" style="width:300px; height:200px;" value="<%= gdsser.getGdsser_tail() %>"/></td></tr>
                  
			                  <tr><td colspan="2"><input type="submit" value="修改" style="width:80px;"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
			   </table>
     
   			</form>
    	      
    	   </div>
       <%}
   %>
     
      
  
     
</div>
</body>
</html>





