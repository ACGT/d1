<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/html/header.jsp"%><%!
private String getImg(String code)
{
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
	if(list!=null&&list.size()>0&&list.get(0)!=null)
	{
		Promotion p=list.get(0);		
		sb.append("<a href=\"").append(p.getSplmst_url()).append("\" target=\"_blank\" style=\"display:block; float:left;\">");
		sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"230\" height=\"400\"  style=\"_height:402px;\"></img></a>");
	}
	return sb.toString();
}


private String getLi(String code)
{
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 5);
	if(list!=null&&list.size()>0)
	{
		for(Promotion p:list)
		{
			sb.append("<li><a href=\""+p.getSplmst_url()+"\" target=\"_blank\">").append(p.getSplmst_name()).append("</a></li>");
		}
	}
	return sb.toString();
}

private String getNvContent(String code)
{
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 6);
	if(list!=null&&list.size()>0)
	{
		sb.append("<div style=\"display: block;\"><ul>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p1=list.get(i);
			if(i==0&&p1!=null)
			{
				sb.append("<li class=\"pimg\" style=\"width:390px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"240\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			}
			if(i==1&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"150\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			}
			if(i==2&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"390\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			    sb.append("</li>");
			}
			if(i==3&&p1!=null)
			{
				sb.append("<li class=\"pimg\"  style=\"width:200px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"200\" height=\"400\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			    sb.append("</li>");
			}
			if(i==4&&p1!=null)
			{
			    sb.append("<li class=\"pimg\"  style=\"width:160px;\"><a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			}
			if(i==5&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
				sb.append("</li>");
			}
		}
		sb.append("</ul></div>");
	}
	return sb.toString();
}

private String getNanContent()
{
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode("3346", 6);
	if(list!=null&&list.size()>0)
	{
		sb.append("<div style=\"display: block;\"><ul>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p1=list.get(i);
			if(i==0&&p1!=null)
			{
				sb.append("<li class=\"pimg\" style=\"width:160px;\"><a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\" class=\"pimg\" style=\"opacity: 1;\"/></a>");
			}
			if(i==1&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
				sb.append("</li>");
			}
			if(i==2&&p1!=null)
			{
				sb.append("<li class=\"pimg\"  style=\"width:200px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"200\" height=\"400\" border=\"0\" style=\"opacity: 1;\"/></a>");
			    sb.append("</li>");
			}
			if(i==3&&p1!=null)
			{
				sb.append("<li class=\"pimg\"  style=\"width:390px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"240\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			
			}
			if(i==4&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"150\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
				
			}
			if(i==5&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"390\" height=\"200\" border=\"0\" style=\"opacity: 1;\"/></a>");
		        sb.append("</li>");
			}
		}
		sb.append("</ul></div>");
	}
	return sb.toString();
}
private String getCosmeticContent()
{
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode("3361", 6);
	if(list!=null&&list.size()>0)
	{
		sb.append("<div style=\"display: block;\"><ul>");
		for(int i=0;i<list.size();i++)
		{
			Promotion p1=list.get(i);
			if(i==0&&p1!=null)
			{
				sb.append("<li class=\"pimg\" style=\"width:160px;\"><a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\" class=\"pimg\" style=\"opacity: 1;\"/></a>");
			}
			if(i==1&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:right;\"><img src=\""+p1.getSplmst_picstr()+"\" width=\"160\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
				sb.append("</li>");
			}
			if(i==2&&p1!=null)
			{
				sb.append("<li class=\"pimg\"  style=\"width:200px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"200\" height=\"400\" border=\"0\" style=\"opacity: 1;\"/></a>");
			    sb.append("</li>");
			}
			if(i==3&&p1!=null)
			{
				sb.append("<li class=\"pimg\"  style=\"width:390px;\">");
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"240\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
			
			}
			if(i==4&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"150\" height=\"200\" border=\"0\"  style=\"opacity: 1;\"/></a>");
				
			}
			if(i==5&&p1!=null)
			{
				sb.append("<a href=\""+p1.getSplmst_url()+"\" target=\"_blank\" style=\"display:block; float:left;\"><img src=\""+p1.getSplmst_picstr() +"\" width=\"390\" height=\"200\" border=\"0\" style=\"opacity: 1;\"/></a>");
		        sb.append("</li>");
			}
		}
		sb.append("</ul></div>");
	}
	return sb.toString();
}

private String getProduct(String code)
{
	StringBuilder sb=new StringBuilder();
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,15);
	if(list!=null && list.size()>0){
		sb.append("<ul>");
		int count=0;
		for(int i=0;i<list.size();i++)
		{
			PromotionProduct pProduct=list.get(i);
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_validflag().longValue()==1&&product.getGdsmst_ifhavegds().longValue()==0)
			{
				count++;
				String rackcode=product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0?product.getGdsmst_rackcode():"";
				if(count>10){break;}
				String theimgurl="";
				//theimgurl=pProduct.getSpgdsrcm_otherimg();
				String ddlj=pProduct.getSpgdsrcm_otherlink()!=null?pProduct.getSpgdsrcm_otherlink():"";
				boolean bl=false;
				//if(rackcode.startsWith("014"))
				//{
					//theimgurl=product.getGdsmst_recimg()==null?"":product.getGdsmst_recimg();
				//}
				//else
				//{
					theimgurl=product.getGdsmst_fzimg()==null?"":product.getGdsmst_fzimg();
					if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
						theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
						}else{
							theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
						}
				//}
				sb.append("<li style=\"width:150px; height:200px; overflow:hidden;\">");
				
				sb.append("<p class=\"pimg\" ><a href=\""+ProductHelper.getProductUrl(product)+"\" target=\"_blank\">");
				sb.append("<img src=\""+theimgurl+"\" width=\"160\" height=\"200\" style=\"margin-left:-5px;\" border=\"0\"></a>");
				
				sb.append("</p>");
				sb.append("<span style=\"position:absolute;background: #fff;color:#000; font-size:12px;line-height: 25px;overflow: hidden;bottom: 0px;width: 150px;filter: alpha(opacity=60);-moz-opacity: 0.6;opacity: 0.6;height: 25px;display: block;\">");
				sb.append("<table cellpadding=\"0\" cellspacing=\"0\" height=\"100%\">");
				sb.append("<tr><td width=\"100\" style=\"font-size:13px;\">&nbsp;&nbsp;");
				sb.append(pProduct.getSpgdsrcm_gdsname()!=null&&pProduct.getSpgdsrcm_gdsname().length()>0?Tools.substring(Tools.clearHTML(pProduct.getSpgdsrcm_gdsname()),12):Tools.substring(Tools.clearHTML(product.getGdsmst_gdsname()),12));
				
				sb.append("</td>");
				sb.append("<td width=\"50\" align=\"right\" valign=\"bottom\">");
				sb.append("<span style=\"font-family:微软雅黑;font-size:13px;line-height:25px; color:#b80024; \"><b>￥"+Tools.getFormatMoney(product.getGdsmst_memberprice().floatValue())+"</b>&nbsp;&nbsp;</span>");
				sb.append("</td>");
				sb.append("</tr></table></span>");
				sb.append("</li>");
			}
		}
	   sb.append("</ul>");
		
	}
	return sb.toString();
}
%>
<%

