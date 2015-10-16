<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="inc/header.jsp"%>
<%!

public static int getCommentListNew(String productId ,Date times){
	if(Tools.isNull(productId)) return 0;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));		
    Calendar c=Calendar.getInstance();
    c.setTime(times);
	c.add(Calendar.DATE,-20);
	listRes.add(Restrictions.ge("gdscom_createdate", c.getTime()));
	return Tools.getManager(Comment.class).getLength(listRes);
}
public static ArrayList<CommentGroup> getCommentGroupListBygdsid(String gdsid)
{
	   ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(gdsid!=null&&gdsid.length()>0&&Tools.isNumber(gdsid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_gdsid",gdsid));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 10000);
	
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				  rlist.add((CommentGroupSub)b); 
		         
				}
			}
		}
		else return null;
		ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
		if(rlist!=null&&rlist.size()>0)
		{
			for(CommentGroupSub cgs:rlist)
			{
				if(cgs!=null)
				{
					CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgs.getCommentgroupsub_cgid().toString());
					if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1){
						cglist1.add(cg);
					}
					
				}
			}
			return cglist1;
		}
		else {
			return null;
		}
}
public static ArrayList<CommentGroupSub> getCommentGroupSubList(String subid)
{
	 ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(subid!=null&&subid.length()>0&&Tools.isNumber(subid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_cgid",new Long(subid)));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				rlist.add((CommentGroupSub)b); 
				}
			}
		}
		return rlist;
}
public static int getCommentcount(String gdsid)
{
	int count=0;
    if(gdsid==null||gdsid.length()<=0||!Tools.isNumber(gdsid))
    {
    	return count;
    }
    Product product=ProductHelper.getById(gdsid);

    ArrayList<CommentGroup> cglist=new ArrayList<CommentGroup>();
    cglist=getCommentGroupListBygdsid(gdsid);
  
    if(cglist!=null&&cglist.size()>0)
    {
    	for(CommentGroup cg:cglist)
    	{
    		if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1)
    		{
    			ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId());
    			if(cgslist!=null&&cgslist.size()>0)
    			{
    				for(CommentGroupSub cgs:cgslist)
    				{
    					if(cgs!=null&&cgs.getCommentgroupsub_flag()!=null&&cgs.getCommentgroupsub_flag().longValue()==1
    							&&cgs.getCommentgroupsub_gdsid()!=null&&cgs.getCommentgroupsub_gdsid().length()>0&&!cgs.getCommentgroupsub_gdsid().equals(gdsid))
    					{
    						Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid().trim());
    						if(p!=null)
    						{
    							Date times=product.getGdsmst_createdate()!=null?product.getGdsmst_createdate():new Date();
    							count+=getCommentListNew(cgs.getCommentgroupsub_gdsid(),times);
    						}
    						
    					}
    				}
    			}
    		}
    	}
    }
    count+=CommentHelper.getCommentLength(gdsid);
    return count;
}
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) 
	{
		 if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			 img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
	}
	
	return img;
}
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

public static class ProductComparator implements Comparator<Product>{

