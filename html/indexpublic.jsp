<%@ page contentType="text/html; charset=UTF-8" import="com.d1.*,com.d1.dbcache.core.*,com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.manager.*"%>
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

//获得每个栏目的关键字推荐
private static String getKeyWord(String code){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
     		String title = recommend.getSplmst_name();
     		sb.append("<a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a>");
     		if(i<size-1) sb.append("&nbsp;&nbsp;&nbsp;&nbsp;");
		}
		
	}
	return sb.toString();
}

//获得左侧分类列表
private static String getCatelist(String code,int length){
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , length);
	if(recommendList != null && !recommendList.isEmpty()){
		
		sb.append("<ul>");
		for(int i=0;i<recommendList.size();i++){
			Promotion recommend = recommendList.get(i);
   		    String title = recommend.getSplmst_name();
   		    sb.append("<li><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" title=\"").append(title).append("\" target=\"_blank\">").append(title).append("</a></li>");
   		
		}
		sb.append("</ul>");
		
	}
	return sb.toString();
}

//获取滚动新闻
private static String getScrollNews(String code)
{
	if(!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();
     ArrayList<Promotion> list=new ArrayList<Promotion>();
     list=PromotionHelper.getBrandListByCode(code, -1);
     if(list!=null&&list.size()>0)
     {
    	 for(Promotion p:list)
    	 {
    		 if(p!=null)
    		 {
		    	 sb.append("<li>");
		    	 sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target='_blank' rel=\"nofollow\">");
		    	 sb.append(StringUtils.clearHTML(p.getSplmst_name()));
		    	 sb.append("</a></li>");
    		 }
    	 }
     }
     
	return sb.toString();
}

//获取优品尚志
private static String getUpsz(String code,int length){
	if(!Tools.isMath(code) || length<=0) return "";
	ArrayList<Promotion> recList = PromotionHelper.getBrandListByCode(code,length);
	if(recList!=null&&recList.size()>0)
	{
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<recList.size();i++)
		{
			if(i==0)
			{
				sb.append(" <div id=\"ypsz_"+(i+1)+"\" class=\"magabody\">");
				sb.append(" <a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\">");
				sb.append("<img src=\""+recList.get(i).getSplmst_picstr()+"\" width=\"245\" height=\"305\"></img></a>");
				sb.append("<span style=\"display:block; padding-top:4px; padding-bottom:2px; _padding-bottom:0px;\">");
				sb.append("<a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\" >");
				sb.append("<img src=\"http://images.d1.com.cn/Index/DJYD.gif\" style=\" margin-left:1px; _margin-top:3px; _margin-bottom:3px; +margin-top:2px; +margin-bottom:2px;\" ></img></a></span></div>");
				
				}
			else
			{
				sb.append(" <div id=\"ypsz_"+(i+1)+"\" class=\"magabody\" style=\"display:none;\">");
				sb.append(" <a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\">");
				sb.append("<img src=\""+recList.get(i).getSplmst_picstr()+"\" width=\"245\" height=\"305\"></img></a>");
				sb.append("<span style=\"display:block; padding-top:4px; padding-bottom:2px; _padding-bottom:0px;\">");
				sb.append("<a href=\""+StringUtils.encodeUrl(recList.get(i).getSplmst_url())+"\" target=\"_blank\" >");
				sb.append("<img src=\"http://images.d1.com.cn/Index/DJYD.gif\" style=\" margin-left:1px; _margin-top:3px; _margin-bottom:3px; +margin-top:2px; +margin-bottom:2px;\" ></img></a></span></div>");
				
			}
		}
		return sb.toString();
	}
	return "";
}


/**
* 获取弹出框图片列表
* @param code 推荐位号
* @return
*/
private static String ScrollImg(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, -1);
	if(list!=null&&list.size()>0)
	{
		sb.append("\"");
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			if(i==list.size()-1)
			{
				sb.append(p.getSplmst_picstr());					
			}
			else
			{
				sb.append(p.getSplmst_picstr()).append(",");
			}
			
		}
		sb.append("\"");
		
	}
	return sb.toString();
	
}


