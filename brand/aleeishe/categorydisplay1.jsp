<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*"%><%@include file="/inc/header.jsp" %><%!
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
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
	
	return img;
}
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
private static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
{
	  boolean flag=false;
	  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
	  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		
		if(list!=null&&list.size()>0)
		{
			if(gdsid.length()==0)
			{
				result=list;
			}
			else
			{
				for(Gdscoll gdscoll:list)
				{
					if(gdscoll!=null)
					{
						ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
						if(gdlist!=null)
						{
							for(Gdscolldetail gd:gdlist)
							{
								if(gd.getGdscolldetail_gdsid().equals(gdsid))
								{
									flag=true;
								}
							}
						}
						if(flag)
						{
							result.add(gdscoll);
						}
						flag=false;
					}
					
				}
				return result;
			}
		}
		return result;
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" type="text/css" rel="stylesheet" />

<link href="/res/css/aleeishe.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<% if(ps.equals("020007001")){ %>
   <title>小栗舍<%= stitle+stitles %>【图片_价格_评价_怎么样】</title>
   <meta name="description" content="D1优尚网是国内唯一在线销售<%= stitles %>,小栗舍<%= stitle+stitles %>商品，提供<%= stitle+stitles %>的最新报价、促销、评论、导购、图片等相关信息" />
   <meta name="keywords" content="<%= stitle+stitles %>, 小栗舍<%= stitle+stitles %>报价、促销、新闻、评论、导购、图片" />
   
<%}
else{
	if(ps.length()>6){
%>
<title>小栗舍<%= stitle %>【图片_价格_评价_怎么样】</title>
<meta name="description" content="D1优尚网是国内唯一在线销售<%= stitles %>,小栗舍<%= stitle %>商品，提供<%= stitles+",小栗舍"+stitle %>的最新报价、促销、评论、导购、图片等相关信息" />
<meta name="keywords" content="<%= stitles+","+stitle %>, 小栗舍<%= stitle %>报价、促销、新闻、评论、导购、图片" />
<%  }
	else
	{%>
		<title>小栗舍<%= stitle %>【图片_价格_评价_怎么样】</title>
        <meta name="description" content="D1优尚网是国内唯一在线销售小栗舍<%= stitle %>商品，提供小栗舍<%=stitle %>的最新报价、促销、评论、导购、图片等相关信息" />
        <meta name="keywords" content="<%= stitle %>, 小栗舍<%= stitle %>报价、促销、新闻、评论、导购、图片" />
		
	<%}
}%>
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
});
	</script>
</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->

 

	  	   <%
	 String productbrand="AleeiShe 小栗舍";
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
		orderURL=orderURL.replace("brand/aleeishe/", "as").replace("jsp", "htm");
		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
		
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    pageURL = pageURL.replaceAll("&+", "&");
 	    
		%>
