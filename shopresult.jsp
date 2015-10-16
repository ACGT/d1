<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="inc/header.jsp"%>
<%@include file="/html/getComment.jsp" %>
<%!
//获取该商户的信息
	private ArrayList<ShopInfo> getShopInfoList(String shopcode)
	{
		ArrayList<ShopInfo> rlist = new ArrayList<ShopInfo>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("shopinfo_shopcode", shopcode));
		List<BaseEntity> list = Tools.getManager(ShopInfo.class).getList(clist, null, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ShopInfo)be);
		}
		
		return rlist ;
		
	}
	public static List<ShopRck> getShopRckList(String shopcode,int parentid){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("shoprck_shopcode", shopcode));
		listRes.add(Restrictions.eq("shoprck_parentid", new Long(parentid)));
		List<Order> olist= new ArrayList<Order>();
		olist.add(Order.asc("shoprck_seq"));
		List list = Tools.getManager(ShopRck.class).getList(listRes, olist, 0, 200);	
		if(list == null || list.isEmpty()) return null;	
		return list;
	}
/**
 * 按照销量比较商品，销量是计算出来的
 * @author cg
 *
 */
	public static class SalesBrandComparator implements Comparator<Brand>{
		 
		 //销售排行map
		private Map<String,Long> saleMap = null;
		
		public SalesBrandComparator(Map<String,Long> saleMap){
			this.saleMap = saleMap;
		}
	
		@Override
		public int compare(Brand p0, Brand p1) {
			long l0 = Tools.longValue(saleMap.get(Tools.trim(p0.getBrand_name())));
			long l1 = Tools.longValue(saleMap.get(Tools.trim(p1.getBrand_name())));
			if(l0>l1){
				return -1 ;
			}else if(l0==l1){
				return 0 ;
			}else{
				return 1 ;
			}
		}
	}
/*
//根据商户分类获取商品*/
	private ArrayList<Product> GetGoods(String rck,String shopcode,String Order)
	{
		ArrayList<Product> result=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();	
		if(!Tools.isNull(rck)&&!rck.equals("20130113")){
		//clist.add(Restrictions.eq("gdsmst_shoprck", rck));
		clist.add(Restrictions.like("gdsmst_shoprck", "%,"+rck+",%"));
		}
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 1000);	
		if(b_list!=null){
			for(BaseEntity be:b_list){
				result.add((Product)be);
			}
		}	
		//排序
				if(Order.equals("4")){
					Collections.sort(result,new SalesViewsCreateCom());// order by   gdsmst_createdate desc
				}
				else if(Order.equals("3")){
					Collections.sort(result,new SalesViewsSalesCom());// order by   gdssale_weeksalecount desc
					//Collections.reverse(list);
				}
				else if(Order.equals("5")){
					Collections.sort(result,new SalesViewPNameCom());// order by   gdsmst_gdsname 
					Collections.reverse(result);
				}
				else if(Order.equals("1")){
					Collections.sort(result,new SalesViewsPriceCom());// order by   gdsmst_memberprice desc
					Collections.reverse(result);
				}
				else if(Order.equals("2")){
					Collections.sort(result,new SalesViewsPriceCom());// order by   gdsmst_memberprice 
					
				}
				else{
					Collections.sort(result,new SalesSequenceComparator());// order by gdsmst_updatedate desc
				}
		return result;
	}



%><%
request.setCharacterEncoding("GBK");
ShopInfo si=new ShopInfo();
String shopcode="";
if(request.getParameter("sc")!=null&&request.getParameter("sc").length()>0){
	shopcode=request.getParameter("sc");
}
if(shopcode.equals("")){
	out.print("参数不正确！<a href=\"http://www.d1.com.cn/\">返回D1首页</a>");
}
ArrayList<ShopInfo> silist= getShopInfoList(shopcode);
if(silist!=null&&silist.size()>0&&silist.get(0)!=null){
   si=silist.get(0);
}
String order="4";
if(request.getParameter("order")!=null&&request.getParameter("order").length()>0){
	order=request.getParameter("order");
}
String productsort = request.getParameter("productsort");
if(!Tools.isNull(productsort)){
	productsort = productsort.trim();
	productsort = Tools.simpleCharReplace(productsort);
	String ps123 = productsort;
	//如果传了多个分类，只取第一个，原来有传多个分类的链接
	if(ps123.indexOf(",")>-1){
		ps123 = ps123.substring(0,ps123.indexOf(","));
	}
	ShopRck sr=(ShopRck)Tools.getManager(ShopRck.class).get(ps123);	
	if(sr == null && !ps123.equals("20130113")){
		response.sendRedirect("/index.jsp");
		return;
	}
}else{
	response.sendRedirect("/index.jsp");
	return;
}


