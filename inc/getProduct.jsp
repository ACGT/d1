<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/html/header.jsp"%>
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
//获取商品推荐
private static String getProductList(String code,int length){
	if(!Tools.isMath(code)) return "";
	List<PromotionProduct> recommendProList = PromotionProductHelper.getPromotionProductByCode(code , length);
	StringBuilder sb = new StringBuilder();
	if(recommendProList != null && !recommendProList.isEmpty()){
		sb.append("<ul>");
		int count=0;
		for(PromotionProduct pp:recommendProList){
			if(pp!=null)
			{
				Product product=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(product!=null)
				{
					count++;
					//ArrayList<GdsCutImg> gcilist=getByGdsid(product.getId());
					String imgurl1="";
					//GdsCutImg gci=new GdsCutImg();
					//if(gcilist!=null&&gcilist.size()>0)
					//{
						//gci=gcilist.get(0);
					//}
					
					//if(gci!=null)
					//{
						
					
						//if(gci!=null&&gci.getGdscutimg_160()!=null&&gci.getGdscutimg_160().length()>0)
						//{
							//imgurl1="http://images.d1.com.cn"+gci.getGdscutimg_160();
						//}
						//else
						//{
							//imgurl1=ProductHelper.getImageTo160(product);
						//}
					//}
					imgurl1=ProductHelper.getImageTo160(product);
					if(count%5==0)
					{
						sb.append("<li style=\"margin-right:0px;\">");
					}
					else
					{
						sb.append("<li>");
					}
					sb.append("<a href=\"").append("/product/").append(product.getId()).append("\" target=\"_blank\">");
					sb.append("<img src=\"").append(imgurl1).append("\" width=\"160\" height=\"160\"/></a>");
					sb.append("<a href=\"/product/").append(product.getId()).append("\" target=\"_blank\">").append(Tools.substring(Tools.clearHTML(pp.getSpgdsrcm_gdsname()),24)).append("</a><br/>");   
					sb.append("<font class=\"font1\">￥").append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font>&nbsp;&nbsp;&nbsp;&nbsp;<font class=\"font2\">￥").append(Tools.getFormatMoney(product.getGdsmst_saleprice())).append("</font>");
				    //sb.append("<a href=\"/product/").append(product.getId()).append("\" target=\"_blank\">").append(Tools.clearHTML(pp.getSpgdsrcm_gdsname())).append("</a>");   
					sb.append("</li>");
				}
			}
	  }
		
		sb.append("</ul>");
		
	}
  return sb.toString();

}
%>
document.write('<div class=\"likewomen1\">');
document.write('<a href=\"http://www.d1.com.cn/html/cosmetic/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/June/fl_85.jpg\" width=\"980\" height=\"49\"/></a>');
document.write('<div class=\"likeall1\">');
document.write('<div class=\"likelist1\" id=\"likehzp\">');
document.write('<%= getProductList("7608",15) %>');
document.write('</div></div></div>');

document.write('<div class=\"likewomen1\">');
document.write('<a href=\"http://yousoo.d1.com.cn/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/June/fl_87.jpg\" width=\"980\" height=\"49\"/></a>');
document.write('<div class=\"likeall1\">');
document.write('<div class=\"likelist1\" id=\"likewm\">');
document.write(' <%= getProductList("7610",10) %>');
document.write('</div></div></div>');

document.write('<div class=\"likewomen1\">');
document.write('<a href=\"http://www.d1.com.cn/result.jsp?productsort=023,032005,033\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/June/fl_89.jpg\" width=\"980\" height=\"49\"/></a>');
document.write(' <div class=\"likeall1\">');
document.write('<div class=\"likelist1\" id=\"likem\">');
document.write(' <%= getProductList("7840",10) %>');
document.write('</div></div></div>');

document.write(' <div class=\"likewomen1\">');
document.write('<a href=\"http://www.d1.com.cn/html/watch/\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2012/index2012/June/fl_91.jpg\" width=\"980\" height=\"49\"/></a>');
document.write('<div class=\"likeall1\">');
document.write('<div class=\"likelist1\" id=\"likesp\">');
document.write('<%= getProductList("7611",10) %>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
         
	        
			
