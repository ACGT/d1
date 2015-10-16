<%@ page contentType="text/html; charset=GBK"%><%@include file="/html/headerg.jsp" %><%!
public static ArrayList<Product> getPProductByCode(String code,String rackcode,int num){
	ArrayList<Product> rlist = new ArrayList<Product>();

	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("spgdsrcm_code",new Long(code)));
	//clist.add(Restrictions.le("spgdsrcm_seq",new Long(100)));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("spgdsrcm_seq"));
	List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, num+10);
	if(list==null||list.size()==0)return null;	
	int total = 0 ;
	if(list!=null){
		for(BaseEntity be:list){
			PromotionProduct pp = (PromotionProduct)be;
			Product product = (Product)Tools.getManager(Product.class).get(pp.getSpgdsrcm_gdsid());
			if(product == null ) continue;
	
			if(!Tools.isNull(rackcode)&&!rackcode.equals("null")){
				
			if(rackcode.indexOf(",")>=0){				
				if(!Tools.isNull(product.getGdsmst_rackcode())&&rackcode.indexOf(product.getGdsmst_rackcode().substring(0,3))==-1)continue;
			}else{
				//System.out.println(rackcode+"-------------------------");
			if(!Tools.isNull(product.getGdsmst_rackcode())
					&&!product.getGdsmst_rackcode().startsWith(rackcode))continue;
			}
			}
	
			rlist.add(product);
			total++;
			if(total==num)break;
		}
	}
		
	return rlist ;
}
%>
<html>
<head>
<title>春装特卖 第三季震撼来袭 1折起 -D1优尚</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<!-- 头部开始 -->
<%@page import="com.d1.util.Tools"%>
<%@page import="java.net.URLDecoder"%><%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=GBK"%>


<%
String title=request.getParameter("title");
if(!Tools.isNull(title)){
	title=URLDecoder.decode(title,"utf-8");
}

String strad2="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"1&url=";
String strad="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"&url=";
String str="http://www.d1.com.cn/intf/lianmeng.jsp?id=d1_1111&subad="+request.getParameter("subad")+"&url="+ request.getParameter("url");
%>
<style>
a{ TEXT-DECORATION: none;}
 A:link    {TEXT-DECORATION: none;}
A:hover   { TEXT-DECORATION: none;}
</style>

</head>

<body>
<center>
<table width="750"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px;" align="center">
  <tr>
    <td width="158" height="70"  rowspan="2"><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><img src="http://images.d1.com.cn/images2013/mail/mailh_01.jpg" width="158" height="55" border="0"/></a></td>
    <td width="271" height="32">&nbsp;</td>
    <td width="84"><img src="<%=strad2 %>http://images.d1.com.cn/images2013/mail/mailh_02.jpg" />&nbsp;&nbsp;<a href="<%=strad %>http://www.d1.com.cn/user/" target="_blank"><span style="color:#000;font-size:9pt;">我的帐户</span></a></td>
    <td width="79"><img src="http://images.d1.com.cn/images2013/mail/mailh_02.jpg"  />&nbsp;&nbsp;<a href="<%=strad %>http://www.d1.com.cn/jifen/index.jsp" target="_blank"><span style="color:#000;font-size:9pt;">积分换购</span></a></td>
    <td width="73"><img src="http://images.d1.com.cn/images2013/mail/mailh_02.jpg" />&nbsp;&nbsp;<a href="<%=strad %>http://help.d1.com.cn/" target="_blank"><span style="color:#000;font-size:9pt;">帮助中心</span></a></td>
    <td width="85"><img src="http://images.d1.com.cn/images2013/index/online.png"  />&nbsp;&nbsp;<a href="http://b.qq.com/webc.htm?new=0&sid=4006808666&eid=218808P8z8p8y8y8q8x8z&o=www.d1.com.cn&q=7&ref=" target="_blank"><span style="color:#000;font-size:9pt;">在线客服</span></a></td>
  </tr>
  <tr>
    <td height="33" colspan="5" align="right"><a href="<%=str%>"><font style="font-size:9pt;color:#000 ">此邮件如果无法浏览，请点击此处》</font></a></td>
  </tr>
  <tr>
    <td height="37" colspan="6" background="http://images.d1.com.cn/images2013/mail/mailh_03.jpg"><table width="750" height="37" border="0" cellpadding="0" cellspacing="0" style="font-family: '微软雅黑';	font-size: 13px;font-weight: 800;color: #FFFFFF;">
      <tr>
        <td width="64" height="37" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;" ><a href="<%=strad %>http://www.d1.com.cn/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>首页</b></span></a></td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/html/women/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>女装</b></span></a> </td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/html/men/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>男装</b></span></a> </td>
        <td width="78" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://cosmetic.d1.com.cn/" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>化妆品</b></span></a> </td>
        <td width="73" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=020012,020011,030011,030015" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>内衣</b></span></a> </td>
        <td width="61" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=021,031" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>鞋</b></span></a></td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"> <a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=040,015002,015009" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>配饰</b></span></a> </td>
        <td width="74" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/result.jsp?productsort=050" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><b>箱包</b></span></a> </td>
        <td width="62" >&nbsp;</td>
        <td width="103" style="text-decoration:none;text-align:center;background-image: url(http://images.d1.com.cn/images2013/mail/mailh_04.jpg);background-repeat: no-repeat;background-position: right;"><a href="<%=strad %>http://www.d1.com.cn/html/miaosha" target="_blank"><span style="color:#ffffff;font-size:10.5pt"><img src="http://images.d1.com.cn/zt2014/0110/hot.gif" width="26" height="11" border="0"/><b>闪购特卖</b></span></a></td>
        <td width="13">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<!-- 头部结束 -->