<div class="albody">
	<div class="autobody">
	     <!--品牌头部分开始-->
         <div class="altop">
		     <div style="height:92px;"></div>
			 <div class="menur">
			 <ul>      
				<li style="width:90px;"><a href="http://aleeishe.d1.com.cn/asindex.htm" style="font-size:16px; ">商品分类</a></li>
				<li <% if(ps.equals("020010")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020010">裙装</a></li>
				<li <% if(ps.equals("020002")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020002">T恤</a></li>
				<li <% if(ps.equals("020001")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020001">衬衫</a></li>
				<li <% if(ps.equals("020009")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020009">裤装</a></li>
				<li <% if(ps.equals("020")) out.print("class=\"lifestyle\"");%>><a href="http://aleeishe.d1.com.cn/ascategorydisplay.htm?productsort=020">全部</a></li>
				<li style="width:75px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=5&sex=1">精致甜美系列</a></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=7&sex=1">俏女孩系列</a></li>
				<li style="width:115px;"><a href="http://aleeishe.d1.com.cn/asseries.htm?serid=6">优雅淑女系列</a></li>
				<li style="width:75px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li ><a href="http://aleeishe.d1.com.cn/asbrand.jsp">品牌故事</a></li>
				</ul>
			 </div>
	         <div class="menu">
			 </div>
		 </div>
			 <div class="alcontent">
					   <!--左侧开始-->
		   <div class="fmancl">
			   <div class="fclsmenu">
				 <ul class="one">
				  <%
		     ArrayList<Gdsser> Gdsserlist= GdsserHelper.getGdsserByBrandid("1690");
	         if(Gdsserlist!=null && Gdsserlist.size()>20){
		      for(Gdsser g:Gdsserlist){
			%>
			<li style="line-height:26px;"><a  style="font-size:15px;" href="series.jsp?serid=<%=g.getId() %>&sex=1" target="_blank"><%=g.getGdsser_title().trim() %></a> <img src="http://images.d1.com.cn/images2012/feelmind/images/selected.png"/></li>
		<%}
	        }%>
				 </ul>
				 <%
			request.setAttribute("brandname", "AleeiShe 小栗舍");
			request.setAttribute("rackcode", "02");
			request.setAttribute("productsort", productsort);
			//request.setAttribute("url", "categorydisplay");
			%>
	        <jsp:include   page= "category1.jsp"   />
			   </div>
		   </div>
		   <!--左侧结束-->
					  <div class="right">
					<div class="top">
					<h4>排序方式：</h4>	 
					<ul>
					 <li><a href="<%=orderURL%>order=4" rel="nofollow">最新上架</a></li>
					 <li><a href="<%=orderURL%>order=3" rel="nofollow">热销商品</a></li>
					 <li><a href="<%=orderURL%>order=2" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/aleeishe/images/up.gif" width="9" height="11"/></li>
					 <li><a href="<%=orderURL%>order=1" rel="nofollow">价格</a><img src="http://images.d1.com.cn/images2012/aleeishe/images/dw.gif" width="9" height="11"/></li>
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
		 <h3 style="font-size:16px;	font-weight:800;color:#712549;border-bottom-width: 1px;	border-bottom-style: solid;	border-bottom-color: #712549;height:25px;padding-left:15px;">
		 <%=rname.substring(0,rname.length()-1) %></h3>
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
        		           		   <li style="width:240px;height:330px;">
        		           	   <%}%>
        		           	   <div class="lf">
        		           	   <p style="z-index:999;text-align:center;"><a href="http://www.d1.com.cn<%= ProductHelper.getProductUrl(p)%>" target="_blank" >
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
        	                      ArrayList<Gdscoll> gdscolllist=getGdscollByGdsid(p.getId()); 
        					      if(gdscolllist!=null&&gdscolllist.size()>0)
        					      {%>
        					    	<div style="position:absolute; margin-top:-47px; +margin-top:-18px; " onmouseover="mdm_over('<%= p.getId()%>','<%= counts%>')" onmouseout="mdm_out('<%= p.getId()%>','<%=counts%>')"><img src="http://images.d1.com.cn/images2012/index2012/da1.png"/></div>
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
        		              <span class="newspan1"><a href="http://www.d1.com.cn/product/<%=p.getId()%>#cmt2" target="_blank">评论(<%=CommentHelper.getCommentLength(p.getId()) %>)</a></span>
        		              </p>
        		           	  </div><p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" >
        		           	  <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(p)%>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,54)%></a>
        		           	  </p>
        		           	  <div class="clear"></div>  
        		           	  <%  
        		           	   Comment com=null;
        		                List<Comment> list= CommentHelper.getCommentList(id,0,1000);
        		                if(list!=null&&list.size()>0)
        		                {
        		                	for(Comment c:list)
        		                	{
        		                		if(c.getGdscom_level().longValue()==5)
        		                		{
        		                			com=c;
        		                			break;
        		                		}
        		                		else
        		                		{
        		                			continue;
        		                		}
        		                	}
        		                	if(com==null)
        		                	{
        		                		for(Comment c:list)
        		                    	{
        		                    		if(c.getGdscom_level().longValue()==4)
        		                    		{
        		                    			com=c;
        		                    			break;
        		                    		}
        		                    		else
        		                    		{
        		                    			continue;
        		                    		}
        		                    	}
        		                		if(com==null)
        		                		{
        		                			for(Comment c:list)
        		                        	{
        		                        		if(c.getGdscom_level().longValue()==3)
        		                        		{
        		                        			com=c;
        		                        			break;
        		                        		}
        		                        		else
        		                        		{
        		                        			continue;
        		                        		}
        		                        	}
        		                		}
        		                	}
        		                }
        		               
        		                  if(com!=null)
        		                  { %>
        		                	 <div class="lb" title="<%= com.getGdscom_content()%>"><b><%=CommentHelper.GetCommentUid(com.getGdscom_uid()) %>：</b><%=StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></div>
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
           	<span style="color:#919191">共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
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
	  
				<div class="clear"></div>
		 </div>
	</div>
</div>
<div class="clear"></div>
	
	<!-- 尾部开始 -->
	<%@include file="/inc/foot.jsp" %>
	<!-- 尾部结束 -->
</body>
</html>
