<%@page import="org.apache.http.HttpRequest"%>
<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,java.util.regex.*"%>
<%!
/**
 * 获取二级页面‘馆长推荐’的文字推荐位内容
 * 
 * @param code推荐位号
 * @return
 * 
 * @author wdx
 */
public static String GetGZTJKeyword(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb = new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , 6);
	if(recommendList != null && !recommendList.isEmpty()){
		sb.append("<ul>");
		for(Promotion p:recommendList)
		{
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
		if(url.indexOf("brand/brandlist.asp")>0){
		url=url.replace("brandlist.asp", "index.jsp");
			}
			sb.append("<li><span style=\" font-size:40px;_font-size:17px; float:left\">·</span><a href='")
				.append(url).append("' target=\"_blank\" title=\"")
				.append(p.getSplmst_name()).append("\" rel=\"nofollow\">")
				.append(StringUtils.getCnSubstring(p.getSplmst_name(),0,26))
				.append("</a></li>");
		}
		sb.append("</ul>");
	}
	return sb.toString();
}

/**
 * 根据推荐位号获取二级页面左侧分类分区的文字推荐
 * @param code 推荐位号
 * @return
 */
public static String GetSubLeftKeyWord(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendlist=PromotionHelper.getBrandListByCode(code, -1);
	
	ProductManager pm = (ProductManager)Tools.getManager(Product.class);
	if(recommendlist!=null&&recommendlist.size()>0)
	{
		sb.append("<ul>");
		for(Promotion p:recommendlist)
		{
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}

		    sb.append("<li><a href='").append(url)
			    .append("' title='")
			    .append(StringUtils.clearHTML(p.getSplmst_name())).append("'>")
			    .append(p.getSplmst_name())
			    .append("</a></li>");
	    }
		sb.append("</ul>");
	}
   return sb.toString();	
	
}
/**
 * 根据推荐位号获取二级页面左侧分类分区的文字推荐
 * @param code 推荐位号
 * @return
 */
public static String GetSubLeftKeyWord_other(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendlist=PromotionHelper.getBrandListByCode(code, -1);
	
	ProductManager pm = (ProductManager)Tools.getManager(Product.class);
	if(recommendlist!=null&&recommendlist.size()>0)
	{
		sb.append("<ul>");
		for(Promotion p:recommendlist)
		{
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}

		    sb.append("<li><a href='").append(url)
			    .append("' title='")
			    .append(StringUtils.clearHTML(p.getSplmst_name())).append("' rel=\"nofollow\">")
			    .append(p.getSplmst_name())
			    .append("</a></li>");
	    }
		sb.append("</ul>");
	}
   return sb.toString();	
	
}
/**
 * 获取二级页面的热卖排行
 * 
 * @param code推荐位号
 * 
 * @return
 */
public static String GetHotMale(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> pp=PromotionHelper.getBrandListByCode(code, 5);
	
	if(pp!=null&&pp.size()>0)
	{
		for(int i=0;i<pp.size();i++)
		{
			Promotion p=pp.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}

			sb.append("<a href=\"").append(url)
				.append("\" target='_blank' title='")
				.append(StringUtils.clearHTML(p.getSplmst_name()))
				.append("'>").append("<img src=\"")
				.append(p.getSplmst_picstr())
				.append("\" class=\"hotimg\" title=\"")
				.append(StringUtils.clearHTML(p.getSplmst_name()))
				.append("\" /></a>");
			
			sb.append("<img src=\"http://images.d1.com.cn/Index/images/hot").append(i+1)
			.append(".gif\"  class=\"hotnum\"/>");
		}
    }
		
	return sb.toString();
}

/**
 * 
 * 获取热门评论
 * @param code 推荐位号
 * @return
 */
public static String GetHotComment(String code)
{
    if(!Tools.isMath(code)) return "";
    StringBuilder sb=new StringBuilder();
    List<Promotion> list=PromotionHelper.getBrandListByCode(code,-1);
    if(list!=null&&list.size()>0)
    {
    	for(Promotion p:list)
    	{
    		String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
		if(url.indexOf("brand/brandlist.asp")>0){
		url=url.replace("brandlist.asp", "index.jsp");
			}
    		sb.append("<div class=\"rmplcontent\"><ul><li><a href=\"")
	    		.append(StringUtils.clearHTML(url))
	    		.append("\" target=\"_blank\"><img src=\"")
	    		.append(p.getSplmst_picstr()).append("\" title=\"")
	    		.append(StringUtils.clearHTML(p.getSplmst_name()))
	    		.append("\"/></a></li>");
    		
    		sb.append("<li style=\" width:100px;\">");
    		
    		sb.append("<span><a href=\"")
    		.append(StringUtils.clearHTML(url))
    		.append("\" target=\"_blank\" title=\"")
    		.append(StringUtils.clearHTML(p.getSplmst_name()))
    		.append("\">")
    		.append(StringUtils.getCnSubstring(StringUtils.clearHTML(p.getSplmst_name()), 0, 60))
    		.append("</a></span></li>");
    		
    		sb.append("</ul><br /></div><br /><img class=\"line\" src=\"http://images.d1.com.cn/Index/images/dashedline.jpg\" width=\"198\" height=\"11\" />");
    	}
    	
    }
	return sb.toString();
	
}

