<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/html/header.jsp" %>



<%!

//获取新图
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
	ArrayList<GdsCutImg> list=new ArrayList<GdsCutImg>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("gdsmst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(GdsCutImg.class).getList(clist, null, 0,1);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((GdsCutImg)be);
		}
	}	
	
 return list;
}
%>

<%
   String gdsid="";
   String tf="";
   int width=0;
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	 
	   gdsid=request.getParameter("gdsid");
	
   }
   else return;
   if(request.getParameter("w")!=null&&request.getParameter("w").length()>0)
   {
	   width=Tools.parseInt(request.getParameter("w"));
   }
 
   int flag=1;
   if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0)
   {
	   flag=Tools.parseInt(request.getParameter("flag"));
   }
   if(request.getParameter("tf")!=null&&request.getParameter("tf").length()>0)
   {
	   tf=request.getParameter("tf");
   }
   Product product=ProductHelper.getById(gdsid);
   if(product!=null)
   {
	 //获取背景图片
		String bg="";
		String namec="";
		String mpc="";
		String sc="";
		String bgc="";
		String border="";
		String tbimg="";
	
		if(flag==1||flag==2||flag==3||flag==4||flag==11||flag==12)
		{
			namec=" color:#7f7f7f";
			mpc=" color:#b80024";
			sc=" color:#333";
			bgc="#d8d8d8";
			border="#545454";
			if(width<=784){
			   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fl1.png";
			}
			else
			{
				 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/fr1.png";
			}
		}

		if(flag==8||flag==9||flag==10)
		{
			namec=" color:#858178";
			mpc=" color:#b80024";
			sc=" color:#ca0000";
			bgc="#dbd5c7";
			border="#a99c94";
			if(width<=784){
				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sl1.png";
				}
				else
				{
					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/sr1.png";
				}
		}
		if(flag==5||flag==6||flag==7)
		{
			namec=" color:#cf85a8";
			mpc=" color:#fff";
			sc=" color:#fff";
			bgc="#b2366c";
			border="#722245";
			if(width<=784){
				   tbimg="http://images.d1.com.cn/images2012/index2012/JULY/al1.png";
				}
				else
				{
					 tbimg="http://images.d1.com.cn/images2012/index2012/JULY/ar1.png";
				}
		}
	    String imgurl="";
		 ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
		 if(gcilist!=null&&gcilist.size()>0)
		 {
			 if(gcilist.get(0)!=null&&gcilist.get(0).getGdscutimg_160()!=null&&gcilist.get(0).getGdscutimg_160().length()>0)
			 {
				 imgurl="http://images.d1.com.cn"+gcilist.get(0).getGdscutimg_160();
			 }
			 else
			 {
				 imgurl=ProductHelper.getImageTo160(product);
			 }
		 }
		 else
		 {
			 imgurl=ProductHelper.getImageTo160(product);
		 }
		 String floats="";
		 if(width>784)
		 {
			 floats="left";
		 }
		 else
		 {
			 floats="right";
		 }
		 
		 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
		 long currentTime = System.currentTimeMillis();
		  String tbtop="";
		  if(tf.equals("1"))
		  {
			  tbtop="60px;";
		  }
		  else if(tf.equals("2"))
		  {
			  tbtop="130px;";
		  }
		  else
		  {
			  tbtop="210px;";
		  }
		
		  if(width<=784){%>
		  <img src="<%= tbimg %>" id="tbimg_<%= flag %>" style="position:absolute; top:<%= tbtop%>;"/>
		  
		  <%} %>
		  <span style="display:block;padding-bottom:5px; width:176px; overflow:hidden;border:solid 2px <%=border%>; background:<%=bgc%>;float:<%= floats%>">
		  <%
		 out.print("<table style=\" width:176px; overflow:hidden;\" cellspcing=\"0\" cellpadding=\"0\">");
	     if(width>784){%>
			 <tr><td width="8"></td><td height="8"></td><td width="8"></td></tr>
			 <tr><td></td><td>
			 <a href="/product/<%= product.getId() %>" target="_blank" ><img src="<%= imgurl %>"  style="background:#fff;"/></a></td>
			 <td></td></tr>
			 <tr><td coslpan="3" height="3"></td></tr>
			 <tr><td width="8"></td>
			 <td><a href="/product/<%= product.getId() %>" target="_blank" style="font-size:13px;<%= namec%>">
			 <%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)%></a></td><td></td></tr>
			 <tr><td coslpan="3" height="4"></td></tr>
			 <tr><td width="8"></td><td style=" text-align:center;">
			 <% 
			 if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
				 %>
				 <font style=" font-family:微软雅黑; font-size:13px;<%= mpc%>"><b>特价：￥<%= Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;
			    <font style="text-decoration:line-through;<%=sc %>">￥<%= Tools.getFormatMoney(product.getGdsmst_oldmemberprice())%></font>
	
	<%		}else
			{%>
				<font style=" font-family:微软雅黑;font-size:13px;<%= mpc%>"><b>￥<%= Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>
			<%}%>
		 </td><td></td></tr>
		 <%
		}else
		{%>
			<tr><td width="8"></td><td height="8"></td><td width="8"></td></tr>
			<tr><td width="8"></td><td>
			 <a href="/product/<%=product.getId()%>" target="_blank"><img src="<%=imgurl%>"  style="background:#fff;"/></a></td>
			 <td width="8"></td>
			 </tr>
			<tr><td coslpan="3" height="3"></td></tr>
			<tr><td width="8"></td><td><a href="/product/<%= product.getId()%>" target="_blank" style="font-size:13px;<%=namec%>"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),64)%></a></td>
			<td width="8"></td></tr>
			<tr><td coslpan="3" height="2"></td></tr>
			<tr><td width="8"></td>
			<td style=" text-align:center;">
			<% 
			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
				%>
			<font style=" font-family:微软雅黑; font-size:13px;<%=mpc%>"><b>特价：￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>&nbsp;&nbsp;&nbsp;&nbsp;
			<font style="text-decoration:line-through;<%=sc %>">￥<%= Tools.getFormatMoney(product.getGdsmst_oldmemberprice())%></font>
	       <% 
			}else
			{%>
				<font  style=" font-family:微软雅黑;font-size:13px;<%= mpc%>"><b>￥<%= Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>
			<%}%>
			 </td><td width="8"></td></tr>
		<%}
	     out.print("</table>");
         %>
         </span>
         <% if(width>784){%>
		  <img src="<%= tbimg %>" id="tbimg_<%= flag %>" style="position:absolute; right:0px; top:<%= tbtop%>;"/>
		  
		  <%} %>
   <%}
%>
