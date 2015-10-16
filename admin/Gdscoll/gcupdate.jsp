<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/public.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*"%>
<%!
//获取最大情侣编号
private  static Long getGdscollBybgid()
{
	
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("gdscoll_bgid"));
	List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 1);
	if(blist!=null&&blist.size()>0)
	{
		for(BaseEntity b:blist)
		{
			if(b!=null)
			{
				list.add((Gdscoll)b);
			}
		}
	}
	if(list!=null&&list.size()>0)
	{
		if(list.get(0).getGdscoll_bgid()!=null)
		{
		return list.get(0).getGdscoll_bgid().longValue();
		}
		else
		{
			return new Long("0");
		}
	}
	else
	{
		return new Long("0");
	}
	
}
%>

<%
//判断是否有权限
boolean flag=false;
if(session.getAttribute("admin_mng")!=null){
     	   String userid=session.getAttribute("admin_mng").toString().trim();
     	   ArrayList<AdminPower> aplist=AdminPowerHelper.getAwardByGdsid(userid, "updategdscoll"); 
     	   if(aplist!=null&&aplist.size()>0)
     	   {
     		   flag=true;
     	   }
} 

   String id="";
   String sid="";

   if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
   {
	   id=request.getParameter("id");
   }
   if(id.length()<=0)
   {
	   return;
   }
   if(request.getParameter("sid")!=null&&request.getParameter("sid").length()>0)
   {
	   sid=request.getParameter("sid");
   }
   if(sid.length()<=0)
   {
	   return;
   }


  if("post".equals(request.getMethod().toLowerCase()))
  {
	  
	  
	      String ids="";
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
		  String ql="";
		 
		  String bigendimg="";
		  String smallendimg="";
		  String cjimg="";
		  String ppimg="";
		  String cjimg1="";
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
		  			    
		  			   if("gdscoll_textposition".equals(fname)){
		  			    	 g1=fitem.getString("utf-8");
		  			     }
		  			     if("gdscoll_imgposition".equals(fname)){
		  			    	 g2=fitem.getString("utf-8");
		  			     }
		  			   if("gdscoll_cate".equals(fname)){
		  			    	 g3=fitem.getString("utf-8");
		  			     }
		  			   if("gdscoll_bgid".equals(fname))
		  			   {
		  				   ql=fitem.getString("utf-8");
		  			   }
		  			   if("id".equals(fname)){
		  			    	 ids=fitem.getString("utf-8");
		  			     }
		  			    
				     }
				     else{//如果是文件
				    	 size+=fitem.getSize();
				     
				     }
			    }
		  	 
		  	Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(ids);
			  if(gdscoll==null)
			  {
				  Tools.outJs(out, "搭配不存在", "back");
				  return;
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
		  					String uploadPath =getUploadFilePath("siteadmin");
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
		  					else if(count==2)
		  					{
		  						smallendimg=uploadFileName;
		  						 if(smallendimg.length()>0)
			  					   {
			  						 smallendimg =smallendimg.replace("/opt", "");
			  					   }
		  					}
		  					else if(count==3)
		  					{
		  						cjimg=uploadFileName;
		  						 if(cjimg.length()>0)
			  					   {
			  						 cjimg =cjimg.replace("/opt", "");
			  					   }
		  					}
		  					else if(count==4)
		  					{
		  						ppimg=uploadFileName;
		  						 if(ppimg.length()>0)
			  					   {
			  						 ppimg =ppimg.replace("/opt", "");
			  					   }
		  					}
		  					else
		  					{
		  						cjimg1=uploadFileName;
		  						 if(cjimg1.length()>0)
			  					   {
		  							cjimg1 =cjimg1.replace("/opt", "");
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
	  	
	  	  
	  	   
	  	   //修改搭配
	  	 
		    gdscoll.setGdscoll_flag(new Long(Tools.parseLong(gf)));
		    gdscoll.setGdscoll_serid(new Long(Tools.parseLong(gs)));
		    gdscoll.setGdscoll_sort(new Long(Tools.parseLong(gs1)));
		    gdscoll.setGdscoll_tail(gtail);
		    gdscoll.setGdscoll_title(gt);
		    gdscoll.setGdscoll_imgposition(new Long(Tools.parseLong(g2)));
		    gdscoll.setGdscoll_textposition(new Long(Tools.parseLong(g1)));
		    gdscoll.setGdscoll_czimg(cjimg1);
		    gdscoll.setGdscoll_bgid(new Long(ql));
		    gdscoll.setGdscoll_cate(new Long(Tools.parseLong(g3)));
			if(bigendimg.length()>0)
			{
				gdscoll.setGdscoll_bigimgurl(bigendimg);
			}
			if(smallendimg.length()>0)
			{
				gdscoll.setGdscoll_smallimgurl(smallendimg);
			}
			if(cjimg.length()>0)
			{
				gdscoll.setGdscoll_indextitle(cjimg);
			}
			if(ppimg.length()>0)
			{
				 gdscoll.setGdscoll_brandimg(ppimg);
			}
			if(Tools.getManager(Gdscoll.class).update(gdscoll, true))
			{
		    	out.print("<script>alert('修改搭配成功！');this.location.href='/admin/Gdscoll/gcupdate.jsp?sid="+sid+"&id="+id+"';</script>");
		    }else{
		    	out.print("<script>alert('修改搭配失败！');this.location.href='/admin/Gdscoll/gcupdate.jsp?sid="+sid+"&id="+id+"';</script>");
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
<title>修改搭配</title>
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
	   
	   var gt=$("#gdscoll_title").val();
	   
	   
	   if(gt=='')
		   {
		   $('#gdscoll_title_notice').html('搭配标题不能为空！');
		   return;
		   }
	   else
		   {
		   $('#gdsscene_title_notice').html('');
		   }
	   document.gdscollupdate.submit();
	     }
   
   function cancle()
   {
	   
	   $("#gdscoll_title").val('');
	   $("#gdscoll_tail").val('');
	   $("#gdscoll_sort").val('');
	   $("#gdscoll_flag").val('1');
	   
	   $("#gdscoll_serid").focus();
   }
</script>

</head>
<body>

<div style="margin:0px auto; width:980px; text-align:center; padding-top:25px; font-size:14px;" >
   <h1 style=" font-size:25px;">修改搭配</h1>
   <a href="addG.jsp?sid=<%= sid%>">添加搭配</a>&nbsp;&nbsp;<a href="gmanager.jsp" target="top">搭配管理</a>
   &nbsp;&nbsp;<a href="agd.jsp?gdscollid=<%= id %>" target="bottom">添加搭配商品</a><br/>
   <%
       Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(id);
       if(gdscoll!=null)
       {%><br/><br/>
    	   <div id="updatefl">
    	      <span>修改搭配信息</span>
    	      <form id="gdscollupdate" name="gdscollupdate" method="post" action="gcupdate.jsp?id=<%= id %>&sid=<%= sid %>"  enctype="multipart/form-data">
			   <table style=" margin:0px auto; font-size:14px;text-align:left;">
			   <input type="hidden" id="id" name="id" value="<%= gdscoll.getId() %>"/>
	    <tr><td>系列编号：</td><td><input type="text" id="gdscoll_serid" name="gdscoll_serid" value="<%= gdscoll.getGdscoll_serid().longValue() %>" style="width:60px;"/></td></tr>
       
       <tr><td>搭配主题：</td><td><input type="text" id="gdscoll_title" value="<%= gdscoll.getGdscoll_title() %>" name="gdscoll_title" />&nbsp;&nbsp;<span id="gdscoll_title_notice"></span></td></tr>
      <tr><td>搭配类别：<select id="gdscoll_cate" name="gdscoll_cate">
                                          <option value="1" <% if(gdscoll.getGdscoll_cate().longValue()==1) out.print("selected"); %>>男</option>
                                          <option value="2" <% if(gdscoll.getGdscoll_cate().longValue()==2) out.print("selected"); %>>女</option>
                                          <option value="3" <% if(gdscoll.getGdscoll_cate().longValue()==3) out.print("selected"); %>>情侣男</option>
                                          <option value="4" <% if(gdscoll.getGdscoll_cate().longValue()==4) out.print("selected"); %>>情侣女</option>
                                          <option value="5" <% if(gdscoll.getGdscoll_cate().longValue()==5) out.print("selected"); %>>情侣</option>
                                    </select></td></tr>
        <tr><td>搭配大图：</td><td><input type="file" id="gdscoll_bigimgurl" name="gdscoll_bigimgurl" /><a href="http://images1.d1.com.cn<%= gdscoll.getGdscoll_bigimgurl() %>" target="_blank">查看大图</a>
        </td></tr>
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_bigimgurl() %>"/></td></tr>
        <tr><td>搭配小图：</td><td><input type="file" id="gdscoll_smallimgurl" name="gdscoll_smallimgurl" /><a href="http://images1.d1.com.cn<%= gdscoll.getGdscoll_smallimgurl() %>" target="_blank">查看小图</a>
        </td></tr>
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_smallimgurl() %>"/></td></tr>
        <tr><td>搭配状态：</td><td><select id="gdscoll_flag" name="gdscoll_flag">
        <% if(flag)
        {%>
               <option value="1" <% if(gdscoll.getGdscoll_flag().longValue()==1) out.print("selected"); %>>可显示</option>
               <option value="0" <% if(gdscoll.getGdscoll_flag().longValue()==0) out.print("selected"); %>>不显示</option>
         <%}
         else
         {
        	 if(gdscoll.getGdscoll_flag().longValue()==1){%>
        		 <option value="1" selected>可显示</option>
        	 <%}
        	 else
        	 {%>
        		  <option value="1" selected>不显示</option>
        	 <%}
         }%> 
                                  </select></td></tr>
       <tr><td>搭配排序：</td><td><input type="text" id="gdscoll_sort" name="gdscoll_sort" value="<%= gdscoll.getGdscoll_sort() %>"/>&nbsp;&nbsp;</td></tr>
        <tr><td>场景图：</td><td><input type="file" id="gdscoll_indextitle" name="gdscoll_indextitle" /><a href="http://images1.d1.com.cn<%= gdscoll.getGdscoll_indextitle() %>" target="_blank">查看场景图</a>
        </td></tr>
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_indextitle() %>"/></td></tr>
       
        <tr><td>品牌图：</td><td><input type="file" id="gdscoll_brandimg" name="gdscoll_brandimg" /><a href="http://images1.d1.com.cn<%= gdscoll.getGdscoll_brandimg() %>" target="_blank">查看品牌图</a>
        </td></tr>
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_brandimg() %>"/></td></tr>
       
        <tr><td>场景页显示的搭配图：</td><td><input type="file" id="gdscoll_czimg" name="gdscoll_czimg" /><a href="http://images1.d1.com.cn<%= gdscoll.getGdscoll_czimg() %>" target="_blank">查看场景页显示的搭配图</a>
        </td></tr>
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_czimg() %>"/></td></tr>
       
        <tr><td colspan="2"><img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_brandimg() %>"/></td></tr>
         <tr><td>搭配图片位置：</td><td><select id="gdscoll_imgposition" name="gdscoll_imgposition">
                                          <option value="0" <% if(gdscoll.getGdscoll_imgposition().longValue()==0) out.print("selected"); %>>左侧</option>
                                          <option value="1" <% if(gdscoll.getGdscoll_imgposition().longValue()==1) out.print("selected"); %>>右侧</option>
                                    </select></td></tr>
         <tr><td>文字描述位置：</td>
         <td><select id="gdscoll_textposition" name="gdscoll_textposition">
                  <option value="1" <% if(gdscoll.getGdscoll_textposition().longValue()==1) out.print("selected"); %>>右侧</option>
                   <option value="0" <% if(gdscoll.getGdscoll_textposition().longValue()==0) out.print("selected"); %>>左侧</option>
             </select></td></tr>
       <tr><td>情侣编号：</td><td><input type="text" id="gdscoll_bgid" name="gdscoll_bgid" value="<%= gdscoll.getGdscoll_bgid()==null?"0":gdscoll.getGdscoll_bgid().longValue() %>"/><span>当前情侣编号是<font style="color:#000"><%= getGdscollBybgid() %></font></span></td></tr>
       
        <tr><td>搭配描述：</td><td><input type="text" id="gdsscoll_tail" name="gdsscoll_tail" style="width:300px; height:200px;" value="<%= gdscoll.getGdscoll_tail() %>"/></td></tr>
		<tr><td colspan="2"><input type="button" value="修改" style="width:80px;" onclick="Check()"/>&nbsp;&nbsp;<input type="button" value="取消" style="width:80px;" onclick="cancle();"/></td></tr>
			   </table>
     
   			</form>
    	      
    	   </div>
       <%}
       else
       {%>
    	 该搭配不存在
       <%}
   %>
 
</div>
</body>
</html>





