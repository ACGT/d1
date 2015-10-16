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
   int width=0;
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	 
	   gdsid=request.getParameter("gdsid");
	   //System.out.print(gdsid);
	   //Tools.outJs(out, gdsid,"back");
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
   Product product=ProductHelper.getById(gdsid);
   if(product!=null)
   {
	 //获取背景图片
		String bg="";
		String namec="";
		String mpc="";
		String sc="";
		if(flag==1||flag==2||flag==3||flag==4)
		{
			namec=" color:#7f7f7f";
			mpc=" color:#b80024";
			sc=" color:#333";
		}

		if(flag==8||flag==9||flag==10)
		{
			namec=" color:#858178";
			mpc=" color:#b80024";
			sc=" color:#ca0000";
		}
		if(flag==5||flag==6||flag==7)
		{
			namec=" color:#cf85a8";
			mpc=" color:#fff";
			sc=" color:#fff";
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
		 long endTime = Tools.dateValue(product.getGdsmst_discountenddate());
		 long currentTime = System.currentTimeMillis();
		 out.print("<table>");
	     if(width>784){%>
			 <tr><td width="9"></td><td height="8"></td><td width="27"></td></tr>
			 <tr><td width="10"></td><td>
			 <a href="/product/<%= product.getId() %>" target="_blank"><img src="<%= imgurl %>"/></a></td>
			 <td width="27"></td></tr>
			 <tr><td coslpan="3" height="3"></td></tr>
			 <tr><td width="8"></td>
			 <td><a href="/product/<%= product.getId() %>" target="_blank" style="font-size:13px;<%= namec%>">
			 <%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),40)%></a></td><td width="27"></td></tr>
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
		 </td><td width="20"></td></tr>
		 <%
		}else
		{%>
			<tr><td width="27"></td><td height="8"></td><td width="8"></td></tr><tr><td width="27"></td><td>
			 <a href="/product/<%=product.getId()%>" target="_blank"><img src="<%=imgurl%>"/></a></td></tr>
			 <tr><td coslpan="3" height="3"></td></tr>
			<tr><td width="27"><td><a href="/product/<%= product.getId()%>" target="_blank" style="font-size:13px;<%=namec%>"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),64)%></a></td>
			<td width="8"></td></tr>
			<tr><td coslpan="3" height="2"></td></tr>
			<tr><td width="20"></td>
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
 
   }
%>
