 <%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
 <%String productsort =request.getParameter("productsort");

String	 productsort1 =productsort;

 %>
 <div class="mbodyllist">
	    
				<div class="mbllistt">
				<%if(productsort.equals("020")){
					out.print("女士服装");
				}else if(productsort.equals("030")){
					out.print("男士服装");
				}else if(productsort.equals("014")){
					out.print("化妆品");
				} %>
				</div><%
				
				List<Directory> dirList = DirectoryHelper.getByParentcode(productsort);
							
				System.out.print(dirList.size());
				if(dirList != null && !dirList.isEmpty()){
				%>
				<div class="classList">
							<div class="water"></div>
							<ul class="foldheader1"><%
					for(Directory dir : dirList){
						if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())>0){
						%><li class="parent"><a href="/result.jsp?productsort=<%=dir.getId() %>"<%if(productsort.equals(dir.getId())){ %> class="on"<%} %>>▼<%=dir.getRakmst_rackname() %></a></li><%
						List<Directory> childDirList = DirectoryHelper.getByParentcode(dir.getId());
						if(childDirList != null && !childDirList.isEmpty()){
							for(Directory childDir : childDirList){
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())>0){
								%><li><a href="/result.jsp?productsort=<%=childDir.getId() %>"<%if(productsort.equals(childDir.getId())){ %> class="on"<%} %>><span style="font-size:14px;">>&nbsp;</span><%=childDir.getRakmst_rackname() %></a></li><%
							}
							}
						}
					}
					}
				%></ul></div><%
			
				}%>
				
			
			</div>
			<%String onerck="";
			  if(!Tools.isNull(productsort1)){
				  String[] stra=null;
				  List<RackcodeTop> hotList=null;
			    	if(productsort1.indexOf(",")>-1){
			    		productsort1.replace("，", ",");
			    		 stra=productsort1.split(",");
		
			    		for(int i=0;i<stra.length;i++){	
			    			if (i==0)onerck=stra[i];
			   List<RackcodeTop> rtopList = RcktopHelper.getHotMale(stra[i],5);
			   if(rtopList!=null&&rtopList.size()>0){
			   for(RackcodeTop rtop:rtopList){
				   hotList.add(rtop);
			             }
			        }
			    		}
			    		}else{
			    			hotList = RcktopHelper.getHotMale(productsort1,5);	
			    		}

			    		%>
			    		 <div class="mbodyllist">
					     <div class="mbllistt">热销排行榜</div>
					     <%
					     if(hotList!=null&&hotList.size()>0){
					     for(RackcodeTop rtopd:hotList){
					    	 Product p=ProductHelper.getById(rtopd.getRcktop_gdsid());
					    	 if(p!=null&&p.getGdsmst_validflag().longValue()==1){
					    		 String imgurlrtop=ProductHelper.getImageTo160(p);
					    		
					    		 String gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,46) ;
					    		 
					    		 double gprice=p.getGdsmst_memberprice().doubleValue();
					    	boolean	msflag= CartHelper.getmsflag(p);
					    	String mstxt="";
									if(msflag){
										gprice=p.getGdsmst_msprice().doubleValue();
										mstxt="秒杀";
									}
					    	 %>
					     <div  class="rcktop"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" title="<%=gname %>"  target="_blank"><img src="<%=imgurlrtop %>" alt="<%=gname %>"  width="160" height="160" border="0" /></a><br />
		 <%=mstxt %><span class="pricetop">￥<%=Tools.getDouble(gprice, 2)  %></span><br />
		 <span><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" title="<%=gname %>"  target="_blank"><%=gname %></a></span>
		 </div>
					<%}
					} 
					     }%>
					</div>
					
			<%
	}
			%>