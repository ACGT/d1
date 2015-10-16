<%@ page contentType="text/html; charset=UTF-8"%>
<%@page	import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,java.util.regex.Pattern"%>
<%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%
if(session.getAttribute("admin_mng")!=null){
	   String userid=session.getAttribute("admin_mng").toString();
	   ArrayList<AdminPower> aplist=   AdminPowerHelper.getAwardByGdsid(userid, "pop_order");
	   if(aplist==null||aplist.size()<=0){
		   out.print("对不起，您没有操作权限！");
		   return;
	   }
} 
else {return;}

%>
<%!
/**
 * 对账单--odrmst_cache
 */
/**
 * 对账单--odrmst
 */
public static ArrayList<Jsdtl> getJsdtlList(HttpServletRequest request,HttpServletResponse response){
	ArrayList<Jsdtl> list=new ArrayList<Jsdtl>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	String jsdtl_jsmstcode = request.getParameter("jsdtl_jsmstcode");
	
	if(jsdtl_jsmstcode!= null && !"".equals(jsdtl_jsmstcode)) {
		listRes.add(Restrictions.eq("jsdtl_jsmstcode", jsdtl_jsmstcode));
	}
    
	List<BaseEntity> list2 = Tools.getManager(Jsdtl.class).getList(listRes, null, 0, 3000);
	if(list2==null || list2.size()==0){
		return null;
	}
	for(BaseEntity be:list2){
		list.add((Jsdtl)be);
	}
	return list;
}	

private double round(double number,int index){
    double result = 0;
    double temp = Math.pow(10, index);
    result = Math.round(number*temp)/temp;
    return result;
}

public static String getUploadFilePath(String catname){
	
	Calendar calendar = Calendar.getInstance();
	
	int m = (calendar.get(Calendar.MONTH)+1);
	String month = null;
	if(m<10)month="0"+m;
	else month=m+"";
	
	int d = calendar.get(Calendar.DAY_OF_MONTH);
	String day = null;
	if(d<10)day="0"+d;
	else day = ""+d;
	
	String dirName = String.valueOf(calendar.get(Calendar.YEAR))+"/"+month+"/"+day+"/";
	return "/opt/shopimg/pz/"+catname+"/"+dirName;
}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/DatePicker/WdatePicker.js")%>"></script>
<link href="res/odrlist.css" rel="stylesheet" type="text/css"  />
<title>结算单明细</title>
</head>
<%
if("post".equals(request.getMethod().toLowerCase()))
{
	  String bigendimg="";
	  String jsmst_code="";
	  String jsmst_status="";
	  String href="";
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
		
			  			     if("jsmst_code".equals(fname))
			  			     {
			  				 	jsmst_code=fitem.getString("utf-8");
			  			     }	  
			  			     if("jsmst_status".equals(fname))
			  			     {
			  			    	jsmst_status=fitem.getString("utf-8");
			  			     }
			  			   if("href".equals(fname))
			  			     {
			  				 	href=fitem.getString("utf-8");
			  			     }
			  			   
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
	  						System.out.println("ok");
	  						fm.mkdirs();
	  					}
	  					
	  					String fileName = Tools.getDBDate()+(int)(Math.random()*10)+"_"+count+ext;//文件名
	  					//String photoName = "http://d1.com.cn/upload/"+ fileName;
	  					//name+=fileName+",";
	  					
	  					
	  					String uploadFileName = uploadPath + fileName.substring(fileName.lastIndexOf("/") + 1);
	  					//Tools.outJs(out, uploadFileName, "back");
  					    bigendimg=uploadFileName;
  					    if(bigendimg.length()>0)
  					    {
  						    bigendimg = bigendimg.replace("/opt", "");
  						  	bigendimg = bigendimg.replace("E:/eclipse/workspace/d1web", "");
  						  
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
	  	   
	  	   
	  	   
	  	   //添加搭配
	  	  	ArrayList<Jsmst> list=new ArrayList<Jsmst>();
			List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			
			if(jsmst_code!= null && !"".equals(jsmst_code)) {
				listRes.add(Restrictions.eq("jsmst_code", jsmst_code));
			}
			
			List<BaseEntity> list2 = Tools.getManager(Jsmst.class).getList(listRes, null, 0, 3000);
			if(list2==null || list2.size()==0){
		    	response.sendRedirect(href+"&code=数据不存在!");
				return;
			}
			for(BaseEntity be:list2){
				list.add((Jsmst)be);
			}
			
			list.get(0).setJsmst_jspicpath(bigendimg);
			list.get(0).setJsmst_jsdate(new Date());
			list.get(0).setJsmst_status(new Long(Long.parseLong(jsmst_status)));
			Tools.getManager(Jsmst.class).update(list.get(0), true);
	  	   
		    if(list.get(0)!=null){
		    	response.sendRedirect(href+"&code=添加成功!");
		    }else{
		    	response.sendRedirect(href+"&code=添加失败!");
		    }
		   } catch (Exception e) {
			   out.print("fail");
		        e.printStackTrace();
		    return;
		   }
	  }
	
	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
	String jsmst_status = request.getParameter("jsmst_status");