String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");

//获取关键字
String headtitle="";
String topcat="";
String parentId="";
if(!Tools.isNull(productsort)&&productsort.indexOf(",")>-1){
		productsort = productsort.substring(0,productsort.indexOf(","));
	}
	if(Tools.isNull(productsort)) headtitle="";
	
	int length = productsort.length();
	boolean isRoot = false;
	
	
		if(productsort != null){
			ShopRck srd = (ShopRck)Tools.getManager(ShopRck.class).get(productsort);
			if(srd != null){
				headtitle = srd.getShoprck_name();
				parentId = srd.getShoprck_parentid().toString();
			}
			if(parentId!=null)
			{
				ShopRck srdp = (ShopRck)Tools.getManager(ShopRck.class).get(productsort);
				if(srdp!=null)
				{
					topcat=srdp.getShoprck_name();
				}
			}
		}
	
	


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>【正品行货】<%= headtitle %>_<%= topcat %>_<%= headtitle %>品牌_价格_图片<%  if(request.getParameter("pageno")!=null&&request.getParameter("pageno").length()>0) out.print("-第"+request.getParameter("pageno")+"页"); %>
-D1优尚网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网<%= headtitle %>, <%= topcat %>频道，提供最新款<%= headtitle %>品牌、<%= headtitle %>价格、<%= headtitle %>图片以及<%= headtitle %>搭配图。想通过网上购物买到名牌<%= headtitle %>，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/result2013.css")%>" rel="stylesheet" type="text/css"  />
<style>
.newbanner1120 {
position: fixed;
z-index: 20000;
top: 0;
background: white;
background: url(http://images.d1.com.cn/images2012/New/result/spjs_7.gif);
text-align: left;
}
#nocolor:hover{
color: #515151;
}
</style>
<script type="text/javascript">
	$(function(){		
		$('.libox').hover(function(){				
				$(this).css('border', 'solid 1px #e4e4e4');
			},function(){				
            $(this).css('border',  'solid 1px #fff');	
			}
		);
		//var wd=window.screen.width;
		var wd=980;
		if(wd>1200){	
			$('#resultall').removeClass('bodywmin')
			$('#resultall').addClass('bodywbig')
			$('#topcls').removeClass('bodywmin')
			$('#topcls').addClass('bodywbig')
			$('#mbody').removeClass('bodywmin')
			$('#mbody').addClass('bodywbig')
			$('#ssort').removeClass('sSort')
			$('#ssort').addClass('sSortbig')
			$('#mbodyr').removeClass('mbodyrmin')
			$('#mbodyr').addClass('mbodyrbig')
			$('#newlist').removeClass('newlistmin')
			$('#newlist').addClass('newlistbig')
			$('#pimg').removeClass('pimgmin')
			$('#pimg').addClass('pimgbig')
		}
	});
	
</script>
</head>

<body style=" margin:0px auto; background:#fff;">
<%@include file="inc/head.jsp" %>
<div class="clear"></div>
<div style="width:100%;overflow:hidden;margin:0px auto;">

	<% //店招背景图
	    if(si!=null&&!Tools.isNull(si.getShopinfo_bigimg())&&!Tools.isNull(si.getShopinfo_logo()))
	    {%>
	      <div style="background:url('<%= si.getShopinfo_bigimg() %>') top center no-repeat;">
	    <%}
	%>
	  <div style="width:980px; margin:0px auto; text-align:center;overflow:hidden;">
	      <%= si!=null&&si.getShopinfo_logo()==null||si.getShopinfo_logo().equals("")?"":si.getShopinfo_logo() %>
	   </div>
	   
	   <% ///if(si!=null&&!Tools.isNull(si.getShopinfo_bigimg()))
	   // {%>
	   <!-- 
	   </div>
	    -->
	   <%//} %> 
	   </div>  
