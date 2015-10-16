<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%!

/**
*
*/
public static ArrayList<Gdscoll> getGdscollBysceneid(int count)
{
	
	ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	clist.add(Restrictions.ge("gdscoll_serid",new Long(9)));
	clist.add(Restrictions.le("gdscoll_serid",new Long(11)));
	clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.desc("gdscoll_createdate"));
	List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, count+10);
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
	return list;
	
}




/**
 * 商品类型获得商品信息列表行数
 * @param p
 * @return
 */
public static int getPageTotalByRCode(String brandname,String productname,String productsort){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.eq("gdsmst_brandname", brandname));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", productsort));
		if(productname.trim().length()!=0){
			clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
		}
		int total = Tools.getManager(Product.class).getLength(clist);
		
	return total;
}

/**
 * 商品类型获得商品信息列表
 * @param p
 * @return
 */
public static ArrayList<Product> getProductListByRCode(String brandname,String productname,String sequence,String productsort,String sequenceprice,int PageIndex,int pageSize){
	ArrayList<Product> list=new ArrayList<Product>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", productsort));
		if(productname.trim().length()!=0){
			clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
		}
		
		List<Order> olist = new ArrayList<Order>();
		//olist.add(Order.desc("gdsmst_createdate"));
		
		boolean flag = true ;
		
		if(sequence.equals("1")){
			olist.add(Order.desc("gdsmst_createdate"));
		}
		else if(sequence.equals("4")){
			olist.add(Order.desc("gdsmst_memberprice"));
			flag = false ;
		}
		else if(sequence.equals("2")){
			olist.add(Order.desc("gdsmst_salecount"));
		}
		else{
			olist.add(Order.desc("gdsmst_createdate"));
		}
		
		if(flag){
			if(sequenceprice.equals("1")){
				olist.add(Order.desc("gdsmst_memberprice"));
			}
			else if(sequenceprice.equals("0")){
				olist.add(Order.asc("gdsmst_memberprice"));
			}
		}
		
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, (PageIndex-1)*pageSize, pageSize);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}
		if(sequence.equals("2")){
		Collections.sort(list,new com.d1.comp.SalesComparator());
		}
	return list;
}
/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
	
	return img;
}
//获取推荐商品
private static String getProductList(String code,int count)
{
	if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();

	ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
	pplist=PromotionProductHelper.getPProductByCode(code, count);
	if(pplist!=null&&pplist.size()>0)
	{
	 int counts=0;
	
  	 sb.append("<ul>");
  	 for(PromotionProduct pp:pplist)
  	 {
  		 if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			 {
  			   
  			    if(counts>7){break;}
  			    Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
				{
				   counts++;
	      		   String title = Tools.clearHTML(p.getGdsmst_gdsname()).trim();
	           	   String id = p.getId();
	           	   long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
	           	   long currentTime = System.currentTimeMillis();
	           	   sb.append("<li>"); 
	           	  
	           	   
	           	   sb.append("<div class=\"lf\">");	           	  
	           	   sb.append("<p style=\"z-index:999;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	   	           if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   	           {  
	   	           		sb.append("<img src=\""+ getImageTo200250(p)+"\" width=\"200\" height=\"250\" />");
	   	           }
	   	           else
	   	           {
	                      sb.append("<img src=\""+ ProductHelper.getImageTo200(p)+"\" width=\"200\" height=\"250\" />");
	   	           }
	   	           sb.append("</a></p>");	   	          
	   	           sb.append("<p style=\"height:35px; font-size:13px; color:#999999; \">");
	   	           sb.append("<span class=\"newspan\">");
	   	           if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
		   	    	 sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>特价:￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		   	    	 sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_oldmemberprice())+"</font>");
				       
	   	           }
		   	       else
		   	       {
		   	           sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		                  }
	   	           sb.append("</span>");
	               sb.append("<span class=\"newspan1\"><a href=\"/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">评论("+CommentHelper.getCommentLength(p.getId())+")</a></span>");
	               sb.append("</p>");
	           	   sb.append("</div>");
	           	   sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" ><a href=\"").append(ProductHelper.getProductUrl(p)).append("\" target=\"_blank\" style=\"font-size:12px; color:#606060; \">").append(StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,54)).append("</a></p><div class=\"clear\"></div>");	   
	               sb.append("</li>");
  		 }
  		}
  	 }   	 
  	 sb.append("</ul>");
	}	
	return sb.toString();
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="VEROMODA,VERO MODA,女装,连衣裙,特价" />
<title>VEROMODA专柜正品，女装特价销售2折起，VERO MODA女装，VERO MODA特价，VERO MODAT恤，VERO MODA连衣裙，VEROMODA女装热卖中</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/html/brand2010/veromoda/vm.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/html/brand2010/veromoda/vm.css")%>" rel="stylesheet" type="text/css" media="screen" />