/**
 * 
 * 获取热卖精品内容
 * @param code
 * @return
 */
public static String GetRMJP(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 4);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}
			if (i == 0)
            {
				sb.append("<li style=\"margin-left:13px\"><a href=\"")
					.append(StringUtils.clearHTML(url))
					.append("\" target=\"_blank\"><img src=\"")
					.append(p.getSplmst_picstr()).append("\" title=\"")
					.append(StringUtils.clearHTML(p.getSplmst_name())).append("\" /></a></li>");
            }
            else
            {
            	sb.append("<li><a href=\"")
	            	.append(StringUtils.clearHTML(url))
	            	.append("\" target=\"_blank\"><img src=\"")
	            	.append(p.getSplmst_picstr())
	            	.append("\" title=\"")
	            	.append(StringUtils.clearHTML(p.getSplmst_name()))
	            	.append("\" /></a></li>");
            }
		}
		sb.append("</ul>");
		
	}
	return sb.toString();
	
}

/**
 * 获取滚动轮图的图片列表
 * @param code 推荐位号
 * @return
 */
public static String ScrollImg(String code)
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
 * 获取图片链接列表
 * @param code 推荐位号
 * @return
 */
public static String ScrollText(String code)
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

/**
 * 获取二级页面活动长图
 * @param code 推荐位号
 * @return
 */
public static String GetChangeImg(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	if(list!=null&&list.size()>0)
	{
		Promotion p=list.get(0);
	    sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr()))
	    .append("\" width=\"980\" height=\"60\" title=\"")
	    .append(StringUtils.clearHTML(p.getSplmst_name()))
	    .append("\" />");
				
	}
	return sb.toString();
}

/**
 * 获取资源图
 * @param code 推荐位号
 * @return
 */
public static String GetRecouseImg(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, -1);
	if(list!=null&&list.size()>0)
	{
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}
			//System.out.println(url);
			if(list.size()==1)
			{
				sb.append("<a href=\"").append(StringUtils.clearHTML(url))
				.append("\" target=\"_blank\"><img  src=\"")
				.append(StringUtils.clearHTML(p.getSplmst_picstr()))
				.append("\" width=\"769\" height=\"180\" style=\" margin-top:10px; float:left;\" title=\"")
				.append(StringUtils.clearHTML(p.getSplmst_name()))
				.append("\" /></a>");
			}	
			else
			{
				
				if(i==0)
				{
					sb.append("<a href=\"").append(StringUtils.clearHTML(url))
					.append("\" target=\"_blank\"><img  src=\"")
					.append(StringUtils.clearHTML(p.getSplmst_picstr()))
					.append("\" width=\"462\" height=\"180\" style=\" margin-top:10px; float:left;\" title=\"")
					.append(StringUtils.clearHTML(p.getSplmst_name()))
					.append("\" /></a>");
				}
				else
				{
					sb.append("<a href=\"").append(StringUtils.clearHTML(url))
					.append("\" target=\"_blank\"><img  src=\"")
					.append(StringUtils.clearHTML(p.getSplmst_picstr()))
					.append("\" width=\"297\" height=\"180\" style=\" margin-top:10px; margin-left:10px; float:left;\" title=\"")
					.append(StringUtils.clearHTML(p.getSplmst_name())).append("\" /></a>");
					
				}
			}
		}
	}
	return sb.toString();
}


/**
 * 
 * 获取二级页面的商品列表
 * @param code  推荐位号
 * @return
 */
