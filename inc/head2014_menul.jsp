 <%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
		//获取推荐位
		 public static ArrayList<SplRck> GetSplRckList(String splcode)
		 {
		 	ArrayList<SplRck> list=new ArrayList<SplRck>();
		 	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		 	clist.add(Restrictions.eq("splrck_rackcode", splcode));
		 	List<Order> olist=new ArrayList<Order>();
		 	olist.add(Order.asc("splrck_seq"));
		 	List<BaseEntity> b_list = Tools.getManager(SplRck.class).getList(clist, olist, 0, 100);
		 	if(b_list!=null){
		 		for(BaseEntity be:b_list){
		 					list.add((SplRck)be);
		 	     }
		 	}
		 	return list;
		 }
		 %>
<%
ArrayList<Promotion> head_plist=new ArrayList<Promotion>();
ArrayList<SplRck> head_splrcklist=new ArrayList<SplRck>(); %>
 document.write('<div style=\"width:90\%; margin:0px auto;\">');
 document.write('	   <dl>');
 document.write('<dt attr=\"0\">');<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005001");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);	
			 if( head_plist!=null&& head_plist.size()>0)
			 {%>document.write(' <b><a href=\"http://www.d1.com.cn/html/women/\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">女装</a>&nbsp;&nbsp;></b> ');
				<%for(int i=0;i<head_plist.size();i++)
				 {
					 Promotion p=head_plist.get(i);
					 if(p!=null)
					 {
						 if(i%4==0)
						 {%> document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
						 <%}
						 else if(i%4==3)
						 {%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
						 <%}
						 else
						 {%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
						 <%}
					 }
				 }
			 }
		 }
		%>document.write('</dt>');
		 document.write('<dd >');
		 document.write('<table width=\"100%\" >');
		 document.write('<tr>');
		 document.write('<td valign=\"top\">');<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%> document.write('<ul>');
				<%
				if(!srl.getId().equals("3521")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
				     for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%> document.write(' <li class=\"childclass\">');
								 document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							  document.write('</li> ');
							  document.write('<li>'); <%}
							 else if(i==head_plist.size()-1)
							 {%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							   document.write('</li> ');
							 <%}
							 else
							 {%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>document.write('</ul>');<%
			}
			
		 }
		%> document.write('</td>');
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3521", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>document.write('</td></tr>');
		 document.write('</table>');	
		 document.write('</dd>');
        document.write('</dl>');
	    document.write('<dl>');
		 document.write('<dt attr=\"1\">');<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005002");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 { %>
				  document.write('<b><a href=\"http://www.d1.com.cn/html/men/\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">男装</a>&nbsp;&nbsp;></b> ');
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a></p>');
							  <%}
							 else
							 {%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>document.write('</dt>');
		 document.write('<dd >');
		 document.write('<table width=\"100%\" >');
		 document.write('<tr>');
		 document.write('<td valign=\"top\">');<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3522")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>document.write('<li class=\"childclass\">');
								 document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							  document.write('</li> ');
							  document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
							 document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							  
								 document.write('</li> ');
							 <%}
							 else
							 {%>
								 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			 document.write('</ul>');<%
			}
			
		 }
		%>
		 document.write('</td>');
		
		 document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3522", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>" width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		 document.write('</td></tr>');
		 document.write('</table>');
		 document.write('</dd>');
        document.write('</dl>');
	    document.write(' <dl>');
		 document.write('<dt attr=\"2\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005003");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				   document.write('<b><a href=\"http://cosmetic.d1.com.cn/\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">化妆品</a>&nbsp;&nbsp;></b> ');
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								  document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						          document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a></p>');
							 <%}
							 else
							 {%>
								 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		 document.write('</dt>');
		 document.write('<dd >');
		 document.write('<table width=\"100%\" >');
		 document.write('<tr>');
		 document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%> document.write('<ul>');
				<%
				if(!srl.getId().equals("3523")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							 document.write(' <li class=\"childclass\">');
								 document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							  document.write('</li> ');
							  document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
							  document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span></li> ');
							  								
							 <%}
							 else
							 {%>
								 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3523", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	    document.write('<dl>');
		document.write('<dt attr=\"3\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005004");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				 document.write(' <b><a href=\"http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015,012\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">内衣家居</a>&nbsp;&nbsp;></b> ');
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								 document.write('<p> <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						         document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd >');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3524")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							 document.write('<li class=\"childclass\">');
								document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							 document.write('</li> ');
							 document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							  document.write('</li> ');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3524", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	    document.write('<dl>');
		document.write('<dt attr=\"4\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005005");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				  document.write('<b><a href=\"http://www.d1.com.cn/result.jsp?productsort=021,031\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">鞋品</a>&nbsp;&nbsp;></b>'); 
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								 document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						         document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
							    
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd >');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3525")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							 document.write('<li class=\"childclass\">');
								document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							document.write(' </li> ');
							 document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span> </li> ');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3525", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	    document.write('<dl>');
		document.write('<dt attr=\"5\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005006");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				  document.write('<b><a href=\"http://www.d1.com.cn/result.jsp?productsort=050\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">箱包皮具</a>&nbsp;&nbsp;></b> ');
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								document.write(' <p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						        document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
							    
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd >');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3526")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							document.write(' <li class=\"childclass\">');
								document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							 document.write('</li> ');
							 document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span></li>');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3526", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	   document.write(' <dl>');
		document.write('<dt attr=\"6\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005007");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				  document.write('<b><a href=\"http://www.d1.com.cn/result.jsp?productsort=040,015002\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">配件/手表</a>&nbsp;&nbsp;></b>'); 
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								document.write(' <p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						         document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd >');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3527")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							 document.write('<li class=\"childclass\">');
								 document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							 document.write('</li> ');
							document.write(' <li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span> </li> ');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3527", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	   document.write(' <dl>');
		document.write('<dt attr=\"7\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005008");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				  document.write('<b><a href=\"http://www.d1.com.cn/result.jsp?productsort=015009\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">饰品</a>&nbsp;&nbsp;></b>'); 
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								 document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						        document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a></p>');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd >');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				if(!srl.getId().equals("3528")){
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							document.write(' <li class=\"childclass\">');
								document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							 document.write('</li> ');
							 document.write('<li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span> </li> ');
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
				}
			%>
			document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3528", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>
					document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>
		document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
       document.write('</dl>');
	  document.write(' <dl  style=\"display:none;\">');
		document.write('<dt attr=\"8\">');
		<%
		 head_splrcklist.clear();
		 head_splrcklist=GetSplRckList("013002005009");
		 if(head_splrcklist!=null&&head_splrcklist.size()>0&&head_splrcklist.get(0)!=null&&head_splrcklist.get(0).getId()!=null)
		 {
			 head_plist.clear();
			 head_plist=PromotionHelper.getBrandListByCode(head_splrcklist.get(0).getId(),-1);
			 if( head_plist!=null&& head_plist.size()>0)
			 {
				 %>
				  document.write('<b><a href=\"www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015,012\" target=\"_blank\" style=\"font-size:14px;font-family: 微软雅黑; color:#333;\">童装童鞋</a>&nbsp;&nbsp;></b>'); 
					<%for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {
							 if(i%4==0)
							 {%>
								 document.write('<p><a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
							 else if(i%4==3)
							 {%>						 
						        document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a> </p>');
							    
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a>');
							 <%}
						 }
					 }
			 }
		 }
		%>
		document.write('</dt>');
		document.write('<dd>');
		document.write('<table width=\"100%\" >');
		document.write('<tr>');
		document.write('<td valign=\"top\">');
		<%
		if(head_splrcklist!=null&&head_splrcklist.size()>0)
		 {
			for(int j=1;j<head_splrcklist.size();j++)
			{
				SplRck  srl=head_splrcklist.get(j);
				%>document.write('<ul>');
				<%
				 head_plist.clear();
				 head_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
				 if( head_plist!=null&& head_plist.size()>0)
				 {%>
				 
				 <% 
					 for(int i=0;i<head_plist.size();i++)
					 {
						 Promotion p=head_plist.get(i);
						 if(p!=null)
						 {%>
						
							<%
							 if(i==0)
							 {%>
							 document.write('<li class=\"childclass\">');
								document.write(' <a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\" style=\"color:#000\"><b><%= p.getSplmst_name() %></b></a>');
							 document.write('</li> ');
							document.write(' <li>');
							 <%}
							 else if(i==head_plist.size()-1)
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span></li>'); 
							 <%}
							 else
							 {%>
								document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><%= p.getSplmst_name() %></a><span>|</span>');
							 <%}
							
							%>
							
						 <%}
					 }
				 }
			%>document.write('</ul>');<%
			}
			
		 }
		%>
		document.write('</td>');
		
		document.write('<td align=\"right\" valign=\"top\">');
		<% 
		head_plist.clear();
		head_plist=PromotionHelper.getBrandListByCode("3529", 3);
		if(head_plist!=	null&&head_plist.size()>0)
		{
			for(Promotion p:head_plist)
			{
				if(p!=null)
				{%>document.write('<a href=\"<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>\" target=\"_blank\"><img src=\"<%= p.getSplmst_picstr()!=null?p.getSplmst_picstr():"" %>"  width=\"200\" height=\"130\" style=\"margin-bottom:6px;\"/></a>');
				<%}
			}
		}
		%>document.write('</td></tr>');
		document.write('</table>');
		document.write('</dd>');
      document.write(' </dl>');
	   document.write('</div>');