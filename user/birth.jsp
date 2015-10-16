<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp"%><%@include file="/user/public.jsp"%>
<%!
public static String birthzp(){
	StringBuilder sb=new StringBuilder();
	sb.append("<div style=\"width:980; background-color:#CCCCCC; text-align:center;\">");
	sb.append("<div style=\"width:965px;overflow:hidden;  padding-bottom:18px;\">");
	 
	String code="9601";
	 
	 
	ArrayList<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code,100);
	ArrayList gdsidlist=new ArrayList();
	if(list!=null && list.size()>0){
		
		for(PromotionProduct pProduct:list){
			gdsidlist.add(pProduct.getSpgdsrcm_gdsid());
			
		}
		if(gdsidlist!=null && gdsidlist.size()>0){
			
		int i=0;
		ArrayList<Product> productlist=ProductHelper.getExistProductById(gdsidlist,100);
		int l=0;
		if(productlist!=null){
			for(Product product:productlist){
				ArrayList<PromotionProduct> pproductlist= PromotionProductHelper.getPProductByCodeGdsid(code,product.getId());
				Directory directory=DirectoryHelper.getById(product.getGdsmst_rackcode());
				if(pproductlist!=null && directory!=null){
					
				 PromotionProduct pProduct=pproductlist.get(0);
				 String theimgurl="";
				 String imgalt=StringUtils.replaceHtml(product.getGdsmst_gdsname());
				 if(pProduct.getSpgdsrcm_otherimg().trim().length()!=0){
					 theimgurl=pProduct.getSpgdsrcm_otherimg().trim();
				 }else{
					 theimgurl=(!Tools.isNull(product.getGdsmst_imgurl())&&product.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn")+product.getGdsmst_imgurl();
				 }
				 
				   float memberprice=product.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
					String oldmprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_oldmemberprice().floatValue());
				   String sprice=ProductGroupHelper.getRoundPrice(product.getGdsmst_saleprice().floatValue());
				   double dl= Tools.getDouble(product.getGdsmst_memberprice().doubleValue()*10/product.getGdsmst_saleprice().doubleValue(),1);
					 String fl=ProductGroupHelper.getRoundPrice((float)dl);
					 
		
					 sb.append("<div style=\"width:230px; float:left; height:320px; /*FF*/ *height:320px;/*IE7*/ _height:320px;/*IE6*/ ");
					 if (l!=0 && i%4!=0 ){
					 sb.append("margin-left:15px;");
					 }else{
					sb.append("margin-left:10px; _margin-left:5px;/*IE6*/ ");
					 }
					 sb.append("margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF;\" >");
	sb.append("<dl style=\"text-align:left;\">");
	sb.append("<dt style=\"width:205px; text-align:center;padding-left:10px; float:left\">");
				sb.append("<div style=\"position:relative;left;width:200px;height:200px;\">");
			sb.append("<a href=\"");
			if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){
			sb.append("/product/").append(product.getId());
			}else{
				sb.append(pProduct.getSpgdsrcm_otherlink().trim());
				}
			sb.append("\" target=_blank style='text-decoration:none' title=\"");
			sb.append(product.getGdsmst_gdsname()+"\">");
			sb.append("<img src=\"").append(theimgurl).append("\" border=1 style=\"border-color:#c0c0c0\" > </a>");
			 if (code.equals("3391")){  
			sb.append("<span style=\"position:absolute; width:51px; height:83px; dislay:block; background:url('http://images.d1.com.cn/images2013/act/tl5.png'); left:4px; top:10px; z-index:5000;\"></span>");
			 }  
			sb.append("</div><dd style=\"width:205px; text-align:left; padding-left:10px; float:left\">");
			sb.append("<div style=\"height:42px;width:205px;\">");
			sb.append("<a  href=\"");
			 if (pProduct.getSpgdsrcm_otherlink().trim().length()==0){
				 sb.append("/product/").append(product.getId());
			 }else{ 
				 sb.append(pProduct.getSpgdsrcm_otherlink().trim());
			 } 
			 sb.append("\" target=_blank style='text-decoration:none' >");
 
			 sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">").append(Tools.substring(product.getGdsmst_gdsname(),38)).append("</font></a></div><span style=\"font-size:12px;font-weight:bold;color:#666666;\"><strike>市场价:￥").append(sprice).append("</strike></span><br>");
			sb.append("<span style=\"font-size:15px;font-weight:bold;color:#ff0000;\">会员价:￥").append(strmprice).append("&nbsp;</span><br>");
		 
			
			sb.append("<div align=\"right\" style=\"height:40px\">");
			 
			if(Tools.longValue(product.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(product)){
			 
				sb.append("<a href=\"###\" attr=\"").append(product.getId()).append("\" onclick=\"getbirth(this);\"><img src=\"http://images.d1.com.cn/user/lingqu.jpg\" border=\"0\" /></a>");
				 
			}else{
			 
				sb.append("<a href=\"###\"><img src=\"http://images.d1.com.cn/images2012/New/product/qh.jpg\" /></a>");
				 
			}  
			sb.append("</div></dd></dl></div>");
		 
			l++;
				}
		}
	}
		}
	}

	 
	sb.append("</div></div>");
	return sb.toString();
}
public static String birthdx(){
	StringBuilder sb=new StringBuilder();
	sb.append("<div style=\"width:980; background-color:#CCCCCC; text-align:center;\">");
	sb.append("<div style=\"width:965px;overflow:hidden;  padding-bottom:18px;\">");
	 
 
	  ProductExpPrice rcmdusr=(ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(250));
	  //System.out.print(rcmdusr.getRcmdusr_startdate().getTime());  
	  if(rcmdusr!=null 
	    	&& System.currentTimeMillis()>rcmdusr.getRcmdusr_startdate().getTime() 
	    	&& System.currentTimeMillis()<rcmdusr.getRcmdusr_enddate().getTime()
	    	){
			ArrayList<ProductExpPriceItem>  list = new ArrayList<ProductExpPriceItem>();
 
		  List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("rcmdgds_rcmid", new Long(250)));
			
			List<BaseEntity> rlist = Tools.getManager(ProductExpPriceItem.class).getList(listRes, null, 0, 30);
			if(rlist!=null){
				for(BaseEntity be:rlist){
					ProductExpPriceItem pp = (ProductExpPriceItem)be;
					list.add(pp);
				}
			}
		 
  
		if(list!=null){
			for(ProductExpPriceItem pdx:list){
                 Product p=ProductHelper.getById(pdx.getRcmdgds_gdsid());
              
                 if(p==null||p.getGdsmst_validflag().longValue()!=1)continue;
                
				 String theimgurl="";
				 String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
				 
					 theimgurl=(!Tools.isNull(p.getGdsmst_imgurl())&&p.getGdsmst_imgurl().indexOf("shopadmin")>0?"http://images.d1.com.cn":"http://images1.d1.com.cn")+p.getGdsmst_imgurl();
				  
				 
				   float memberprice=p.getGdsmst_memberprice().floatValue();
					String strmprice=ProductGroupHelper.getRoundPrice(memberprice);
					String oldmprice=ProductGroupHelper.getRoundPrice(p.getGdsmst_oldmemberprice().floatValue());
				   String sprice=ProductGroupHelper.getRoundPrice(p.getGdsmst_saleprice().floatValue());
				   double dl= Tools.getDouble(p.getGdsmst_memberprice().doubleValue()*10/p.getGdsmst_saleprice().doubleValue(),1);
					 String fl=ProductGroupHelper.getRoundPrice((float)dl);
					 
					 float dxprice=pdx.getRcmdgds_memberprice().floatValue();
					 sb.append("<div style=\"width:230px; float:left; height:320px; /*FF*/ *height:320px;/*IE7*/ _height:320px;/*IE6*/ ");
					  
					sb.append("margin-left:10px; _margin-left:5px;/*IE6*/ ");
					 
					 sb.append("margin-top:8px; padding-top:10px; line-height:21px; background-color:#FFFFFF;\" >");
	sb.append("<dl style=\"text-align:left;\">");
	sb.append("<dt style=\"width:205px; text-align:center;padding-left:10px; float:left\">");
				sb.append("<div style=\"position:relative;left;width:200px;height:200px;\">");
			sb.append("<a href=\"");
 
			sb.append("/product/").append(p.getId());
		 
			sb.append("\" target=_blank style='text-decoration:none' title=\"");
			sb.append(p.getGdsmst_gdsname()+"\">");
			sb.append("<img src=\"").append(theimgurl).append("\" border=1 style=\"border-color:#c0c0c0\" > </a>");
	 
			sb.append("</div><dd style=\"width:205px; text-align:left; padding-left:10px; float:left\">");
			sb.append("<div style=\"height:42px;width:205px;\">");
			sb.append("<a  href=\"");
 
				 sb.append("/product/").append(p.getId());
	 
			 sb.append("\" target=_blank style='text-decoration:none' >");
			 if(dxprice>0){
				  
				 sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">").append(Tools.substring(p.getGdsmst_gdsname(),38)).append("</font></a></div>");
				 sb.append("<span style=\"font-size:12px;color:#666666;\"><strike>会员价:￥").append(strmprice).append("</strike>&nbsp;&nbsp;</span>");
			    sb.append("<span style=\"font-size:14px;font-weight:bold;color:#ff0000;\">独享价:￥").append(ProductGroupHelper.getRoundPrice(dxprice)).append("</span> <br>");
			  }else{  
			 sb.append("<font style=\"font-size:10pt\" color=\"#3c3c3c\">").append(Tools.substring(p.getGdsmst_gdsname(),38)).append("</font></a></div><span style=\"font-size:12px;font-weight:bold;color:#666666;\"><strike>市场价:￥").append(sprice).append("</strike></span><br>");
			sb.append("<span style=\"font-size:15px;font-weight:bold;color:#ff0000;\">会员价:￥").append(strmprice).append("&nbsp;</span><br>");
		 }
			
			sb.append("<div align=\"right\" style=\"height:40px\">");
			 
			if(Tools.longValue(p.getGdsmst_ifhavegds()) == 0&& ProductStockHelper.canBuy(p)){
			 
				sb.append("<a href=\"###\" attr=\"").append(p.getId()).append("\" onclick=\"$.inCart(this);\"><img src=\"http://images.d1.com.cn/images2011/sales/tm004.gif\" border=\"0\" /></a>");
				 
			}else{
			 
				sb.append("<a href=\"###\"><img src=\"http://images.d1.com.cn/images2012/New/product/qh.jpg\" /></a>");
				 
			}  
			sb.append("</div></dd></dl></div>");
			 
				}
		}
	}
	 
	
	sb.append("</div></div>");
	return sb.toString();
}
%>
<% Tools.setCookie(response,"rcmdusr_rcmid","250",(int)(Tools.DAY_MILLIS/1000*1));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>白金会员生日礼物</title>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/global.css")%>" rel="stylesheet" type="text/css"/>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<style>
.ulvalidate{ list-style-type: none;}
.ulvalidate li{ float:left;padding-left:20px;}
.acco-safe s,.account .fl s{display:inline-block;*zoom:1;margin-right:3px;width:16px;height:16px; vertical-align:middle;line-height:100px;font-size:0;overflow:hidden;background:url(http://images.d1.com.cn/images2012/login/icon-veri-1.png) no-repeat}
.acco-safe a{margin-right:8px;color:#3051ae; text-decoration:underline; font-size:12px;}
.acco-safe .teln s{background-position:0 -17px}
.acco-safe .mail s{background-position:-17px 0}
.acco-safe .mailn s{background-position:-17px -17px}
.acco-safe .spsd s{background-position:-34px 0}
.acco-safe .spsdn s{background-position:-34px -17px}
.mbr_infoimg {float:left;};
.mbr_infoimg img{ border:solid 1px #c2c2c2; vertical-align:middle; float:left;}
</style>
<script type="text/javascript">
function getbirth(obj){
		/*$.ajax({
			type: "POST",
			data:"id="+type, 
			dataType: "json",
			url: "/ajax/user/getbirth.jsp",
			success: function(json) {
                           if (json.urlflag){
		   
                              $.alert(json.message,'提示',function(){
					this.location.href="/newlogin/valitel.jsp";
				});
				}else{
				//$.alert(json.message);
				
				}
			}
			
			});*/
	    $.inCart(obj,{ajaxUrl:'/ajax/user/getbirth.jsp',width:400,align:'center'});
		 
	}
</script>
</head>
<body>
    <!--头部-->
	<%@include file="/inc/head.jsp" %>
	<!-- 头部结束-->
	<center>
	<table id="__01" width="980" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_01.jpg" width="980" height="128" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_02.jpg" width="980" height="102" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_03_2.jpg" width="980" height="142" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_04.jpg" width="980" height="132" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_05.jpg" width="980" height="25" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
		<%=birthzp() %>
		</td></tr>
	
	<tr>
		<td colspan="4">
			<img src="http://images.d1.com.cn/images2013/user/bjbir_14.jpg" width="980" height="98" alt="" /></td>
	</tr>
	<tr>
		<td colspan="4">
		<%=birthdx()%>
		 
</td>
	</tr>
</table>
	</center>
	
	    <!-- 尾部 -->
    <%@include file="/inc/foot.jsp" %>
    <!-- 尾部结束 -->
</body>
</html>
	