</head>

<body >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<div class="vcenter">
<img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/logo.jpg" style="margin:0px; padding:0px;"/>
<div id="banner">
    <ul>
       <li><a href="http://www.d1.com.cn/html/women" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_07.jpg"/></a></li>
       <li><a href="http://www.d1.com.cn/result.jsp?productsort=020006" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_08.jpg"/></a></li>
       <li><a href="http://www.d1.com.cn/result.jsp?productsort=020004" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_09.jpg"/></a></li>
       <li><a href="http://www.d1.com.cn/result.jsp?productsort=020008" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_10.jpg"/></a></li>
       <li><a href="http://www.d1.com.cn/result.jsp?productsort=020010004" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_11.jpg"/></a></li>
       <li><a href="http://www.d1.com.cn/result.jsp?productsort=020006004" target="_blank"><img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/a_12.jpg"/></a></li>
       
    </ul>
</div>
<div class="clear"></div>
<%
     ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode("3255", 1);
     if(plist!=null&&plist.size()>0)
     {%>
    	 <a href="<%= plist.get(0).getSplmst_url().trim() %>" target="_blank"><img src="<%= plist.get(0).getSplmst_picstr() %>"/></a>
    	
     <%}
%>
<div class="cotent">
   <h3>VERO MODA风格女装</h3>
   
VERO MODA是丹麦国际时装公司BESTSELLER集团旗下知名品牌之一。经典中渗透最新的时尚感觉，简洁的款式突出优雅的女人味。为成熟的女性带来职业休闲装的新概念让她们上班和休闲场合都
能感觉到自信和美丽。VERO MODA拥有众多优秀的设计师，VERO MODA的销售网络遍布全球22个国家，拥有650家大型概念店，紧随世界时尚潮流，为全世界女性提供最具品位的时装。28年来，
VERO MODA一直为独立、自信、成熟的国际都市女性提供个性剪裁的时尚服装。与众多欧洲高档时装不同，VERO MODA主张"与其仰望不如穿在身上"的理念，时尚的设计，合理的价格，全球供应链
，使VERO MODA成为全球上班族女性的首选品牌。
</div>
	<div id="tabAuto1">
	<ul class="tabAuto1">
	<li class="active current"></li>
	<li ></li>
	<li ></li>
	</ul>
	<div class="clear"></div>
	<div class="tgh-box1">
	   <%
	       //获取诗若漫最新15套搭配
	       ArrayList<Gdscoll> gdscolllist=new ArrayList<Gdscoll>();
	       gdscolllist=getGdscollBysceneid(15);
	       if(gdscolllist!=null&&gdscolllist.size()>0)
	       {
	    	   int count=0;
	    	   for(Gdscoll gdscoll:gdscolllist)
	    	   {
	    		   if(gdscoll!=null)
	    		   {
	    			   count++;
	    			   if(count>15){break;}
	    			   if(count%5==1)
	    			   {
	    				   out.print("<div><ul>");
	    			   }
	    			   
	    			   if(count%5==1)
	    			   {%>
	    				 <li style="margin-left:0px;">
	    				     <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=gdscoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=gdscoll.getGdscoll_brandimg() %>" border="0"/></a>
	    				 </li>    
	    			   <%}
	    			   else{
	    			   %>
	    			    <li>
	    				     <a href="http://www.d1.com.cn/gdscoll/index.jsp?id=<%=gdscoll.getId() %>" target="_blank"><img src="http://images1.d1.com.cn<%=gdscoll.getGdscoll_brandimg() %>" border="0"/></a>
	    				 </li> 
	    		   <%   }
	    			   if(count%5==0)
	    			   {
	    				   out.print("</ul></div>");
	    			   }
	    		   }
	    	   }
	       }
	   %>
	  
	</div>
	</div>
	<div class="clear"></div>
	
	<div  id="rmdp">
	<img src="http://images.d1.com.cn/images2012/index2012/oct/vimages/vero_06.jpg"/>
	<table width="99%" style="margin:0px auto;">
	   <tr>
	      <td>
	      <div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("8184",20) %> 
	               </td>
	            </tr>
	         </table>
	      </div>
	   
	   </td>
	   </tr>
	</table>
	
	</div>
	
	
 <script type="text/javascript" src="/inc/getVTag.jsp"></script>	
<div>
   
</div>

</div>

<!-- 尾部开始 -->
<%@include file="/inc/foot.jsp"%>
<!-- 尾部结束 -->

</body>

</html>