/**
* 获取弹出框链接列表
* @param code 推荐位号
* @return
*/
private static String ScrollText(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, -1);
	if(list!=null&&list.size()>0)
	{
		sb.append("\"");
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}
			if(i==list.size()-1)
			{
				sb.append(StringUtils.clearHTML(url));					
			}
			else
			{
				sb.append(StringUtils.clearHTML(url)).append("|");
			}
			
		}
		sb.append("\"");
		
	}
	return sb.toString();
}

//获取人气爆款图片列表
private static String getImglist(String code,int length)
{
    if(!Tools.isMath(code)) return "";
    StringBuilder sb=new StringBuilder();
    List<Promotion> list=PromotionHelper.getBrandListByCode(code, 4);
    if(list!=null&&list.size()>0)
    {
    	sb.append("<ul class=\"index_rqbk\">");
    	for(Promotion p:list)
    	{
    		if(p!=null)
    		{
    			sb.append("<li><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
    			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/>");
    			sb.append("</a></li>");
    		}
    	}
    	sb.append("</ul>");
    }
    return sb.toString();
    
}


//获取场景背景图片
private static String getSeceBg(String code)
{
	 if(!Tools.isMath(code)) return "";
	    StringBuilder sb=new StringBuilder();
	    List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	    if(list!=null&&list.size()>0&&list.get(0)!=null&&list.get(0).getSplmst_picstr()!=null&&list.get(0).getSplmst_picstr().length()>0)
	    {
	    	sb.append("style=\"background:url('").append(list.get(0).getSplmst_picstr()).append("') no-repeat;\"");
	    }
	    return sb.toString();
}


//获取品牌推荐
private static String getPPimglist(String code,int length)
{
    if(!Tools.isMath(code)) return "";
    StringBuilder sb=new StringBuilder();
    List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
    if(list!=null&&list.size()>0)
    {
    	int size=0;
    	sb.append("<ul>");
    	for(Promotion p:list)
    	{ 
    		if(p!=null)
    		{
    			size++;
    			if(size>5)
    			{
    				sb.append("<li style=\"border-top:none;\">");
    			}
    			else
    			{
    				sb.append(" <li>");
    			}
    			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
    			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"123\" height=\"174\"/>");
    			sb.append("</a></li>");
    		}
    	}
    	sb.append("</ul>");
    }
    return sb.toString();
    
}

//获取图片推荐
private static String getimglist(String code,int length)
{
  if(!Tools.isMath(code)) return "";
  StringBuilder sb=new StringBuilder();
  List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
  if(list!=null&&list.size()>0)
  {
  	int size=0;
  	
  	for(Promotion p:list)
  	{ 
  		if(p!=null)
  		{
  			
  				sb.append(" <li>");
  			
  			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
  			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"100\" height=\"40\"/>");
  			sb.append("</a></li>");
  		}
  	}
  	
  }
  return sb.toString();
  
}
//获取一张图
private static String getimg(String code,int length,int width,int height)
{
if(!Tools.isMath(code)) return "";
StringBuilder sb=new StringBuilder();
List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
if(list!=null&&list.size()>0)
{
	int size=0;
	
	for(Promotion p:list)
	{ 
		if(p!=null)
		{	
			
			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\""+width+"\" height=\""+height+"\"/>");
			sb.append("</a>");
		}
	}
	
}
return sb.toString();

}


//获取系列
private static String getxl(String code,int length)
{
if(!Tools.isMath(code)) return "";
StringBuilder sb=new StringBuilder();
List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
if(list!=null&&list.size()>0)
{
	int size=0;
	
	for(Promotion p:list)
	{ 
		if(p!=null)
		{
			sb.append("<li><font style=\"font-size:13px\">▪</font>&nbsp;").append("<a href=\""+p.getSplmst_url()+"#left"+"\" target=\"_blank\" style=\"color:#fff;\">"+Tools.clearHTML(p.getSplmst_name())).append("</a></li>");
			
		}
	}
	
}
return sb.toString();

}


