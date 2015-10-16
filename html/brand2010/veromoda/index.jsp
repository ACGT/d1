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
		clist.add(Restrictions.eq("gdsmst_brandname", brandname));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.like("gdsmst_rackcode", productsort));
		if(productname.trim().length()!=0){
			clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
		}
		
		List<Order> olist = new ArrayList<Order>();
		//olist.add(Order.desc("gdsmst_createdate"));
		
		boolean flag = true ;
		
		if(sequence.equals("1")){
			olist.add(Order.desc("gdsmst_autoupdatedate"));
		}
		else if(sequence.equals("4")){
			olist.add(Order.desc("gdsmst_memberprice"));
			flag = false ;
		}
		else if(sequence.equals("2")){
			olist.add(Order.desc("gdsmst_salecount"));
		}
		else{
			olist.add(Order.desc("gdsmst_autoupdatedate"));
		}
		

		
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 50);
		if(b_list==null||b_list.size()==0)return null;
		if(b_list!=null){
			int count=1;
			StringBuilder grpdtlmstid=new StringBuilder();
			for(BaseEntity be:b_list){
				if(brandname.equals("诗若漫")){
			GoodsGroupDetail grpdtl=(GoodsGroupDetail)Tools.getManager(GoodsGroupDetail.class).findByProperty("gdsgrpdtl_gdsid", be.getId());
		//System.out.println("test:"+be.getId());
		        if(grpdtl!=null){
		        if(grpdtlmstid!=null&&grpdtlmstid.indexOf(grpdtl.getGdsgrpdtl_mstid().toString()+",")>=0)continue;
		       grpdtlmstid.append(grpdtl.getGdsgrpdtl_mstid().toString()+",");
		      
		        }
		        }
				if (count>pageSize)break;
				list.add((Product)be);
				count=count+1;
			}
		}
		/*if(sequence.equals("2")){
		Collections.sort(list,new com.d1.comp.SalesComparator());
		}*/
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
<title>VEROMODA专柜正品，女装特价销售2折起，VERO MODA女装，VERO MODA特价，VERO MODAT恤，VERO MODA连衣裙，VEROMODA女装热卖中</title>
<meta name="description" content="D1优尚网是提供VERO MODA女装，VERO MODAT恤，VERO MODA连衣裙的一家网上商城，在线销售2000多种女性服装，确保正品，假一罚二，支持货到付款" />
<meta name="keywords" content="VEROMODA,VERO MODA,女装,连衣裙,特价" />
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
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0"  align="center">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_01.jpg" width="609" height="43" alt=""></td>
		<td colspan="2">
			<a href="http://www.d1.com.cn/html/brand2010/only/index.jsp?sequence=2" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_02.jpg" width="135" height="43" alt=""></a></td>
		<td colspan="2">
			<a href="http://feelmind.d1.com.cn" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_03.jpg" width="151" height="43" alt=""></a></td>
		<td>
			<a href="http://aleeishe.d1.com.cn" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_04.jpg" width="85" height="43" alt=""></a></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_05.jpg" width="980" height="98" alt=""></td>
	</tr>
	<tr>
		<td>
			<a href="http://www.d1.com.cn/html/women" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_06.jpg" alt="" width="146" height="47" border="0"></a></td>
		<td>
			<a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020010004" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_07.jpg" alt="" width="168" height="47" border="0"></a></td>
		<td>
			<a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020002" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_08.jpg" alt="" width="161" height="47" border="0"></a></td>
		<td colspan="2">
			<a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020001" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_09.jpg" alt="" width="170" height="47" border="0"></a></td>
		<td colspan="2">
			<a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020008" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_10.jpg" alt="" width="165" height="47" border="0"></a></td>
		<td colspan="2">
			<a href="http://sheromo.d1.com.cn/srmcategorydisplay.htm?productsort=020006" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_11.jpg" alt="" width="170" height="47" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="9">
			<a href="http://www.d1.com.cn/zhuanti/201304/srm0408/" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_12.jpg" alt="" width="980" height="438" border="0" ></a></td>
	</tr>
	<tr>
		<td colspan="9">
<div class="cotent">
   <h3>VERO MODA风格女装</h3>
   
VERO MODA风格的服装：独立、自信、成熟。拥有国际都市个性剪裁的女性时尚服装。与众多欧洲高档时装不同，VERO MODA风格主张"与其仰望不如穿在身上"的理念，经典中渗透最新的时尚感觉，简洁的款式突出优雅的女人味。为成熟的女性带来职业休闲装的新概念让她们上班和休闲场合都能感觉到自信和美丽。
</div>			
</td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_14.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="9"><div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("8620",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_16.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
			 <script type="text/javascript" src="/inc/getVTag.jsp"></script>	
			 </td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_18.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
		<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                 
			<%String brandname="诗若漫";
			String sequence="1";
			ArrayList<Product> list=getProductListByRCode( brandname, "", sequence, "020%", "0",1,16);

if(list!=null){

	%>
<%
int i=0;
StringBuilder sb=new StringBuilder();
	 sb.append("<ul>");
for(Product p:list){
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
sb.append("</ul>");
out.println(sb.toString());
}

%>
	               </td>
	            </tr>
	         </table>
	      </div>
			</td>
	</tr>
	<tr>
		<td colspan="9">
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/srm_20.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="9">
					<div class="imglist">
	         <table>
	            <tr>
	               <td>
<%
String brandname2="VERO MODA";
String sequence2="2";
ArrayList<Product> list2=ProductHelper.getProductListByRCode( brandname2, "", sequence2, "020%", "0",1,20);

if(list2!=null){

	%>
<%
int i=0;
	StringBuilder sb=new StringBuilder();
	 sb.append("<ul>");
for(Product p:list2){
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
sb.append("</ul>");
out.println(sb.toString());
}
%>    </td>
	            </tr>
	         </table>
	      </div>
</td>
	</tr>
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="146" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="168" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="161" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="134" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="36" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="99" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="66" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="85" height="1" alt=""></td>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/veromoda/分隔符.gif" width="85" height="1" alt=""></td>
	</tr>
</table>
<!-- End ImageReady Slices -->


<!-- 尾部开始 -->
<%@include file="/inc/foot.jsp"%>
<!-- 尾部结束 -->

</body>

</html>