<div class="all bodywmin" id="resultall">

	<div class="mbody bodywmin" id="mbody">
		<div class="mbodyl">
		<div class="mbodyllist">
		   <div class="mbllistt">店内分类</div>
	       <div class="classList">
	       <div class="water"></div>
		   <ul class="foldheader1">
		   <li class="parent">
				<a href="/shopresult.jsp?productsort=20130113&sc=<%=shopcode%>"  target="_blank">▼全部商品</a>
		   </li>
	       <%
	          List<ShopRck> shoprcklist=getShopRckList(shopcode,0);
		      if(shoprcklist!=null){
		    	   for(ShopRck sprck:shoprcklist){
		    	   if(sprck!=null){
		    	   	String shoprck_id= sprck.getId();
		    	   	%>		  	   	
		    	   	   
		    	   	   <li class="parent"><a id="nocolor">▼&nbsp;<%=sprck.getShoprck_name() %></a></li>
		    	   	<%
		    	   	    List<ShopRck> shoprcklist2=getShopRckList(shopcode,Tools.parseInt(sprck.getId()));
		    	   	    int parentnum=0;
		    	  	    if(shoprcklist2!=null){
		    	  	         parentnum=shoprcklist2.size();  
		    	  	    }
		                if(shoprcklist2!=null){
		    	   		    int inum=0;
		    	         for(ShopRck sprck2:shoprcklist2){
		    	       	     shoprck_id= sprck2.getId();
                             %><li><a href="http://www.d1.com.cn/shopresult.jsp?productsort=<%=shoprck_id %>&sc=<%=shopcode %>"<%if(productsort.equals(shoprck_id)){ %> class="on"<%} %>  target="_blank">>&nbsp;<%=sprck2.getShoprck_name() %></a></li>
							<%
							   inum++;
						 }
					     }
		                %>
		               
						<%}  
		    	    }
							   }
							%>
			 </ul>				
      </div>
	 </div>             
