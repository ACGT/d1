<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%@include file="/brand/public.jsp" %>
<%!

//获得品牌下的分类
static ArrayList<BrandRck> getRackByBrand(String brandcode,String rackcode){
	    ArrayList<BrandRck> list=new ArrayList<BrandRck>();
	    ArrayList<BrandRck> rlist=new ArrayList<BrandRck>();
	    
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brandrck_brand", brandcode));
		clist.add(Restrictions.ge("brandrck_count", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("brandrck_seq"));
		List<BaseEntity> b_list = Tools.getManager(BrandRck.class).getList(clist, olist, 0,1000);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((BrandRck)be);
			}
		}
		//去掉重复分类
	    if(list!=null && list.size()>0){
			for(BrandRck product:list){
				if(!Tools.isNull(rackcode)){
					if(product.getBrandrck_rackcode().trim().startsWith(rackcode)){
						rlist.add(product);
					}
				}else{
					rlist.add(product);
				}
				
			}
		}
		return rlist;
}

//获得品牌下的分类南方
static ArrayList<BrandRck> getRackByBrandSouth(String brandcode,String rackcode){
	    ArrayList<BrandRck> list=new ArrayList<BrandRck>();
	    ArrayList<BrandRck> rlist=new ArrayList<BrandRck>();
	    
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brandrck_brand", brandcode));
		clist.add(Restrictions.ge("brandrck_count", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("brandrck_southseq"));
		List<BaseEntity> b_list = Tools.getManager(BrandRck.class).getList(clist, olist, 0,1000);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((BrandRck)be);
			}
		}
		//去掉重复分类
	    if(list!=null && list.size()>0){
			for(BrandRck product:list){
				if(!Tools.isNull(rackcode)){
					if(product.getBrandrck_rackcode().trim().startsWith(rackcode)){
						rlist.add(product);
					}
				}else{
					rlist.add(product);
				}
				
			}
		}
		return rlist;
}



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 【Feel Mind】_FM品牌官网_D1优尚网旗下品牌</title>
<meta name="description" content="D1优尚网是国内唯一在线销售Feel Mind/FM男装商品,提供Feel Mind/FM男装产品的最新报价、评论、导购、图片等相关信息" />
<meta name="keywords" content="Feel Mind/FM, Feel Mind/FM男装报价、促销、新闻、评论、导购、图片" />

<link href="/res/css/feelmind.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />

<style>
 /*滚动图片样式*/
	.scrollimglist{ width:740px;  height:365px; margin-top:10px; margin-left:12px; _margin-left:5px; }
	.container{ overflow:hidden;  width:740px; height:365px; }
	#CenterImg{overflow:hidden;padding:1px;}
	#CenterImg img{ border:none;}
	#ImgTable{table-layout:auto;}
	#ImgTable tr td a img{margin:1px;margin-top:0px;padding:0px;}
	#idNum{float:right;position:absolute;top:342px;right:18px;}
	#idNum li{float:left;list-style:none;color: #000;text-align: center;line-height: 15px;width: 15px;height: 15px;	font-family:"微软雅黑";font-size: 13px; font-weight:bold; cursor: pointer;margin: 2px;background:#f3f3f5;}
	#idNum li.on{line-height: 15px;width: 17px;height: 16px;color:#fff;background:#8a2b3f;}
    .newbanner1120 {position: fixed;z-index: 20000;top: 0px;text-align: left;background:#3c3c3c;}
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
    $('.one li:not(.two li)').each(function(i){
    	$(this).mouseover(function(){
    		//alert(i);
    		overul(i+1);
    	});
    	$(this).mouseout(function(){
    		outul(i+1);
    	});
    });
    
    //导航栏浮动
	//var m=$(".fmenul").offset().top;  
	//$(window).bind("scroll",function(){
    //var i=$(document).scrollTop(),
    //g=$(".fmenul");
	//if(i>=m)
	//{
		// g.addClass('newbanner1120');
	//}
    //else{
    	// g.removeClass('newbanner1120');
    	 //}
	//});
    
});

