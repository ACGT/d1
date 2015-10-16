<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%
String gdsid = request.getParameter("id");
Product product = ProductHelper.getById(gdsid);
String[] gdsarr=null;
if (product==null){
	out.print("找不到物品信息！");
	return;
}
int showlen=ShowOrderHelper.getSdLenByGdsid(gdsid);
int currentPage = 1 ;
String pg = request.getParameter("pg");
if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);

int PAGE_SIZE = 15 ;
PageBean pBean = new PageBean(showlen,PAGE_SIZE,currentPage);

ArrayList<MyShow> showlist=ShowOrderHelper.getAllShowByGdsid(product.getId());
if(showlen>0 && showlist!=null){
 int end = pBean.getStart()+PAGE_SIZE;
 	    if(end > showlen) end = showlen;
 	 
 	  List<MyShow> list2 =showlist.subList(pBean.getStart(),end);
 	 int size=list2.size();
 	   if(list2!=null && size>0){
 		%>
 		<div style="width:750px;padding-top:15px;" name="sdCont" id="SdContent">
 		<%   
 		   int row=size/3;//得到行数,及每列个数
 		   int last=size%3;
 		   int l1=0; int l2=0; 
 		   if(last==1){
 			   l1=1;
 		   }else if(last==2){
 			  l1=1;
 			  l2=1;
 		   }
 		   for(int i=0;i<size;i++){
 			  MyShow show1=list2.get(i); 
				  Product p=ProductHelper.getById(show1.getMyshow_gdsid());
			
	 				 String uid=show1.getMyshow_mbruid();
	 				 if(uid.trim().length()<6){
	 					 uid="***"+uid+"***";
	 				 }else{
	 					 uid="***"+uid.substring(0, 5)+"***";
	 				 }
 			   if(i==0){
 					%>   
 					<div style="float:left; padding-left:15px;">
 				  <% }else if(i==row+l1){
 					 %>   
 					 </div>
 					  <div style="float:left; ">
 				   <% }else if(i==2*row+l1+l2){
	 					 %>   
	 					 </div>
	 					  <div style="float:left;">
	 				   <% }
	 				    if(p!=null){
				  %>   
				   <div  class="poster_grid poster_wall pins" > 
									<div class="new_poster"> 
									<div class="np_pic hover_pic">   
									<a target="_blank" href="http://images1.d1.com.cn<%=show1.getMyshow_img400500() %>" class="pic_load">
									<img width="200" title="" src="http://images1.d1.com.cn<%=show1.getMyshow_img240300() %>" onmouseover="sdimg_over('<%= show1.getId()%>')" onmouseout="sdimg_out('<%= show1.getId()%>')" class="goods_pic" /></a> 
					 
									</div> 
									<div class="comm_box"> 
									<p class="l18_f posterContent"><table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr><td align="left"><b><%=uid %></b></td><td align="right" width="100"><%= new SimpleDateFormat("yyyy-MM-dd").format(show1.getMyshow_createdate())  %></td></tr><tr><td colspan="2" align="left"><%=Tools.clearHTML(show1.getMyshow_content()) %></td></tr></tr>
									</table></p> 
									</div>
									
									  </div>
									  </div>
									  <div style="clear:both;"></div>
									   <div class="floatdp" id="floatdp<%=show1.getId() %>" style="display:none;" >
									  
									   </div>
					 			  <%  }
						 				    if(i==size-1){
						 				    	%>
						 				    	</div>
						 				   <%  }
					 		  }
 		   
 		%>
 		 <div style="clear:both;height:15px;">&nbsp;</div>
 		 <%    if(pBean.getTotalPages()>1){ %>
		<table cellpadding="0" cellspacing="0" border="0"> <tr>
			<td><div class="GPager">
	           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
	           	<%if(pBean.getCurrentPage()>1){ %><a href="#sdCont" onclick="pro_showorder('<%=gdsid %>',1);">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="#sdCont" onclick="pro_showorder('<%=gdsid %>',<%=pBean.getPreviousPage() %>);">上一页</a><%}%><%
	           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
	           		if(i==1){
	           		%><span class="curr"><%=i %></span><%
	           		}else{
	           		%><a href="#sdCont" onclick="pro_showorder('<%=gdsid %>',<%=i %>);"><%=i %></a><%
	           		}
	           	}%>
	           	<%if(pBean.hasNextPage()){%><a href="#sdCont" onclick="pro_showorder('<%=gdsid %>',<%=pBean.getNextPage() %>);">下一页</a><%}%>
	           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="#sdCont" onclick="pro_showorder('<%=gdsid %>',<%=pBean.getTotalPages() %>);">尾页</a><%} %>
	           </div></td>
		</tr></table><%
		} %>
 		</div>
 		
	
<%}}else{
	%>
	<div style="text-align:center;padding-top:30px;" id="Sdmore" > 还没有会员进行晒单。</div>
<%}
%>