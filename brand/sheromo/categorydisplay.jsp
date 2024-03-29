<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/getComment.jsp" %>
<%!
static ArrayList<GdsCutImg> getByGdsid(String gdsid){
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
 static ArrayList<Directory> getBycode(String rackcode) {
	ArrayList<Directory> list=new ArrayList<Directory>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("rakmst_rackcode", rackcode));
	clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
	List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, null, 0, 1);
	if(clist==null||clist.size()==0)return null;
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Directory)be);
		}
	}
	return list;
}
public static ArrayList<Product> getProductListByRCode(String brandname,String sequence,String productsort){
	ArrayList<Product> list=new ArrayList<Product>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_brandname", brandname));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		
		
		List<Order> olist = new ArrayList<Order>();
		//olist.add(Order.desc("gdsmst_createdate"));
		
		boolean flag = false ;
		
		if(sequence.equals("4")){
			olist.add(Order.desc("gdsmst_createdate"));
		}
		else if(sequence.equals("1")){
			olist.add(Order.desc("gdsmst_memberprice"));
		}
		else if(sequence.equals("2")){
			olist.add(Order.asc("gdsmst_memberprice"));
		}
		else if(sequence.equals("3")){
			//olist.add(Order.desc("gdsmst_salecount"));
		}
		else{
			if(productsort!=null&& (productsort.startsWith("020")|| productsort.startsWith("030"))){
				flag=true;
			}else{
				olist.add(Order.desc("gdsmst_createdate"));
			}
		}
		
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 3000);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}
		if(sequence.equals("3") || flag){
		Collections.sort(list,new SalesComparator());
		Collections.reverse(list);
		}
	return list;
}
/**
 * 获得服装图 240*300
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo240300(Product product){
	String img = (product != null ? product.getGdsmst_img240300() : null);
	if(Tools.isNull(img)){
		img = img.trim().replace('\\','/');
	}
			 if(img!=null&&img.startsWith("/shopimg/gdsimg")){
				
				 img = "http://images1.d1.com.cn"+img;
					}else{
						img = "http://images.d1.com.cn"+img;
					}
	return img;
}

%>
<%
   String stitle="";
   String stitles="";
   String scontent="";
   String ps="";
   if(!Tools.isNull(request.getParameter("productsort"))&&request.getParameter("productsort").length()>0)
   {
	  ps=request.getParameter("productsort");
	  Directory dir=DirectoryHelper.getById(ps);
	  if(dir!=null)
	  {
		  String rname=dir.getRakmst_rackname();
		  stitle=rname;
		  Directory dirs=DirectoryHelper.getById(dir.getRakmst_parentrackcode());
		  if(dirs!=null)
		  {
		     stitles=dirs.getRakmst_rackname();
		  }
	  }
      
   }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/sheromo.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<%
	if(ps.length()>6){
%>
<title>诗若漫<%= stitle %>【图片_价格_评价_怎么样】</title>
<meta name="description" content="D1优尚网是国内唯一在线销售<%= stitles %>,诗若漫<%= stitle %>商品，提供<%= stitles+",诗若漫"+stitle %>的最新报价、促销、评论、导购、图片等相关信息" />
<meta name="keywords" content="<%= stitles+","+stitle %>, 诗若漫<%= stitle %>报价、促销、新闻、评论、导购、图片" />
<%  }
	else
	{%>
		<title>诗若漫<%= stitle %>【图片_价格_评价_怎么样】</title>
        <meta name="description" content="D1优尚网是国内唯一在线销售诗若漫<%= stitle %>商品，提供诗若漫<%=stitle %>的最新报价、促销、评论、导购、图片等相关信息" />
        <meta name="keywords" content="<%= stitle %>, 诗若漫<%= stitle %>报价、促销、新闻、评论、导购、图片" />
		
<% }%>
<style>
.newbanner1120{position: fixed;z-index: 20000; width:765px;top: 0px;height: 40px;background-image: url(http://images.d1.com.cn/images2012/sheromo/003.jpg);background-repeat: no-repeat;padding-top: 15px;}
.newbanner1120 h4 {font-size: 14px;color: #333;font-weight: 800;padding-left: 15px;float: left;width: 80px;}
.newbanner1120 li {margin-left: 10px;width: 80px;background-color: #9F9188;height: 20px;float: left;text-align: center;line-height: 20px;}
.newbanner1120 li a {color: white;text-decoration: none;}


</style>
<script type="text/javascript">
function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	$("#next2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	}

function mdmover(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	obj.css("display","block");
	}


 function mdm_out(gdsid,flag)
{
	 $("#floatdp"+gdsid+flag).css("display","none");
	
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+gdsid+count);
	if(obj!=null)
	{
		    $(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulthtml.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
				//$(obj).css("background","");
				//$(obj).addClass("floatdp");
				//$(obj).css("background-image","url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat");
				//$(obj).css("background-position","right 315px;");
				//$(obj).css("margin-top","0px");
			});
	
    }
}

function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+gdsid+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		}
    
}

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
	var m=$("#top").offset().top;  
	$(window).bind("scroll",function(){
    var i=$(document).scrollTop(),
    g=$("#top");
	if(i>=m)
	{
		 g.removeClass('top');
		 g.addClass('newbanner1120');
	}
    else{
    	 g.removeClass('newbanner1120');
    	 g.addClass('top');
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
	 String productbrand="诗若漫";
	 String orderContent = request.getParameter("order");
	 if(!Tools.isNull(orderContent)){
	 	orderContent = Tools.simpleCharReplace(orderContent);
	 	if(Tools.parseInt(orderContent) > 4){
	 		orderContent = "3";
	 	}
	 }else{
	 	orderContent = "4";
	 }
	 String ggURL = Tools.addOrUpdateParameter(request,null,null);
	 if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
	 String productsort = request.getParameter("productsort");
	 String[] ps124=null;
	 if(!Tools.isNull(productsort)){
	 	productsort = productsort.trim();
	 	productsort = Tools.simpleCharReplace(productsort);
	 	
	 	String ps123 = productsort;
	 	ps123=ps123.replace("，", ",");
	 	ps124=ps123.split(",");
	 	for(int i=0;i<ps124.length;i++){
	 		String str=ps124[i];
	 		Directory dir = DirectoryHelper.getById(str);
		 	if(dir == null){		 		
		 		response.sendRedirect("/index.jsp");
		 		return;
		 	}
	 	}	 	
	 }else{
	 	response.sendRedirect("/index.jsp");
	 	return;
	 }
	 List<Product> productList = new ArrayList<Product>();
		for(int i=0;i<ps124.length;i++){
	 		String str=ps124[i];
	 		List<Product> ls=getProductListByRCode(productbrand,orderContent,str);
	 		productList.addAll(ls);
	 	}	 		
		int totalLength = (productList != null ?productList.size() : 0);
		
		int PAGE_SIZE = 30 ;
 	    int currentPage = 1 ;
 	    String pg = request.getParameter("pageno");
 	    if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
 	    PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
 	   
 	    int end = pBean.getStart()+PAGE_SIZE;
 	    if(end > totalLength) end = totalLength;
		
		String orderURL = ggURL.replaceAll("order=[^&]*","");
		orderURL = orderURL.replaceAll("pageno=[0-9]+","&");
		orderURL = orderURL.replaceAll("&+", "&");
		if(!orderURL.endsWith("&")) orderURL = orderURL + "&";
		orderURL=orderURL.replace("brand/sheromo/", "srm").replace("jsp", "htm");
		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
		
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    pageURL = pageURL.replaceAll("&+", "&");
 	    
		%>
<div class="sbody">
  <div class="autobody">
    <div class="stop">
	     <div style="height:80px;"></div>
			 <div class="menu">
			 <ul>      
				<li  style="width:90px;"><a href="http://sheromo.d1.com.cn/" style="font-size:16px; ">商品分类</a></li>
				<li <% if(ps.equals("020010")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010">裙子</a></li>
				<li <% if(ps.equals("020002")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002">T恤</a></li>
				<li <% if(ps.equals("020001")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li <% if(ps.equals("020008,020009")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008,020009">裤子</a></li>
				<li <% if(ps.equals("020006")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006">外套</a></li>
				<li <% if(ps.equals("020")) out.print("class=\"lifestyle\"");%>><a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020">全部</a></li>
				
	            <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;color: #9D8F86;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=9&sex=1">知性OL系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=10">丹宁风尚系列</a></li>
				<li style="width:115px;"><a href="http://sheromo.d1.com.cn/srmseries.htm?serid=11">国际经典系列</a></li>
				<li style="width:50px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li ><a href="http://sheromo.d1.com.cn/srmstory.htm">品牌故事</a></li>
				</ul>
			 </div>
			 <div class="clear"></div>
	</div>
	<!--列表开始-->
	<div class="scontent">
	    <div class="left">
		<!--left-->
			   <div class="fclsmenu">
				 <ul class="one">
				    <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1969");
	if(Gdsserlist!=null && Gdsserlist.size()>20){
		for(Gdsser g:Gdsserlist){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>&sex=1" ><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	}%> 
				 </ul>
				 <%
			request.setAttribute("brandname", "诗若漫");
			request.setAttribute("productsort", productsort);
			request.setAttribute("rackcode", "02");
		//	request.setAttribute("url", "categorydisplay");
			%>
	        <jsp:include   page= "category1.jsp"   />
			  
			 
			  
			   </div>
		   </div>
		   <!--left  end-->
		   <!--right-->
		   <div class="right">
			<div id="top" class="top">
			<h4>排序方式：</h4>	 
			<ul>
			 <li><a href="<%=orderURL%>order=4" rel="nofollow">最新上架</a></li>
			 <li><a href="<%=orderURL%>order=3" rel="nofollow">热销商品</a></li>
			 <li><a href="<%=orderURL%>order=2" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/sheromo/up.gif" width="12" height="13"></li>
			 <li><a href="<%=orderURL%>order=1" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/sheromo/dw.gif" width="12" height="13"></li>
			</ul>
			<div class="clear"></div>
			</div>
		
			 <%
		  String rname="";
		  for(int i=0;i<ps124.length;i++){
		 		String str=ps124[i];
		 		 Directory dir = DirectoryHelper.getById(str);				 
				 if(dir!=null){
					 rname+="&nbsp;"+dir.getRakmst_rackname().trim()+"&nbsp;"+"&";
				 }
		  }
		  
		 %>
		 <h3 style="font-size:16px;	font-weight:800;color:#58412F;border-bottom-width: 1px;border-bottom-style: solid;border-bottom-color: #58412F;height:25px;padding-left:15px;"> <%=rname.substring(0,rname.length()-1) %></h3>
			 <%
           if(productList != null && !productList.isEmpty()){
        	   
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        	   %>
        		<div class="newlist">
        		<table><tr><td>
        	    	 <ul>
        	     <%
        	       int counts=0;
        	    	 for(Product p:gList)
        	    	 {
        	    		 
        	    			counts++;
        	    			
        	 				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
        	 				{
        		      		   String title = Tools.clearHTML(p.getGdsmst_gdsname()).trim();
        		           	   String id = p.getId();
        		           	   long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
        		           	   long currentTime = System.currentTimeMillis();
        		           	   if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
        		   			   {%>
        		   	               <li style=" width:240px; height:437px;">
        		   	            <%}
        		           	   else
        		           	   {%>
        		           		   <li style="  width:240px;height:330px;">
        		           	   <%}%>
        		           	   <div class="lf">
        		           	   <p style="z-index:999; text-align:center;"><a href="http://www.d1.com.cn<%= ProductHelper.getProductUrl(p)%>" target="_blank" >
        		   	           <%
	        		   	           if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	        		   	           {  %>
	        		   	           		<img src="<%= getImageTo240300(p)%>" width="240" height="300" />
	        		   	           <%}
	        		   	           else
	        		   	           {%>
	        		                    <img src="<%= ProductHelper.getImageTo200(p)%>" width="200" height="200" />
	        		   	           <%} %>
        		   	           </a></p>
        		   	           <%        		   	           
        		   	              //每个商品对应的搭配列表
        	                      ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(p.getId()); 
        					      if(gdscolllist!=null&&gdscolllist.size()>0)
        					      {%>
        					    	<div style="position:absolute; margin-top:-47px; +margin-top:-49px; " onmouseover="mdm_over('<%= p.getId()%>','<%= counts%>')" onmouseout="mdm_out('<%= p.getId()%>','<%=counts%>')"><img src="http://images.d1.com.cn/images2012/index2012/da1.png"/></div>
                                  <%}%>
        					   </p>
        		   	           <p style="height:35px; font-size:13px; color:#999999; ">
        		   	           <span class="newspan">
        		   	           <% 
        		   	           if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){%>
        			   	    	 <font color="#b80024" style=" font-family:'微软雅黑'"><b>特价：￥<%=Tools.getFormatMoney(p.getGdsmst_memberprice())  %></b></font>&nbsp;&nbsp;
        			   	         <font style="text-decoration:line-through;">￥<%= Tools.getFormatMoney(p.getGdsmst_oldmemberprice())%></font>
        			   	      <% }
        			   	       else
        			   	       {%>
        			   	           <font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(p.getGdsmst_memberprice()) %></b></font>&nbsp;&nbsp;
        			               
        			          <% }%>
        		   	          </span>
        		              <span class="newspan1"><a href="http://www.d1.com.cn/product/<%=p.getId()%>?st=com#cmt" target="_blank" rel="nofollow">评论(<%=getCommentList(p.getId()).size() %>)</a></span>
        		              </p>
        		           	  </div><p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" >
        		           	  <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,54)%></a>
        		           	  </p>
        		           	  <div class="clear"></div>  
        		           	  <%  
        		           	   Comment com=null;
        		                List<Comment> list= CommentHelper.getCommentListByLevel(id,0,1);
        		                if(list!=null&&list.size()>0&&list.get(0)!=null)
        		                {
        		                	com=list.get(0);
        		                }
        		                  if(com!=null)
        		                  { %>
        		                	 <div class="lb" title="<%= com.getGdscom_content()%>"><b><%=CommentHelper.GetCommentUid(com.getGdscom_uid()) %>：</b><a href="http://www.d1.com.cn/product/<%=p.getId()%>#cmt2" target="_blank" rel="nofollow"><%=StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></a></div>
        		                 <% }
        		                  else
        		                  {%>
        		                	  <div class="lb" ><b>暂无评论！！！</b></div>  
        		                  <%}
        		                  if(gdscolllist!=null&&gdscolllist.size()>0)
        		                  {%>

        		                   <div  id="floatdp<%=p.getId() %><%= counts%>" onmouseover="mdmover('<%=p.getId() %>','<%=counts %>')" onmouseout="mdm_out('<%=p.getId() %>','<%=counts%>')"></div>
        		                  <%} %>
        		                </li>
        		                <%
        	    		 }
        	    		}
        	    	 	 %>
        	    	 </ul></td></tr></table>
        	    	</div>
        		   
        		   
        		   
           
		 
        		       <%}} %>
			   
			
			  <div class="clear"></div>
<%
           if(pBean.getTotalPages()>1){
        	   //System.out.print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
           %>
           <div class="GPager">
           	<span >共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           			if(i==1)
           			{%>
           				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
           			<%}
           			else
           			{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		    }
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div><%}%>
           <div class="clear"></div>
	    <div  style="height:15px;"></div>
	   </div> 
		
		   <!--right-->
		   <div class="clear"></div>
	</div>
	<!--列表结束-->
  </div>
</div>
<%@include file="/inc/foot.jsp" %>
</body>
</html>