public static String GetSubProductList(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code, 100);
	if(list!=null&&list.size()>0)
	{
		int j=0;
		for(int i=0;i<list.size();i++)
		{
			PromotionProduct p=list.get(i);
			Product product=ProductHelper.getById(p.getSpgdsrcm_gdsid());
			//if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			if(!ProductHelper.isNormal(product)) continue;
			if(j<8)
			{
				String title=StringUtils.clearHTML(p.getSpgdsrcm_gdsname());
				String imgurl= product.getGdsmst_recimg().trim();
				
				 boolean	msflag= CartHelper.getmsflag(product);
                 Float gprice=product.getGdsmst_memberprice();
	   	           if(msflag){
	   	        	  gprice=product.getGdsmst_msprice();
	
	   	           }
				if(imgurl!=null&&imgurl.startsWith("/shopimg/gdsimg")){
					imgurl = "http://images1.d1.com.cn"+imgurl;
						}else{
							imgurl = "http://images.d1.com.cn"+imgurl;
						}
				j++;
				if(j%4==0)
				{
					sb.append("<div class=\"gdmstlist_sub\" style=\" margin-right:0px;\">");
				}
				else
				{
					sb.append("<div class=\"gdmstlist_sub\" >");
				}
				
				sb.append(" <a href='http://www.d1.com.cn/product/").append(product.getId())
				.append("' target=\"_blank\" title=\"")
				.append(title).append("\"><img src='").append(imgurl)
				.append("' width=\"160\" height=\"160\" title=\"")
				.append(StringUtils.clearHTML(p.getSpgdsrcm_gdsname()))
				.append("\"/></a><br/>");
				sb.append("<span class=\"spans\"><a href='http://www.d1.com.cn/product/")
				.append(product.getId()).append("' target=\"_blank\" title=\"")
				.append(title).append("\">")
				.append(StringUtils.getCnSubstring(StringUtils.clearHTML(p.getSpgdsrcm_gdsname()), 0, 40))
				.append("</a>");
				sb.append("</span>");
				sb.append("<span><font class=\"font1\">￥")
				.append(Tools.getFormatMoney(gprice)).append("</font><font class=\"font2\">￥")
				.append(Tools.getFormatMoney(product.getGdsmst_saleprice()))
				.append("</font></span></div>");
			}
		}
	}
	return sb.toString();
	
}

/**
 * 获取品牌分类
 * @param code 推荐位号
 * @return
 */
public static String GetPP(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code,-1);
	String width = "85px";
    if(list!=null&&list.size()>0)
	{
		sb.append("<table>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}
			if (i % 2 == 0)
            {
                sb.append("<tr>");
            }

            if (i % 2 == 1)
            {
                sb.append("<td style=\" width:").append(width).append(";\"><a href='")
                .append(StringUtils.clearHTML(url))
                .append("' target=\"_blank\" title=\"")
                .append(StringUtils.clearHTML(p.getSplmst_name())).append("\" rel=\"nofollow\">")
                .append(StringUtils.clearHTML(p.getSplmst_name())).append("</a></td>");
            }
            else
            {
                sb.append("<td><a href='").append(StringUtils.clearHTML(url))
                .append("' target=\"_blank\" title='")
                .append(StringUtils.clearHTML(p.getSplmst_name()))
                .append("' rel=\"nofollow\">").append(StringUtils.clearHTML(p.getSplmst_name()))
                .append("</a></td>");
            }
           
            if (i % 2 == 1)
            {
                sb.append("</tr>");
            }
        }
		sb.append("</table>");
		
	}
	return sb.toString();
}


/**
 * 获取品牌分类
 * @param code 推荐位号
 * @return
 */
public static String GetPP_other(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code,-1);
	String width = "160px";
    if(list!=null&&list.size()>0)
	{
		sb.append("<table>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p=list.get(i);
			String url=StringUtils.encodeUrl(p.getSplmst_url()).replace("aspx", "jsp");
			if(url.indexOf("brand/brandlist.asp")>0){
			url=url.replace("brandlist.asp", "index.jsp");
				}
			
                sb.append("<tr>");
                 sb.append("<td style=\" width:").append(width).append(";\"><a href='")
                .append(StringUtils.clearHTML(url))
                .append("' target=\"_blank\" title=\"")
                .append(StringUtils.clearHTML(p.getSplmst_name())).append("\" rel=\"nofollow\">")
                .append(StringUtils.clearHTML(p.getSplmst_name())).append("</a></td>");
                sb.append("</tr>");
          
        }
		sb.append("</table>");
		
	}
	return sb.toString();
}

/**
 * 获取名表品牌
 * @param code 分类号
 * @return
 */
public static String GetWatchSearch_mbpp(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
    ArrayList<Directory> dir=DirectoryHelper.getByParentrackcode(code);
    sb.append(" <select name=\"productsort\" size=\"1\" style=\"width:120px\" id=\"mb_mbpp\" \\>");
    sb.append("<option selected value='").append(code).append("'>全部世界名表</option>");
    if(dir!=null&&dir.size()>0)
    {
    	for(Directory d:dir)
    	{
    		sb.append("<option value=\"").append(d.getId()).append("\">")
    		.append(d.getRakmst_rackname()).append("</option>");
        }
    }
    sb.append("</select>");
    return sb.toString();
}


