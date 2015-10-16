<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/header.jsp" %>



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
   if(request.getParameter("gdsid")!=null&&request.getParameter("gdsid").length()>0)
   {
	 
	   gdsid=request.getParameter("gdsid");
   }
   else return;
   int flag=1;
   if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0)
   {
	   flag=Tools.parseInt(request.getParameter("flag"));
   }
   int pp=1;
   if(request.getParameter("pp")!=null&&request.getParameter("pp").length()>0)
   {
	   pp=Tools.parseInt(request.getParameter("pp"));
   }
   Product product=ProductHelper.getById(gdsid);
   if(product!=null)
   {
	 //获取背景图片
		String bg="";
		String namec="color:#7f7f7f";
		String mpc="color:#b80024";
		String sc="color:#333";
		
		//if(pp==1)
		//{
			//namec=" color:#7f7f7f";
			//mpc=" color:#b80024";
			//sc=" color:#333";
		//}

		//if(pp==3)
		//{
			//namec=" color:#858178";
			//mpc=" color:#b80024";
			//sc=" color:#ca0000";
		//}
		//if(pp==2)
		//{
			//namec=" color:#cf85a8";
			//mpc=" color:#fff";
			//sc=" color:#fff";
		//}
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
		 if(flag%6==1||flag%6==3||flag%6==5){
			 out.print("<table>");
		 }
		 else{
			 out.print("<table>");
		 }
		
	    %>
			<tr><td width="27"></td><td height="8"></td><td width="10"></td></tr><tr><td width="27"></td><td>
			 <a href="/product/<%=product.getId()%>" target="_blank"><img src="<%=imgurl%>"/></a></td></tr>
			 <tr><td coslpan="3" height="3"></td></tr>
			<tr><td width="27"><td><a href="/product/<%= product.getId()%>" target="_blank" style="font-size:13px;<%=namec%>"><%= Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),64)%></a></td>
			<td width="10"></td></tr>
			<tr><td coslpan="3" height="2"></td></tr>
			<tr><td width="20"></td>
			<td style=" text-align:center;">
			<% 
			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
				%>
			<font style=" font-family:微软雅黑; font-size:13px;<%=mpc%>"><b>特价：￥<%=Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>
			   <% 
			}else
			{%>
				<font  style=" font-family:微软雅黑;font-size:13px;<%= mpc%>"><b>￥<%= Tools.getFormatMoney(product.getGdsmst_memberprice())%></b></font>
			<%}%>
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="/product/<%= product.getId() %>" target="_blank" style="color:#333;">商品详情>></a>
			 </td><td width="10"></td></tr>
		<%
	     out.print("</table>");
 
   }
%>
