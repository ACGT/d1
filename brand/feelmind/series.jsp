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


private static  ArrayList<Gdscoll> getGdscollBySerid1(Long sex){
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();

	ArrayList<Gdscoll> scolllist=GdscollHelper.getGdscollBySerid("1",sex);
	ArrayList<Gdscoll> scolllist1=GdscollHelper.getGdscollBySerid("3",sex);
	if(scolllist!=null && scolllist.size()>0){
		for(Gdscoll s:scolllist){
			list.add(s);
		}
	}
	if(scolllist1!=null && scolllist1.size()>0){
		for(Gdscoll s:scolllist1){
			list.add(s);
		}
	}
	Long sex1=3l;
	if(sex.intValue()==1) sex1=3l;
	else if(sex.intValue()==2) sex1=4l;
	ArrayList<Gdscoll> scolllist2=GdscollHelper.getGdscollBySerid("1",sex1);
	ArrayList<Gdscoll> scolllist21=GdscollHelper.getGdscollBySerid("3",sex1);
	if(scolllist2!=null && scolllist2.size()>0){
		for(Gdscoll s:scolllist2){
			list.add(s);
		}
	}
	if(scolllist21!=null && scolllist21.size()>0){
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
   if(!Tools.isNull(request.getParameter("serid"))&&Tools.isNumber(request.getParameter("serid"))){
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
       else if(serid.equals("0"))
       {
    	   scontent="女装系列";
       }
       else
       {
    	   scontent="北美风南加州系列";
       }
   }
   else { return;}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Feel Mind/FM<%=scontent %>【图片_价格_评价_怎么样】</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Feel Mind/FM<%= scontent %>系列报价、促销、新闻、评论、导购、图片" />
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM<%= scontent %>系列商品，提供Feel Mind/FM<%= scontent %>系列的最新报价、促销、评论、导购、图片等相关信息" />
<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style>
   .fmlist{ width:980px; background:url('http://images.d1.com.cn/images2012/fmdpbg2_1.jpg') repeat-y; margin-top:10px;}
   .fmlist ul{ list-style:bnone; margin:0px;padding:0px;}
   .fmlist ul li {margin-left:-60px; +margin-left:-64px; height:400px; float:left;}
    .fmlist ul li p{ margin-top:11px; margin-left:35px; width:175px;}
   .fmlist ul li p a { color:#919191}
   .fmlist ul li p span{ display:block; width:80px; text-align:left; float:left;} 
   .fmlist ul li p span font{ font-size:12px; color:#919191;}
   .newbanner1120 {position: fixed;z-index: 20000;top: 0px;text-align: left;background:#3c3c3c;}
   </style>
    <script language=javascript>
    function view_time2(){
    	var startDate= new Date();
    	var endDate= new Date("2012/07/20 15:00:00");
    	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
        if(lasttime>0){
        	var the_D=Math.floor((lasttime/3600)/24)
            var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
            var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
            var the_S=Math.floor((lasttime-the_H*3600)%60);
           if(the_D!=0){$("#topd").text(the_D);}
            if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
            if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
            $("#tops").text(the_S);
           // $getid(objid).innerHTML = html+html2+html1;
            lasttime--;
        }
    }	
    $(document).ready(function() {
    	var startDate= new Date();
    	var endDate= new Date("2012/07/20 15:00:00");
    	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
        if(lasttime>0){
          setInterval(view_time2,1000);
        }
      //导航栏浮动
		var m=$(".fmenul").offset().top;  
		$(window).bind("scroll",function(){
	    var i=$(document).scrollTop(),
	    g=$(".fmenul");
		if(i>=m)
		{
			 g.addClass('newbanner1120');
		}
	    else{
	    	 g.removeClass('newbanner1120');
	    	 }
		});
    });
		</script>
</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


     <%
     String sex=request.getParameter("sex");
     if(Tools.isNull(sex)){
    	sex="1"; 
     }
     if(!Tools.isNull(request.getParameter("serid"))&&Tools.isNumber(request.getParameter("serid"))){
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
	     <a href="http://feelmind.d1.com.cn/fmbrand.htm" target="_blank" >品牌故事</a>
	       </td></tr>
	      
	   </table>
	    <div class="fmenul">
	     <ul>      
				<li  style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</font></a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmlovels.htm" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:90px;" <% if(serid.equals("1") && "1".equals(sex)) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">加州男装</a></li>
				<li style="width:90px;" <% if(serid.equals("1") && "2".equals(sex)) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=2">加州女装</a></li>
				<li style="width:90px;" <% if(serid.equals("3") && "1".equals(sex)) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部男装</a></li>
				<li style="width:90px;" <% if(serid.equals("3") && "2".equals(sex)) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=2">西部女装</a></li>
				<li style="width:90px;" <% if(serid.equals("4")) out.print("class=\"lifestyle\"");%>><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">学院男装</a></li>
				
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     <%
         if(serid.equals("1"))
         {%>
        	<img src="http://images.d1.com.cn/images2012/feelmind/images/FMs1.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("3"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/feelmind/images/FMs2.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("4"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/feelmind/images/FMs3.jpg" style="margin-top:10px;"/> 
         <%}
         else if(serid.equals("0"))
         {%>
        	 <img src="http://images.d1.com.cn/images2012/feelmind/images/FMs4.jpg" style="margin-top:10px;"/> 
         <%}
         else
         {%>
        	  <img src="http://images.d1.com.cn/images2012/feelmind/images/FMs4.jpg" style="margin-top:10px;"/> 
         <%}
        
     %>
     
     

     <%
         
         if(sex.equals("-1")){%>
        	        <div class="fmlist">
	  <table><tr><td>
		     <%
		   
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=getGdscollBySerid1(new Long(sex));
			if(scolllist!=null && scolllist.size()>0){
				%>
				<ul>
				<%
				isscoll=true;
				int count=0;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if(scoll!=null&&scoll.getGdscoll_flag()!=null&&scoll.getGdscoll_flag().longValue()==1){
						//查看搭配详细
						int counts=0;
   					    ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(scoll.getId());
						if(gdetaillist!=null)
						{
							for(Gdscolldetail gd:gdetaillist)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
									counts++;
									
								}
							}
						}
						
						if(counts>1){
						 count++;
						if(count%5==1)
						{%>
							<li style="margin-left:0px;">
						<%}
						else
						{%>
							<li>
						<%}
				%>
				<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0"/></a>
				<%  
				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(scoll.getId());
				   if(gdlist!=null&&gdlist.size()>0)
				   {
					   int newsum=0;
					   out.print("<p>");
					   for(Gdscolldetail gd:gdlist)
					   {
						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						   {
							   newsum++;
							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
							   {%>
								   <span><a href="http://www.d1.com.cn/product/<%= product.getId()%>" target="_blank"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
							  <% }
						   }
						   
					   }
					   out.print("</p>");	
				   }  
				   %>
				</li>
				<%}
					}
				}
				%>
				</ul>
				<%
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

		%>
		 </td></tr></table>
		 </div> 
         <%}
         else
         {%>
        	 
     
     
     
     
        <div class="fmlist">
	  <table><tr><td>
		     <%
		    ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("987");
		    Gdsser g=GdsserHelper.getById(request.getParameter("serid"));	
		    if(g!=null){
			boolean isscoll=false;
			ArrayList<Gdscoll> scolllist=getGdscollBySerid(g.getId(),new Long(sex));
			if(scolllist!=null && scolllist.size()>0){
				%>
				<ul>
				<%
				isscoll=true;
				int count=0;
				for(int i=0;i<scolllist.size();i++){
					Gdscoll scoll=scolllist.get(i);
					if(scoll!=null&&scoll.getGdscoll_flag()!=null&&scoll.getGdscoll_flag().longValue()==1){
						//查看搭配详细
						int counts=0;
   					    ArrayList<Gdscolldetail> gdetaillist=GdscollHelper.getGdscollBycollid1(scoll.getId());
						if(gdetaillist!=null)
						{
							for(Gdscolldetail gd:gdetaillist)
							{
								Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
								if(p!=null&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&ProductStockHelper.canBuy(p)){
									counts++;
									
								}
							}
						}
						
						if(counts>1){
						count++;
						if(count%5==1)
						{%>
							<li style="margin-left:0px;">
						<%}
						else
						{%>
							<li>
						<%}
				%>
				<a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=scoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=scoll.getGdscoll_brandimg() %>" border="0"/></a>
				<%  
				   ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid(scoll.getId());
				   if(gdlist!=null&&gdlist.size()>0)
				   {
					   int newsum=0;
					   out.print("<p>");
					   for(Gdscolldetail gd:gdlist)
					   {
						   if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==1&&gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
						   {
							   newsum++;
							   Product product=ProductHelper.getById(gd.getGdscolldetail_gdsid());
							   if(product!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1)
							   {%>
								   <span><a href="http://www.d1.com.cn/product/<%= product.getId()%>" target="_blank"><%= gd.getGdscolldetail_title()%></a>&nbsp;<font><%= Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())%></font></span>
							  <% }
						   }
						   
					   }
					   out.print("</p>");	
				   }  
				   %>
				</li>
				<%
						}
					}
				}
				%>
				</ul>
				<%
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
		 </td></tr></table>
		 </div>
		<%} %>
	  
    <% } %>

	    <div class="clear"></div>

	 
  </div>
</div>
  <div class="clear"></div>
<%@include file="foot.jsp" %>
</body>
</html>