<br/>
<br/>
			<!-- 获取新分类结束 -->
	
		</div>
		<div class="mbodyrmin" id="mbodyr">
				
		<%
		
		ArrayList<Product> productList = GetGoods(productsort,shopcode,order);
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
		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");		
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    pageURL = pageURL.replaceAll("&+", "&"); 	    
		%>
			<div class = 'sSort' id="ssort">
               <span style='float:left'>&nbsp;&nbsp;<img src='http://images.d1.com.cn/images2012/New/result/red2.gif' style="_padding-top:4px;padding-top:2px;"/>&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style='float:left;color:#555555; font-weight:bold; font-size:14px;'>共有<font style=" color:#f00"><%=totalLength %></font>个产品&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style='float:left;color:#555555; font-size:12px;'>排序方式</span>
               <span style='float:right;color:#555555; font-size:12px;'><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getPreviousPage()%>">上一页</a><%}%>&nbsp;&nbsp;
               	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>&nbsp;&nbsp;
               </span>
               <dd style=" margin-left:15px;">
                   <a href='<%=orderURL%>order=4' rel="nofollow"><img src='<%="4".equals(order)?"http://images.d1.com.cn/images2012/New/result/newsale2.gif":"http://images.d1.com.cn/images2012/New/result/newsale1.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=3' rel="nofollow"><img src='<%="3".equals(order)?"http://images.d1.com.cn/images2012/New/result/saletop2.gif":"http://images.d1.com.cn/images2012/New/result/saletop1.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=2' rel="nofollow"><img src='<%="2".equals(order)?"http://images.d1.com.cn/images2012/New/result/price21.gif":"http://images.d1.com.cn/images2012/New/result/price2.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=1' rel="nofollow"><img src='<%="1".equals(order)?"http://images.d1.com.cn/images2012/New/result/price11.gif":"http://images.d1.com.cn/images2012/New/result/price1.gif" %>' border="0"/></a>&nbsp;&nbsp;
               </dd>
               
           </div>
           <div class="clear"></div>
           <%
           if(productList != null && !productList.isEmpty()){
        	  
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        		   int count=0;
           %>
         <div class="newlistmin" id="newlist">
         <ul><%
 for(Product goods : gList){
	 count++;
        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
        	   String id = goods.getId();
        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
        	   long currentTime = System.currentTimeMillis();
        	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,52) ;
        	String gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,30) ;
        	
        			ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(goods.getGdsmst_shopcode());
        			String shopname="";
        			if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
        			
        	%>
         <li class="libox">
    		<div class="lf"><%
           			//if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
           			%>
           			<!-- 
           				<a href='<%=ProductHelper.getProductUrl(goods) %>' target='_blank' title="<%=title %>"><img src="http://images.d1.com.cn/images2010/tejia2.gif" class="di" /></a>
           					 -->
           			
           				<% 
           				if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")||goods.getGdsmst_rackcode().substring(0,3).equals("034")))
           					{
           					%>
           				<p style="z-index:999;position:relative;height:250px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				<%}else{ %>
           			     <p style="z-index:999;position:relative;height:200px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           			
           				<% }%>
           				 <img src="<%= ProductHelper.getImageTo200(goods) %>" width="200" height="200"  alt="<%= Tools.clearHTML(goods.getGdsmst_gdsname()) %>" />
           	                				      
           				</a>  
           				
           				<%
           				    if(goods.getGdsmst_rackcode()!=null&&goods.getGdsmst_rackcode().length()>0&&(goods.getGdsmst_rackcode().startsWith("02")||goods.getGdsmst_rackcode().startsWith("03")
           				    		||goods.getGdsmst_rackcode().startsWith("015009"))&&goods.getGdsmst_specialflag().longValue()!=1)
           				    {%>
           				    	<!-- <span style="position:absolute; width:60px; height:85px; dislay:block; background:url('http://images.d1.com.cn/images2013/product/240-fz.png'); left:0px; top:0px; z-index:5000;"></span> -->
           				    <%}
           				if(goods.getGdsmst_rackcode()!=null&&goods.getGdsmst_rackcode().length()>0&&(goods.getGdsmst_rackcode().startsWith("014"))&&goods.getGdsmst_specialflag().longValue()!=1)
           				    {%>
       				    	<!-- <span style="position:absolute; width:60px; height:85px; dislay:block; background:url('http://images.d1.com.cn/images2013/product/240-zp.png'); left:0px; top:0px; z-index:5000;"></span>-->
       				    <%}
           				%>
           				<%  //每个商品对应的搭配列表
                              ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(goods.getId()); 
           				 %>   
                    
                       <%if (goods.getGdsmst_specialflag().longValue()==0){%>
                    
           				<!-- <span style="position:absolute; width:51px; height:68px; dislay:block; background:url('http://images.d1.com.cn/zt2012/20130218sbj/200-38.png'); left:0px; top:-5px; z-index:5000;"></span> -->
           				<%} %>
           				</p>
           
             
			               <% if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){%>
			              <p style=" text-align:center"><strong>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="priced">￥<%=Tools.getFormatMoney(goods.getGdsmst_oldmemberprice()) %></span></p>
			               <%}else
			                {%>
			              <p style=" text-align:center"><strong>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></strong></p>
			               <%} %>
		   		               
			<p class="gdst"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" target="_blank"><%=gname%></a></p>
			  <p class="gdst2"><span style="color:#fff">.</span>&nbsp;<%=gtitle %></p>
			    <!-- <p class="gdsshop"><a href="#" target="_blank"><%//=shopname %></a></p>-->
	
               </div>
              <div class="clear"></div>
             <!--  <%
                /*Comment com=null;
                List<Comment> list= CommentHelper.getCommentListByLevel(id,0,1);
                if(list!=null&&list.size()>0&&list.get(0)!=null)
                {
                	com=list.get(0);
                }*/
              %>
              <%
                 // if(com!=null)
                  //{%>
                	  <div class="lb" title="<%//= com.getGdscom_content() %>"><b><%//= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><a href="/product/<%//=id %>?st=com#cmt" target="_blank" rel="nofollow"><%//= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></a></div>
                  <% 
                  //}
                  //else
                  //{%>
                	<div class="lb" ><b>暂无评论！！！</b></div>  
                  <%//}
              %> -->
              <%
                  //获取搭配浮层
                  
                  if(gdscolllist!=null&&gdscolllist.size()>0)
                  {%>

                	  <div  id="floatdp<%= count %>" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">

                      </div>
                      <div id="price<%= count%>" class="dpprice" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">
                          <table width="100%">
                           <tr>
                            <td>   
                            <br/>
			                        <font style="text-align:left; font-size:12px; color:#ca0000;display:block; font-weight:bold; margin:0px auto;">&nbsp;说明：<br/>&nbsp;&nbsp;&nbsp;&nbsp;两件或两件以上95折 <br/>&nbsp;&nbsp;&nbsp;&nbsp;请在左侧选择搭配单品。</font>
			                        <br/><font style="color:#333; font-size:14px; font-weight:bold;">共&nbsp;<em id="count_<%=count %>">1</em>&nbsp;件&nbsp;&nbsp;组合购买</font><br/>
			                 <br>
			                 <strike>总价：￥&nbsp;<em id="totalmoney_<%=count %>">0.0</em>&nbsp;元  </strike>
			                 <br>组合价：<font color="#bc0000" face="微软雅黑">￥&nbsp;<em id="money_<%=count %>">0.0</em>&nbsp;</font>元<br>
			                                                  共优惠：￥&nbsp;<em id="cheap_<%=count %>"><%= 0.0 %></em>&nbsp;元  <br><br>
			                  <a href="javascript:void(0)" onclick="AddInCart(this)" flag="<%= count%>"><img src="http://images.d1.com.cn/Index/images/ljgmzh.png" />  </a> 
			                  <br/>
			                   <%
					         if((goods.getGdsmst_rackcode().startsWith("020")||goods.getGdsmst_rackcode().startsWith("030"))&&(goods.getGdsmst_brandname()!=null&&goods.getGdsmst_brandname().length()>0&&(goods.getGdsmst_brandname().equals("诗若漫")||goods.getGdsmst_brandname().equals("AleeiShe 小栗舍")||goods.getGdsmst_brandname().equals("FEEL MIND")))){%>
					    	 <a href="/gdscoll/freegdscoll.jsp?id=<%= id%>" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/SEP/DIY.png" style="border:none;"/></a><br/>
					    	
					         <%}
					      %>
			                </td>
                           </tr>
                          </table>  
                      </div>
                  <%}
              %>
             <input id="hidden<%=count %>" type="hidden" value="0"/>
              </li>
            <%
           } %>
