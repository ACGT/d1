<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/html/header.jsp"%>
<%@include file="/html/getComment.jsp" %>
<%!
private static ArrayList<GdsCutImg> getByGdsid(String gdsid){
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


//获取商品别表
private  String getProductlist(String code,int length)
{ 
  if(!Tools.isMath(code)) return "";
  ArrayList<PromotionProduct> plist = PromotionProductHelper.getPromotionProductByCode(code , length);

  StringBuilder sb = new StringBuilder();
  if(plist!=null&&plist.size()>0)
  {
  	int count=0;
  	sb.append("<table><tr><td><ul>");
  	for(PromotionProduct pp:plist){
  		if(pp.getSpgdsrcm_gdsid()!=null)
  		{
  			Product goods=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
  			if(goods!=null&&goods.getGdsmst_validflag()!=null&&goods.getGdsmst_validflag().longValue()==1&&goods.getGdsmst_ifhavegds()!=null&&goods.getGdsmst_ifhavegds().longValue()==0)
  			{
		  		count++;
		  		if(count>length){ break;}
		  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		  		String ids = goods.getId();
		  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
		  		long currentTimes = System.currentTimeMillis();
		  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
		  		if(count%4==0)
		  		{
		  			sb.append("<li style=\"margin-right:0px;\">");
		  		}
		  		else
		  		{
		  		   sb.append("<li>");
		  		}
		  		sb.append("<div class=\"lf\">");
		  		sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
		  		sb.append("<img src=\"http://images.d1.com.cn"+ goods.getGdsmst_img240300() +"\" width=\"240\" height=\"300\"  alt=\""+ Tools.clearHTML(goods.getGdsmst_gdsname()) +"\" />");
		  		
		  		
		  		sb.append("</a> ");
		  		sb.append("</p>");
		  		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
		  		sb.append("<span class=\"newspan\">");
		  		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
		  			sb.append("<font color=\"#b80024\" style=\" font-family:微软雅黑\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		  			sb.append("<font><strike>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</strike></font>");
		  		}else{
		  			sb.append(" <font color=\"#b80024\" style=\" font-family:微软雅黑\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		  		}
		  		sb.append("</span>");
		  		 //评论
	            int contentcount =0;
	            ArrayList<Comment> commentlists=getCommentList(goods.getId());
	            contentcount=commentlists.size();
		  		sb.append("<span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+ goods.getId() +"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">评论("+ contentcount +")</a></span>");
		  	    sb.append("</p>");          
		  		sb.append("</div>");    
		  		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
		  		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
		  		sb.append("<div class=\"clear\"></div> "); 
		  		sb.append("</li>");
		  	 }
  		}
  	}
  	
  	sb.append("</ul></td></tr></table>");    	
  	
  }
  return sb.toString();
}

//获取商品别表
private  String getProductlist1(String code,int length)
{ 
if(!Tools.isMath(code)) return "";
ArrayList<PromotionProduct> plist = PromotionProductHelper.getPromotionProductByCode(code , length);

StringBuilder sb = new StringBuilder();
if(plist!=null&&plist.size()>0)
{
	int count=0;
	sb.append("<table><tr><td><ul>");
	for(PromotionProduct pp:plist){
		if(pp.getSpgdsrcm_gdsid()!=null)
		{
			Product goods=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			if(goods!=null&&goods.getGdsmst_validflag()!=null&&goods.getGdsmst_validflag().longValue()==1&&goods.getGdsmst_ifhavegds()!=null&&goods.getGdsmst_ifhavegds().longValue()==0)
			{
		  		count++;
		  		if(count>length){ break;}
		  		String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		  		String ids = goods.getId();
		  		long endTimes = Tools.dateValue(goods.getGdsmst_discountenddate());
		  		long currentTimes = System.currentTimeMillis();
		  		String gnames=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,65) ;
		  		if(count%4==0)
		  		{
		  			sb.append("<li style=\"margin-right:0px;\">");
		  		}
		  		else
		  		{
		  		   sb.append("<li>");
		  		}
		  		sb.append("<div class=\"lf\">");
		  		sb.append("<p><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" >");
		  		sb.append("<img src=\""+ ProductHelper.getImageTo400(goods)+"\" width=\"240\" height=\"240\"  alt=\""+Tools.clearHTML(goods.getGdsmst_gdsname())+"\"/>");
		  		sb.append("</a> ");
		  		sb.append("</p>");
		  		sb.append("	<p style=\"height:35px; font-size:13px; color:#999999;\">");
		  		sb.append("<span class=\"newspan\">");
		  		if(endTimes >= currentTimes && endTimes <= currentTimes+Tools.MONTH_MILLIS){
		  			sb.append("<font color=\"#b80024\" style=\" font-family:微软雅黑\"><b>特价:￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		  			sb.append("<font><strike>￥"+Tools.getFormatMoney(goods.getGdsmst_oldmemberprice().floatValue())+"</strike></font>");
		  		}else{
		  			sb.append(" <font color=\"#b80024\" style=\" font-family:微软雅黑\"><b>￥"+Tools.getFormatMoney(goods.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		  		}
		  		sb.append("</span>	");		  		
	            //评论
	            int contentcount =0;
	            ArrayList<Comment> commentlists=getCommentList(goods.getId());
	            contentcount=commentlists.size();
		  		sb.append("<span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+ goods.getId() +"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">评论("+ contentcount +")</a></span>");
		  		sb.append(" </p>");          
		  		sb.append("</div>");    
		  		sb.append("<p style=\"height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;\" >");
		  		sb.append("<a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(goods)+"\" target=\"_blank\" style=\"font-size:12px; color:#606060;\">"+gnames+"</a></p>");
		  		sb.append("<div class=\"clear\"></div> "); 
		  		sb.append("</li>");
		  	 }
		}
	}
	
	sb.append("</ul></td></tr></table>");    	
	
}
return sb.toString();
}

%>
document.write('<div class=\"ysflproduct\" style=\"margin-top:10px;\">');
document.write('<div class=\"ysyrf\"><a href=\"http://www.d1.com.cn/html/self/yrf.jsp\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/result.jsp?productsort=030007002\" target=\"_blank\">男式羽绒服>></a>&nbsp;&nbsp;&nbsp;<a href=\"http://www.d1.com.cn/result.jsp?productsort=020007002\" target=\"_blank\">女式羽绒服>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist("8346",8) %>');
document.write('</div></div>');


document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"ysmy\"><a href=\"http://www.d1.com.cn/result.jsp?productsort=020007001,020007003,030007001,030007004\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/result.jsp?productsort=030007001\" target=\"_blank\">男式棉服>></a>&nbsp;&nbsp;&nbsp;<a href=\"http://www.d1.com.cn/result.jsp?productsort=020007001\" target=\"_blank\">女式棉服>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist("8347",8) %>');
document.write('</div></div>');


document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"ysdy\"><a href=\"http://www.d1.com.cn/search.jsp?key_wds=5aSn6KGj&sort=createtime&asc=false\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/result.jsp?productsort=030006004\" target=\"_blank\">男式大衣>></a>&nbsp;&nbsp;&nbsp;<a href=\"http://www.d1.com.cn/result.jsp?productsort=020006005\" target=\"_blank\">女式大衣>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist("8348",8) %>');
document.write('</div></div>');


document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"ysmf\"><a href=\"http://www.d1.com.cn/html/self/my.jsp\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/result.jsp?productsort=030004\" target=\"_blank\">男式毛衣>></a>&nbsp;&nbsp;&nbsp;<a href=\"http://www.d1.com.cn/result.jsp?productsort=020004\" target=\"_blank\">女式毛衣>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist("8349",8) %>');
document.write('</div></div>');


document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"yskz\"><a href=\"http://www.d1.com.cn/html/self/kz.jsp\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/result.jsp?productsort=030008,030009\" target=\"_blank\">男式裤装>></a>&nbsp;&nbsp;&nbsp;<a href=\"http://www.d1.com.cn/result.jsp?productsort=020008,020009\" target=\"_blank\">女式裤装>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist("8350",8) %>');
document.write('</div></div>');

document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"ysps\"><a href=\"http://www.d1.com.cn/html/self/ps.jsp\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://www.d1.com.cn/html/self/ps.jsp\" target=\"_blank\">更多配饰>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist1("8351",8) %>');
document.write('</div></div>');

document.write('<div class=\"ysflproduct\">');
document.write('<div class=\"yshzp\"><a href=\"http://cosmetic.d1.com.cn/\" target=\"_blank\" style=\"display:block; float:left; width:600px;height:50px;\"></a><a href=\"http://cosmetic.d1.com.cn/\" target=\"_blank\">更多化妆品>></a>&nbsp;&nbsp;&nbsp;</div>');
document.write('<div class=\"newproductlist\">');
document.write('<%= getProductlist1("8352",8) %>');
document.write('</div></div>');


         
	        
			