%>
<body style="overflow-x: hidden">
<table width="806" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr>
    <td class="menuodrtd"  colspan="7">订单列表</td>
							
  </tr>
      <tr class="odrt">
        <td >商户编号/商户名称</td>
        <td >订单号</td>
        <td >收货人</td>
        <td >发货时间</td>
        <td >商品金额</td>
        <td >减免金额</td>
        <td >购物券</td>
        <td >购物券分摊</td>
        <td >运费</td>
        <td >退换货运费</td>
        <td >佣金</td>
        <td >应结金额</td>
        <td >操作</td>
      </tr>
<%
	String jsdtl_jsmstcode = request.getParameter("jsdtl_jsmstcode");
	String jsmst_shpcode = request.getParameter("jsmst_shpcode");
	String jsmst_shpname = request.getParameter("jsmst_shpname");

	String ggURL = Tools.addOrUpdateParameter(request,null,null);
	ArrayList<Jsdtl> list=new ArrayList<Jsdtl>();
	list = getJsdtlList(request,response);
	
    int pageno1=1;
    
    if(ggURL != null) 
    	   {
    	     ggURL.replaceAll("pageno1=[0-9]*","");
    	   }
    //翻页
      int totalLength1 = (list != null ?list.size() : 0);
      int PAGE_SIZE = 30;
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
    {
   	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
   		
   	 	double sum_gdsprice = 0;
   		double sum_jmprice = 0;
   		double sum_gwjprice = 0;
   		double sum_giftfee = 0;
   		double sum_lmcommision = 0;
   		double sum_shipfee = 0;
	      for(int i=(pageno1-1)*30;i<list.size()&&i<pageno1*30;i++)
   	  {
	    	  Jsdtl jsdtl=list.get(i);
%>
	<tr>
	<%
		float shipfee = jsdtl.getJsdtl_shipfee()==null?0:jsdtl.getJsdtl_shipfee().floatValue();
		float gdsprice = jsdtl.getJsdtl_gdsprice()==null?0:(jsdtl.getJsdtl_gdsprice().floatValue()-shipfee);
		float jmprice = jsdtl.getJsdtl_jmprice()==null?0:jsdtl.getJsdtl_jmprice().floatValue();
		float gwjprice = jsdtl.getJsdtl_gwjshare()==1?(jsdtl.getJsdtl_gwjprice()==null?0:jsdtl.getJsdtl_gwjprice().floatValue()):0;
		float giftfee = jsdtl.getJsdtl_giftfee()==null?0:jsdtl.getJsdtl_giftfee().floatValue();
		float lmcommision = jsdtl.getJsdtl_lmcommision()==null?0:jsdtl.getJsdtl_lmcommision().floatValue();
		
	  	  sum_gdsprice += round(gdsprice,2);
	  	  sum_jmprice += round(jmprice,2);
	  	  sum_gwjprice += round(gwjprice,2);
	  	  sum_giftfee += round(giftfee,2);
	  	  sum_lmcommision += round(lmcommision,2);
	  	  sum_shipfee += round(shipfee,2);

	%>
		<td height="40"><%=jsmst_shpcode+"<br>"+jsmst_shpname %></td>
		<td align="center"><%=jsdtl.getJsdtl_odrid() %></td>
		<td align="center"><%=jsdtl.getJsdtl_odrname() %></td>
		<td align="center"><%=jsdtl.getJsdtl_shipdate() %></td>
		<td align="center"><%=round(gdsprice,2) %></td>
		<td align="center"><%=round(jmprice,2) %></td>
		<td align="center"><%=round(gwjprice,2) %></td>
		<td align="center">
			<input type="radio" name="jsdtl_gwjshare<%=jsdtl.getJsdtl_odrid() %>" value="2" id="jsdtl_gwjshare<%=jsdtl.getJsdtl_odrid() %>" <%if(jsdtl.getJsdtl_gwjshare().longValue()==2) out.print("checked"); %>>D1&nbsp;&nbsp;<input type="radio" name="jsdtl_gwjshare<%=jsdtl.getJsdtl_odrid() %>" id="jsdtl_gwjshare<%=jsdtl.getJsdtl_odrid() %>" value="1" <%if(jsdtl.getJsdtl_gwjshare().longValue()==1) out.print("checked"); %>>商户
		</td>
		<td align="center"><%=round(shipfee,2) %></td>
		<td align="center"><%=round(giftfee,2) %></td>
		<td align="center"><%=round(lmcommision,2)%></td>
		<td align="center"><%=round(gdsprice-jmprice-gwjprice-lmcommision+giftfee+shipfee,2)%></td>
		<td align="center">
					<a href='#' onclick="update('<%=jsdtl.getJsdtl_odrid() %>','<%=jsdtl.getJsdtl_flag()%>')">修改</a>
		</td>
	</tr>
<%
   	  }
%>
    <tr>
   		<td>总计</td>
   		<td></td>
   		<td align="center"><%=round(sum_gdsprice,2) %></td>
   		<td align="center"><%=round(sum_jmprice,2) %></td>
   		<td align="center"><%=round(sum_gwjprice,2) %></td>
   		<td></td>
   		<td align="center"><%=round(sum_shipfee,2) %></td>
   		<td align="center"><%=round(sum_giftfee,2) %></td>
   		<td align="center"><%=round(sum_lmcommision,2) %></td>
   		<td align="center"><%=round(sum_gdsprice+sum_giftfee+sum_shipfee-sum_jmprice-sum_lmcommision-sum_gwjprice,2) %></td>
   		<td></td>
   	</tr>

<%
	      
	           if(pBean1.getTotalPages()>=1){
	           %>
	           <tr>
	   <td colspan="7" height="45">
	           <span class="GPager" style="margin:0px auto; overflow:hidden;">
	           	<span>共<font class="rd"><%=pBean1.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean1.getCurrentPage() %></font>页</span>
	           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=1">首页</a><%if(pBean1.hasPreviousPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上一页</a><%}%><%
	           	for(int i=pBean1.getStartPage();i<=pBean1.getEndPage()&&i<=pBean1.getTotalPages();i++){
	           		if(i==currentPage1){
	           		%>&nbsp;&nbsp;<span class="curr"><%=i %></span><%
	           		}else{
	           		%>&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=i %>"><%=i %></a><%
	           		}
	           	}%>
	           	<%if(pBean1.hasNextPage()){%>&nbsp;&nbsp;<a href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下一页</a><%}%>
	           	&nbsp;&nbsp;<a href="<%=pageURL1 %>pageno1=<%=pBean1.getTotalPages() %>">尾页</a>
	           </span> </td>
	           <td align="right" colspan="3">
	           <%
	           		if(jsmst_status.equals("2")) {
	           %>
	           		<form id="gdscoll" name="gdscoll" method="post" action="jsdtllist.jsp" enctype="multipart/form-data">
	           			<input type="hidden" id="href" name="href" value="<%=request.getParameter("href")%>"/>
	           			<input type="hidden" id="jsmst_status" name="jsmst_status" value="3"/>
	           			<input type="hidden" id="jsmst_code" name="jsmst_code" value="<%=jsdtl_jsmstcode%>"/>
	           			<input type="file" id="gdscoll_bigimgurl" name="gdscoll_bigimgurl" />
	           			<input type='submit' name='submit1' value='结算'/>
	           		</form>
	           <%
	           		}else if(jsmst_status.equals("1")) {
	           %>
	           		<input type='button' name='submit1' value='审核' onclick="jsl('2')"/>
	           <%
	           		}else if(jsmst_status.equals("0")) {
	           %>
	           		<input type='button' name='submit1' value='提交' onclick="jsl('1')"/>
	           	<%
	           		}
	           	%>
	           		<input type='button' name='submit1' value='返回' onclick="rtn()"/>
	           </td>
  </tr><%}}%>	
      <tr>
 </tr>
