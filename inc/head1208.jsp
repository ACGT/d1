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
	StringBuilder sb = new StringBuilder();
	  List<Promotion> listh1=PromotionHelper.getBrandListByCode(code, 30);
	    if(listh1!=null&&listh1.size()>0)
	    {	
	    //	sb.append("<span style=\"float:left; font-size:12px; color:#efd1d1; padding-left:20px;_padding-left:15px;padding-top:5px; _padding-top:8px;\">&nbsp;</span>");
	    	for(int i=0;i<listh1.size();i++)
	    	{
	    	Promotion p=listh1.get(i);
	    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_url()!=null&&p.getSplmst_url().length()>0)
	    		{
	    			sb.append("<span style=\"float:left; font-size:13px; color:#efd1d1; padding-left:25px;_padding-left:20px;padding-top:5px; _padding-top:8px;\">");
	    			sb.append("<a style=\"color:#ccc;\" href=\""+p.getSplmst_url()+"\" >"+p.getSplmst_name()+"</a></span>");
	    			
	    		}
	    	}
	   }
    return sb.toString();
    
}

%>
<%String url_file = request.getServletPath();

if(url_file != null && url_file.length()>0) url_file = url_file.substring(1).replace(".jsp",""); %>
var url_file='<%=url_file %>';
<!-- 首页 -->
document.write('<div id=\"imenu\" class=\"newheadover\" ><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3208") %>');
document.write('</div></div>');

<!-- 女装-->
document.write('<div id=\"womanmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3210") %>');
document.write('</div></div>');

<!-- 男装 -->
document.write('<div id=\"manmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3209") %>');
document.write('</div></div>');

<!-- 裙装 -->
document.write('<div id=\"qzmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3211") %>');
document.write('</div></div>');

<!-- 裤装 -->
document.write('<div id=\"kzmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3212") %>');
document.write('</div></div>');

<!-- 化妆品 -->
document.write('<div id=\"hzpmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3213") %>');
document.write('</div></div>');

<!-- 饰品 -->
document.write('<div id=\"spmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3214") %>');
document.write('</div></div>');

<!-- 箱包 -->
document.write('<div id=\"bagmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3215") %>');
document.write('</div></div>');

<!-- 鞋 -->
document.write('<div id=\"shoesmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3216") %>');
document.write('</div></div>');

<!-- 手表 -->
document.write('<div id=\"watchmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3217") %>');
document.write('</div></div>');

<!-- 搭配 -->
document.write('<div id=\"dpmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3218") %>');
document.write('</div></div>');

<!-- 新品 -->
document.write('<div id=\"newpmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3219") %>');
document.write('</div></div>');

<!--爆款-->
document.write('<div id=\"hotmenu\" class=\"newheadover\"><div style=\"width:980px; margin:0px auto;\">');
document.write('<%= getHotKey("3220") %>');
document.write('</div></div>');















