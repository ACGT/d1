<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*,com.d1.helper.*,com.d1.bean.*,java.util.*"%>
<%!

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
   		String title = Tools.clearHTML(recommend.getSplmst_name());
   		String ys="";
     		if(code.equals("3040"))
     		{
     			ys="style=\"color:#ae846c\"";
     		}
     		else if(code.equals("3038"))
     		{
     			ys="style=\"color:#7a92c2\"";
     	    }
     		else if(code.equals("3035"))
     		{
     			ys="style=\"color:#f6b0c3\"";
     		}
     		else 
     		{
     			ys="";
     		}
   		sb.append("<em><a href=\"").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("\" title=\"").append(Tools.clearHTML(title)).append("\" target=\"_blank\"").append(ys).append(">").append(title).append("</a></em>");
   		//sb.append("&nbsp;&nbsp;|&nbsp;&nbsp;");
   		
   		
		}
		
	}
	return sb.toString();
}
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
			
			sb.append("<a href=").append(StringUtils.encodeUrl(p.getSplmst_url())).append(" target=_blank>");
			sb.append("<img src=").append(p.getSplmst_picstr()).append(" width="+width+" height="+height+"/>");
			sb.append("</a>");
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
   		sb1.append("<div><a href=").append(StringUtils.encodeUrl(recommend.getSplmst_url())).append("").append(title).append(" target=_blank>").append("<img src=").append(recommend.getSplmst_picstr()).append(" width=980 height=500  />").append("</a></div>");
   		
		}
		sb.append("</ul>");
		sb1.append("</div>");
	}
	return sb.append(sb1.toString()).toString();


}
//获取头部分类的文字推荐
private static String getHotKey(String code)
{
	if(code==null||code.length()==0||!Tools.isNumber(code))
	{
		return "";
	}
	StringBuilder sb=new StringBuilder();
    ArrayList<Promotion> plist=PromotionHelper.getBrandListByCode(code, -1);	
    if(plist!=null&&plist.size()>0)
    {
 	   for(Promotion p:plist)
 	   {
 		   if(p!=null)
 		   {
 			  sb.append("<p><a href=\""+p.getSplmst_url()+"\" target=\"_blank\">"+p.getSplmst_name().replace("<br/>", "")+"</a>|</p>");
 			  if(p.getSplmst_name().indexOf("<br/>")>=0)
 			  {
 			    	  sb.append("<div class=\"clear\"></div>");
 			  } 			 
 			}
 	   }
 	  
    }
    return sb.toString();
    
}

%>
<%String url_file = request.getServletPath();

if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp",""); %>
var url_file='<%=url_file %>';
document.write('<div id=\"menu\"><div class=\"wrapper\">');

document.write('<div id=\"wmenu\" style=\"position:absolute;left:0px; top:30px; width:560px; overflow:hidden; \">');
document.write('<img src=\"http://images.d1.com.cn/images2012/index2012/JULY/sjt.png\" style=\"position:absolute;+position:relative;top:0px; left:65px;\"/>');
document.write('<table width=\"560\" style=\" background:#fff; margin:0px auto; border:solid 2px #ab1a1a; margin-top:12px; +margin-top:-2px;\">');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('上&nbsp;装：</td><td class=\"hotlist\"><%= getHotKey("3176") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('下&nbsp;装：</td><td class=\"hotlist\"><%= getHotKey("3177") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('裙&nbsp;装：</td><td class=\"hotlist\"><%= getHotKey("3178") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('配&nbsp;饰：</td><td class=\"hotlist\"><%= getHotKey("3179") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('化妆品：</td><td class=\"hotlist\"><%= getHotKey("3180") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"border-bottom:dashed 1px #ccc;padding-left:15px; color:#000;vertical-align:top;\"> ');
document.write('特色频道：</td><td class=\"hotlist\"><%= getHotKey("3181") %></td></tr>');
document.write('</table>');
document.write('</div>');

document.write('<div id=\"mmenu\" style=\"position:absolute;right:0px; width:560px; overflow:hidden; top:30px;\">');
document.write('<img src=\"http://images.d1.com.cn/images2012/index2012/JULY/sjt.png\" style=\"position:absolute;+position:relative;top:0px; left:135px;\"/>');
document.write('<table width=\"560\" style=\"background:#fff; margin:0px auto; border:solid 2px #ab1a1a; margin-top:12px; +margin-top:-2px;\">');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('上&nbsp;装：</td><td class=\"hotlist\"><%= getHotKey("3182") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('下&nbsp;装：</td><td class=\"hotlist\"><%= getHotKey("3183") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('配&nbsp;饰：</td><td class=\"hotlist\"><%= getHotKey("3184") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"padding-left:15px; color:#000; border-bottom:dashed 1px #ccc;vertical-align:top;\"> ');
document.write('名&nbsp;品：</td><td class=\"hotlist\"><%= getHotKey("3185") %></td></tr>');
document.write('<tr>');
document.write('<td width=\"70\" style=\"border-bottom:dashed 1px #ccc;padding-left:15px; color:#000;vertical-align:top;\"> ');
document.write('特色频道：</td><td class=\"hotlist\"><%= getHotKey("3186") %></td></tr>');
document.write('</table>');
document.write('</div>');



