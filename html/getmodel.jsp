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
   String pstr="";
   String type="";
   String bgimg="";
   if(request.getParameter("p")!=null&&request.getParameter("p").length()>0)
   {
	 
	   pstr=request.getParameter("p");
   }
   else return;
   if(request.getParameter("type")!=null&&request.getParameter("type").length()>0)
   {
	   type=request.getParameter("type");
   }
   if(type.equals("1")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/fm1.jpg";
   }
   else if(type.equals("2")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/xls1.jpg";
   }
   else if(type.equals("3")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/srr.jpg";
   }
   else if(type.equals("4")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/FMm_2.jpg";
   }
   else if(type.equals("5")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/FMw_2.jpg";
   }
   else if(type.equals("6")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/srm_2.jpg";
   }
   else if(type.equals("7")){
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/xls_2.jpg";
   }
   else
   {
	   bgimg="http://images.d1.com.cn/images2012/index2012/SEP/fm1.jpg";
   }
   
   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>D1优尚网-首页模板</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>

<style type="text/css">
 ul{ list-style:none; margin:0px; padding:0px;}
 ul li{ margin-left:-66px; float:left;}
 a{ font-size:12px;}
</style>
</head>
<body>
<center>
   <div style="width:980px; background:url(<%= bgimg%>) no-repeat"> 
   <table><tr><td>
   <%
	   if(pstr.length()>0)
	   {
		   pstr.replace("，",",");
	   }
	   String[] str=pstr.split(",");
	   if(str!=null&&str.length>0)
	   {System.out.print(str.length);
	   %>
	   <ul>
		  <% for(int i=0;i<str.length;i++)
		   {
			  if(str[i].length()>0&&Tools.isNumber(str[i])){
			   Gdscoll gdscoll=(Gdscoll)Tools.getManager(Gdscoll.class).get(str[i]);
			   String s="";
			   if(type.equals("3")){
				   s=" margin-top:5px; ";
			   }
			   if(gdscoll!=null&&gdscoll.getGdscoll_flag()!=null&&gdscoll.getGdscoll_flag().longValue()==1)
			   {
			      if(i==0)
			      {%>
			    	   <li style="margin-left:0px; <%= s%>">
			      <%}
			      else
			      {%>
			    	  <li style="<%= s%>">  
			      <%}
			   %>
				    <img src="http://images1.d1.com.cn<%= gdscoll.getGdscoll_brandimg() %>"/>
				   <%
				    if(i==0)
				    {%>
				    	 <div style="padding-left:50px; width:175px; display:block; margin-top:20px; ">
				    <%}
				    else
				    {%>
				    	<div style="padding-left:36px; width:175px; display:block;margin-top:20px; ">
				    <%}
    				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(gdscoll.getId());
    				   if(gdlist!=null&&gdlist.size()>0)
    				   {
    					   int newsum=0;
    					   for(Gdscolldetail gd:gdlist)
    					   {
    						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
    						   {
    							   newsum++;
    							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
    							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
    							   {%>
    								  <span><a href="/product/<%= product.getId()%>" target="_blank"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
    							   <%}
    						   }
    						   
    					   }
    					   
    					   
    				   }
				    
				    %>
				   </li>  
			   <%}
			  }
		   }%>
	  </ul>
	  <%}
   %>
      </td></tr></table>
   </div>
   </center>
</body>
</html>