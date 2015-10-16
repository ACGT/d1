<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/admin/chkrgt.jsp"%>
<%@include file="/admin/public.jsp"%>
<%
   String start="";
   String ends="";
   if(request.getParameter("s")!=null&&request.getParameter("s").length()>0){
	   start=request.getParameter("s");
   }
   if(request.getParameter("e")!=null&&request.getParameter("e").length()>0){
	   ends=request.getParameter("e");
   }
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
   Date s=new Date();
   Date e=new Date();
   if(start.length()>0||ends.length()>0){
	   if(start.length()>0&&ends.length()<=0){
		   s=sdf.parse(start);
		  
	   }
	   else if(start.length()<=0&&ends.length()>0){		   
		   e=sdf.parse(ends);
		   Date ls=sdf.parse(ends);
		   ls.setMinutes(-60*24*2);
	       s=ls;
	   }
	   else{
		   s=sdf.parse(start);
		   e=sdf.parse(ends);
	   }
	
   }
   else{
	   Calendar c=Calendar.getInstance();
	   e=c.getTime();
	   c.add(Calendar.DAY_OF_MONTH, -2);
	   s=c.getTime();
   }
   if(s.after(e)){
	   out.print("您输入的起始时间不正确，请重新输入查询！！！");
	   return;
   }
   double amount=0;//总访问量
   double ipcount=0;//总访问ip数
   double clickcount=0;//总点击数
   double amount1=0;//总访问量
   double ipcount1=0;//总访问ip数
   double clickcount1=0;//总点击数

   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>获取数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
  body{background:#fff;}
  a{ color:#6495ED; font-size:14px; text-decoration:underline;}
  span{ color:#f00;}
  td{border-bottom:solid 1px #999999;border-right:solid 1px #999999; text-align:center;}
  .Pager a{ padding:4px; border:solid 1px #ccc; margin:4px;}
</style>
</head>
<body style="padding-left:10px;">
<div style=" text-align:center; margin:0px auto;"><h3>首页日志汇总</h3></div>
<div style="border:solid 1px #ccc;  margin:0px auto;">
<div style="float:left; padding:15px; overflow:hidden; ">
      <%
          ArrayList<Hitindex> hilist=HitindexHelper.gethitindexListBydate(s, e);
	      if(hilist!=null&&hilist.size()>0){
	    	  for(Hitindex hi:hilist){
	    		  amount+=hi.getHitindex_count().longValue();
	    		  ipcount+=hi.getHitindex_ipcount().longValue();
	    		  clickcount+=hi.getHitindex_djcount().longValue();
	    		  amount1+=hi.getHitindex_allcount().longValue();
	    		  ipcount1+=hi.getHitindex_allcountip().longValue();
	    		  clickcount1+=hi.getHitindex_allcountsession().longValue();
	    		  
	    	  }%>
	    	  <table border="0" cellpadding="0" cellspacing="0" style="font-size:14px; line-height:24px;">
	    	   <tr>
	             <td width="200" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">最终页面</td>
				  <td width="100" style="border-top:solid 1px #999999;">总访问量</td>
				  <td width="100" style="border-top:solid 1px #999999;">访问ip数</td>
				  <td width="100" style="border-top:solid 1px #999999; ">点击数</td>
				   <td width="100" style="border-top:solid 1px #999999;">总访问量(index)</td>
				  <td width="100" style="border-top:solid 1px #999999;">访问ip数(index)</td>
				  <td width="100" style="border-top:solid 1px #999999; ">点击数(index)</td>
				  <td width="100" style="border-top:solid 1px #999999; ">页面跳出率</td>
	          </tr>   
	          <tr>
	          <td  style="border-left:solid 1px #999999;"><a href="http://www.d1.com.cn/" target="_blank">http://www.d1.com.cn/index.jsp</a></td>
	          <td><%= (int)amount %></td>
	          <td><%= (int)ipcount %></td>
	          <td><%= (int)clickcount %></td>   
	          <td><%= (int)amount1 %></td>   
	          <td><%= (int)ipcount1 %></td>   
	          <td><%= (int)clickcount1 %></td>   
	          <td><%= clickcount1==0?"":Tools.getDouble(((clickcount-clickcount1)/clickcount1)*100,2) %>%</td> 
	          </tr>
	    	  </table>
	    	  <br/><br/>
	    	  <font style="color:#f00; font-size:15px; line-height:24px;">访问量详情>></font><br />
	    	  <table border="0" cellpadding="0" cellspacing="0" style="font-size:14px; line-height:24px;">
	    	  <tr><td width="80" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">序号</td>
	             <td width="200" style="border-top:solid 1px #999999;">最终页面</td>
				  <td width="100" style="border-top:solid 1px #999999;">PV</td>
				  <td width="100" style="border-top:solid 1px #999999;">IP</td>
				  <td width="100" style="border-top:solid 1px #999999; ">UV</td>
				  <td width="100" style="border-top:solid 1px #999999; ">PV(index)</td>
				  <td width="100" style="border-top:solid 1px #999999; ">IP(index)</td>
				  <td width="100" style="border-top:solid 1px #999999; ">UV(index)</td>
				   <td width="100" style="border-top:solid 1px #999999; ">页面跳出率</td>
				  <td width="200" style="border-top:solid 1px #999999;">创建时间</td>
	          </tr>
	 	    	  <%
	    	  for(Hitindex hi:hilist){
	    		  if(hi!=null){
	    		  double ac=0;	    		
	    		  double cc=0;
	    		  ac=hi.getHitindex_djcount().longValue();
	    		  cc=hi.getHitindex_allcountsession().longValue();
	    		  %>
	    		 
	    			  <tr>
	    			  <td style="border-left:solid 1px #999999; "><%= hi.getId() %></td>
	    			     <td style="text-align:left;">&nbsp;&nbsp;<a href="http://www.d1.com.cn<%= hi.getHitindex_uri() %>" target="_blank">http://www.d1.com.cn<%= hi.getHitindex_uri() %></a></td>
	    			     <td><%= hi.getHitindex_count().longValue() %></td>
	    			     <td><%= hi.getHitindex_ipcount().longValue() %></td>
	    			     <td><%= hi.getHitindex_djcount().longValue() %></td>
	    			     <td><%= hi.getHitindex_allcount().longValue() %></td>
	    			     <td><%= hi.getHitindex_allcountip().longValue() %></td>
	    			     <td><%= hi.getHitindex_allcountsession().longValue() %></td>
	    			     <td><%= cc==0?"":Tools.getDouble(((ac-cc)/cc)*100,2) %>%</td>
	    			     <td><%= hi.getHitindex_createdate() %></td>
	    			  </tr>
	    		  <%}
	    	  }%>
	          </table>
	   <%   }
      %>
      <br/><br/><br/>
       <%
       //ArrayList<Hitlogindex> hlilist=HitlogindexHelper.getHitlogindexList();
       ArrayList<Hitlogindex> hlilist=HitlogindexHelper.getHitlogindexListByDate(s, e);
	      if(hlilist!=null&&hlilist.size()>0){
	    	  %>
	    	  <table border="0" cellpadding="0" cellspacing="0" style="font-size:14px; line-height:24px;">
	    	  <tr><td width="80" style="border-top:solid 1px #999999;border-left:solid 1px #999999;">序号</td>
	             <td width="550" style="border-top:solid 1px #999999;">点击的页面</td>
				  <td width="100" style="border-top:solid 1px #999999;">UV</td>
				  <td width="100" style="border-top:solid 1px #999999;">IP</td>
				  <td width="100" style="border-top:solid 1px #999999;">首页点出数</td>
				  <td width="100" style="border-top:solid 1px #999999;">页面点击率</td>
				  <td width="200" style="border-top:solid 1px #999999;">创建时间</td>
	          </tr>
	    	   <%
	    	   //分页
			   int pageno1=1;
			   String ggURL = Tools.addOrUpdateParameter(request,null,null);
			   if(ggURL != null) {
					ggURL.replaceAll("pageno1=[0-9]*","");
			   }
			   int totalLength1 = (hlilist != null ?hlilist.size() : 0);
			   int PAGE_SIZE = 50 ;
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
			   if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
			   {
				   pageno1=Tools.parseInt(request.getParameter("pageno1"));
			   }
			  for(int i=(pageno1-1)*50;i<hlilist.size()&&i<pageno1*50;i++)
			  {
				  Hitlogindex hi=hlilist.get(i);
	    		  if(hi!=null){%>
	    			  <tr>
	    			  <td style="border-left:solid 1px #999999; "><%= hi.getId() %></td>
	    			     <td style="text-align:left;">&nbsp;&nbsp;<a href="<%= hi.getUrl() %>" target="_blank"><%= hi.getUrl() %></a></td>
	    			     <td><%= hi.getHits().longValue()%></td>
	    			     <td><%= hi.getIpcount().longValue() %></td>	
	    			     <%
	    			         Hitindex  hindex=(Hitindex)Tools.getManager(Hitindex.class).findByProperty("hitindex_createdate", hi.getCreatedate());
	    			         if(hindex!=null){
	    			        	 double sum1=hindex.getHitindex_allcountsession().longValue();
	    			        	 double sum2=hindex.getHitindex_djcount().longValue();
	    			        	 double fwl=Tools.getDouble((hi.getHits()/sum2)*100,2);
	    			        	 %>
	    			        	 <td><%= (int)sum1 %></td>
                                 <td><%= fwl %>%</td>
	    			         <%}
	    			         else{%>
	    			        	<td></td> <td></td>
	    			         <%}
	    			     %>
	    			     
	    			     
	    			         			     
	    			     <td><%= hi.getCreatedate() %></td>
	    			  </tr>
	    		  <%}
	    	  }%>
	    	   <tr>
                 
					       <td colspan="7" height="45" style="border-left:solid 1px #999999;">
					       <% if(hlilist!=null&&hlilist.size()>0)
					       {%>
					    	    <span class="Pager" style="margin:0px auto; overflow:hidden;">
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
					           </span>
					    	   
					      <%  } %>
					       
					          
					       </td>
					 </tr>
	          </table>
	   <%   }
      %>
</div>
      
</div>
</body>
</html>