<center>
<div>
<a href="<%=strad %>http://www.d1.com.cn/html/zt2014/0220qc/" target="_blank"><img src="http://images.d1.com.cn/zt2014/0220qc/tmmail-top.jpg"  /></a>
</div>
<div style="width:750px;padding-top:8px;background: #167e1b;">
<%

StringBuilder sb=new StringBuilder();
String rackcode="";
String pagecount="45";
String ggURL = Tools.addOrUpdateParameter(request,null,null);
ArrayList<Product> productList =new ArrayList<Product>();

productList=getPProductByCode("9181",rackcode,500);


int totalLength = (productList != null ?productList.size() : 0);
int PAGE_SIZE =Tools.parseInt(pagecount) ;
int currentPage = 1 ;
String pg = request.getParameter("pageno");
if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);   
int end = pBean.getStart()+PAGE_SIZE;
if(end > totalLength) end = totalLength;  
String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
int pagenum=totalLength/PAGE_SIZE;
if(totalLength%PAGE_SIZE>0) 
	{pagenum=pagenum+1;
	}
if(currentPage>pagenum){
	out.print("");
	return;
}
if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
pageURL = pageURL.replaceAll("&+", "&");    
int hg=310;
int hgimg=200;
int wdimg=200;

if(productList != null && !productList.isEmpty()){  	  
	   List<Product> gList = productList.subList(pBean.getStart(),end);
	   if(gList != null && !gList.isEmpty()){
		   for(Product pp:gList){
			   String theimgurl=pp.getGdsmst_imgurl();
			   if(!pp.getGdsmst_rackcode().startsWith("014")){
					theimgurl=pp.getGdsmst_img240300();
					hg=410;
					hgimg=300;
					wdimg=240;

				}
			   String gdsid=pp.getId();
				String imgalt=StringUtils.replaceHtml(pp.getGdsmst_gdsname());
				
				String memtxt="特卖价";
				 String memtxt2="市场价";
				 int oldmemprice=pp.getGdsmst_saleprice().intValue();
				 int memprice=pp.getGdsmst_memberprice().intValue();
					if(CartHelper.getmsflag(pp)){
						memprice=pp.getGdsmst_msprice().intValue();
						//oldmemprice=pp.getGdsmst_memberprice().intValue();
						//memtxt="清仓价";
						//memtxt2="原售价";
				 }
					
		    		   if(theimgurl!=null){
		    			  if(theimgurl.startsWith("/shopimg/gdsimg")){
		    				  theimgurl = "http://images1.d1.com.cn"+theimgurl.trim();
		     						}else{
		     							theimgurl = "http://images.d1.com.cn"+theimgurl.trim();
		     						}
		    		   }
				
			   String gdsimglfag="http://images.d1.com.cn/zt2014/0220qc/sale_tm.png";
			   if(pp.getGdsmst_validflag().longValue()!=1){
					gdsimglfag="http://images.d1.com.cn/zt2014/0220qc/end_sale.png";
				}
			   sb.append("<li style=\"height:"+hg+"px;width:240px;float:left;margin:0px 0px 8px 2px;background-color: #fff;border: 1px solid #ffdde4;\">");
				sb.append("<table width=\"240\" height=\""+hg+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
				sb.append("    <tr>");
				sb.append("      <td height=\""+hgimg+"\" colspan=\"5\" align=\"center\" style=\"position:relative;\"> ");
				sb.append("<a href=\""+strad+"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
				sb.append("      <img src=\"").append(theimgurl).append("\"  alt=\"").append(imgalt).append("\" width=\""+wdimg+"\" height=\""+hgimg+"\" border=\"0\" /></a>");
				if(pp.getGdsmst_validflag().longValue()!=1){
					String endimgcss="position:absolute; top:20px; left:40px; z-index:999";
					if(!pp.getGdsmst_rackcode().startsWith("014")){
					endimgcss="position:absolute; top:70px; left:40px; z-index:999";
					}
				sb.append("      <span style=\""+endimgcss+"\"><img src=\""+gdsimglfag+"\"  /></span>");
				}else{
				sb.append("      <span style=\"position:absolute; top:0px; left:0px; z-index:999\"><img src=\""+gdsimglfag+"\"  /></span>");
				}
				sb.append("      </td>");
				sb.append("      </tr>");
				sb.append("<tr>");
				sb.append(" <td height=\"50\">&nbsp;</td>");
				sb.append("<td colspan=\"3\" style=\"font-size:12px; color:#333;font-family:微软雅黑; line-height:21px\">");
				sb.append("<a href=\""+strad+"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" style=\"color:#4b4b4b\" target=\"_blank\">");
				sb.append(imgalt.length()>34?imgalt.substring(0,34):imgalt);
				sb.append("</a></td>");
				sb.append("<td>&nbsp;</td>");
				sb.append("</tr>");
				sb.append("    <tr>");
				sb.append("      <td width=\"3\" bgcolor=\"#ff6b9e\"></td>");
				sb.append("      <td width=\"98\" bgcolor=\"#ff6b9e\"><span  style=\"font-size:21px;color:#FFF;font-family:'微软雅黑';	line-height: 25px;\">").append(memtxt).append("</span><br />");
				sb.append("      <span style=\"font-size:14px;color:#687a6c;font-family:'微软雅黑';line-height: 18px;\"><s>").append(memtxt2).append("：").append(oldmemprice).append("</s></span>");
				sb.append("      </td>");
				sb.append("      <td width=\"76\" align=\"center\" bgcolor=\"#ff6b9e\" valign=\"top\"  style=\"font-size:34px;color:#FFF;font-family:'微软雅黑';font-weight:800;line-height: 36px;\">").append(memprice).append("</td>");
				sb.append("      <td width=\"60\" align=\"center\" bgcolor=\"#ff6b9e\">");
				sb.append("<a href=\""+strad+"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
				sb.append("<img src=\"http://images.d1.com.cn/zt2014/0220qc/tm002-2.jpg\" width=\"60\" height=\"60\" /></a></td>");
				sb.append("      <td width=\"3\" bgcolor=\"#ff6b9e\"></td>");
				sb.append("    </tr>");
				sb.append("  </table>");
				sb.append("</li>");
  
		   }
		   
	   }
}
out.print(sb.toString());
%>
</div>
</center>
<%@include file="/html/mail_tail.jsp"%>
</body>
</html>