String flags="1";
if(request.getParameter("flag")!=null&&request.getParameter("flag").length()>0&&Tools.isNumber(request.getParameter("flag")))
{
    flags=request.getParameter("flag");	
}

%>

document.write('<div id=\"wmain\" style=\"width:980px;+height:438px;overflow:hidden; margin:0px auto; margin-top:10px; \">');
document.write('<div class=\"womenleft\">');
document.write('<a href=\"http://www.d1.com.cn/html/women/\" target=\"_blank\" style=\"display:block; float:left;border-bottom:solid 3px #9C0001\"><img id=\"womentitle\" src=\"http://images.d1.com.cn/images2012/index2012/13january/women1.jpg\"  border=\"0\" /></a>');
document.write('<%=getImg("3343") %>');
document.write('</div>');
document.write('<div class=\"womenright\">');
document.write('<div id=\"womenindex\">');
document.write('<ul class=\"womenindex\">');
document.write('<%= getLi("3347") %>');
document.write('</ul>');
document.write('<div class=\"womenindexcontent\">');
document.write('<%=getNvContent("3344") %>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8420") %>');
document.write('</div>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8416") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8417") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8432") %>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');

document.write('<div id=\"mmain\" style=\"width:980px;+height:438px;overflow:hidden;margin:0px auto; margin-top:20px; \">');
document.write('<div class=\"womenleft\">');
document.write('<a href=\"http://www.d1.com.cn/html/men/\" target=\"_blank\" style=\"display:block; float:left;border-bottom:solid 3px #9C0001\"><img id=\"mentitle\" src=\"http://images.d1.com.cn/images2012/index2012/13january/men1.jpg\"  border=\"0\" /></a>');
document.write('<%=getImg("3345") %>');
document.write('</div>');
document.write('<div class=\"womenright\">');
document.write('<div id=\"menindex\">');
document.write('<ul class=\"menindex\">');
document.write('<%= getLi("3348") %>');
document.write('</ul>');
document.write('<div class=\"menindexcontent\">');
document.write('<%=getNanContent() %>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8418") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8419") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8433") %>');
document.write('</div>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8421") %>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');


document.write('<div id=\"spmain\" style=\"width:980px;+height:438px;overflow:hidden; margin:0px auto; margin-top:20px; \">');
document.write('<div class=\"womenleft\">');
document.write('<a href=\"http://www.d1.com.cn/html/self/ps.jsp\" target=\"_blank\" style=\"display:block; float:left;border-bottom:solid 3px #9C0001\"><img id=\"sptitle\" src=\"http://images.d1.com.cn/images2012/index2012/13january/ps.jpg\"  border=\"0\" /></a>');
document.write('<%=getImg("3349") %>');
document.write('</div>');
document.write('<div class=\"womenright\">');
document.write('<div id=\"spindex\">');
document.write('<ul class=\"spindex\">');
document.write('<%= getLi("3351") %>');
document.write('</ul>');
document.write('<div class=\"spindexcontent\">');
document.write('<%=getNvContent("3350") %>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8422") %>');
document.write('</div>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8434") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8423") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8424") %>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');


document.write('<div id=\"cosmetic\" style=\"width:980px;+height:438px;overflow:hidden;margin:0px auto; margin-top:20px; \">');
document.write('<div class=\"womenleft\">');
document.write('<a href=\"http://cosmetic.d1.com.cn/\" target=\"_blank\" style=\"display:block; float:left;border-bottom:solid 3px #9C0001\"><img id=\"cosmetictitle\" src=\"http://images.d1.com.cn/images2012/index2012/13january/cosmetic.jpg\"  border=\"0\" /></a>');
document.write('<%=getImg("3360") %>');
document.write('</div>');
document.write('<div class=\"womenright\">');
document.write('<div id=\"cosmeticindex\">');
document.write('<ul class=\"cosmeticindex\">');
document.write('<%= getLi("3359") %>');
document.write('</ul>');
document.write('<div class=\"cosmeticindexcontent\">');
document.write('<%=getCosmeticContent() %>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8493") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8494") %>');
document.write('</div>');	
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8495") %>');
document.write('</div>');
document.write('<div style=\"display: none;\">');
document.write('<%=getProduct("8496") %>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');
document.write('</div>');