		@Override
		public int compare(Product p0, Product p1) {	
			float p0s=0f;
			float p0sv=0f;
			float p1s=0f;
			float p1sv=0f;
			if(p0.getGdsmst_sortxs()!=null)p0s=p0.getGdsmst_sortxs().floatValue();
			if(p0.getGdsmst_sortxsv()!=null)p0sv=p0.getGdsmst_sortxsv().floatValue();
			if(p1.getGdsmst_sortxs()!=null)p1s=p1.getGdsmst_sortxs().floatValue();
			if(p1.getGdsmst_sortxsv()!=null)p1sv=p1.getGdsmst_sortxsv().floatValue();
			if(p0s+p0sv>p1s+p1sv){
				return 1 ;
			}else if(p0s+p0sv==p1s+p1sv){
				return 0 ;
			}else{
				return -1 ;
			}
		}
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
	private ArrayList<Product> GetGoods(String brand,String shopcode,String Order)
	{
		ArrayList<Product> result=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();	
		if(!Tools.isNull(brand))clist.add(Restrictions.eq("gdsmst_brand", brand));
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
					Collections.sort(result,new ProductComparator());// order by gdsmst_updatedate desc
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
String order="0";
if(request.getParameter("order")!=null&&request.getParameter("order").length()>0){
	order=request.getParameter("order");
}
String brand = request.getParameter("brand");
if(!Tools.isNull(brand)){
	brand = brand.trim();
	brand = Tools.simpleCharReplace(brand);
	
	
}


String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");

String headtitle="";
if(!Tools.isNull(brand)&&brand.indexOf(",")>=0){
	String[] brands=brand.split(",");
	for(int i=0;i<brands.length;i++){
		Brand brand1=BrandHelper.getBrandByCode(brands[i]);
		headtitle+=","+brand1.getBrand_name();
	}
}else{
	Brand brand1=BrandHelper.getBrandByCode(brand);
	if(brand1!=null)headtitle=brand1.getBrand_name();
}


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>【正品行货】<%= headtitle %>_<%= headtitle %>品牌_价格_图片<%  if(request.getParameter("pageno")!=null&&request.getParameter("pageno").length()>0) out.print("-第"+request.getParameter("pageno")+"页"); %>
-D1优尚网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网<%= headtitle %>, 频道，提供最新款<%= headtitle %>品牌、<%= headtitle %>价格、<%= headtitle %>图片以及<%= headtitle %>搭配图。想通过网上购物买到名牌<%= headtitle %>，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart2014.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/result2014.css")%>" rel="stylesheet" type="text/css"  />
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
<div class="listbody resultw">
<div class="r_list m_t10" id="r_list">
		<div class="mbodyrmin" id="mbodyr">
				
		<%
		
		ArrayList<Product> productList = GetGoods(brand,shopcode,order);
		int totalLength = (productList != null ?productList.size() : 0);		
		int PAGE_SIZE = 28 ;
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
			  <div class="rl_sort">
    <dl>
    <%/*orderContent
     case 6://热销商品升
  case 5 ://上架时间升
  case 4 ://上架时间降
  	case 3://热销商品
	case 2://价格，升序
	case 1://价格，倒序*/
		 %>
       <dd <%=Tools.isNull(order)||order.equals("0")?"class=\"rls_02 cur\"":""%>><a href='<%=orderURL%>' rel="nofollow">综合</a></dd>
      <dd <%//if(!Tools.isNull(orderContent)&&orderContent.equals("6")){
    	 // out.print("class=\"rls_02u cur\"");
      //}else 
    	  if(!Tools.isNull(order)&&order.equals("3")){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      %> >
      <%if(!Tools.isNull(order)&&!order.equals("3")){ %>
      <a href='<%=orderURL%>order=3' rel="nofollow">
      <%}else{ %>
       <a href='#' rel="nofollow">
      <%} %>
           销量&nbsp;</a></dd>
      <dd <%//if(!Tools.isNull(order)&&order.equals("5")){
    	  //out.print("class=\"rls_02u cur\"");
     // }else 
    	 if(!Tools.isNull(order)&&order.equals("4")){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      %>>
      <%if(!Tools.isNull(order)&&!order.equals("4")){ %>
      <a href='<%=orderURL%>order=4' rel="nofollow">
      <%}else{ %>
       <a href='#' rel="nofollow">
      <%} %>
         新品&nbsp;</a></dd>
      <dd <%if(!Tools.isNull(order)&&order.equals("1")){
    	  out.print("class=\"rls_04 cur\"");
      }else if(!Tools.isNull(order)&&order.equals("2")){
    	  out.print("class=\"rls_05 cur\"");
      }else{
    	  out.print("class=\"rls_03\"");
      }      
      %>><a href='<%=orderURL%>order=<%=!Tools.isNull(order)&&order.equals("1")?"2":"1" %>' rel="nofollow">价格&nbsp;</a></dd>
    </dl>
      
       <div class="sort_page">
       <span><%=pBean.getCurrentPage() %>/<%=pBean.getTotalPages() %>&nbsp;&nbsp;</span><span>
       <%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-left.gif" width="21" height="20" />
       </a><%}%>
       &nbsp;&nbsp;&nbsp;&nbsp;<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-right.gif" width="21" height="20" /></a><%}%></span> </div>
    </div>
           <div class="clear"></div>
           <%
           if(productList != null && !productList.isEmpty()){
        	  
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        		   int count=0;
           %>
           <ul class="m_t10"><%
        		   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
           String	nowtime2= DateFormat.format( new Date());
 for(Product goods : gList){
	 count++;
	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
	   String id = goods.getId();
	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
	   long currentTime = System.currentTimeMillis();
	   boolean ismiaoshao=false; 
	   boolean issgflag=false; 
	   String brandname=goods.getGdsmst_brandname();
	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
	String gtitle="";
	if(gname.length()<32){
	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
	}
	
			//ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
			//String shopname="";
			//if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
			ismiaoshao=CartHelper.getmsflag(goods);
		boolean	clsflag=false;
		
		D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
		long gdsnum=0;
		long buynum=0;
		long gdsnum2=0;
		if(ismiaoshao){
		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
		  if(sg!=null&&sg.getSggdsdtl_status().longValue()==1){
			   gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
	             gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
	        	
	         	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

	             if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
	             	  gdsnum=0;

	             }
			  
		     if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
				&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
		    	 issgflag=true ;
		     }
		  }
		}
			%>
<li class="libox" style="<%=clsflag?"height:370px":""%>">
<div class="rl_gds">
     <div class="g_simg">
     <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank">
     <% 
     if(clsflag){
			out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" />");
			}else{
				if(!Tools.isNull(getImageTo200250(goods))){
				out.print("<img src=\""+getImageTo200250(goods)+"\"  alt=\""+gname+"\" width=\"200\" height=\"250\" />");	
				}else{
      			out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" style=\"padding:25px 0px;\" />");
				}
			}
			
