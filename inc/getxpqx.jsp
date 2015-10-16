<%@ page contentType="text/html; charset=UTF-8" import="com.d1.util.*"%><%@include file="/html/header.jsp"%><%!
String getxpqx1(String code){
	StringBuilder sb = new StringBuilder();
	List<Promotion> list=PromotionHelper.getBrandListByCode(code, 4);
	if(list!=null && list.size()>0){
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\" width=\"980\">");
		for(int i=0;i<list.size();i++){
			Promotion p=list.get(i);
			if((i+1)%4==1){
				sb.append("<tr><td colspan=\"9\" height=\"20px\">&nbsp;</td></tr>");
			} if(i%4==0){
				 sb.append("<tr><td width=\"45\">&nbsp;</td>");
				}
			 sb.append("<td valign=\"top\" style=\"border:solid #bbb 1px;height:250px;background:#fff;\">");
			 sb.append("<a href=\"").append(p.getSplmst_url()).append("\" target=\"_blank\" >");
			 sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" width=\"200\" height=\"250\"  ></img></a>");
			 sb.append("</td>");
			 if((i+1)%4!=0){
					sb.append("<td width=\"30\">&nbsp;</td>");
				}if((i+1)%4==0){ 
					 sb.append("<td width=\"45\">&nbsp;</td></tr><tr><td height=\"30\" colspan=\"9\" >&nbsp;</td></tr>");
				} 
		}
		 sb.append("</table>");
		
	}
	return sb.toString();
}


String getxpqx(String code){
	StringBuilder sb = new StringBuilder();
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code,4);
	if(list!=null && list.size()>0){
		sb.append("<table cellpadding=\"0\" cellspacing=\"0\" width=\"980\">");
		for(int i=0;i<list.size();i++){
			PromotionProduct pProduct=list.get(i);
			Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
			if(product!=null){
				String theimgurl="";
				theimgurl=pProduct.getSpgdsrcm_otherimg();
				boolean bl=false;
				if(Tools.isNull(theimgurl)){
					 if(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030"))){
						 theimgurl=product.getGdsmst_img200250(); 
						 if(Tools.isNull(theimgurl)){
							 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
								 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
							 }else{
								 theimgurl="http://images.d1.com.cn"+product.getGdsmst_imgurl();
							 } 
						 }else{
							 theimgurl="http://images.d1.com.cn"+ theimgurl;
						 }
					 }
					 else{
						 theimgurl=ProductHelper.getImageTo200(product);
						}
				}else{
					bl=true;
				}
				
				if((i+1)%4==1){
					sb.append("<tr><td colspan=\"9\" height=\"20px\">&nbsp;</td></tr>");
				}
				 if(i%4==0){
					 sb.append("<tr><td width=\"45\">&nbsp;</td>");
					}
				 sb.append("<td valign=\"top\" style=\"border:solid #bbb 1px;height:250px;background:#fff;\">");
					if(bl||(product.getGdsmst_rackcode().length()>=6&&(product.getGdsmst_rackcode().substring(0,3).equals("020")||product.getGdsmst_rackcode().substring(0,3).equals("030")))){
						 sb.append("<p style=\"z-index:999;\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" >");
						 sb.append("<img src=\"").append(theimgurl).append("\" width=\"200\" height=\"250\" ></img></a></p>");
					}else{
						 sb.append("<p style=\"z-index:999; padding-top:25px; padding-bottom:25px;\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" >");
						 sb.append("<img src=\"").append(theimgurl).append("\" width=\"200\" height=\"200\"  ></img></a></p>");
					}
				
				 sb.append("<span class=\"retime\"  id=\"black_").append(product.getId()).append("\" >"); 
				 sb.append("<table cellpadding=\"0\" cellspacing=\"0\">");
				 sb.append("<tr><td width=\"120px\"  style=\"padding-left:2px;\"><a href=\"").append(ProductHelper.getProductUrl(product)).append("\" target=\"_blank\" style=\"font-size:13px; color:#fff; \">").append(StringUtils.getCnSubstring(pProduct.getSpgdsrcm_gdsname(),0,28)).append("</a></td>");
				 sb.append("<td width=\"70\"  align=\"right\" valign=\"bottom\"><span style=\"font-family:微软雅黑;font-size:16px;color:#fff;\">￥</span><span style=\"font-family:微软雅黑;font-size:36px;line-height:36px; color:#fff; padding-top:5px;\">").append(Tools.getFormatMoney(product.getGdsmst_memberprice()) ).append("</span></td>");
				 sb.append("	</tr>");
				 sb.append("	</table>");
				 sb.append("	</span>");
				 sb.append("	</td>");
				if((i+1)%4!=0){
				sb.append("<td width=\"30\">&nbsp;</td>");
			}if((i+1)%4==0){ 
				 sb.append("<td width=\"45\">&nbsp;</td></tr><tr><td height=\"30\" colspan=\"9\" >&nbsp;</td></tr>");
			} 
			}
		}
		 sb.append("</table>");
		
	}
	return sb.toString();
}
%>
document.write('<div class=\"tabxpqx\">');
document.write('<div id=\"tabxpqx1\">');
document.write('<%=getxpqx1("3221") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx2\">');
document.write('<%=getxpqx("7981") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx3\">');
document.write('<%=getxpqx("7982") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx4\">');
document.write('<%=getxpqx("7983") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx5\">');
document.write('<%=getxpqx("7984") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx6\">');
document.write('<%=getxpqx("7985") %>');
document.write('</div>');

document.write('<div id=\"tabxpqx7\">');
document.write('<%=getxpqx("7986") %>');
document.write('</div>');



document.write('</div>');
