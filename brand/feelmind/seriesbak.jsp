<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<Gdscoll> getGdscollBySerid(String serid,Long sex){
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();

	ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBySerid(serid,sex);
	if(scolllist!=null && scolllist.size()>0){
		for(Gdscoll s:scolllist){
			list.add(s);
		}
	}
	Long sex1=3l;
	if(sex.intValue()==1) sex1=3l;
	else if(sex.intValue()==2) sex1=4l;
	ArrayList<Gdscoll> scolllist2=GdscollHelper.getGdscollBySerid(serid,sex1);
	if(scolllist2!=null && scolllist2.size()>0){
		for(Gdscoll s:scolllist2){
			list.add(s);
		}
	}
	return list;
}
%>
<%
   String scontent="";
   String serid="";
   if(!Tools.isNull(request.getParameter("serid"))){
	   serid=request.getParameter("serid");
       if(serid.equals("1"))
       {
    	   scontent="北美风南加州系列";
       }
       else if(serid.equals("3"))
       {
    	   scontent="西部/户外经典系列";
       }
       else if(serid.equals("4"))
       {
    	   scontent="新英格兰/学院系列";
       }
       else
       {
    	   scontent="北美风南加州系列";
       }
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<title>Feel Mind/FM<%=scontent %>【图片_价格_评价_怎么样】</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Feel Mind/FM<%= scontent %>系列报价、促销、新闻、评论、导购、图片" />
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM<%= scontent %>系列商品，提供Feel Mind/FM<%= scontent %>系列的最新报价、促销、评论、导购、图片等相关信息" />

</head>

<body>
<div style="background:url('http://images.d1.com.cn/images2012/index2012/index98050bg2.jpg')  "><a href="http://www.d1.com.cn/zhuanti/20120629qchd/qchd.jsp" style=" width:980px; display:block; margin:0px auto;" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/980X50new1.jpg"/></a></div>

<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->
     <%
     String sex=request.getParameter("sex");
     if(Tools.isNull(sex)){
    	sex="1"; 
     }
     if(!Tools.isNull(request.getParameter("serid"))){
    	 String rackcode="";
    	 if(!Tools.isNull(sex)){
    		if("1".equals(sex)){
    			rackcode="03";
    		}else if("2".equals(sex)){
    			rackcode="02";
    		}
    	 }
    	 
    	 %> 
<div class="fbody">
  <div class="autobody">
     <!--品牌头部分开始-->
     <div class="ftop">
	 <div class="fmenu">
	     <table height="90" width="980" class="newtable">
	       <tr><td colspan="2" height="40"></td></tr>
	       <tr><td width="800"></td><td><a href="http://www.d1.com.cn/zhuanti/20120620tyd/tyd.jsp" target="_blank" >实体体验店</a>
	      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	       <a href="/brand/feelmind/brand.jsp" target="_blank" >品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li style="width:90px;"><a href="/brand/feelmind/" style="font-size:16px; ">FM首页</font></a></li>
				<li><a href="http://www.d1.com.cn/brand/feelmind/categorydisplay.jsp?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://www.d1.com.cn/brand/feelmind/categorydisplay.jsp?productsort=020" style="font-size:16px; ">女装</a></li>
				<li><a href="http://www.d1.com.cn/brand/feelmind/lovels.jsp" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:150px;" <% if(serid.equals("1")) out.print("class=\"lifestyle\"");%>><a href="http://www.d1.com.cn/brand/feelmind/series.jsp?serid=1&sex=1">北美风南加州系列</a></li>
				<li style="width:150px;" <% if(serid.equals("3")) out.print("class=\"lifestyle\"");%>><a href="http://www.d1.com.cn/brand/feelmind/series.jsp?serid=3&sex=1">西部/户外经典系列</a></li>
				<li style="width:150px;" <% if(serid.equals("4")) out.print("class=\"lifestyle\"");%>><a href="http://www.d1.com.cn/brand/feelmind/series.jsp?serid=4&sex=1">新英格兰/学院系列</a></li>
				<li style="width:100px;"><a href="/brand/feelmind/series.jsp?serid=0&sex=2">FM女装系列</a></li>
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     <div class="fmanc">

    	 	   <!--左侧开始-->
	   <div class="fmancl">
	       <div class="fclsmenu">
		     <ul class="one">
		     <%
		    ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("987");
		     Gdsser g=GdsserHelper.getById(request.getParameter("serid"));
		if(g!=null && Gdsserlist!=null && Gdsserlist.size()>0){
			for(Gdsser g1:Gdsserlist){
				if("2".equals(sex) && "4".equals(g1.getId())){
				continue;
			}else{
			%>
			<li style="line-height:26px; "><a  style="font-size:15px;<%if(g1.getId().trim().equals(g.getId().trim())){%> color:#D5D3CB;<%} %> " href="series.jsp?serid=<%=g1.getId() %>&sex=<%=sex %>" ><%=g1.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}}}
	else{%>
	 <li><a href="#">北美风南加州系列</a></li>
			   <li><a href="#">北美风南加州系列</a></li>
			   <li><a href="#">北美风南加州系列</a></li>
	<%} %>
		      <li>&nbsp;</li>   
	         </ul>
			<%
			request.setAttribute("brandname", "FEEL MIND");
			request.setAttribute("rackcode", rackcode);
			%>
			<jsp:include   page= "category.jsp"   />
		   </div>
	   </div>
	   <!--左侧结束-->
	    <!--右侧开始-->
	   <div class="fmancr">
	   
	    <%
	    String code="3001";
	    if(g!=null){
	    	if("1".equals(g.getId().trim())){code="3001";}
	    	else if("3".equals(g.getId().trim())){code="3002";}
	    	else if("4".equals(g.getId().trim())){code="3003";}
	    }
	     String str1=PromotionHelper.getImgPromotion(code,1);
	     %>
	     <div class="top" style="height:300px;background-image:url( <%if("1".equals(g.getId().trim())){%>http://images.d1.com.cn/images2012/feelmind/images/1.jpg);<%} else if("3".equals(g.getId().trim())){%>http://images.d1.com.cn/images2012/feelmind/images/2.jpg);<%}else if("4".equals(g.getId().trim())){%>http://images.d1.com.cn/images2012/feelmind/images/3.jpg);<%}%>   ">
	   <%  if(Tools.isNull(str1)) {
	    	%>
	    	
	     
	    	<% }else{
	    		out.print(str1);
	    	}
	     %>
         </div>
		<div class="fserlist">
		<%
		if(g!=null){
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=getGdscollBySerid(g.getId(),new Long(sex));
			if(scolllist!=null && scolllist.size()>0){
				isscoll=true;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if((i+1)%3==1){
						%>
						 <div class="flistr">
           <ul>
					<%}%>
				<li><a href="/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0" height="335"/></a></li>
				<%
				if((i+1)%3==0){
				%>
					</ul>
					</div>
					<%}
				}
			}
			if(!isscoll){
				%>
				<div class="flistr">
           <ul>
              <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
           </ul>
		   </div>
		   <div class="flistr">
           <ul>
              <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/tt.jpg"/></li>
           </ul>
		   </div>
			<%}
		}
		%>
		 </div>
	   </div>
	   <!--右侧结束-->
    <% }
     %>

	    <div class="clear"></div>
	 </div>
	 
  </div>
</div>
  <div class="clear"></div>
<%@include file="foot.jsp" %>
</body>
</html>