/**
   根据分类好获取价格规格所取的值
*/

public static String GetWatchSearch_jgfw(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	ArrayList<SearchList> list=SearchListHelper.getSearchList_price(code);
	sb.append("<select name=\"productprice\" size=\"1\" style=\"width:100px\" id=\"mb_mbjg\">");
	sb.append("<option value=\"\">全部</option>");
	if(list!=null&&list.size()>0)
	{
		String pricecotent=list.get(0).getSearchlist_context();
		String priceunit[]=pricecotent.split(";");
		for(int i=0;i<priceunit.length;i++)
		{
			if(i==0)
			{
				sb.append("<option  value=\"").append(priceunit[i]).append("\">小于").append(priceunit[i].substring(1,priceunit[i].length())).append("</option>");
				
			}
			else if(i==priceunit.length-1)
			{
				sb.append("<option  value=\"").append(priceunit[i]).append("\">大于").append(priceunit[i].substring(0, priceunit[i].length()- 1)).append("</option>");
			}
			else
			{
				sb.append("<option  value=\"").append(priceunit[i]).append("\">").append(priceunit[i]).append("</option>");
			}
		}
		
	}
	sb.append("</select>");
	return sb.toString();
	
}

/*获取规格*/
public static String GetWatchSearch_productother(String stdmst_name,int flag)
{
    StringBuilder sb=new StringBuilder();
    Standard s=StandardHelper.getStandards(stdmst_name,flag);
    sb.append("<select name=\"productother").append(flag).append("\" size=\"1\" style=\"width:100px\" id=\"productother").append(flag).append("\">");
    sb.append("<option value=\"\">全部</option>");
    if(s!=null)
    {
    	String productother="";
    	String[] posub=null;
    	switch(flag)
    	{
    		case 1:
    		{
    			productother = s.getStdmst_atrdtl1();
                posub = productother.split(";");
                break;
    		}
    		case 2:
    		{
    			productother = s.getStdmst_atrdtl2();
                posub = productother.split(";");
                break;
    		}
    		case 3:
    		{
    			productother = s.getStdmst_atrdtl3();
                posub = productother.split(";");
                break;
    		}
    		case 4:
    		{
    			productother = s.getStdmst_atrdtl4();
                posub = productother.split(";");
                break;
    		}
    		case 5:
    		{
    			productother = s.getStdmst_atrdtl5();
                posub = productother.split(";");
                break;
    		}
    		case 6:
    		{
    			productother = s.getStdmst_atrdtl6();
                posub = productother.split(";");
                break;
    		}
    		case 7:
    		{
    			productother = s.getStdmst_atrdtl7();
                posub = productother.split(";");
                break;
    		}
    		case 8:
    		{
    			productother = s.getStdmst_atrdtl8();
                posub = productother.split(";");
                break;
    		}
    		default:
    		{    			
    			productother = s.getStdmst_atrdtl1();
                posub = productother.split(";");
                break;
    		}
    	}
    	for(int i=0;i<posub.length;i++)
    	{
    		sb.append("<option  value=\"").append(posub[i]).append("\">").append(posub[i]).append("</option>");
    	}
    }
    sb.append("</select>");
    return sb.toString();
   
}

/**
 * 获取新版女装页面右侧上两个图
 * @param code 推荐位号
 * @return
 */
public static String Getnew2012Img(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 2);
	if(list!=null&&list.size()>0)
	{
		sb.append("<div class=\"zyw\">");
		int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				i++;
				if(i==1)
				{
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" width=\"200\" height=\"200\"/>");
				sb.append("</a>");
				}
				else
				{
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\" style=\" margin-top:5px; display:block;\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" width=\"200\" height=\"130\"/>");
				sb.append("</a>");
				}
				
			}
		}
		sb.append("</div>");
	}
	return sb.toString();
		
}
	/**
	 * 获取新版女装页面导航图标
	 * @param code 推荐位号
	 * @return
	 */
public static String getnewdh(String code,int length)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<table style=\" background:url('http://images.d1.com.cn/images2012/nwbg.gif'); width:980px; height:125px;\"><tr>");
		int i=0;
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				i++;
				if(i==3)
				{
					sb.append("<td><a href=\"").append(StringUtils.clearHTML(p.getSplmst_url())).append("\" target='_blank'>");
					sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/></a></td>");
				}
				else
				{
					sb.append("<td width=\"325\"><a href=\"").append(StringUtils.clearHTML(p.getSplmst_url())).append("\" target='_blank'>");
					sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/></a></td>");
				}
				
			}
		}
		sb.append("</tr></table>");
		
	}
	return sb.toString();

}
	
