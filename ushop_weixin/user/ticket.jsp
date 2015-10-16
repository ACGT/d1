<%@ page contentType="text/html; charset=UTF-8"%><%@include
	file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%@include file="../inc/islogin.jsp"%><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-会员专区—我的优惠券</title>
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>"
	type="text/css" rel="stylesheet" />
<link
	href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/wap.css")%>"
	rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
	<!-- 头部 -->
	<%@ include file="../inc/head.jsp"%>
	<!-- 头部结束 -->
	<div style="margin-bottom: 15px;">
		<div style="background: #FFDEAD; padding: 3px; width: 100%;">
			<a href="/mindex.jsp">首页</a>><a href="index.jsp">我的优尚</a>>我的优惠券 <br />
		</div>
		<%

    ArrayList<TicketHelper.TicketWrap> islist=new ArrayList<TicketHelper.TicketWrap>();
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
			
		}
		else
		{
			TicketCrd tc=tw.getTicketCrd();
			if(tc.getTktcrd_validflag().longValue()==1&&tc.getTktcrd_validatee().after(new Date())&&tc.getTktcrd_realvalue()>0)
			{
				islist.add(tw);
			}
			
		}
	}

%>

		<% 

	 if(islist==null||islist.size()==0 ){
         
    	    out.print("&nbsp;您没有任何优惠券,<a href=\"/wap/user/index.jsp\">返回我的优尚</a>");
    	  }
    else
    {
    	//分页
		   int pageno1=1;
		   
			String ggURL = Tools.addOrUpdateParameter(request,null,null);
			if(ggURL != null) 
				   {
				     ggURL.replaceAll("pageno1=[0-9]*","");
				   }
			//翻页
			 int totalLength1 = (islist != null ?islist.size() : 0);
			 	
			  int PAGE_SIZE = 5 ;
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
    %>
		<form action="ticket.jsp" method="post">
			<input type="hidden" name="ticket" value="ticket"></input>
			<table>
				<tr>
					<td>&nbsp;有效优惠券(<%= islist.size() %>)
					</td>
				</tr>
				<% 
           if(request.getParameter("pageno1")!=null&&request.getParameter("pageno1").length()>0)
		   {
			   pageno1=Tools.parseInt(request.getParameter("pageno1"));
		   }
           
           for(int i=(pageno1-1)*10;i<islist.size()&&i<pageno1*10;i++)
            {
            	String range = "全场";
				
				if(islist.get(i).getType()==0)
				{
					if(islist.get(i).getTicket().getTktmst_brandname()!=null&&islist.get(i).getTicket().getTktmst_brandname().length()>0)
					{
						range=islist.get(i).getTicket().getTktmst_brandname();
					}
					else
					{
						
						Directory dir = (Directory)Tools.getManager(Directory.class).get(islist.get(i).getTicket().getTktmst_rackcode());
						
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
				<tr>
					<td>&nbsp;<%= i+1 %>、<%= range %>&nbsp;&nbsp;&nbsp; <%  if(islist.get(i).getType()==0)
		                      {
						    	out.print("满"+Tools.getFloat(islist.get(i).getTicket().getTktmst_gdsvalue(),2)+"-"+Tools.getFloat(islist.get(i).getTicket().getTktmst_value(),2));
										
		                      
		                      }
		                      else
		                      {
		                    	 out.print("所购的商品按照"+Tools.getFloat((islist.get(i).getTicketCrd().getTktcrd_discount().floatValue()*100),2)+"%减免");
		                     
		                      }
				   %>
					</td>
				</tr>
				<tr>
					<td>&nbsp;金额：<%
                      if(islist.get(i).getType()==0)
                      {
                    	  out.print(Tools.getFloat(islist.get(i).getTicket().getTktmst_value(),2)+"元");
                      }
                      else
                      {
                    	  out.print(Tools.getFloat(islist.get(i).getTicketCrd().getTktcrd_realvalue().floatValue(),2)+"元");
                      }
				    %></td>
				</tr>
				<tr>
					<td>&nbsp;有效期：<%
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
				</tr>

				<%
				
            }
           %>
				<tr>
					<td>
						<% if(islist!=null&&islist.size()>0)
					       {%> <% if(pBean1.hasPreviousPage()){ %>&nbsp;<a
						href="<%=pageURL1%>pageno1=<%=pBean1.getPreviousPage()%>">上页</a>
						<%} %> <% if(pBean1.hasNextPage()){ %>&nbsp;&nbsp;<a
						href="<%=pageURL1%>pageno1=<%=pBean1.getNextPage()%>">下页</a>
						<%} %> &nbsp;&nbsp;<input type="text" name="pageno1"
						style="width: 50px;" id="page" value="<%=currentPage1%>" />/<%=pBean1.getTotalPages() %>
						&nbsp;&nbsp;<input type="submit" value="跳转" style="padding: 3px;" />

						<%  }%>
					</td>
				</tr>
			</table>
		</form>
		<%}
	

      %>


		<br /> <a href="activeticket.jsp">激活新优惠券>></a> <br /> 返回 <a
			href="index.jsp">我的优尚</a>
	</div>



	<!-- 尾部 -->
	<%@ include file="../inc/userfoot.jsp"%>
	<!-- 尾部结束 -->
</body>
</html>