function overul(flag)
{
    var obj =$('#ul'+flag);
    if(obj.length>0)
    	{
    	   obj.css('display','block');
    	}
}
function outul(flag)
{
    var obj =$('#ul'+flag);
    if(obj.length>0)
    	{
    	   obj.css('display','none');
    	}
}
</script>  
</head>

<body>
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->


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
				<li class="lifestyle" style="width:90px;"><a href="http://feelmind.d1.com.cn/fmman.htm" style="font-size:16px; ">FM首页</font></a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" style="font-size:16px; ">男装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" style="font-size:16px; ">女装</a></li>
				<li><a href="http://feelmind.d1.com.cn/fmlovels.htm" style="font-size:16px; ">情侣装</a></li>
                <li style="width:60px;">&nbsp;&nbsp;&nbsp;&nbsp;</li>
               <li style="width:90px; font-size:16px;">搭配指南&nbsp;<font style="font-size:14px">>></font></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=1">加州男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=1&sex=2">加州女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=1">西部男装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=3&sex=2">西部女装</a></li>
				<li style="width:90px;"><a href="http://feelmind.d1.com.cn/fmseries.htm?serid=4&sex=1">学院男装</a></li>
				</ul>
        </div>
		</div>
		 <div class="clear"></div>
     </div>
     <div class="fmanc">
	   <!--左侧开始-->
	   <div class="fmancl">
	       <div class="fclsmenu">
	       <%
	       String flagbrand=session.getAttribute("flaghead")==null?"2":session.getAttribute("flaghead").toString();
	       
	       ArrayList<BrandRck> brlist=new ArrayList<BrandRck>();
	         ArrayList<BrandRck> brlist1=new ArrayList<BrandRck>();
	          if(flagbrand.equals("1"))
	          {
	        	  brlist=getRackByBrandSouth("001346","02");
	        	  brlist1=getRackByBrandSouth("001346","03");
	          }
	          else
	          {
	        	  brlist=getRackByBrand("001346","02");
	        	  brlist1=getRackByBrand("001346","03");
	          }
	          
	          if(flagbrand.equals("1"))
	   			{%>
	   			<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" target="_blank">男装分类</a></h3>
	   			 <ul class="one" style="padding-left:20px;">			
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002">T恤</a>
	   		 	       <ul class="two" style="display:none;" id="ul1">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030002"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;"  id="ul2">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030001"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;"  id="ul3">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030003"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul4">
	   		 	       <%
	   		 	         
	   		 	        	  if(brlist!=null&&brlist.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030004"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul5">
	   		 	       <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030005"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul6">
	   		 	       <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030006"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	    
	   		 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;"  id="ul7">
	   		 	       <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030007"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	    
	   				<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;"  id="ul8">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030008"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>  
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul9">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030009"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	     
	   		 	     
	   		 	     <li><a href="javascript:void(0)" >配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul10">
	   		 	            <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=033">男包</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032001">帽子</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032002">围巾</a></li>	
	   			 	        					      
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032005">腰带</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032003">袜子</a></li>
	   			 	        					     
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=031">男鞋</a></li>
	   			 	    </ul>
	   		 	     </li>
	   		 </ul>	  
	   			<%}
	   			else
	   			{			
	   			%>
	   			<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030" target="_blank">男装分类</a></h3>
	   			   <ul class="one" style="padding-left:20px;">

<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul6">
	   			 	        <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030002"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;" id="ul5">
	   			 	        <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030001"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
    <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
	   		 	       <ul class="two" style="display:none;" id="ul7">
	   		 	        <%
	   		 	         
	   		 	        	  if(brlist1!=null&&brlist1.size()>0)
	   		 	        	  {
	   		 	        		  for(BrandRck br:brlist1)
	   		 	        		  {
	   		 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030003"))
	   		 	        			  {
	   		 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   		 	        					  if(dir!=null)
	   		 	        					  {%>
	   		 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   		 	        					  <%}
	   		 	        			  }
	   		 	        		  }
	   		 	        	  }
	   		 	         
	   		 	       %>
	   		 	       </ul>
	   		 	     </li>
	   		 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul8">
	   			 	        <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030008"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul9">
	   			 	        <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030009"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul3">
	   			 	       <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030005"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul4">
	   			 	       <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030004"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			   <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul2">
	   			 	       <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030006"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			 	      
	   			 	      
	   			 	 
	   		 	    
	   			 	    <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul1">
	   			 	       <%
	   			 	         
	   			 	        	  if(brlist1!=null&&brlist1.size()>0)
	   			 	        	  {
	   			 	        		  for(BrandRck br:brlist1)
	   			 	        		  {
	   			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("030007"))
	   			 	        			  {
	   			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
	   			 	        					  if(dir!=null)
	   			 	        					  {%>
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
	   			 	        					  <%}
	   			 	        			  }
	   			 	        		  }
	   			 	        	  }
	   			 	         
	   			 	       %>
	   			 	       </ul>
	   			 	     </li>
	   			 	     
	   			 	     
	   			 	     
	   			 	     
	   			 	     <li><a href="javascript:void(0)" >配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
	   			 	       <ul class="two" style="display:none;"  id="ul10">
	   			 	            
	   			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=033">男包</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032001">帽子</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032002">围巾</a></li>	
	   			 	        					      
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032005">腰带</a></li>
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=032003">袜子</a></li>
	   			 	        					     
	   			 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=031">男鞋</a></li>
	   			 	           
	   			 	       </ul>
	   			 	     </li>
	   			 </ul>	       
	   			
	   			<%}
	        	   
	          
		        if(flagbrand.equals("1"))
				{%>
				<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" target="_blank">女装分类</a></h3>
				<ul class="one" style="padding-left:20px;">			
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;"  id="ul11">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020002"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;"  id="ul12">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020001"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;"  id="ul13">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020003"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul14">
			 	       <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020004"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul15">
			 	       <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020005"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul16">
			 	       <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020006"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul17">
				 	       <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020007"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
			 	    
					<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul18">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020008"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>  
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul19">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020009"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     
			 	     
			 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul20">
			 	                   <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
				 	        					     
				 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=022005">腰带</a></li>
				 	        					      
				 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=021">女鞋</a></li>
			 	       </ul>
			 	     </li>
			 </ul>	  
				<%
				}
				else
				{		
				%>
				<h3><a  style="font-size:15px; color:#fff;" href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020" target="_blank">女装分类</a></h3>
				   <ul class="one" style="padding-left:20px;">
				  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020002">T恤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul16">
				 	        <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020002"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020001">衬衫<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul15">
				 	        <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020001"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	    
				 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020003">POLO<font style=" font-size:12px;">&nbsp;▶</font></a>
			 	       <ul class="two" style="display:none;" id="ul17">
			 	        <%
			 	         
			 	        	  if(brlist!=null&&brlist.size()>0)
			 	        	  {
			 	        		  for(BrandRck br:brlist)
			 	        		  {
			 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020003"))
			 	        			  {
			 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
			 	        					  if(dir!=null)
			 	        					  {%>
			 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
			 	        					  <%}
			 	        			  }
			 	        		  }
			 	        	  }
			 	         
			 	       %>
			 	       </ul>
			 	     </li>
			 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020008">长裤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul18">
				 	        <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020008"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020009">短裤<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul19">
				 	        <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020009"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020005">卫衣<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul13">
				 	       <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020005"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     	
				 	     <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020004">毛衫<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul14">
				 	       <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020004"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 		<li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020006">外套<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul12">
				 	       <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020006"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
				 	     
			 	     	
				 	    <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=020007">棉服/羽绒服<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul11">
				 	       <%
				 	         
				 	        	  if(brlist!=null&&brlist.size()>0)
				 	        	  {
				 	        		  for(BrandRck br:brlist)
				 	        		  {
				 	        			  if(br!=null&&br.getBrandrck_rackcode()!=null&&br.getBrandrck_rackcode().trim().startsWith("020007"))
				 	        			  {
				 	        			          Directory dir=DirectoryHelper.getById(br.getBrandrck_rackcode().trim());
				 	        					  if(dir!=null)
				 	        					  {%>
				 	        						  <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=<%=dir.getId()%>"><%=dir.getRakmst_rackname().trim() %></a></li>
				 	        					  <%}
				 	        			  }
				 	        		  }
				 	        	  }
				 	         
				 	       %>
				 	       </ul>
				 	     </li>
			 	     
				 	     
				 	     <li><a href="javascript:void(0)">配饰<font style=" font-size:12px;">&nbsp;▶</font></a>
				 	       <ul class="two" style="display:none;" id="ul20">
				 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=015009">饰品</a></li>
				 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=022005">腰带</a></li>
				 	        					      <li><a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=021">女鞋</a></li>
				 	           
				 	       </ul>
				 	     </li>
				 </ul>	       
				
				<%}%>
		   </div>
	   </div>
	   <!--左侧结束-->
	    <!--右侧开始-->
	   <div class="fmancr">
	      <script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/YSImgScoll.js")%>"></script>
	             
	      <div class="scrollimglist">       
	                <script>ShowCenter(<%= ScrollImg("3126") %>,<%= ScrollText("3126") %>)</script>
	      </div>
		 <div class="bot">
	       <ul>
	       <%
	       ArrayList<Promotion> list=PromotionHelper.getBrandListByCode("3127",100);
	   	if(list!=null && list.size()>0){
	   		for(Promotion promotion:list){
	   			if(!promotion.getSplmst_url().equals("#")){%>
				<li><a href="<%=PromotionHelper.getPathUrl(0,StringUtils.encodeUrl(promotion.getSplmst_url()))%>" target="_blank">
			<%} %>
			<img src="<%=promotion.getSplmst_picstr() %>"  alt="<%=promotion.getSplmst_name() %>" border="0" />
			<% if(!promotion.getSplmst_url().equals("#")){%>
				</a></li>
			<%}
	   		}
	   	}else{%>   
	    	     <li><img src="http://images.d1.com.cn/images2012/feelmind/images/004.jpg" width="730" height="457"/></li>
			  <li><img src="http://images.d1.com.cn/images2012/feelmind/images/004.jpg" width="730" height="457"/></li>
	      <% }
	   	%>
		    
	       </ul>
		 </div>
		 <!-- 商品推荐 -->
		  <div class="plist">
		           <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030002" target="_blank"> <h3>T恤</h3></a>
		           <div class="newlist">
		              <%= getProduct("7866",6) %>
		           </div>
		        </div>
		        <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030001" target="_blank" style="color:#919191;"><h3>衬衫</h3></a>
	                <div class="newlist">
	                <%= getProduct("7868",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030004" target="_blank" style="color:#919191;"><h3>POLO</h3></a>
	                <div class="newlist">
	                <%= getProduct("8050",6) %>
	                </div>
	              </div>
				
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030008" target="_blank" style="color:#919191;"><h3>长裤</h3></a>
	                <div class="newlist">
	                <%= getProduct("8205",6) %>
	                </div>
	              </div>
	              <div class="plist">
	                <a href="http://feelmind.d1.com.cn/fmcategorydisplay.htm?productsort=030009&order=3" target="_blank" style="color:#919191;"><h3>短裤</h3></a>
	                <div class="newlist">
	                <%= getProduct("7869",6) %>
	                </div>
	              </div>
	              
	   </div>
	   <!--右侧结束-->
	    <div class="clear"></div>
	 </div>
	 
  </div>
</div>
<%@include file="foot.jsp" %>
</body>
</html>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
