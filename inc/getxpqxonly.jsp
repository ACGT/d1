<%@ page contentType="text/html; charset=UTF-8" %><%!
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
				//}
				sb.append("<li style=\"width:150px; height:200px; overflow:hidden;\">");
				
				sb.append("<p class=\"pimg\" ><a href=\""+ProductHelper.getProductUrl(product)+"\" target=\"_blank\">");
				sb.append("<img src=\"http://images.d1.com.cn"+theimgurl+"\" width=\"160\" height=\"200\" style=\"margin-left:-5px;\" border=\"0\"></a>");
				
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

StringBuilder womenstr=new StringBuilder();
womenstr.append("<div id=\"wmain\" style=\"width:980px;+height:438px;overflow:hidden; margin:0px auto; margin-top:10px; \">");
womenstr.append("<div class=\"womenleft\">");
womenstr.append("<a href=\"http://www.d1.com.cn/html/women/\" target=\"_blank\" style=\"display:block; float:left;border-bottom:solid 3px #9C0001\"><img id=\"womentitle\" src=\"http://images.d1.com.cn/images2012/index2012/13january/women1.jpg\"  border=\"0\" /></a>");
womenstr.append(getImg("3343"));
womenstr.append("</div>");
womenstr.append("<div class=\"womenright\">");
womenstr.append("<div id=\"womenindex\">");
womenstr.append("<ul class=\"womenindex\">");
womenstr.append(getLi("3347"));
womenstr.append("</ul>");
womenstr.append("<div class=\"womenindexcontent\">");
womenstr.append(getNvContent("3344"));
womenstr.append("<div style=\"display: none;\">");
womenstr.append(getProduct("8420"));
womenstr.append("</div>");
womenstr.append("<div style=\"display: none;\">");
womenstr.append(getProduct("8416"));
womenstr.append("</div>");	
womenstr.append("<div style=\"display: none;\">");
womenstr.append(getProduct("8417"));
womenstr.append("</div>");	
womenstr.append("<div style=\"display: none;\">");
womenstr.append(getProduct("8432"));
womenstr.append("</div>");
womenstr.append("</div>");
womenstr.append("</div>");
womenstr.append("</div>");
womenstr.append("</div>");
out.print(womenstr.toString());
%>
