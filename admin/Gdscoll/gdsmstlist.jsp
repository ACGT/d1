<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%>
<%@include file="/admin/chkrgt.jsp"%>
<%!
//获取商品列表
    private static ArrayList<Product> getGdsmst(String name,String id,String validflag,Date starttime,Date endtime)
    {
	      ArrayList<Product> plist=new ArrayList<Product>();
	      List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	      if(name.length()>0)
	      {
	    	  clist.add(Restrictions.like("gdsmst_gdsname","%"+name+"%"));
	      }
	      if(id.length()>0&&Tools.isNumber(id))
	      {
	    	  clist.add(Restrictions.eq("id",id.trim()));
	      }
	      if(validflag.length()>0)
	      {
	    	  clist.add(Restrictions.eq("gdsmst_validflag",new Long(validflag)));
	      }
	      
	      if(starttime!=null&&starttime.toString().length()>0){	
	  		clist.add(Restrictions.ge("gdsmst_createdate", starttime));		   
	  	  }
	      if(endtime!=null&&endtime.toString().length()>0){
		  	clist.add(Restrictions.le("gdsmst_createdate", endtime));		
		  }		
		  List<Order> olist=new ArrayList<Order>();
		  olist.add(Order.desc("gdsmst_createdate"));
		  List<BaseEntity> blist=Tools.getManager(Product.class).getList(clist, olist, 0, 10000);
		  if(blist!=null&&blist.size()>0)
		  {
			  for(BaseEntity be:blist)
			  {
				  if(be!=null)
				  {
					  plist.add((Product)be);
				  }
			  }
		  }
		  return plist;	
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品列表</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css">
body{ background:#fff;}
  a{ color:#6495ED; font-size:14px; text-decoration:underline; padding:4px; margin:4px;}
  table a{color:#6495ED; font-size:12px; text-decoration:underline; margin-right:4px; }
  td{ height:30px;border-bottom:solid 1px #999999;border-right:solid 1px #999999; text-align:center;}
  input{ width:250px;}
  span{ color:#f00;}
</style>


</head>
<body>
<%
String ggURL = Tools.addOrUpdateParameter(request,null,null);
String name="";
String gdsid="";
String flag="";
String starttime="";
String endtime="";

if(request.getParameter("gdsname")!=null&&request.getParameter("gdsname").length()>0)
{
    name=request.getParameter("gdsname");	
}
if(request.getParameter("id")!=null&&request.getParameter("id").length()>0)
{
    gdsid=request.getParameter("id");	
}
if(request.getParameter("validflag")!=null&&request.getParameter("validflag").length()>0)
{
    flag=request.getParameter("validflag");	
}
if(request.getParameter("startime")!=null&&request.getParameter("startime").length()>0)
{
    starttime=request.getParameter("startime");	
}
if(request.getParameter("endtime")!=null&&request.getParameter("endtime").length()>0)
{
    endtime=request.getParameter("endtime");	
}
ArrayList<Product> list=new ArrayList<Product>();
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
if(starttime.length()>0&&endtime.length()<=0){
	try{
		Date s=format.parse(starttime+" 00:00:00");
		list=getGdsmst(name,gdsid,flag,s,null);
	  
	}catch(Exception ex){
		
	}
}
else if(starttime.length()<=0&&endtime.length()>0){
	try{
		
	    Date e=format.parse(endtime+" 00:00:00");
	    list=getGdsmst(name,gdsid,flag,null,e);
	}catch(Exception ex){
		
	}
}
else if(starttime.length()>0&&endtime.length()>0){
	try{		
	    Date e=format.parse(endtime+" 00:00:00");
	    Date s=format.parse(starttime+" 00:00:00");
	    list=getGdsmst(name,gdsid,flag,s,e);
	}catch(Exception ex){
		System.out.print(ex);
	}
}
else{
	list=getGdsmst(name,gdsid,flag,null,null);
}
%>
<div style="margin:0px auto;text-align:center; padding-top:25px; font-size:14px;">

   <a  href="<%= ggURL%>" >刷新页面</a><br/><br/>  
   <%
      
      
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
     <table style="margin:0px auto;text-align:center; border:solid 1px #333;"  border="1" cellspcing="0" cellpadding="0">
         <tr style="background:#f4f4f4; color:#333"><td width="65" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">商品图</td>
         <td width="100"  style="border-top:solid 1px #999999;">商品编号</td><td width="250" style="border-top:solid 1px #999999;">商品名称</td><td width="80" style="border-top:solid 1px #999999;">市场价</td><td width="80" style="border-top:solid 1px #999999;">会员价</td>
         <td width="80"style="border-top:solid 1px #999999;" >VIP价</td><td width="100" style="border-top:solid 1px #999999;">操作</td></tr>
    	 <% 
    	 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
	    	 
	      for(int i=(pageno1-1)*15;i<list.size()&&i<pageno1*15;i++)
    	  {
	    	  Product p=list.get(i);
    		  if(p!=null)
    		  {%>
    			<tr style="border-bottom:#f4f4f4 solid 1px ;"><td style="border-top:solid 1px #999999;border-left:solid 1px #999999;"><img src="http://images.d1.com.cn<%= p.getGdsmst_recimg() %>"/></td>
    			<td style="border-top:solid 1px #999999;"><%= p.getId() %></td>
    			
    			<td style="border-top:solid 1px #999999;"><%= p.getGdsmst_gdsname() %></td>
    			<td style="border-top:solid 1px #999999;"><%= Tools.getFloat(p.getGdsmst_saleprice().floatValue(),2) %></td>
    			<td style="border-top:solid 1px #999999;"><%= Tools.getFloat(p.getGdsmst_memberprice().floatValue(),2)%></td>
    			<td style="border-top:solid 1px #999999;"><%= Tools.getFloat(p.getGdsmst_vipprice().floatValue(),2)%></td>
    			<td style="border-top:solid 1px #999999;"><a href="http://admin.d1.com.cn:322/gdsadmin_new/gdsinfo.asp?req_gdsid=<%= p.getId() %>" target="bottom">维护</a>
    			&nbsp;&nbsp;<a href="http://www.d1.com.cn/product/<%= p.getId() %>" target="_blank">预览</a></td>
    			</tr>  
    		  <%}
    	  }%>
    	  <!-- 分页 -->
						    <%
					           if(pBean1.getTotalPages()>=1){
					           %>
					           <tr>
					   <td colspan="7" height="45">
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
    	没有满足条件的记录！！
      <%}
   
   %>
 
</div>
</body>
</html>