/**
 * 获取新版女装页面图片列表上面的资源图
 * @param code 推荐位号
 * @return
 */
public static String Getnew2012ImgBig(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			sb.append(" <div class=\"gdszy\">");
			if(p!=null)
			{
				
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" width=\"980\" height=\"150\"/>");
				sb.append("</a>");
				
			}
		}
		sb.append("</div>");
	}
	return sb.toString();
}


/**
 * 获取新版女装页面图片列表上面的资源图
 * @param code 推荐位号
 * @return
 */
public static String Getnew2012ImgBig1(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			sb.append(" <div class=\"gdszy\">");
			if(p!=null)
			{
				
				sb.append("<a href=\"").append(Tools.clearHTML(p.getSplmst_url())).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(StringUtils.clearHTML(p.getSplmst_picstr())).append("\" width=\"980\" height=\"44\"/>");
				sb.append("</a>");
				
			}
		}
		sb.append("</div>");
	}
	return sb.toString();
}

/**
 * 获取新版女装页面分类列表
 * @param code 推荐位号
 * @return
 */
public static String Getnew2012clist(String code)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 11);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				sb.append("<li><a href=\"").append(p.getSplmst_url()).append("\" target=\"_blank\">");
				sb.append(Tools.clearHTML(p.getSplmst_name()));
				sb.append("</a></li>");
				
			}
		}
		sb.append("</ul>");
	}
	return sb.toString();
}


/**
 * 获取新版女装页面商品列表
 * @param code 推荐位号
 * @return
 */
public static String Getnew2012glist(String code,int length)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<PromotionProduct> list=PromotionProductHelper.getPromotionProductByCode(code, length);
	if(list!=null&&list.size()>0)
	{
		
       int i=0;
		sb.append("<div class=\"ngdlist\"><ul>");
		for(PromotionProduct pp:list)
		{
			
			if(pp!=null)
			{
				Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
				 boolean	msflag= CartHelper.getmsflag(p);
                 Float gprice=p.getGdsmst_memberprice();
	   	           if(msflag){
	   	        	  gprice=p.getGdsmst_msprice();
	   	 
	   	           }
				if(p!=null)
				{
					i++;
					if(i%4==0)
					{
						sb.append("<li style=\"margin-right:0px;\"><a href=\"").append("http://www.d1.com.cn/product/"+p.getId()).append("\" title=\""+imgalt+"\" target=\"_blank\">");
					}
					else
					{
				         sb.append("<li><a href=\"").append("http://www.d1.com.cn/product/"+p.getId()).append("\" title=\""+imgalt+"\" target=\"_blank\">");
				
					}
                sb.append("<img src=\"").append("http://images.d1.com.cn").append(p.getGdsmst_img240300()!=null&&p.getGdsmst_img240300().length()>0?p.getGdsmst_img240300():pp.getSpgdsrcm_otherimg());
				sb.append("\"");
				sb.append(" alt=\""+imgalt+"\" width=\"240\" height=\"300\"/></a>");
				sb.append("<div class=\"ntt\"><a href=\"").append("http://www.d1.com.cn/product/"+p.getId()).append("\" title=\""+imgalt+"\" target=\"_blank\">");
				sb.append(Tools.substring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),30));
				sb.append("</a>");
				sb.append("<br/>");
				sb.append("<font class=\"font1\">￥"+Tools.getFloat(gprice, 1)+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class=\"font2\">￥"+Tools.getFloat(p.getGdsmst_saleprice(), 1)+"</font>");
				sb.append("</div></li>");
				}
				
			}
		}
		sb.append("</ul></div>");
	}
	return sb.toString();
}


public static String getTopCategory(String code,int length)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, length);
	if(list!=null&&list.size()>0)
	{
		sb.append("<ul>");
		for(Promotion p:list)
		{
			
			if(p!=null)
			{
				
				sb.append("<li><a href=\"").append(p.getSplmst_url()).append("\" target=\"_blank\">");
				sb.append("<img src=\"").append(Tools.clearHTML(p.getSplmst_picstr())).append("\" />");
				sb.append("</a></li>");
				
			}
		}
		sb.append("</ul>");
	}
	return sb.toString();
}

