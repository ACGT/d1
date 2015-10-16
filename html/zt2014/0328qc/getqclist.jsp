<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %>
<%!
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
	//System.out.println(rackcode+"-------------------------"+total);
	return rlist ;
}
%>
<%
StringBuilder sb=new StringBuilder();
String rackcode=request.getParameter("rackcode");
String pagecount=request.getParameter("pagecount");
String ggURL = Tools.addOrUpdateParameter(request,null,null);
ArrayList<Product> productList =new ArrayList<Product>();
int num=500;
if(!Tools.isNull(rackcode))num=1000;

productList=getPProductByCode("9181",rackcode,num);


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
			   int pd=0;
			   String theimgurl=pp.getGdsmst_imgurl();
			   if(!pp.getGdsmst_rackcode().startsWith("014")){
					theimgurl=pp.getGdsmst_img240300();
					hg=410;
					
					hgimg=300;
					wdimg=240;
					if(Tools.isNull(theimgurl)){
						hgimg=240;
						pd=30;
					}

				}
			   if(Tools.isNull(theimgurl)){
					theimgurl=pp.getGdsmst_midimg();
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
			   sb.append("<li style=\"height:"+hg+"px;\">");
				sb.append("<table width=\"240\" height=\""+hg+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
				sb.append("    <tr>");
				sb.append("      <td height=\""+hgimg+"\" colspan=\"5\" align=\"center\" class=\"gdslistimg\"> ");
				sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
				sb.append("      <img src=\"").append(theimgurl).append("\"  alt=\"").append(imgalt).append("\" width=\""+wdimg+"\" style=\"padding: "+pd+"px 0px\" height=\""+hgimg+"\" border=\"0\" /></a>");
				if(pp.getGdsmst_validflag().longValue()!=1){
					String endimgcss="gdslistimgl2";
					if(!pp.getGdsmst_rackcode().startsWith("014")){
					endimgcss="gdslistimgl3";
					}
				sb.append("      <span class=\""+endimgcss+"\"><img src=\""+gdsimglfag+"\"  /></span>");
				}else{
				sb.append("      <span class=\"gdslistimgl\"><img src=\""+gdsimglfag+"\"  /></span>");
				}
				sb.append("      </td>");
				sb.append("      </tr>");
				sb.append("<tr>");
				sb.append(" <td height=\"50\">&nbsp;</td>");
				sb.append("<td colspan=\"3\" class=\"gdstitle\">");
				sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
				sb.append(imgalt.length()>34?imgalt.substring(0,34):imgalt);
				sb.append("</a></td>");
				sb.append("<td>&nbsp;</td>");
				sb.append("</tr>");
				sb.append("    <tr>");
				sb.append("      <td width=\"3\" bgcolor=\"#ff6b9e\"></td>");
				sb.append("      <td width=\"98\" bgcolor=\"#ff6b9e\"><span  class=\"qcgdst\">").append(memtxt).append("</span><br />");
				sb.append("      <span class=\"qcgdsp2\"><s>").append(memtxt2).append("：").append(oldmemprice).append("</s></span>");
				sb.append("      </td>");
				sb.append("      <td width=\"76\" align=\"center\" bgcolor=\"#ff6b9e\" valign=\"top\"  class=\"qcgdsp\">").append(memprice).append("</td>");
				sb.append("      <td width=\"60\" align=\"center\" bgcolor=\"#ff6b9e\">");
				sb.append("<a href=\"http://www.d1.com.cn/product/").append(gdsid).append("\" title=\"").append(imgalt).append("\" target=\"_blank\">");
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