//获取文字加图片
private static String getimglist1(String code,int length)
{
		if(!Tools.isMath(code)) return "";
		StringBuilder sb=new StringBuilder();
		List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
		if(list!=null&&list.size()>0)
		{
			int size=0;
			
			for(Promotion p:list)
			{ 
				if(p!=null)
				{
					size++;
					if(size==1)
					{
						sb.append("<tr><td height=\"15\"></td></tr>");
					}
					sb.append("<tr><td style=\"text-align:center;\"><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\"><img src=\"").append(p.getSplmst_picstr()).append("\" width=\"180\" height=\"90\"/></a></td></tr>");
					sb.append("<tr><td height=\"15\"></td></tr>");
					//if(size%3!=0)
					//{
					// sb.append("<tr><td height=\"10\" style=\"border-bottom:dashed 1px #ccc;\"></td></tr>");
					//}
				}
			}
			
		}
		return sb.toString();

}
//获取图片加图片
private static String getimglist2(String code,int length)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
	if(list!=null&&list.size()>0)
	{
		int size=0;
		
		for(Promotion p:list)
		{ 
			if(p!=null)
			{
				size++;
				if(size==1)
				{
					sb.append("<tr><td height=\"8\"></td></tr>");
				}
				sb.append("<tr><td style=\"text-align:center;\"><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\"><img src=\"").append(p.getSplmst_picstr()).append("\" width=\"180\" height=\"90\"/></a></td></tr>");
				sb.append("<tr><td height=\"8\"></td></tr>");
				//if(size%3!=0)
				//{
				// sb.append("<tr><td height=\"10\" style=\"border-bottom:dashed 1px #ccc;\"></td></tr>");
				//}
			}
		}
		
	}
	return sb.toString();

}


//获取商品推荐
private static String getProductList(String code,int length){
	if(!Tools.isMath(code)) return "";
	List<PromotionProduct> recommendProList = PromotionProductHelper.getPromotionProductByCode(code , length);
	StringBuilder sb = new StringBuilder();
	if(recommendProList != null && !recommendProList.isEmpty()){
		sb.append("<ul>");
		for(PromotionProduct pp:recommendProList){
			if(pp!=null)
			{
				Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(product!=null)
				{
					ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
					String imgurl1="";
					GdsCutImg gci=new GdsCutImg();
					if(gcilist!=null&&gcilist.size()>0)
					{
						gci=gcilist.get(0);
					}
					
					if(gci!=null)
					{
						
					
						if(gci!=null&&gci.getGdscutimg_160()!=null&&gci.getGdscutimg_160().length()>0)
						{
							imgurl1=gci.getGdscutimg_160();
							if(imgurl1!=null&&imgurl1.startsWith("/shopimg/gdsimg")){
								imgurl1 = "http://images1.d1.com.cn"+imgurl1.trim();
								}else{
									imgurl1 = "http://images.d1.com.cn"+imgurl1.trim();
								}
						}
						else
						{
							imgurl1=ProductHelper.getImageTo160(product);
						}
					}
					sb.append("<li><table height=\"258\" >");
					sb.append("<tr><td height=\"38\"></td></tr>");
					sb.append("<tr><td height=\"167\"><a href=\"").append("/product/").append(product.getId()).append("\" target=\"_blank\">");
					sb.append("<img src=\"").append(imgurl1).append("\" width=\"160\" height=\"160\"/></a></td></tr>");
					sb.append("<tr><td height=\"30\" style=\"text-align:center; padding-top:4px;\"><font class=\"font1\">￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font>&nbsp;&nbsp;&nbsp;&nbsp;<font class=\"font2\">￥").append(Tools.getFormatMoney(product.getGdsmst_saleprice())).append("</font></td></tr>");
				    sb.append("<tr><td style=\"text-align:center; padding:4px;\"><a href=\"/product/").append(product.getId()).append("\" target=\"_blank\">").append(Tools.clearHTML(pp.getSpgdsrcm_gdsname())).append("</a></td></tr>");   
					sb.append("</table></li>");
				}
			}
	  }
		
		sb.append("</ul>");
		
	}
    return sb.toString();

}