</ul>
</div>
<%
           if(pBean.getTotalPages()>1){
           %>
           <div class="GPager">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
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
           </div><%}
           }}else{
        	   %><div style="color:red;text-align:center;">没有满足条件的搜索结果！！！</div><%
           } %>
       
           <% 
         Directory dir= DirectoryHelper.getById(productsort);
		if(dir!=null)
		{
			  String str=dir.getRakmst_rackname();
			  if(str.length()>0)
    {%>
   	
   	
       <%  //String newtag=getXGSS(id).replace('，', ',');
   	     ArrayList<Tag> elist=new ArrayList<Tag>();
   	     ArrayList<Tag> alist=new ArrayList<Tag>();
   	     ArrayList<Tag> list=TagHelper.getTags();
   	     if(list!=null&&list.size()>0)
   	     {
   	    	 for(Tag t:list)
   	    	 {
   	    		 if(t!=null&&t.getTag_key()!=null&&t.getTag_key().length()>0&&t.getTag_key().indexOf(str)>=0)
   	    		 {
   	    			 alist.add(t);
   	    		 }
   	    	 }
   	     }
   	     
   	     if(alist!=null)
   	     {
   	    	 for(int i=0;i<alist.size();i++)
   	    	 {
   	    		 Tag ti=alist.get(i);
   	    		 for(int j=i;j<alist.size()-1;j++)
   	    		 {   	    			
   	    			 Tag tj=alist.get(j+1);
   	    			 if(ti.getTag_key().equals(tj.getTag_key()))
   	    			 {
   	    				 ti=null;
   	    				 break;
   	    			 }
   	    			 
   	    		 }
   	    		if(ti!=null){
	    			   elist.add(ti);
	    	    }
   	    	 }
   	     }
			
   	     if(elist!=null&&elist.size()>0)
   	     {
   	        
   	     %>
   	    	   <div class="xgss" id="xgss">
   	               <em style="border:none;">相关搜索：  </em>
   	    	<%  
   	    	    if(elist.size()<=15)
   	    	    {
   	    	    	for(int i=0;i<elist.size();i++)
   					{
   						Tag cc=elist.get(i);
   						if(cc!=null)
   						{
   						
   					%>
   		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
   		            <%
   						}
   					}
   	    	    }
   	    	    else
   	    	    {
   	    	    	
   	   			    int num = new Random().nextInt(elist.size()-15);
       	   			for(int i=num;i<num+15;i++)
   					{
   						Tag cc=elist.get(i);
   						if(cc!=null)
   						{
   						
   					%>
   		            	<em><a href="http://www.d1.com.cn/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
   		            <%
   						}
   					}
   	    	    }
   	    	   
   	              out.print(" </div>");
   	    }
           
   }
   
}%>
            <div class="clear"></div>
           
           
           
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<%@include file="inc/foot.jsp" %>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script>
$(document).ready(function() {
	    var obj=$("#xgss");
	    if(obj!=null){
		  $(obj).css("display","none");
	    }
	    //导航栏浮动
		var m=$(".sSort").offset().top;  
		$(window).bind("scroll",function(){
	    var i=$(document).scrollTop(),
	    g=$(".sSort");
		if(i>=m)
		{
			 g.addClass('newbanner1120');
		}
	    else{g.removeClass('newbanner1120');}
		});
    //$(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
</script>
</body>
</html>