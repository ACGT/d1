<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
//默认顶级分类名
private String CateName = "全部";
private String parentId = "000";
//获得面包屑
private String getCateogryLink(String productsort){
	if(!Tools.isNull(productsort)&&productsort.indexOf(",")>-1){
		productsort = productsort.substring(0,productsort.indexOf(","));
	}
	if(Tools.isNull(productsort) || productsort.length() < 3 || "000".equals(productsort)) return "";
	
	int length = productsort.length();
	boolean isRoot = false;
	if(length >= 3){
		String rackcode = null;
		if(productsort.startsWith("017001")){
			rackcode = "017001";
		}else if(productsort.startsWith("017002")){
			rackcode = "017002";
		}else if(productsort.startsWith("017005")){
			rackcode = "017005";
		}else if(productsort.startsWith("017007")){
			rackcode = "017007";
		}else if(productsort.startsWith("017006")){
			rackcode = "017006";
		}else if(productsort.startsWith("017003")){
			rackcode = "017003";
		}else if(productsort.startsWith("014")){
			rackcode = "014";
		}else if(productsort.startsWith("015009")){
			rackcode = "015009";
		}else if(productsort.startsWith("015002")){
			rackcode = "015002";
		}
		else if(productsort.startsWith("020012")){//女式内衣
			rackcode = "020012";
		}else if(productsort.startsWith("030011")){//男式内衣
			rackcode = "030011";
		}
		else if(productsort.startsWith("020")){//女装
			rackcode = "020";
		}else if(productsort.startsWith("030")){//男装
			rackcode = "030";
		}else if(productsort.startsWith("023")){//女式箱包
			rackcode = "023";
		}else if(productsort.startsWith("021")){//女鞋
			rackcode = "021";
		}else if(productsort.startsWith("022")){//女配饰
			rackcode = "022";
		}else if(productsort.startsWith("032")){//男配饰
			rackcode = "032";
		}
		if(rackcode != null){
			Directory dir = DirectoryHelper.getById(rackcode);
			if(dir != null){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
				isRoot = true;
			}
		}
	}
	
	StringBuilder sb = new StringBuilder();
	for(int i=3;i<=length;i=i+3){
		String rackcode = productsort.substring(0,i);
		Directory dir = DirectoryHelper.getById(rackcode);
		if(dir != null){
			if(!isRoot && i==(length-6<3?3:length-6)){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
			}
			sb.append("<b>&gt;</b><a href=\"");
			if("014".equals(rackcode)){
				sb.append("/html/cosmetic/");
			}else if("015".equals(rackcode)){
				sb.append("/html/ornament/");
			}else if("017".equals(rackcode)){
				sb.append("/html/cloth/");
			}else{
				sb.append("/result.jsp?productsort=").append(rackcode);
			}
			if(productsort.equals(rackcode)){
				sb.append("\" class=\"dis\"");
			}else{
				sb.append("\"");
			}
			sb.append(" style=\"color:#892E3F\" target=\"_blank\">&nbsp;").append(dir.getRakmst_rackname()).append("&nbsp;</a>");
		}
	}
	return sb.toString();
}
%>
<%
int w=980;
if(request.getParameter("w")!=null&&request.getParameter("w").toString().length()>0)
{
	   w=Tools.parseInt(request.getParameter("w").toString());
	}	
String productsort1="";
if(request.getParameter("productsort1")!=null&&request.getParameter("productsort1").toString().length()>0)
{
	productsort1=request.getParameter("productsort1").toString();
	}	

