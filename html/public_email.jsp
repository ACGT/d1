<%@page import="org.apache.http.HttpRequest"%>
<%@ page contentType="text/html; charset=GBK" import="com.d1.*,
com.d1.bean.*,
com.d1.manager.*,
com.d1.helper.*,
com.d1.dbcache.core.*,
com.d1.util.*,
com.d1.service.*,
com.d1.search.*,
org.hibernate.criterion.*,
org.hibernate.*,
java.net.URLEncoder,
java.net.URLDecoder,
net.sf.json.JSONObject,
java.util.*,
java.text.*,
java.io.*,java.util.regex.*"%>
<%!
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
	}else if(act_list.getActindex_delflag().intValue() == 1){
		return null;//记录已删除
	}
	return act_list;
}
public static ArrayList<SgGdsDtl> getsghot(int num){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_mailflag", new Long(1)));
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("sggdsdtl_mailsort"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, num);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}	
public static String getsgmail( ActIndex act_list,String subad)
{
StringBuilder sb=new StringBuilder();
String str = act_list.getActindex_content();//专题内容
SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");

String x1 = "\\$[^0-9]*\\$\\d*\\$";
	  Pattern pattern = Pattern.compile(x1); 
	  Matcher matcher = pattern.matcher(str); 
	  String result = "";
	  String msg = "";
	  while(matcher.find()){ 
		  if(matcher.group().indexOf("$sgmail$")==-1)continue;
		  String[] strArray = matcher.group().split("\\$");
		 int num=Tools.parseInt(strArray[2]);
		  if(strArray[1].equals("sgmail")){
			  ArrayList<SgGdsDtl> sgmaillist= getsghot(50);
 if (sgmaillist!=null&&sgmaillist.size()>0){
sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
String gdsid="";
int j=0;
 for(int i=0;i<sgmaillist.size();i++){
	 SgGdsDtl sg=sgmaillist.get(i);
	 if(sg==null)continue;
	 if(j>=num)break;
	 gdsid=sg.getSggdsdtl_gdsid();
     Product product=ProductHelper.getById(gdsid);
     boolean ismiaoshao=false;
     if(product==null)continue;
     Date nowday=new Date();

     if(product.getGdsmst_promotionstart()!=null&&product.getGdsmst_promotionend()!=null&&product.getGdsmst_msprice()!=null){
     	Date sdate=product.getGdsmst_promotionstart();
     	Date edate=product.getGdsmst_promotionend();	

     	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
     			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
     			&&product.getGdsmst_msprice().floatValue()>=0f){
     		ismiaoshao = true;
     	}
     	//System.out.println(Tools.getDateDiff(ft.format(sdate),ft.format(edate)));
     	//System.out.println(sdate+"======="+edate);
     }
     if(!ismiaoshao)continue;
     j+=1;
    long gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
   long gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum() .longValue();
    String gdstitle=sg.getSggdsdtl_gdsname();
    if (gdstitle!=null&&gdstitle.length()>16){
   	 gdstitle=gdstitle.substring(0,16);
    }
    String gdsmemo=sg.getSggdsdtl_memo();
    if (gdsmemo!=null&&gdsmemo.length()>42){
   	 gdsmemo=gdsmemo.substring(0,42);
    }
if(i%2==0){
sb.append("<tr><td bgcolor=\"#fef0d6\"><table width=\"750\" height=\"316\" style=\"border-bottom-width: 1px;");
sb.append("	border-bottom-style: dashed;border-bottom-color: #201d14;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
sb.append(" <tr><td width=\"10\" rowspan=\"4\"></td>");
sb.append("<td width=\"300\" rowspan=\"4\"><a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(sg.getSggdsdtl_imgurl()).append("\" width=\"300\" height=\"300\" border=\"0\" /></a></td>");
sb.append("<td height=\"8\"> </td>");
sb.append(" <td></td> </tr>");
sb.append("<tr> <td width=\"428\" height=\"150\" valign=\"top\" style=\"padding-left:10px;font-family:微软雅黑;\">");
sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><span style=\"color:#1d1e18; font-size:24px\">").append(gdstitle).append("</span></a><br />");
sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><span style=\"color:#5d5855; font-size:16px\">").append(gdsmemo).append("</span></a></td>");
sb.append("<td width=\"12\"></td>    </tr>");
sb.append("<tr>  <td height=\"80\"><table width=\"428\" style=\"font-size:12px; font-family:微软雅黑;;background-image:url(http://images.d1.com.cn/images2014/miaosha/sgmail002.jpg)  \" height=\"80\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
sb.append("  <tr><td width=\"80\" rowspan=\"2\" align=\"center\"  style=\"color:#FFF\">");
sb.append("<span style=\" font-size:32px;\"><b>限量</b></span><br />");
sb.append("<span style=\" font-size:21px;\"><b>").append(sg.getSggdsdtl_vallnum()).append("件</b></span>");
sb.append("</td> <td width=\"8\" height=\"25\">&nbsp;</td>");
sb.append("<td width=\"163\" valign=\"bottom\">商城价：").append(product.getGdsmst_memberprice()).append("</td>");
sb.append("<td width=\"176\" rowspan=\"2\">仅剩").append(gdsnum).append("件</td></tr>");
sb.append("<tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp; <span style=\" font-size:42px;color:#BE1623;\"><b>").append(product.getGdsmst_msprice()).append("</b></span></td> </tr>");
sb.append("</table></td><td></td></tr>");
sb.append("<tr><td align=\"center\"><a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2014/miaosha/sgbut.png\" width=\"160\" height=\"37\" border=\"0\" /></a></td>");
sb.append("<td></td>   </tr>  </table></td></tr>");
}else{
sb.append("<tr>  <td bgcolor=\"#e0e4ff\"><table width=\"750\" height=\"316\" style=\"border-bottom-width: 1px;border-bottom-style: dashed;border-bottom-color: #201d14;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
sb.append("<tr><td width=\"10\" rowspan=\"4\"></td><td height=\"8\"></td><td></td><td></td></tr>");
sb.append("<tr><td width=\"428\" height=\"150\" valign=\"top\" style=\"padding-left:10px;font-family:微软雅黑;\">");
sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><span style=\"color:#1d1e18; font-size:24px\">").append(gdstitle).append("</span></a><br />");
sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><span style=\"color:#5d5855; font-size:16px\">").append(gdsmemo).append("</span></a></td>");
sb.append("<td width=\"300\" rowspan=\"3\"><a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images1.d1.com.cn").append(sg.getSggdsdtl_imgurl()).append("\" width=\"300\" height=\"300\" border=\"0\" /></a></td>");
sb.append("<td width=\"12\"></td></tr>");
sb.append("<tr><td height=\"80\"><table width=\"428\" style=\"font-size:12px; font-family:微软雅黑;background-image:url(http://images.d1.com.cn/images2014/miaosha/sgmail002.jpg) \" height=\"80\"  border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
sb.append(" <tr><td width=\"80\" rowspan=\"2\" align=\"center\"  style=\"color:#FFF\"><span style=\" font-size:32px;\"><b>限量</b></span><br />");
sb.append("<span style=\" font-size:21px;\"><b>").append(sg.getSggdsdtl_vallnum()).append("件</b></span></td>");
sb.append("<td width=\"8\" height=\"25\">&nbsp;</td>");
sb.append("<td width=\"163\" valign=\"bottom\">商城价：").append(product.getGdsmst_memberprice()).append("</td>");
sb.append("   <td width=\"176\" rowspan=\"2\">仅剩").append(gdsnum).append("件</td></tr>");
sb.append("  <tr><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp; <span style=\" font-size:42px;color:#BE1623;\"><b>").append(product.getGdsmst_msprice()).append("</b></span></td>");
sb.append("</tr></table></td><td></td></tr>");
sb.append("<tr><td align=\"center\"><a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn/product/").append(gdsid).append("\" target=\"_blank\"><img src=\"http://images.d1.com.cn/images2014/miaosha/sgbut.png\" width=\"160\" height=\"37\" border=\"0\" /></td><td></td></tr>  </table></td></tr>");
} 
}
sb.append("<tr>  <td>&nbsp;</td></tr></table>");
		  }
		  }
		  result = str.replaceAll(x1, sb.toString());

	  }