//获取分类下的文字推荐
private String getCKey(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
     		String title = recommend.getSplmst_name();
     		sb.append("<a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" title=\"").append(Tools.clearHTML(title)).append("\" target=\"_blank\">").append(title).append("</a>");
     		
     		if(title.indexOf("<br>")<0)
     		{
     			if(i<size-1)
     			{
     			   sb.append("&nbsp;|&nbsp;");
     			}
     		}
     		
     		
		}
		
	}
	return sb.toString();
}
//获取tag
private static String getTag(String code,String flag)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	StringBuilder sb1 = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , -1);
	if(recommendList != null && !recommendList.isEmpty()){
		int size = recommendList.size();
		sb.append("<ul class=\"tabAuto").append(flag).append("\">");
		sb1.append("<div class=\"tgh-box").append(flag).append("\">");
		for(int i=0;i<size;i++){
			Promotion recommend = recommendList.get(i);
     		String title = recommend.getSplmst_name();
     		sb.append("<li>").append(title).append("</li>");
     		sb1.append("<div><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\"").append(" target=\"_blank\">").append("<img src=\"").append(recommend.getSplmst_picstr()).append("\" width=\"980\" height=\"531\"  />").append("</a></div>");
     		
		}
		sb.append("</ul>");
		sb1.append("</div>");
	}
	return sb.append(sb1.toString()).toString();


}
//获取首页个品牌logo图
private static String getLogo(String code)
{
  if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
  String result="";
  ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
  if(list!=null&&list.size()>0)
  {
  	if(list.get(0)!=null&&list.get(0).getSplmst_picstr()!=null&&list.get(0).getSplmst_picstr().length()>0)
  	{
  		result=list.get(0).getSplmst_picstr();
  	}
  }
  return result;
}
//获取首页个品牌logo图链接
private static String getLogoUrl(String code)
{
if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
String result="";
ArrayList<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
if(list!=null&&list.size()>0)
{
	if(list.get(0)!=null&&list.get(0).getSplmst_url()!=null&&list.get(0).getSplmst_url().length()>0)
	{
		
		result=list.get(0).getSplmst_url()+"#left";
		
		
	}
}
return result;
}
//获取其他配件（就是搭配详细里不显示的商品）
private static ArrayList<Gdscolldetail> getOtherGdscoll(String gdscollid)
{
	ArrayList<Gdscolldetail> list=new ArrayList<Gdscolldetail>();
	if(Tools.isNull(gdscollid)||!Tools.isNumber(gdscollid))
	{
		return null;
	}
ArrayList<Gdscolldetail> glist=GdscollHelper.getGdscollBycollid1(gdscollid);
if(glist!=null&&glist.size()>0)
{
	for(Gdscolldetail gd:glist)
	{
		if(gd!=null&&gd.getGdscolldetail_gdsflag()!=null&&gd.getGdscolldetail_gdsflag().longValue()==0)
		{
			if(gd.getGdscolldetail_gdsid()!=null&&gd.getGdscolldetail_gdsid().length()>0)
			{
	    			Product p=ProductHelper.getById(gd.getGdscolldetail_gdsid());
	    			if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0&&ProductStockHelper.canBuy(p))
	    			{
	    			  list.add(gd);
	    			}
			}
		}
	}
}
return list;
}
//获取热门分类
private static String getHotClass(String code)
{
	if(Tools.isNull(code)||!Tools.isNumber(code))
	{
	   return "";	
	}
   StringBuilder sb=new StringBuilder();
   ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(code, 100);
   if(plist!=null&&plist.size()>0)
   {
	   int i=0;
	   for(Promotion p:plist)
	   {
		   if(p!=null)
		   {
			   i++;
			   if(i==1)
			   {
				   if(code.equals("3174")||code.equals("3175"))
				   {
					   sb.append("<td class=\"hottd\" style=\"border-bottom:#e1e1e1;\"> <div class=\"hottile\"><a href=\""+p.getSplmst_url()+"\" target=\"_blank\">"+p.getSplmst_name()+"</a></div></td>");
				   }
				   else
				   {
					   if(code.equals("3234")||code.equals("3235")||code.equals("3160"))
					   {
						   sb.append("<td class=\"hottd\"> <div class=\"hottile\"><a>"+p.getSplmst_name()+"</a></div></td>");
					    }
					   else{
						   sb.append("<td class=\"hottd\"> <div class=\"hottile\"><a href=\""+p.getSplmst_url()+"\" target=\"_blank\">"+p.getSplmst_name()+"</a></div></td>");
						}
					    
				   }
				   sb.append("<td class=\"hotb\"><div class=\"hotcontent\">");
			   }
			   else
			   {
				   
				  
				   sb.append("<p><a href=\""+p.getSplmst_url()+"\" target=\"_blank\">"+p.getSplmst_name().replace("<br/>", "")+"</a>|</p>");
				 
			      if(p.getSplmst_name().indexOf("<br/>")>=0)
			      {
			    	  sb.append("<br/><div class=\"clear\"></div>");
			      }
			   }
			}
	   }
	   sb.append("</div></td>");
   }
   
   return sb.toString();
}
//获取首页轮播
public static String getIndexLB(String code)
{
    StringBuilder sb=new StringBuilder();
    StringBuilder sb1=new StringBuilder();
    if(Tools.isNull(code)||!Tools.isMath(code)) return "";
    ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(code, 10);
    if(plist!=null&&plist.size()>0)
    {
    	sb.append(" <div id=\"tabAuto08\">");
    	sb.append("<div class=\"tgh-box08\">");
    	sb1.append(" <ul class=\"tabAuto08\">");
    	int i=0;
    	for(Promotion p:plist)
    	{
    		if(p!=null)
    		{
    			i++;
    			String url=p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"http://www.d1.com.cn";
    		    String mainimg=p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0?p.getSplmst_picstr():"";
    		    String smallimg=p.getSplmst_picstr2()!=null&&p.getSplmst_picstr2().length()>0?p.getSplmst_picstr2():"";
    		    sb.append("<div style=\"display: block; \"><a href=\""+url+"\" target=\"_blank\"><img src=\""+mainimg+"\" width=\"740\" height=\"336\"/></a></div>");
    		    if(i==1){
    		    	sb1.append("<li><a href=\""+url+"\" target=\"_blank\"><img src=\""+smallimg+"\" width=\"119\" height=\"74\"></a>");
    		    	sb1.append(" <span  class=\"indexfloat\" ></span>");
    		    	sb1.append("</li>");
        		}
    		    else
    		    {
    		    	sb1.append("<li><a href=\""+url+"\" target=\"_blank\"><img src=\""+smallimg+"\" width=\"119\" height=\"74\"></a>");
    		    	sb1.append(" <span class=\"indexfloat\"  ></span>");
    		    	sb1.append("</li>");
    		    }
    		    if(i>=6)
    		    {
    		    	break;
    		    }
    		}
    	}
    	sb1.append("</ul>");
    	sb.append("</div><div class=\"clear\"></div>");
    	sb.append(sb1);
    	sb.append("</div>");
    }
    
    return sb.toString();
    
    
}