//获取化妆品团购商品
private ArrayList<PromotionProduct> getTuanlist(String code)
	{
	    if(Tools.isNull(code)||!Tools.isNumber(code)){ return null;}
		StringBuilder sb=new StringBuilder();
		List<PromotionProduct> list=new ArrayList<PromotionProduct>();
		ArrayList<PromotionProduct> rlist=new ArrayList<PromotionProduct>();
		list=PromotionProductHelper.getPProductByCode(code);
		if(list!=null&&list.size()>0)
		{
			int i=0;
			for(PromotionProduct pp:list)
			{
				if(pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0&&pp.getSpgdsrcm_enddate()!=null&&pp.getSpgdsrcm_begindate()!=null)
				{
			        Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
			        if(product!=null)
			        {
			        	 long discountendDate = Tools.dateValue(pp.getSpgdsrcm_enddate());//应该是秒杀结束的时间。
			        	 long begindate=Tools.dateValue(pp.getSpgdsrcm_begindate());
			        	 long nowtime=System.currentTimeMillis();
			        	if(discountendDate>=nowtime&&begindate<=nowtime)
			        	{
			        		rlist.add(pp);
			        		i++;
			        	}
			        	if(i>=8)
			        	{
			        		break;
			        	}
			        }
			        
				}
			}
		}
		return rlist;
	}