return result;
}


/**
 * 
 * 获取专题内容
 * @param code  专题id
 * @return
 */
 public static String GetActindexContent(String id,String subad){
	  if(!Tools.isMath(id)) return "";
	  ActIndex act_list = GetActindexList(id);
	  if(act_list == null){
	   	return "";
	  }
	  String str = act_list.getActindex_content();//专题内容
	  String is_SH = act_list.getActindex_shopcode();//商户编号
	  Long dectype = act_list.getActindex_dectype();//推荐位模板类型
	  if(str == null){
	   	return "";
	  }
	  str = GetSubadContent(str,subad);
	 
	  if(str.indexOf("$sgmail$")>=0){
		  str=  getsgmail(act_list,subad);
	  }
	  String x1 = "\\$\\$(\\d|\\,)*\\$\\$\\d*\\$\\$";
	  Pattern pattern = Pattern.compile(x1); 
	  Matcher matcher = pattern.matcher(str); 
	  
	  String msg = "";
	  while(matcher.find()){ 
		   String[] strArray = matcher.group().split("\\$\\$");
		   if(is_SH.equals("00000000") || is_SH.equals("13100902")){
			   //获取自己的商品列表
			   //System.out.println("zzzzzzzzzzzzzzzzzz=="+strArray[1]);
			   msg = GetMy2013glist(strArray[1],Integer.parseInt(strArray[2]),subad,act_list); 
		   }else{
			   //获取商户的商品列表
			   //msg = GetSH2013glist("01205289,01205290,01205291",Integer.parseInt(strArray[2]));
			   //System.out.println("sssssssssssssssss");
			   msg = GetSH2013glist(strArray[1],Integer.parseInt(strArray[2]),subad);
			   
		   }
	  	   str = str.replace(matcher.group(), msg);
	  }
	  String result = str;
	  return result;
	  
 } 

 /**
  * 获取自己的商品列表
  * @param code 推荐位号
  * @return
  */
 public static String GetMy2013glist(String code,int len,String subad,ActIndex act_list){
	 //System.out.println("code=="+code+"===len:"+len+"===subad:"+subad);
	 if(Tools.isNull(code)) return "";
	 Long dectype = act_list.getActindex_dectype();
	 String model_title = act_list.getActindex_areatitle();
	 StringBuilder sb = new StringBuilder();
	 ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,len);
	 if(list!=null && list.size()>0){
		int i=0;
		int l=0;
		sb.append("<div style=\"width:750px; text-align:center; background-color:#"+act_list.getActindex_areatbgcolor()+";\">"); 
		sb.append("<div style=\"width:750px; overflow:hidden;  padding-bottom:18px; "); 
		if(dectype == 1){
			sb.append("margin-left: 0px;\">");
		}else if(dectype == 2 || dectype == 3){
			sb.append("margin-left: 0px;\">");
		}else{
			sb.append("margin-left: 13px;\">");
		}
		
		if(!Tools.isNull(model_title)){
			sb.append("<div style=\"height: 60px; \">");
			sb.append("<div style=\"color: #"+act_list.getActindex_areatcolor()+";text-align:left;padding-top: 20px; font-family: '微软雅黑'; font-size: 18pt;");
			if(dectype == 2 || dectype == 3){
				sb.append("padding-left: 20px;");
			}else{
				sb.append("padding-left: 9px;");
			}
			sb.append("\">");
			sb.append(model_title);
  	    	sb.append("</div></div>");
  	    }
		
		
	 	for(PromotionProduct pProduct:list){
		 	Product product=ProductHelper.getById(pProduct.getSpgdsrcm_gdsid());
 			String theimgurl="";
 			String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
 			if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
 				 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();//目前没用
 			}else{
 				 theimgurl=product.getGdsmst_imgurl();
 			}
 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
 			}else{
 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
 			}
 			float memberprice=product.getGdsmst_memberprice().floatValue();//会员价
 			String strmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
 			String sprice=ProductGroupHelper.getRoundPrice(memberprice);
 			float msprice=0;
 			if(product.getGdsmst_msprice()!=null){
 				msprice = product.getGdsmst_msprice().floatValue();//秒杀价
 			}
 			String ms_price="";
 			if(msprice >= 0){
 				ms_price=ProductGroupHelper.getRoundPrice(msprice);
 			}
 			if(dectype == 0){//简单模板
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
	 			sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+pProduct.getSpgdsrcm_gdsname()+"\">");
				sb.append("<img src=\""+theimgurl+"\" border=0 style=\"border-color:#c0c0c0\" >");
				sb.append("<jsp:include page= \"/sales/showLayer.jsp\"/> ");  	
				sb.append("</a></div>");
				sb.append("<div style=\"width:205px; text-align:left; padding-left:0px; float:left\">");
				sb.append("<div style=\"height:42px;width:205px;\">");
				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
				if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
					sb.append("/product/"+product.getId()+"");
				}else{
					sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
				sb.append("\" target=_blank style='text-decoration:none'>");
				sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">"+Tools.substring(product.getGdsmst_gdsname(),48)+"</font></a>");
				sb.append("</div><span style=\"font-size:12px;width:90px;color:#666666;display:block;float:left;\">");
				if(CartHelper.getmsflag(product)){//如果有秒杀价 把市场价换成会员价  把会员价换成秒杀价
					sb.append("会员价：￥"+sprice+"");
				}else{
					sb.append("市场价：￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"");
				}
				sb.append("&nbsp;&nbsp;</span>");
				sb.append("<span style=\"font-family:'微软雅黑';color:#C00000;display:block;float:left; font-weight:bold; font-size:30px; line-height:30px;\">￥");
				if(CartHelper.getmsflag(product)){
					sb.append(ms_price);
				}else{
					sb.append(sprice);
				}
				sb.append("</span>");
	 			sb.append("</div></dl></div>");
 			}else if(dectype == 1){//160*160*4/行通用模板
 				if(product.getGdsmst_recimg().trim().length()!=0){
 					theimgurl=product.getGdsmst_recimg().trim();
	 			}
	 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
	 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
	 			}else{
	 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
	 			}
 				sb.append("<div style=\"float:left;width:183px;height:275px; margin-left:4px;margin-top:10px;display: inline;background-color:#FFFFFF; overflow:hidden;\" >"); 
 				sb.append("<table width='180' height='275' border='0' cellpadding='0' cellspacing='0' style=\"background-color:#FFFFFF;\">");
 				sb.append("<tr><td>&nbsp;</td><td height='10' colspan='2'>&nbsp;</td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td width='20'>&nbsp;</td><td width='160' height='160' colspan='2'>");
				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+product.getGdsmst_gdsname()+"\">");
	 			sb.append("<img src=\""+theimgurl+"\" border=0 style=\"border-color:#c0c0c0\" title=\""+product.getGdsmst_gdsname()+"\">");
	 			sb.append("</a>");
 				sb.append("</td><td width='20'>&nbsp;</td></tr>");
 				String g_name = product.getGdsmst_gdsname();
 				sb.append("<tr><td>&nbsp;</td><td height='25' colspan='2'>");
				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+g_name+"\">");		
 				sb.append("<span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">"+stringformat(g_name, 22)+"</span>");
 				sb.append("</a></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td height='25' colspan='2'>");
 				String intrduce="";
			    if(pProduct.getSpgdsrcm_briefintrduce() != null){
			    	intrduce = Tools.substring(Tools.clearHTML(pProduct.getSpgdsrcm_briefintrduce()),60);
			    }
			    sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+intrduce+"\">");	
 				sb.append("<span style=\"font-family:'微软雅黑'; font-size:12px;color:#ff0000;\">"+stringformat(intrduce,22)+"</span></a>");
 				sb.append("</td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td width='100' height='25'><span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">");
 				if(CartHelper.getmsflag(product)){//如果有秒杀价 把市场价换成会员价  把会员价换成秒杀价
 					sb.append("<span style=\"color:red\">秒杀价：</span>");
				}else{
					sb.append("会员价：");
				}
 				sb.append("</span><span style=\"font-family:'微软雅黑'; font-size:17px; color:#ff0000;\">￥");
				if(CartHelper.getmsflag(product)){//如果有秒杀价 把市场价换成会员价  把会员价换成秒杀价
					sb.append(ms_price);
				}else{
					sb.append(sprice);
				}
 				sb.append("</span>");	
 				sb.append("</td><td width='60' rowspan='2'>");
 				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+product.getGdsmst_gdsname()+"\">");
	 			sb.append("<img src='http://images.d1.com.cn/zt2014/0110/qianggou750.png' border=0>");
	 			sb.append("</a></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td height='20'><span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">");
 				if(CartHelper.getmsflag(product)){
					sb.append("会员价：<s>￥"+sprice+"</s>");
				}else{
					sb.append("市场价：<s>￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"</s>");
				}
 				sb.append("</span></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td height='10' colspan='4'>&nbsp;</td></tr></table>");
 				sb.append("</div>");
 			}else if(dectype == 2 || dectype == 3){//200*200*3/行通用模板     200*250*3/行通用模板
				if(dectype == 2){
	 				if(!Tools.isNull(product.getGdsmst_imgurl())){
	 					theimgurl=product.getGdsmst_imgurl().trim();
		 			}
				}else{
					if(!Tools.isNull(product.getGdsmst_img200250())){
	 					theimgurl=product.getGdsmst_img200250().trim();
		 			}
				}	
	 			if(theimgurl!=null&&theimgurl.startsWith("/shopimg/gdsimg")){
	 				theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
	 			}else{
	 				theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
	 			}
 				sb.append("<div style=\"float:left; margin-top:14px;background-color:#FFFFFF; overflow:hidden; margin-left:14px;display: inline;");
 				if(dectype == 2){
 					sb.append("width='230px' height='315px'");
 				}else{
 					sb.append("width='230px' height='365px'");
 				}
 				sb.append("\" >"); 
 				sb.append("<table border='0' cellpadding='0' cellspacing='0' style=\"background-color:#FFFFFF;\"");
 				if(dectype == 2){
 					sb.append("width='230' height='315'");
 				}else{
 					sb.append("width='230' height='365'");
 				}
 				sb.append(">");
 				sb.append("<tr><td>&nbsp;</td><td height='10' colspan='2'>&nbsp;</td><td>&nbsp;</td></tr>");
 				if(dectype == 2){
 					sb.append("<tr><td width='15'>&nbsp;</td><td height='200' colspan='2'>");
 				}else{
 					sb.append("<tr><td width='15'>&nbsp;</td><td height='250' colspan='2'>");
 				}
				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+product.getGdsmst_gdsname()+"\">");
	 			sb.append("<img src=\""+theimgurl+"\" border=0  style=\"border-color:#c0c0c0\" title=\""+product.getGdsmst_gdsname()+"\"");
	 			if(dectype == 2){
	 				sb.append("width='200' height='200'");
	 			}else{
	 				sb.append("width='200' height='250'");
	 			}
	 			sb.append(">");
	 			sb.append("</a>");
	 			if(dectype == 2){
	 				sb.append("</td><td width='15'>&nbsp;</td></tr>");
 				}else{
 					sb.append("</td><td width='15'>&nbsp;</td></tr>");
 				}
 				sb.append("</td><td width='20'>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td height='25' colspan='2'>");
 				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+product.getGdsmst_gdsname()+"\">");
 				sb.append("<span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">"+stringformat(product.getGdsmst_gdsname(),30)+"</span>");
 				sb.append("</a></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td height='25' colspan='2'>");
 				String intrduce="";
			    if(pProduct.getSpgdsrcm_briefintrduce() != null){
			    	intrduce = Tools.substring(Tools.clearHTML(pProduct.getSpgdsrcm_briefintrduce()),60);
			    }
			    sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+intrduce+"\">");
 				sb.append("<span style=\"font-family:'微软雅黑'; font-size:12px;color:#ff0000;\">"+stringformat(intrduce,28)+"</span></a>");
 				sb.append("</td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td width='100' height='25'><span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">");
 				if(CartHelper.getmsflag(product)){//如果有秒杀价 把市场价换成会员价  把会员价换成秒杀价
 					sb.append("<span style=\"color:red\">秒杀价：</span>");
				}else{
					sb.append("会员价：");
				}
 				sb.append("</span><span style=\"font-family:'微软雅黑'; font-size:17px; color:#ff0000;\">￥");
				if(CartHelper.getmsflag(product)){//如果有秒杀价 把市场价换成会员价  把会员价换成秒杀价
					sb.append(ms_price);
				}else{
					sb.append(sprice);
				}
 				sb.append("</span>");	
 				sb.append("</td><td width='60' rowspan='2'>");
 				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+subad+"&url=http://www.d1.com.cn");
	 			if(pProduct.getSpgdsrcm_otherlink().trim().length()==0){
	 				sb.append("/product/"+product.getId()+"");
	 			}else{
	 				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+product.getGdsmst_gdsname()+"\">");
	 			sb.append("<img src='http://images.d1.com.cn/zt2014/0110/qianggou750.png' border=0>");
	 			sb.append("</a></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td>&nbsp;</td><td height='20'><span style=\"font-family:'微软雅黑'; font-size:12px; color:#505050;\">");
 				if(CartHelper.getmsflag(product)){
					sb.append("会员价：<s>￥"+sprice+"</s>");
				}else{
					sb.append("市场价：<s>￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"</s>");
				}
 				sb.append("</span></td><td>&nbsp;</td></tr>");
 				sb.append("<tr><td height='10' colspan='4'>&nbsp;</td></tr></table>");
 				sb.append("</div>");
 			}
 			l++;
	 }
	sb.append("</div></div>");
 }
 	return sb.toString();
 }

 /*
　* 计算字符串的字节长度(字母数字计1，汉字及标点计2)
　*
　*/
public static int byteLength(String string){
	int count = 0;
	for(int i=0;i<string.length();i++){
	if(Integer.toHexString(string.charAt(i)).length()==4){
		count += 2;
	}else{
		count++;
	}
	}
	return count;
}
/*
* 按指定长度，省略字符串部分字符
* @para String 字符串
* @para length 保留字符串长度
* @return 省略后的字符串
*/
public static String stringformat(String string,int length){
StringBuffer sb = new StringBuffer();
if(byteLength(string)>length){
	int count = 0;
	for(int i=0;i<string.length();i++){
		char temp = string.charAt(i);
		if(Integer.toHexString(temp).length()==4){
			count += 2;
		}else{
			count++;
		}
		if(count<length-3){
			sb.append(temp);
		}
		if(count==length-3){
			sb.append(temp);
			break;
		}
		if(count>length-3){
			sb.append(" ");
			break;
		}
	}
	sb.append("...");
}else{
	sb.append(string);
}
	return sb.toString();
}
 //格式化字符串长度，超出部分显示省略号,区分汉字跟字母。汉字2个字节，字母数字一个字节
