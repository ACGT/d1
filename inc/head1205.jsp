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
%>
<%String url_file = request.getServletPath();

if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp",""); %>
var url_file='<%=url_file %>';

document.write('<div id=\"menu\"><div class=\"wrapper\"><div class=\"menul\"> <div id=\"white\" onmouseover=\"allover()\" onmouseout=\"allout()\" style=\"background-image: url(http://images.d1.com.cn/images2012/index2012/menul2_3.jpg);background-repeat: no-repeat;background-position: left top; height:42px; position:absolute; margin-left:15px; margin-top:-1px; width:167px; float:left; border-bottom:none; z-index:12; display:none;\"></div>');
document.write('<div id=\"smenu\" onmouseover=\"allover()\" onmouseout=\"allout()\" style=\"width:830px;position:absolute; margin-left:15px; margin-top:40px; border-bottom:none; z-index:9; border:solid 1px #8a0101; border-top:none;display:none;\">');
document.write('<table width=\"790\" style=\" margin:0px auto;\">');
document.write('<tr><td style=\"border-bottom:dashed 1px #ccc;\"><%= getimg("3068",1,180,83) %></td>');
document.write('<td width=\"440\" style=\"padding-left:15px; border-bottom:dashed 1px #ccc;+width:435px;\"> ');
document.write('<table class=\"testa\">');
document.write('<tr><td width=\"45\" style=\"vertical-align:top;\">小栗舍:</td><td><%= getCKey("3034") %></td></tr>');
document.write('<tr><td style=\"color:#f6b0c3\">系列:</td><td style=\"color:#f6b0c3\"><%= getCKey("3035") %></td></tr>');
document.write('</table></td><td style=\"padding-left:5px;border-bottom:dashed 1px #ccc;\"><%= getimg("3010",1,155,75) %></td>');
document.write('</tr><tr><td style=\"border-bottom:dashed 1px #ccc;\" ><%= getimg("3069",1,180,92) %></td>');
document.write('<td style=\"padding-left:15px; border-bottom:dashed 1px #ccc;\">');
document.write('<table class=\"testa\"><tr><td width=\"45\" style=\"vertical-align:top;\">男款:</td><td><%= getCKey("3036") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">女款:</td><td><%= getCKey("3037") %></td></tr>');
document.write('<tr><td style=\"color:#7a92c2\">系列:</td><td style=\"color:#7a92c2\"><%= getCKey("3038") %></td></tr>');
document.write('       </table> </td>');
document.write('<td style=\"padding-left:5px; border-bottom:dashed 1px #ccc;\"><%= getimg("3011",1,155,75) %></td>');
document.write('</tr> <tr><td style=\" border-bottom:dashed 1px #ccc;\"><%= getimg("3070",1,180,92) %></td>');
document.write('<td style=\"padding-left:15px; border-bottom:dashed 1px #ccc;\">');
document.write('<table class=\"testa\"><tr><td width=\"45\">诗若漫:</td><td><%= getCKey("3039") %></td></tr>');
document.write('<tr><td style=\"color:#ae846c\">系列:</td><td style=\"color:#ae846c\"><%= getCKey("3040") %></td></tr>');
document.write('</table> </td><td style=\"padding-left:5px; border-bottom:dashed 1px #ccc;\"><%= getimg("3012",1,155,75) %></td>');
document.write('</tr> <tr><td style=\" border-bottom:dashed 1px #ccc;\"><%= getimg("3071",1,180,89) %></td>');
document.write('<td style=\"padding-left:15px; border-bottom:dashed 1px #ccc;\">');
document.write('<table class=\"testa\"><tr><td width=\"45\" style=\"vertical-align:top;\">护肤:</td><td><%= getCKey("3041") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">香水:</td><td><%= getCKey("3042") %></td></tr>');                      
document.write('<tr><td style=\"vertical-align:top;\">彩妆:</td><td><%= getCKey("3043") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">男士:</td><td><%= getCKey("3044") %></td></tr>');
document.write(' </table></td><td style=\"padding-left:5px; border-bottom:dashed 1px #ccc;  padding-top:5px; padding-bottom:5px;\"><%= getimg("3013",1,155,110) %></td></tr>');
document.write('<tr><td style=\" border-bottom:dashed 1px #ccc;\"><%= getimg("3072",1,180,92) %></td>');
document.write(' <td style=\"padding-left:15px;border-bottom:dashed 1px #ccc;\">');
document.write('<table class=\"testa\"><tr><td width=\"45\" style=\"vertical-align:top;\">女装:</td><td><%= getCKey("3045") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">男装:</td><td><%= getCKey("3046") %></td></tr>');                      
document.write('<tr><td style=\"vertical-align:top;\">皮具:</td><td><%= getCKey("3047") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">饰品:</td><td><%= getCKey("3048") %></td></tr>');
document.write('<tr><td style=\"vertical-align:top;\">手表:</td><td><%= getCKey("3049") %></td></tr>');
document.write('</table>');       
document.write('</td>');
document.write('<td style=\"padding-left:5px;border-bottom:dashed 1px #ccc; padding-top:5px; padding-bottom:5px;\"><%= getimg("3014",1,155,110) %></td>');
document.write('</tr>');
document.write('</table>');
document.write('</div>');

