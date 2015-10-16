<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
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
<title>ONLY专柜正品,特价销售2折起,ONLYT恤,ONLY衬衫,ONLY清仓,ONLY特价,ONLY女装热卖中</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/html/brand2010/veromoda/vm.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/channel.css")%>" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/autotab.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/scrollimg.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/html/brand2010/veromoda/vm.js")%>"></script>

<style>
 .scrollimglist2 {width: 980px;height: 450px; margin:0px auto;}
 .tdlin {
	border-top-width: 2px;
	border-bottom-width: 2px;
	border-top-style: solid;
	border-bottom-style: solid;
	border-top-color: #000000;
	border-bottom-color: #000000;
}
.womenleft{ width:230px;background:#000; float:left;overflow:hidden;height:435px;+height:438px;}
.womenright{ width:750px; float:right;overflow:hidden;height:435px;+height:438px;padding:0px; margin:0px;}
.womenindex{ width:750px; height:35px;border-bottom:solid 3px #9C0001; overflow:hidden;padding:0px; margin:0px;}
.womenindex li{cursor: pointer;background:url('http://images.d1.com.cn/images2012/index2012/13january/azrbg.png');float: left;color: #2B2C2C;font-size: 12px;text-align: center;line-height: 35px; width:118px; height:35px;}
.womenindex li.current {background-image: url('http://images.d1.com.cn/images2012/index2012/13january/ahoverbg.png');color: #2B2C2C;}
.womenindexcontent{ width:750px; height:400px;padding:0px; margin:0px; overflow:hidden; float:right;}
.womenindexcontent div ul{width:750px; height:400px;overflow:hidden; padding:0px; margin:0px; list-style:none;background:#000;}
.womenindexcontent div ul li{ float:left; position:relative; font-size:12px;}
.womenindexcontent div ul li a{font-size:0px;}
.womenindexcontent div ul li p{margin:0px;}
.menindex{ width:750px; height:35px;border-bottom:solid 3px #9C0001; overflow:hidden;padding:0px; margin:0px;}
.menindex li{cursor: pointer;background:url('http://images.d1.com.cn/images2012/index2012/13january/azrbg.png');float: left;color: #2B2C2C;font-size: 12px;text-align: center;line-height: 35px; width:118px; height:35px;}
.menindex li.current {background-image: url('http://images.d1.com.cn/images2012/index2012/13january/ahoverbg.png');color: #2B2C2C;}
.menindexcontent{ width:750px; height:400px;padding:0px; margin:0px; overflow:hidden; float:right;}
.menindexcontent div ul{width:750px; height:400px; padding:0px; margin:0px; list-style:none;background:#000;}
.menindexcontent div ul li{ float:left; position:relative; font-size:12px;}
.menindexcontent div ul li a{font-size:0px;}
.menindexcontent div ul li p{margin:0px;}
</style>
</head>
<body >
<!-- 头部开始 -->
<%@include file="/inc/head.jsp"%>
<!-- 头部结束 -->
<table id="__01" width="980"  border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
			<img src="http://images.d1.com.cn/images2013/brand/only/only_01.jpg" width="576" height="43" alt=""></td>
		<td><a href="http://www.d1.com.cn/html/brand2010/veromoda/" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/only/only_02.jpg" alt="" width="175" height="43" border="0"></a></td>
		<td><a href="http://feelmind.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/only/only_03.jpg" alt="" width="141" height="43" border="0"></a></td>
		<td>
			<a href="http://aleeishe.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2013/brand/only/only_04.jpg" alt="" width="88" height="43" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_05.jpg" width="980" height="99" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_06_1.jpg" width="980" height="426" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_07.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                 
			<%String brandname="ONLY";
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
	      </div></td>
	</tr>
	<tr>
		<td height="80" colspan="4" class="tdlin"><p style="line-height:26px;"><span style="font-size:14px; font-weight:bold">ONLY 风格女装</span><br>ONLY风格的服装：张扬自我的主张，活力，自信，热情，主张女人要有自己独立的风格！在衣服的色彩上鲜明大胆，在生活理念上追求自由;强悍独立但是却有十足的女人味。</p></td>
	</tr>
	<tr>
		<td colspan="4">
			
			<div class="scrollimglist2">
                
                  <script>ShowCenter(<%= ScrollImg("3396") %>,<%= ScrollText("3396") %>,980,450,3000)</script>   
            
         </div>
			</td>
	</tr>
	<tr>
		<td colspan="4">
			<%@include file="/inc/getxpqxonly.jsp"%></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_12.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("7988",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_14.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("7775",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_16.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("7776",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_18.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("7777",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_20.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("8213",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/brand/only/only_22.jpg" width="980" height="50" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="imglist">
	         <table>
	            <tr>
	               <td>
	                  <%=getProductList("7778",16) %> 
	               </td>
	            </tr>
	         </table>
	      </div></td>
	</tr>
</table>
<!-- End ImageReady Slices -->


<!-- 尾部开始 -->
<%@include file="/inc/foot.jsp"%>
<!-- 尾部结束 -->

</body>

</html>