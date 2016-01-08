<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="/inc/islogin.jsp"%><%!
//获取优惠券，validate=true获取有效的
private ArrayList<Ticket> getUserTickets(User user,boolean validate){
	ArrayList<Ticket> ticketList = TicketHelper.getAllUserTickets(user.getId(), "-1");
	ArrayList<Ticket> rlist = new ArrayList<Ticket>();
	if(ticketList==null||ticketList.size()==0)return null;
	for(Ticket t:ticketList){
		if(validate)
		{
			if(t.getTktmst_validflag()!=null&&t.getTktmst_validflag().longValue()==0&&t.getTktmst_validatee().after(new Date())){
				rlist.add(t);
			}
		}
		else
		{
			if((t.getTktmst_validflag()!=null&&t.getTktmst_validflag().longValue()!=0)||t.getTktmst_validatee().before(new Date())){
				rlist.add(t);
			}
		}
	}
	
	return rlist;
}%>

<%

ArrayList<TicketHelper.TicketWrap> islist=new ArrayList<TicketHelper.TicketWrap>();
ArrayList<TicketHelper.TicketWrap> nolist=new ArrayList<TicketHelper.TicketWrap>();

	ArrayList<TicketHelper.TicketWrap> list=new ArrayList<TicketHelper.TicketWrap>();
	list=TicketHelper.getTotalLoginUserTickets(request,response);
	for(TicketHelper.TicketWrap tw:list)
	{
		if(tw.getType()==0)
		{
			Ticket t=tw.getTicket();
			if(t.getTktmst_validflag().longValue()==0&&t.getTktmst_validatee().after(new Date()))
			{
				islist.add(tw);
			}
			else
			{
				nolist.add(tw);
			}
		}
		else
		{
			TicketCrd tc=tw.getTicketCrd();
			if(tc.getTktcrd_validflag().longValue()==1&&tc.getTktcrd_validatee().after(new Date())&&tc.getTktcrd_realvalue()>0)
			{
				islist.add(tw);
			}
			else
			{
				nolist.add(tw);
			}
		}
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员专区——优惠券</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/user.css")%>" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<script language="javascript" type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/user/orderajax.js")%>"></script>
<style type="text/css" rel="stylesheet">
	.WaitActiveEQ{width:120px;height:26px;border-style:none;background:url(http://images.d1.com.cn/BuyImages/loading.gif);background-repeat:no-repeat;}
	.ActivateEquan1{width:120px;height:26px;border:none;background:url(http://images.d1.com.cn/images2012/New/user/jhbtn.jpg);cursor:pointer; background-repeat:no-repeat;}
</style>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
     <!-- 中间内容 -->
     <div class="center">
        
     <%@include file="left.jsp" %>
     
  <!--右侧-->
	
   <div class="mbr_right">

		<div class="myyhq">

		  &nbsp;&nbsp;<span>我的优惠券</span>

		</div>

		<table border="0" width="769" height="10"><tr><td></td></tr></table>

		<div class="yhqlist">
		<%SimpleDateFormat fmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	     Date actendDate=null;
	     Date tktendDate=null;
	     try{
	    	 actendDate=fmt2.parse("2013-4-30 23:59:59");
	     	 tktendDate=fmt2.parse("2013-4-30 23:59:59");
	     	 }
	     catch(Exception ex){
	     	ex.printStackTrace();
	     }
	     if(Tools.dateValue(actendDate)>System.currentTimeMillis()&&session.getAttribute("d1lianmengsubad")!=null&&("p1304012tmkh".equals(session.getAttribute("d1lianmengsubad"))
	    		 ||session.getAttribute("d1lianmengsubad").toString().startsWith("ptenpay"))){ %>
<div style="height:40px"><a href="/index.jsp" target="_blank"><span style="font-size:16px;color:#f00">30元现金券已领取成功，马上去购物吧》》</span></a></div>
<%} %>
		    <div id="yh_tags" class="yh_tag">
		      	    <a href="javascript:void(0)" >有效优惠券</a><a href="javascript:void(0)">无效优惠券</a>
			</div>

			   <div id="yh_content_list">

			       <div style=" display:none;">

				   <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none; " >

				   <tr style=" color:#a25663;" height="33">
				   <td class="d1"  width="80">优惠券类型</td>
				   <td  class="d1" width="80">金额</td>
				   <td class="d1" width="60">状态</td>
				   <td class="d1" width="220">有效期</td>
				   <td class="d1" width="91">适用商品范围</td> 
				   <td class="d1" width="151">使用规则</td>
				   <td class="d1" >生成时间</td>
				   </tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >
					<%
					//ArrayList<Ticket> ticketList = getUserTickets(lUser, true);
					
				   //分页
				   int pageno1=1;
				   int pageno2=1;
					String ggURL = Tools.addOrUpdateParameter(request,null,null);
					if(ggURL != null) 
						   {
						     ggURL.replaceAll("pageno1=[0-9]*","");
						   }
					//翻页
					 int totalLength1 = (islist != null ?islist.size() : 0);
					 	
					  int PAGE_SIZE = 10 ;
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
					
					
					  //if(ticketList!=null){
						if(islist!=null&&islist.size()>0)
						  {
							 if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
							   {
								   pageno1=Tools.parseInt(request.getParameter("pageno1"));
							   }
						//for(Ticket ticket:ticketList)
						 //for(int i=(pageno1-1)*10;i<ticketList.size()&&i<pageno1*10;i++)
					     for(int i=(pageno1-1)*10;i<islist.size()&&i<pageno1*10;i++)
						 {
							String range = "全场";
							//Ticket ticket=ticketList.get(i);
					

							if(islist.get(i).getType()==0)
							{
								//Directory dir = (Directory)Tools.getManager(Directory.class).get(ticket.getTktmst_rackcode());
								
								if(!Tools.isNull(islist.get(i).getTicket().getTktmst_sprckcodeStr())){
									range="<a href=\"http://www.d1.com.cn/html/result_rec.jsp?aid="+islist.get(i).getTicket().getTktmst_sprckcodeStr()+"\" style=\" text-decoration:underline;\" target=\"_blank\" >促销专区</a>";
								   }
								else if(islist.get(i).getTicket().getTktmst_brandname()!=null&&islist.get(i).getTicket().getTktmst_brandname().length()>0)
								{
									range=islist.get(i).getTicket().getTktmst_brandname();
								}
								else
								{
									
									Directory dir = (Directory)Tools.getManager(Directory.class).get(islist.get(i).getTicket().getTktmst_rackcode());
									
									if(dir!=null&&!"000".equals(dir.getId())){
										range = "<a href=\"http://www.d1.com.cn/result.jsp?productsort="+dir.getId()+"&shopd1=1\" style=\" text-decoration:underline;\" target=\"_blank\" >自营"+dir.getRakmst_rackname()+"</a>";
									}
									if("017".equals(dir.getId())){
										range = "<a href=\"http://www.d1.com.cn/shop/780/2\" style=\" text-decoration:underline;\" target=\"_blank\" >自营服饰</a>";
									}
								}
							}
							else
							{
                                //Directory dir = (Directory)Tools.getManager(Directory.class).get(islist.get(i).getTicketCrd().get().getTktmst_rackcode());
								range="全场";
								if(islist.get(i).getTicketCrd().getTktcrd_brandname()!=null&&islist.get(i).getTicketCrd().getTktcrd_brandname().length()>0)
								{
									range=islist.get(i).getTicketCrd().getTktcrd_brandname();
								}else if(islist.get(i).getTicketCrd().getTktcrd_rackcode()!=null&&islist.get(i).getTicketCrd().getTktcrd_rackcode().length()>0)
								{
                                     Directory dir = (Directory)Tools.getManager(Directory.class).get(islist.get(i).getTicketCrd().getTktcrd_rackcode());
							
									if(dir!=null&&!"000".equals(dir.getId())){
										range = "<a href=\"http://www.d1.com.cn/result.jsp?productsort="+dir.getId()+"&shopd1=1\" style=\" text-decoration:underline;\" target=\"_blank\" >自营"+dir.getRakmst_rackname()+"</a>";
									}
								}
							
							}
					%>
				   <tr height="35"  ><td width="80"><% 
				           
				          
						   if(islist.get(i).getType()==0)
		                      {
		                    	   out.print("优惠券");  
		                      }
		                      else
		                      {
		                    	  out.print("减免券");  
		                      }
				   %></td>
				   <td width="80"><span><b><%
                      if(islist.get(i).getType()==0)
                      {
                    	  out.print("￥"+Tools.getFloat(islist.get(i).getTicket().getTktmst_value(),2));
                      }
                      else
                      {
                    	  out.print("￥"+Tools.getFloat(islist.get(i).getTicketCrd().getTktcrd_realvalue().floatValue(),2));
                      }
				    %></b></td>
				   <td width="60">未使用</td>
				   <td width="220"><%
						    if(islist.get(i).getType()==0)
		                      {
						    	if(islist.get(i).getTicket().getTktmst_validatee()!=null&&islist.get(i).getTicket().getTktmst_validates()!=null)
						    	{
						    		out.print(Tools.getFormatDate(islist.get(i).getTicket().getTktmst_validates().getTime(), "yyyy-MM-dd")+"~"+Tools.getFormatDate(islist.get(i).getTicket().getTktmst_validatee().getTime(), "yyyy-MM-dd"));
						    	}
		                      }
		                    	
		                      else
		                      {
		                    	  if(islist.get(i).getTicketCrd().getTktcrd_validatee()!=null&&islist.get(i).getTicketCrd().getTktcrd_validates()!=null)
							    	{
							    		out.print(Tools.getFormatDate(islist.get(i).getTicketCrd().getTktcrd_validates().getTime(), "yyyy-MM-dd")+"~"+Tools.getFormatDate(islist.get(i).getTicketCrd().getTktcrd_validatee().getTime(), "yyyy-MM-dd"));
							    	}
		                      }
				   %></td>
				   
				   <td width="90"><%if (range!=null&&range.equals("FEEL MIND")){  %>
				   <a href="http://www.d1.com.cn/brand/feelmind" style=" text-decoration:underline;" target="_blank" ><%=range%></a>
				   <%}
				   else{%>
			       <%=range%>
			       <%} %>
				   </td>
				   <td width="150"><b>
				   <%  if(islist.get(i).getType()==0)
		                      {
						    	out.print("满"+Tools.getFloat(islist.get(i).getTicket().getTktmst_gdsvalue(),2)+"-"+Tools.getFloat(islist.get(i).getTicket().getTktmst_value(),2));
										
		                      
		                      }
		                      else
		                      {
		                    	 out.print("所购的商品按照"+Tools.getFloat((islist.get(i).getTicketCrd().getTktcrd_discount().floatValue()*100),2)+"%减免");
		                     
		                      }
				   %></b></td>
				   <td><%  if(islist.get(i).getType()==0) out.print(Tools.getFormatDate(islist.get(i).getTicket().getTktmst_createdate().getTime(), "yyyy-MM-dd"));
				           else
				           {
				        	   if(islist.get(i).getTicketCrd()!=null&&islist.get(i).getTicketCrd().getTktcrd_createdate()!=null)
				        		   out.print(Tools.getFormatDate(islist.get(i).getTicketCrd().getTktcrd_createdate().getTime(), "yyyy-MM-dd"));
				           }   %></td>
				          
				   <%} 
					}%>
				   <tr>
                 
					       <td colspan="7" height="45">
					       <% if(islist!=null&&islist.size()>0)
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
					    	   
					      <%  }
					       else
					       { %>
					    	您还没有优惠券  
					       <%}
					       %>
					       
					          
					       </td>
					 </tr>

				   </table>

					</div>

					 <div style=" display:none;">

					  <table width="769"  border="0" cellspacing="0" cellpadding="0"  class="t" style=" border:solid 1px #c2c2c2; border-bottom:none;" >

				   <tr style=" color:#a25663;" height="33"><td class="d1"  width="80">优惠券类型</td><td  class="d1" width="80">金额</td><td class="d1" width="60">状态</td><td class="d1" width="220">有效期</td><td class="d1" width="91">适用商品范围</td> <td class="d1" width="151">使用规则</td>
				   <td class="d1">生成时间</td></tr>

				   </table>

					<table width="769"  border="0" cellspacing="1" cellpadding="0"  class="t" >

				   <%
				  
				   //分页
					if(ggURL != null) 
					   {
					     ggURL.replaceAll("pageno2=[0-9]*","");
					   }
				//翻页
				 int totalLength2 = (nolist != null ?nolist.size() : 0);
				   int currentPage2 = 1 ;
				  String pg2 ="1";
				  if(request.getParameter("pageno2")!=null)
				  {
				  	pg2= request.getParameter("pageno2");
				  }
				  if(StringUtils.isDigits(pg2))currentPage2 = Integer.parseInt(pg2);
				  PageBean pBean2 = new PageBean(totalLength2,PAGE_SIZE,currentPage2);
				  int end2 = pBean2.getStart()+PAGE_SIZE;
				  if(end2 > totalLength2) end2 = totalLength2;
				  String pageURL2 = ggURL.replaceAll("pageno2=[^&]*","");
				  if(!pageURL2.endsWith("&")) pageURL2 = pageURL2 + "&";
						
					if(nolist!=null){
						 if(request.getParameter("pageno2")!=null&&request.getParameter("pageno2").length()>0)
						   {
							   pageno2=Tools.parseInt(request.getParameter("pageno2"));
						   }
						//for(Ticket ticket:ticketList123)
						for(int i=(pageno2-1)*10;i<nolist.size()&&i<pageno2*10;i++)
						{
							String range = "全场";
							if(nolist.get(i).getType()==0)
							{
								//Directory dir = (Directory)Tools.getManager(Directory.class).get(ticket.getTktmst_rackcode());

								if(!Tools.isNull(nolist.get(i).getTicket().getTktmst_sprckcodeStr())){
									range="<a href=\"http://www.d1.com.cn/html/result_rec.jsp?aid="+nolist.get(i).getTicket().getTktmst_sprckcodeStr()+"\" style=\" text-decoration:underline;\" target=\"_blank\" >促销专区</a>";

								   }
								else if(nolist.get(i).getTicket().getTktmst_brandname()!=null&&nolist.get(i).getTicket().getTktmst_brandname().length()>0)
								{
									range=nolist.get(i).getTicket().getTktmst_brandname();
								}
								else
								{
									
									Directory dir = (Directory)Tools.getManager(Directory.class).get(nolist.get(i).getTicket().getTktmst_rackcode());
									
									if(dir!=null){
										range = dir.getRakmst_rackname();
									}
								}
								
								
							}
							else
							{
                                //Directory dir = (Directory)Tools.getManager(Directory.class).get(islist.get(i).getTicketCrd().get().getTktmst_rackcode());
								
								range="全场";
							
							}
					  
					%>
				   <tr height="35"  ><td width="80"><% 
                     if(nolist.get(i).getType()==0)
                      {
					      out.print("优惠券");
	                  }
                      else
                      {
                    	  out.print("减免券");
                      }
				   %>
                   </td>
				   <td width="80"><span><b><% if(nolist.get(i).getType()==0)
                      {
					   out.print("￥"+Tools.getFloat(nolist.get(i).getTicket().getTktmst_value(),2));
	                  }
                      else
                      {
                    	  out.print("￥"+Tools.getFloat(nolist.get(i).getTicketCrd().getTktcrd_realvalue(),2));
                      }
                   %></b></td>
				   <td width="60">
				   <% if(nolist.get(i).getType()==0)
                      {
						   if(nolist.get(i).getTicket().getTktmst_validflag().longValue()==1)
						   {
							   out.print("已使用");
						   }
						   else
						   {
							   out.print("未使用");
						   }
                     
                      }
                      else
                      {
                    	  if(nolist.get(i).getTicketCrd().getTktcrd_validflag().longValue()==1&&nolist.get(i).getTicketCrd().getTktcrd_realvalue()>0)
	   					   {
	   						   out.print("未使用");
	   					   }
	   					   else
	   					   {
	   						   out.print("已使用");
	   					   } 
                       }
                      %>
				   
				 </td>  
				   <td width="220"><%
						    if(nolist.get(i).getType()==0)
		                      {
						    	if(nolist.get(i).getTicket().getTktmst_validatee()!=null&&nolist.get(i).getTicket().getTktmst_validates()!=null)
						    	{
						    		out.print(Tools.getFormatDate(nolist.get(i).getTicket().getTktmst_validates().getTime(), "yyyy-MM-dd")+"~"+Tools.getFormatDate(nolist.get(i).getTicket().getTktmst_validatee().getTime(), "yyyy-MM-dd"));
						    	}
		                      }
		                    	
		                      else
		                      {
		                    	  if(nolist.get(i).getTicketCrd().getTktcrd_validatee()!=null&&nolist.get(i).getTicketCrd().getTktcrd_validates()!=null)
							    	{
							    		out.print(Tools.getFormatDate(nolist.get(i).getTicketCrd().getTktcrd_validates().getTime(), "yyyy-MM-dd")+"~"+Tools.getFormatDate(nolist.get(i).getTicketCrd().getTktcrd_validatee().getTime(), "yyyy-MM-dd"));
							    	}
		                      }
				   %></td>
				   <td width="90"><%=range%></td>
				   <td width="150"><b><%  if(nolist.get(i).getType()==0)
		                      {
						    	out.print("满"+Tools.getFloat(nolist.get(i).getTicket().getTktmst_gdsvalue(),2)+"-"+Tools.getFloat(nolist.get(i).getTicket().getTktmst_value(),2));
										
		                      
		                      }
		                      else
		                      {
		                    	  out.print("所购商品按照"+Tools.getFloat((nolist.get(i).getTicketCrd().getTktcrd_discount().floatValue()*100),2)+"%减免券");
				                            
		                      }
				   %></b></td>
				   <td><%  if(nolist.get(i).getType()==0) out.print(Tools.getFormatDate(nolist.get(i).getTicket().getTktmst_createdate().getTime(), "yyyy-MM-dd"));
				           else
				           {
				        	  if(nolist.get(i).getTicketCrd()!=null)out.print(Tools.getFormatDate(nolist.get(i).getTicketCrd().getTktcrd_createdate()==null?nolist.get(i).getTicketCrd().getTktcrd_validates().getTime():nolist.get(i).getTicketCrd().getTktcrd_createdate().getTime(), "yyyy-MM-dd"));
				           }   %></td>
				   <%}
					}%>
				   <tr>
                        <td colspan="7" height="45">
                         <% if(nolist!=null&&nolist.size()>0)
					       {%>
					           <span class="Pager" style="margin:0px auto; overflow:hidden;">
					           	<span>共<font class="rd"><%=pBean2.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean2.getCurrentPage() %></font>页</span>
					           	<a href="<%=pageURL2 %>pageno2=1">首页</a><%if(pBean2.hasPreviousPage()){%><a href="<%=pageURL2%>pageno2=<%=pBean2.getPreviousPage()%>">上一页</a><%}%><%
					           	    for(int i=pBean2.getStartPage();i<=pBean2.getEndPage()&&i<=pBean2.getTotalPages();i++){
					           		if(i==currentPage2){
					           		%><span class="curr"><%=i %></span><%
					           		}else{
					           		%><a href="<%=pageURL2 %>pageno2=<%=i %>"><%=i %></a><%
					           		}
					           	}%>
					           	<%if(pBean2.hasNextPage()){%><a href="<%=pageURL2%>pageno1=<%=pBean2.getNextPage()%>">下一页</a><%}%>
					           	<a href="<%=pageURL2 %>pageno2=<%=pBean2.getTotalPages() %>">尾页</a>
					           </span>
					           <% }
					           else
					           {%>
					        	 您还没有优惠券  
					           <%}%>
					       </td>
					 
				   </tr>

				   </table>

					 </div>

			   </div>

		</div>
		<table width="769" height="20"><tr><td></td></tr></table>

		<div class="jhyhq">

		    <table width="769"  border="0" cellspacing="0" cellpadding="0" class="jhtable"  >

		   

		    <tr><td colspan="3" style=" background:url(http://images.d1.com.cn/images2012/New/user/inorderbg.jpg);text-align:left;" height="33"><span style=" color:#a25663; font-size:14px;"><b>&nbsp;&nbsp;如已获得优惠券码，请查看券面名称，并在下方对应位置激活：</b></span></td></tr>

			<tr><td colspan="3" height="10"></td></tr>

		   <tr>

		      <td width="100" style=" text-align:right" height="50">优惠券:&nbsp;&nbsp;</td>
		      <td><input type="text" id="ticketcode" /></td><td width="407">
		      <input type="button"  id="activetickets" style=" border:none; width:120px; height:26px; background-color:#fff;" onclick="ActivateTicket()"  class="ActivateEquan1"  >
		      </input>
		      </td>

		   </tr>

		   <tr><td colspan="3" height="30"></td></tr>

		   <tr><td colspan="3" style=" text-align:center;"><div style=" margin:0px auto; background-color:#f3f3f3; width:760px; height:100px; text-align:left; line-height:100px;">
		   <% if (Tools.isNull(chePingAn)){%>
			   &nbsp;&nbsp;您目前有积分:<font color="#d60002"><%=ProductGroupHelper.getRoundPrice(UserScoreHelper.getRealScore(lUser.getId())) %></font>分&nbsp;&nbsp;<a href="/jifen/index.jsp" target="_blank"><img src="http://images.d1.com.cn/images2012/New/user/dhyhq.jpg" style=" vertical-align:middle" /></a>
			  <% }%>
		
		   </div></td></tr>

		   <tr><td colspan="3" height="10"></td></tr>

		   </table>

		</div>
 </div>
 
	  <!-- 右侧结束 -->
         
     </div>
    <div class="clear"></div>
    <!--中间内容结束-->
    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>
<script language="javascript" type="text/javascript" >
    function $aa(id) { return document.getElementById(id) };

function bindtags(tags1,contentlist,bigdiv)
{
   var 	t0=$aa(tags1).getElementByNames("a");
   var c0=$aa(contentlist).getElementByNames("div");
   
}
function switch_tags(tags, contents, cls, index, method, time) {
    this.time = time;
    this.method = method;
    this.tags = tags;
    this.contents = contents;
    this.cls = cls;
    this.c_index = index;
    tags[index].className = cls;
    if(index==1)
	{
	 $aa("yh_tags").className="tags4";
	}
    else
	{
	 $aa("yh_tags").className="tags3";
	}
	
    contents[index].style.display = "";
    this.bind_switch();
};

switch_tags.prototype.bind_switch = function() {
    var nb = this;
    var set_int;
    for (var i = 0; i < this.tags.length; i++) {
        this.tags[i].index = i;
        //onmouseover	
        if (this.method == "click") {
            this.tags[i].onmouseover = function() {
                var o = this;
                set_int = setTimeout(function() { sw(o.index) }, nb.time);
            };
            this.tags[i].onmouseout = function() {clearTimeout(set_int); }
        }
        //onclick
        else if (this.method == "mouseover") {
            this.tags[i].onclick = function() { sw(this.index); }
        }
		
    }
    //延时切换		
    function sw(m) {
           var obj = nb.tags[m];
        nb.tags[nb.c_index].className = "";
        nb.contents[nb.c_index].style.display = "none";
        obj.className = nb.cls;
        nb.contents[obj.index].style.display = "";
        nb.c_index = obj.index;
		switch(m)
		{
			case 0:
					 {
						 $aa("yh_tags").className="tags1";
						 break;
					 };
			case 1:
			{
				$aa("yh_tags").className="tags2";
						 break;
			};
			
			default:
					{
				   $aa("yh_tags").className="tags1";
						 break;
				};
		}
    };
	
};

var t1 = $aa("yh_tags").getElementsByTagName("a");
var c1 = $aa("yh_content_list").getElementsByTagName("div");
var strHref = window.document.location.href;
if(strHref.indexOf("?")>0)
	{
	  if(strHref.lastIndexOf('=')>5)
		  {
		     strHref=strHref.substr((strHref.lastIndexOf('=')-7),7);
		     if(strHref=='pageno1')
		    	 {
		    	 new switch_tags(t1, c1, "active", 0, "mouseover");
		    	 }
		     else
		    	 {
		    	 new switch_tags(t1, c1, "active", 1, "mouseover");
		    	 }
		  }
	  else
		  {
		  new switch_tags(t1, c1, "active", 0, "mouseover");
		  }
	}
else
	{
	  new switch_tags(t1, c1, "active", 0, "mouseover");
	}
//new switch_tags(t1, c1, "active", 0, "mouseover");
</script>