			%>
			<%if(acttb!=null){ 
			String acttxt="满"+acttb.getD1acttb_snum1()+"<br>减"+acttb.getD1acttb_enum1();
			%>
			<div class="gsimg_acttxt"><%=acttxt %></div>
			<%} %>
			<%if (issgflag){ 
				 String endtime2= DateFormat.format(goods.getGdsmst_promotionend());
			%>
			<div class="list_bg listsg_show"> </div>
			<div class="list_sg  listsg_show">
			已有<%=buynum %>人购买</br>
			仅剩余<%=gdsnum %>件</br>
			<div class="lsgtm" id="tjjs_<%=count%>">

				     <SCRIPT language="javascript">
                   var startDate= new Date("<%=nowtime2%>");
                   var endDate= new Date("<%=endtime2%>");
                   the_s[<%=count%>]=(endDate.getTime()-startDate.getTime())/1000;
                   setInterval("view_time(<%=count%>,'tjjs_<%=count%>')",1000);
                   </SCRIPT>
			</div>
			</div>
			<%} %>
 </a>
  </div>
    <div class="g_price">
    <span class="g_mprice">￥<font style="font-size:21px;">
<%
if(ismiaoshao){
out.print(Tools.getFormatMoney(goods.getGdsmst_msprice()));
}else{
out.print(Tools.getFormatMoney(goods.getGdsmst_memberprice()));
}
int comnum= getCommentcount(id);
int numflag=goods.getGdsmst_buylimit().intValue();

%>
</font></span><span class="m_t10">&nbsp;&nbsp;&nbsp;&nbsp;￥<s><%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></s>&nbsp;&nbsp;</span>
<%if(ismiaoshao&&!issgflag){ %>
<span class="g_hot">直降</span>  
<%}else if(issgflag){ %>
<span class="g_hot"><img src="http://images.d1.com.cn/images2014/result/list_sg.png"></img></span>  
<%} %>
</div>
 <div class="clear"></div>
     <div class="g_title">
    <span class="g_name"> 
     <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank"> <%=gname %>
   <%if(!gtitle.equals("null")&&gtitle.length()>0) {%>
    <span style="color:#c51520"><%=gtitle %></span>
    <%} %>
    </a>
    </span>
     <span class="<%=comnum>0?"g_com":""%>">
     <%=comnum>0?"<a href=\"http://www.d1.com.cn/product/"+id+"#cmt\" target=\"_blank\">"+comnum+"篇评论</a>":"&nbsp;" %></span>
     </div>
     <%if(clsflag){ %>
        <div class="g_incart" style="text-align:center">
         <span><input name="gdsnum<%=id %>"  id="gdsnum<%=id %>" class="gdsnum" value="1" type="text" /></span>
<span class="g_numbut m_l10"><a href="###" onclick="addnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-up.gif" width="16" height="14" /></a><br />
     <a href="###" onclick="lessnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-down.gif" width="16" height="14" /></a></span><span class="m_l10">
       <a href="###" attr="<%=goods.getId() %>" onclick="addlistCart(this);"><img src="http://images.d1.com.cn/images2014/result/addcart.jpg" width="108" height="26" /></a>
     </div>
     
     <%} %>
    
</div>
</li>
<%} %>
 </ul>
      <div class="clear"></div>
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
           }
        	   }else{
        	   %><div style="color:red;text-align:center;">没有满足条件的搜索结果！！！</div><%
           } %>
  </div>
	</div>

<div class="clear"></div>
</div>
<%@include file="inc/foot.jsp" %>

</body>
</html>