//获取首页个品牌logo图(分区域)
private static String getLogo(String code,String flag)
{
if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
String result="";
ArrayList<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code, flag, 1);
if(list!=null&&list.size()>0)
{
	if(list.get(0)!=null&&list.get(0).getSplmst_picstr()!=null&&list.get(0).getSplmst_picstr().length()>0)
	{
		result=list.get(0).getSplmst_picstr();
	}
}
return result;
}
//获取首页个品牌logo图链接
private static String getLogoUrl(String code,String flag)
{
if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
String result="";
ArrayList<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code, flag, 1);
if(list!=null&&list.size()>0)
{
	if(list.get(0)!=null&&list.get(0).getSplmst_url()!=null&&list.get(0).getSplmst_url().length()>0)
	{
		
		result=list.get(0).getSplmst_url()+"#left";
		
		
	}
}
return result;
}

//获取首页轮播(分南北区域)
public static String getIndexLB(String code,String flag)
{
  StringBuilder sb=new StringBuilder();
  StringBuilder sb1=new StringBuilder();
  if(Tools.isNull(code)||!Tools.isMath(code)) return "";
  ArrayList<Promotion> plist=PromotionHelper.getBrandListByCodeAndArea(code, flag, 10);
  if(plist!=null&&plist.size()>0)
  {
  	sb.append(" <div id=\"tabAuto08\">");
  	sb.append("<div class=\"tgh-box08\">");
  	sb1.append(" <ul class=\"tabAuto08\">");
  	int i=0;
  	for(Promotion p:plist)
  	{
  		if(p!=null)
  		{
  			i++;
  			String url=p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"http://www.d1.com.cn";
  		    String mainimg=p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0?p.getSplmst_picstr():"";
  		    String smallimg=p.getSplmst_picstr2()!=null&&p.getSplmst_picstr2().length()>0?p.getSplmst_picstr2():"";
  		    sb.append("<div style=\"display: block; \"><a href=\""+url+"\" target=\"_blank\"><img src=\""+mainimg+"\" width=\"740\" height=\"336\"/></a></div>");
  		    if(i==1){
  		    	sb1.append("<li><a href=\""+url+"\" target=\"_blank\"><img src=\""+smallimg+"\" width=\"119\" height=\"74\"></a>");
  		    	sb1.append(" <span  class=\"indexfloat\" ></span>");
  		    	sb1.append("</li>");
      		}
  		    else
  		    {
  		    	sb1.append("<li><a href=\""+url+"\" target=\"_blank\"><img src=\""+smallimg+"\" width=\"119\" height=\"74\"></a>");
  		    	sb1.append(" <span class=\"indexfloat\"  ></span>");
  		    	sb1.append("</li>");
  		    }
  		    if(i>=6)
  		    {
  		    	break;
  		    }
  		}
  	}
  	sb1.append("</ul>");
  	sb.append("</div><div class=\"clear\"></div>");
  	sb.append(sb1);
  	sb.append("</div>");
  }
  
  return sb.toString();
  
  
}