/**
* 获取弹出框图片列表
* @param code 推荐位号
* @return
*/
private static String ScrollImgNew(String code,String flag)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code,flag,-1);
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
private static String ScrollTextNew(String code,String flag)
{
	if(!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCodeAndArea(code, flag, -1);
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

/**
 * 
 * 获取专题列表
 * @param id  主题id
 * @return
 */
public static ActIndex GetActindexList(String id)
{
	if(Tools.isNull(id)) return null;
	ActIndex act_list = (ActIndex)Tools.getManager(ActIndex.class).get(id);
	if(act_list == null){
		return null;
	}else if(act_list.getActindex_status() != 1){
		return null;//审核未通过或审核失败
	}else if(act_list.getActindex_delflag().intValue() == 1){
		return null;//记录已删除
	}
	return act_list;
}




/**
 * 
 * 获取专题内容
 * @param code  专题id
 * @return
 */
 public static String GetActindexContent(String id){
	  System.out.println("@@@@@@@@@@@@@@@@"+id);
	  if(!Tools.isMath(id)) return "";
	  ActIndex act_list = GetActindexList(id);
	  if(act_list == null){
	   	return "";
	  }
	  String str = act_list.getActindex_content();//专题内容
	  String is_SH = act_list.getActindex_shopcode();//商户编号
	  if(str == null){
	   	return "";
	  }
	  //String x1 = "\\$\\$\\d*\\$\\$\\d*\\$\\$";
	  String x1 = "\\$\\$(\\d|\\,)*\\$\\$\\d*\\$\\$";
	  
	  Pattern pattern = Pattern.compile(x1); 
	  Matcher matcher = pattern.matcher(str); 
	  String result = "";
	  String msg = "";
	  while(matcher.find()){ 
		   String[] strArray = matcher.group().split("\\$\\$");
		   if(is_SH.equals("00000000")){
			   //获取自己的商品列表
			   //System.out.println("zzzzzzzzzzzzzzzzzz");
			   msg = GetMy2013glist(strArray[1],Integer.parseInt(strArray[2])); 
		   }else{
			   //获取商户的商品列表
			   //msg = GetSH2013glist("01205289,01205290,01205291",Integer.parseInt(strArray[2]));
			   //System.out.println("sssssssssssssssss");
			   msg = GetSH2013glist(strArray[1],Integer.parseInt(strArray[2]));
			   //System.out.println("sssssssssssssssss"+strArray[1]);
		   }
	  	   result = str.replaceAll(x1, msg);
	  }
	  return result;
 } 
 /**
  * 获取商户的商品列表
  * @param code 商品id
  * @return
  */
 public static String GetSH2013glist(String code,int len){
	if(Tools.isNull(code)) return "";
	StringBuilder sb = new StringBuilder();
	ArrayList gdsidlist=new ArrayList();
	String[] codelist = code.split(",");
	for(int z=0;z<codelist.length;z++){
		gdsidlist.add(codelist[z]);
	}
 	if(gdsidlist!=null && gdsidlist.size()>0){
	 	int i=0;
	 	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
	 	int l=0;
	 	sb.append("<div style=\"width:980px; text-align:center;\"><div style=\"width:965px; overflow:hidden;  padding-bottom:18px; \">");
	 	if(productlist!=null){
	 		for(Product product:productlist){
	 			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
	 			String theimgurl="";
	 			String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
	 			theimgurl=product.getGdsmst_imgurl();
	 			
	 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
	 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
	 			}else{
	 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
	 			}
	 			float memberprice=product.getGdsmst_memberprice().floatValue();
	 			String strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
	 			String sprice=ProductGroupHelper.getRoundPrice(memberprice);
	 			boolean	msflag= CartHelper.getmsflag(product);
 
	   	           if(msflag){
	   	        	sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_msprice().floatValue());
	   	 
	   	           }
	 			sb.append("<div style=\"float:left;width:231px;height:300px; /*FF*/ *height:300px;/*IE7*/ _height:300px;/*IE6*/ _width:232px;"); 
	 			if (l!=0 && i%4!=0 ){
	 				sb.append("margin-left:15px;");
	 			}else{
	 				sb.append("margin-left:10px; _margin-left:5px;/*IE6*/");
	 			}
	 			sb.append("margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;\" >");
	 			sb.append("<dl style=\"text-align:left;\">");
	 			sb.append("<dt style=\"width:205px; text-align:center;padding-left:10px;\">");
	 			sb.append("<div style=\"position:relative;left;width:200px;height:200px;\">");
	 			sb.append("<a href=\"");
	 			sb.append("/product/"+product.getId()+"");
	 			
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+imgalt+"\">");
				sb.append("<img src=\""+theimgurl+"\" border=1 alt=\""+imgalt+"\" style=\"border-color:#c0c0c0\" >");
				sb.append("<jsp:include page= \"/sales/showLayer.jsp\"/> ");  	
				sb.append("</a></div>");
				sb.append("<dd style=\"width:205px; text-align:left; padding-left:10px; float:left\">");
				sb.append("<div style=\"height:42px;width:205px;\">");
				sb.append("<a href=\"");
				sb.append("/product/"+product.getId()+"");
				sb.append("\" target=_blank title=\""+imgalt+"\" style='text-decoration:none'>");
				sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">"+Tools.substring(product.getGdsmst_gdsname(),48)+"</font></a>");
				sb.append("</div><span style=\"font-size:12px;width:90px;color:#666666;display:block;float:left;\">市场价：￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"&nbsp;&nbsp;</span>");
				sb.append("<span style=\"font-family:'微软雅黑';color:#C00000;display:block;float:left; font-weight:bold; font-size:30px; line-height:30px;\">￥"+sprice+"</span>");
	 			sb.append("</dd></dl></div>");
	 			l++;
 		}
	 	}
		 sb.append("</div></div>");
	}
 	return sb.toString();
 }


 /**
  * 获取自己的商品列表
  * @param code 推荐位号
  * @return
  */
 public static String GetMy2013glist(String code,int len){
	 if(!Tools.isMath(code)) return "";
	 StringBuilder sb = new StringBuilder();
	 ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,len);
	 ArrayList gdsidlist=new ArrayList();
	 if(list!=null && list.size()>0){
	 	for(PromotionProduct pProduct:list){
	 		gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
	 	}
	 	if(gdsidlist!=null && gdsidlist.size()>0){
		 	int i=0;
		 	ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
		 	int l=0;
		 	sb.append("<div style=\"width:980px; text-align:center;\"><div style=\"width:965px; overflow:hidden;  padding-bottom:18px; \">");
		 	if(productlist!=null){
		 		for(Product product:productlist){
		 			ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
		 			Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
		 			if(pproductlist!=null && directory!=null){
		 			PromotionProduct pProduct=pproductlist.get(0);
		 			String theimgurl="";
		 			String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
		 		
		 			if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
		 				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
		 			}else{
		 				 theimgurl=product.getGdsmst_imgurl();
		 			}
		 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
		 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
		 			}else{
		 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
		 			}
		 			String spgdsrcm_layertype=pProduct.getSpgdsrcm_layertype();
		 			float memberprice=product.getGdsmst_memberprice().floatValue();
		 			String strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
		 			String sprice=ProductGroupHelper.getRoundPrice(memberprice);
		 			boolean	msflag= CartHelper.getmsflag(product);
		 			 
		   	           if(msflag){
		   	        	sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_msprice().floatValue());
		   	           }
		 			
		 			sb.append("<div style=\"float:left;width:231px;height:300px; /*FF*/ *height:300px;/*IE7*/ _height:300px;/*IE6*/ _width:232px;"); 
		 			if (l!=0 && i%4!=0 ){
		 				sb.append("margin-left:15px;");
		 			}else{
		 				sb.append("margin-left:10px; _margin-left:5px;/*IE6*/");
		 			}
		 			sb.append("margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF; overflow:hidden;\" >");
		 			sb.append("<dl style=\"text-align:left;\">");
		 			sb.append("<dt style=\"width:205px; text-align:center;padding-left:10px;\">");
		 			sb.append("<div style=\"position:relative;left;width:200px;height:200px;\">");
		 			sb.append("<a href=\"");
		 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
		 				sb.append("/product/"+product.getId()+"");
		 			}else{
		 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
					}
		 			sb.append("\" target=_blank style='text-decoration:none' title=\""+imgalt+"\">");
					sb.append("<img src=\""+theimgurl+"\" border=1  alt=\""+imgalt+"\" style=\"border-color:#c0c0c0\" >");
					sb.append("<jsp:include page= \"/sales/showLayer.jsp\"/> ");  	
					sb.append("</a></div>");
					sb.append("<dd style=\"width:205px; text-align:left; padding-left:10px; float:left\">");
					sb.append("<div style=\"height:42px;width:205px;\">");
					sb.append("<a href=\"");
					if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
						sb.append("/product/"+product.getId()+"");
					}else{
						sb.append(pProduct.getSpgdsrcm_otherlink().trim());
					}
					sb.append("\" target=_blank  title=\""+imgalt+"\" style='text-decoration:none'>");
					sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">"+Tools.substring(product.getGdsmst_gdsname(),48)+"</font></a>");
					sb.append("</div><span style=\"font-size:12px;width:90px;color:#666666;display:block;float:left;\">市场价：￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"&nbsp;&nbsp;</span>");
					sb.append("<span style=\"font-family:'微软雅黑';color:#C00000;display:block;float:left; font-weight:bold; font-size:30px; line-height:30px;\">￥"+sprice+"</span>");
		 			sb.append("</dd></dl></div>");
		 			l++;
		 		}
	 		}
		 	sb.append("</div></div>");
	 	}
	}
 }
 	return sb.toString();
 }
 //检查a链接当中是否存在外链
 public boolean check_url(String content){
	  String x1 = "(<\\s*a\\s+(?:[^\\s>]\\s*){0,})href\\s*=\\s*(\"|'|)([^\2\\s>]*)\\2((?:\\s*[^\\s>]){0,}\\s*>)";
	  //String x2 ="(<\\s*a\\s+(?:[^\\s>]\\s*){0,})href\\s*=\\s*(\"|'|)(?i)http:\\/\\/((\\w{3}\\.)*d1\\.)+(com|cn)+((?:\\s*[^\\s>]){0,}\\s*>)";
	  //http://aleeishe.d1.com.cn/
	  //String x2 ="(<\\s*a\\s+(?:[^\\s>]\\s*){0,})href\\s*=\\s*(\"|'|)(?i)http:\\/\\/((\\w{0,}\\.)*d1\\.)+(com|cn)+((?:\\s*[^\\s>]){0,}\\s*>)";
	  //http://b.qq.com/webc.htm 放宽a链接过滤
	  String x2 ="(<\\s*a\\s+(?:[^\\s>]\\s*){0,})href\\s*=\\s*(\"|'|)(?i)http:\\/\\/((\\w{0,}\\.)*(d1|b\\.qq)\\.)+(com|cn)+((?:\\s*[^\\s>]){0,}\\s*>)";
	  Pattern pattern_all = Pattern.compile(x1); 
	  Pattern pattern_pieces = Pattern.compile(x2); 
	  Matcher matcher_all = pattern_all.matcher(content);
	  Matcher matcher_pieces = pattern_pieces.matcher(content); 
	  int all = 0;
	  int pieces = 0;
	  while(matcher_all.find()){ 
		  all++;
	  	  //System.out.println("所有链接数："+all+"链接："+matcher_all.group());
	  }
	  while(matcher_pieces.find()){
		  pieces++;
	  	  //System.out.println("匹配链接数："+pieces+"链接："+matcher_pieces.group());
	  }
	  if(all > pieces){
		  return false;
	  }
	  return true;
	 
 }
 //对a链接进行替换
 public static String GetSubadContent(String str,String subad){
	 	if(Tools.isNull(str)) return "";
		String x1 = "href=\"([^\"]*)\"";//提取href内容
		Pattern pattern = Pattern.compile(x1); 
		Matcher matcher = pattern.matcher(str);
		
		List<String>list = new ArrayList<String>();
		while(matcher!=null && matcher.find()){  
			//System.out.println("--"+matcher.group(1));
			list.add(matcher.group(1));
	    }
		//System.out.println("===="+list.get(0));
		for(int i=0;i<list.size();i++){
			String msg = "http://www.d1.com.cn/buy/lianmeng.asp?id=d1_1111&subad="+subad+"&url="+list.get(i).replace("&amp;", "&").replace("&", "@");
			if(list.get(i).indexOf("buy/lianmeng") == -1){
				str = str.replace(list.get(i), msg);
				if(i+1<list.size() && list.get(i).equals(list.get(i+1))){
					break;
				}
				//System.out.println("sssssssss=="+i+"=="+str);
				//System.out.println("lllllllll=="+i+"=="+list.get(i));
			}
		}
		//System.out.println("最终=="+str);
		return str;
 }

%>