%>
<div class="mbodyllist">
	    <%
	    if(!Tools.isNull(productsort1)){
			    	if(productsort1.indexOf(",")>-1){
			    		productsort1.replace("，", ",");
			    		String[] stra=productsort1.split(",");
			    		
			    		for(int i=0;i<stra.length;i++){			    			
			    			Directory dir = DirectoryHelper.getById(stra[i]);
				    		if(dir!=null){
				    			String topstr="";
				    			topstr=getCateogryLink(dir.getId());
				    			%>
				                <div class="mbllistt"><%= topstr.substring(11,topstr.length()) %></div><%
					          List<Directory> dirlist =DirectoryHelper.getByParentcode(dir.getId());	
	
						if(dirlist != null && !dirlist.isEmpty()){
						%>
						<div class="classList">
							<div class="water"></div>
							<ul class="foldheader1"><%
							for(Directory dirs : dirlist){
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dirs.getId())>0){
								%><li class="parent"><a href="http://www.d1.com.cn/result.jsp?productsort=<%=dirs.getId() %>"<%if(productsort1.equals(dirs.getId())){ %> class="on"<%} %>>▼<%=dirs.getRakmst_rackname() %></a></li><%
								
								List<Directory> childDirList = new ArrayList<Directory>();
								childDirList=DirectoryHelper.getByParentcode(dirs.getId());
								
								if(childDirList != null && !childDirList.isEmpty()){
									for(Directory childDir : childDirList){
										if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())>0){
										%><li><a href="http://www.d1.com.cn/result.jsp?productsort=<%=childDir.getId() %>"<%if(productsort1.equals(childDir.getId())){ %> class="on"<%} %> > <span style="font-size:14px;">>&nbsp;</span><%=childDir.getRakmst_rackname() %></a></li><%
									}
									}
								}
							}
							}
						%></ul></div><%
						       } 
				    	   }
			    		}
			    	}
			    	else{
			    	  
			    	   %>
			    	
			    		  <div class="mbllistt"><%=CateName %>分类</div><%
						
                        List<Directory> dirList1 = new ArrayList<Directory>();		
	
							dirList1=DirectoryHelper.getByParentcode(parentId);
						if(dirList1 != null && !dirList1.isEmpty()){
						%>
						<div class="classList">
							<div class="water"></div>
							<ul class="foldheader1"><%
							for(Directory dir : dirList1){
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())>0){
								%><li class="parent"><a href="http://www.d1.com.cn/result.jsp?productsort=<%=dir.getId() %>"<%if(productsort1.equals(dir.getId())){ %> class="on"<%} %>>▼<%=dir.getRakmst_rackname() %></a></li><%
								
								List<Directory> childDirList = new ArrayList<Directory>();
								childDirList=DirectoryHelper.getByParentcode(dir.getId());
								
								if(childDirList != null && !childDirList.isEmpty()){
									for(Directory childDir : childDirList){
										if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())>0){
										%><li><a href="http://www.d1.com.cn/result.jsp?productsort=<%=childDir.getId() %>"<%if(productsort1.equals(childDir.getId())){ %> class="on"<%} %> > <span style="font-size:14px;">>&nbsp;</span><%=childDir.getRakmst_rackname() %></a></li><%
									}
									}
								}
							}
							}
						%></ul></div><%
						}  
			        }       
			       
			    }
			%>	
</div>

	
			<!-- 获取新分类结束 -->
			<%String onerck="";
			  if(!Tools.isNull(productsort1)){
			    	if(productsort1.indexOf(",")>-1){
			    		productsort1.replace("，", ",");
			    		String[] stra=productsort1.split(",");
			    		ArrayList<RackcodeTop> hotList=new ArrayList<RackcodeTop>();
			    		for(int i=0;i<stra.length;i++){	
			    			if (i==0)onerck=stra[i];
			   List<RackcodeTop> rtopList = RcktopHelper.getHotMale(stra[i],5);
			   if(rtopList!=null&&rtopList.size()>0){
			   for(RackcodeTop rtop:rtopList){
				   hotList.add(rtop);
			             }
			        }
			
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
					    		 double gprice=p.getGdsmst_memberprice().doubleValue();
					    		 String gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,46) ;
					    		 boolean	msflag= CartHelper.getmsflag(p);

					   	           if(msflag){
					   	        	  gprice=p.getGdsmst_msprice().doubleValue();
					   	           }
					    	 %>
					     <div  class="rcktop"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" title="<%=gname %>" target="_blank"><img src="<%=imgurlrtop %>" alt="<%=gname %>" width="160" height="160" border="0" /></a><br />
		 <span class="pricetop">￥<%=Tools.getDouble(gprice, 2)  %></span><br />
		 <span><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" title="<%=gname %>"  target="_blank"><%=gname %></a></span>
		 </div>
					<%}
					} 
					     }%>
					</div>
					
			<%}else{
				List<RackcodeTop> rtopList =RcktopHelper.getHotMale(productsort1,5);
				onerck=productsort1;
				%>
				 <div class="mbodyllist">
					     <div class="mbllistt">热销排行榜</div>
					     <%
					     if(rtopList!=null&&rtopList.size()>0){
					     for(RackcodeTop rtopd:rtopList){
					    	 Product p=ProductHelper.getById(rtopd.getRcktop_gdsid());
					    	 if(p!=null&&p.getGdsmst_validflag().longValue()==1){
					    		 String imgurlrtop=ProductHelper.getImageTo160(p);
					    		 double gprice=p.getGdsmst_memberprice().doubleValue();
					    		 String gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,46) ;
					    		 boolean	msflag= CartHelper.getmsflag(p);

					   	           if(msflag){
					   	        	  gprice=p.getGdsmst_msprice().doubleValue();
					   	           }
					    	 %>
					     <div  class="rcktop"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" target="_blank"><img src="<%=imgurlrtop %>" width="160" height="160" border="0" /></a><br />
		 <span class="pricetop">￥<%=Tools.getDouble(gprice, 2) %></span><br />
		 <span><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" target="_blank"><%=gname %></a></span>
		 </div>
			<%}
			}  	
			}%>
			</div>
			<%
			}
	}
			%>