//获取人气爆款图片列表(分南北方向)
private static String getImglist(String code,int length,String flag)
{
  if(!Tools.isMath(code)) return "";
  StringBuilder sb=new StringBuilder();
  List<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code, flag, 4);
  if(list!=null&&list.size()>0)
  {
  	sb.append("<ul class=\"index_rqbk\">");
  	for(Promotion p:list)
  	{
  		if(p!=null)
  		{
  			sb.append("<li><a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
  			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/>");
  			sb.append("</a></li>");
  		}
  	}
  	sb.append("</ul>");
  }
  return sb.toString();
  
}
//获取一张图(分南北)
private static String getimg(String code,String flag,int length,int width,int height)
{
if(!Tools.isMath(code)) return "";
StringBuilder sb=new StringBuilder();
List<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code, flag, length);
if(list!=null&&list.size()>0)
{
	int size=0;
	
	for(Promotion p:list)
	{ 
		if(p!=null)
		{	
			
			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\""+width+"\" height=\""+height+"\"/>");
			sb.append("</a>");
		}
	}
	
}
return sb.toString();

}
//获取头部分类的文字推荐
private static String getindexHotKey(String code,int length)
{
	if(code==null||code.length()==0||!Tools.isNumber(code))
	{
		return "";
	}
	StringBuilder sb = new StringBuilder();
	  List<Promotion> listh1=PromotionHelper.getBrandListByCode(code,length);
	  if(listh1!=null&&listh1.size()>0)
	  {
		  for(int i=0;i<listh1.size();i++)
		  {
			  Promotion p=listh1.get(i);
		    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
		    		{
		    			if(i==0)
		    			{
		    				sb.append("<div style=\"height:250px;\"><span style=\"height:23px;\" ></span>");
		    				sb.append("<span style=\"font-size:13px; font-weight:bold;line-height:30px;\"><a href=\""+p.getSplmst_url()+"\" target=\"_blank\" style=\"color:#3f3939;\">"+p.getSplmst_name()+"</a></span>");
		    				sb.append("<ul>");
		    					
	                    }
		    			else
		    			{
		    			   sb.append("<li><a href=\""+p.getSplmst_url()+"\" target=\"_blank\"><font style=\"font-size:13px;\">▪&nbsp;</font>"+p.getSplmst_name()+"</a></li>");
		    			}
		    			if(i==listh1.size()-1)
		    			{
		    				 sb.append("</ul>");
		    				 sb.append("</div>");
		    			}
		    		}
	    	}
		 
	  }

return sb.toString();

}
%>