</table>
<script type="text/javascript">
function update(jsdtl_odrid, jsdtl_flag) {
	alert('');
	var jsdtl_gwjshares = document.getElementsByName('jsdtl_gwjshare'+jsdtl_odrid);
	for (var i = 0; i < jsdtl_gwjshares.length; i++) {
		if(jsdtl_gwjshares[i].checked) {
			self.location='jsdtlUpdate.jsp?jsdtl_jsmstcode=<%=jsdtl_jsmstcode%>&jsmst_shpcode=<%=jsmst_shpcode%>&jsmst_shpname=<%=jsmst_shpname%>&jsmst_status=<%=jsmst_status%>&jsdtl_odrid='+jsdtl_odrid+'&jsdtl_gwjshare='+jsdtl_gwjshares[i].value+'&jsdtl_flag='+jsdtl_flag+'&href=<%=request.getParameter("href")%>';
		}
    }
}

function jsl(status) {
	self.location='jsmstAudit.jsp?jsmst_code=<%=jsdtl_jsmstcode%>&jsmst_status='+status+'&pageno1=<%=pageno1%>&href=<%=request.getParameter("href")%>';
}

function rtn() {
	self.location='<%=request.getParameter("href")%>?pageno1=<%=pageno1%>';
}
</script>

</body>
</html>