/* public static String stringformat(String str,int n){
	   String temp="";
       if(str.length()<=n){//如果长度比需要的长度n小,返回原字符串
       		return str;
       }else{
           int t = 0;
           char[] q = str.toCharArray();
           for(int i=0;i<q.length&&t<n;i++){
              if((int)q[i]>=0x4E00 && (int)q[i]<=0x9FA5){//是否汉字
                 temp+=q[i];
                 t+=2;
              }else{
                 temp+=q[i];
                 t++;
              }
           }
           return (temp+"...");
       }
 }
 */
 /**
  * 获取自己的商品列表    没有推荐位的
  * @param code 推荐位号
  * @return
  */
 public static String GetMy2013glistnocode(String id){
	 if(Tools.isNull(id)) return "";
	 StringBuilder sb = new StringBuilder();
	 ActIndex a_index = GetActindexList(id);
	 String str  = a_index.getActindex_content();
	 String subad = a_index.getActindex_subad();
	 if(str != null){
		 str = GetSubadContent(str,subad);
	 }
	 if(a_index!=null && a_index.getActindex_content() != null){
		 	sb.append("<div style=\"width:750px; text-align:center;\"><div style=\"width:750px; overflow:hidden;\">");
		 	sb.append(str);
		 	sb.append("</div></div>");
    }
 	return sb.toString();
 }

 /**
  * 获取商户的商品列表
  * @param code 推荐位号
  * @return
  */
 public static String GetSH2013glist(String code,int len,String subad){
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
	 	//width:980普通  750邮件
	 	sb.append("<div style=\"width:750px; text-align:center;\"><div style=\"width:750px; overflow:hidden;  padding-bottom:18px; margin-left: 13px;\">");
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
	 			sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+ subad +"&url=http://www.d1.com.cn");
	 			sb.append("/product/"+product.getId()+"");
	 			
	 			sb.append("\" target=_blank style='text-decoration:none' title=\""+imgalt+"\">");
				sb.append("<img src=\""+theimgurl+"\" border=1 style=\"border-color:#c0c0c0\" >");
				sb.append("<jsp:include page= \"/sales/showLayer.jsp\"/> ");  	
				sb.append("</a></div>");
				sb.append("<div style=\"width:205px; text-align:left; padding-left:0px; float:left\">");
				sb.append("<div style=\"height:42px;width:205px;\">");
				sb.append("<a href=\"http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+ subad +"&url=http://www.d1.com.cn");
				sb.append("/product/"+product.getId()+"");
				sb.append("\" target=_blank style='text-decoration:none'>");
				sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">"+Tools.substring(product.getGdsmst_gdsname(),48)+"</font></a>");
				sb.append("</div><span style=\"font-size:12px;width:90px;color:#666666;display:block;float:left;\">市场价：￥"+ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice())+"&nbsp;&nbsp;</span>");
				sb.append("<span style=\"font-family:'微软雅黑';color:#C00000;display:block;float:left; font-weight:bold; font-size:30px; line-height:30px;\">￥"+sprice+"</span>");
	 			sb.append("</div></dl></div>");
	 			l++;
 		}
	 	}
		 sb.append("</div></div>");
	}
 	return sb.toString();
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
		String hrefstr="|";
		for(int i=0;i<list.size();i++){
			String msg = "http://www.d1.com.cn/buy/lianmeng.asp?id=d1_1111&subad="+subad+"&url="+list.get(i).replace("&amp;", "&").replace("&", "@");
			if(hrefstr.indexOf("|"+list.get(i)+"|")==-1){
				hrefstr+=list.get(i)+"|";
				str = str.replace("\""+list.get(i)+"\"", msg);
			}
			
			//System.out.println("sssssssss=="+i+"=="+str);
			//System.out.println("lllllllll=="+i+"=="+list.get(i));
			
		}
		//System.out.println("最终=="+str);
		return str;
}




%>