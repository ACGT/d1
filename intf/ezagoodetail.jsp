<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
public static ArrayList<Sku> getSkuListViaProductId(String productId){
	
	if(Tools.isNull(productId)||!SkuHelper.hasSku(productId))return null;
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", productId));
    clist.add(Restrictions.eq("skumst_validflag", new Long(1)));//上架
	clist.add(Restrictions.gt("skumst_stock", new Long(0)));//有库存
	
	List<BaseEntity> list = Tools.getManager(Sku.class).getList(clist, null, 0, 100);
	
	ArrayList<Sku> rlist = new ArrayList<Sku>();
	if(list!=null&&list.size()>0){
		for(BaseEntity sku:list){
			rlist.add((Sku)sku);
		}
	}
	return rlist ;
}

static Size getsize(String sizeid){
	Size size =(Size) Tools.getManager(Size.class).get(sizeid);
	 return size;
}
static String getsize(Product p){
	if (p.getGdsmst_sizeid()==null){
		return "";
	}
Size s=getsize(p.getGdsmst_sizeid().toString());
StringBuilder sb=new StringBuilder();
if(s!=null){
	//System.out.print("111111111111111111111111111111111111");
	sb.append("<table width=\"750\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	sb.append("<tr>");
	sb.append("<td colspan=\"2\">");
	sb.append("<img src=\"http://images.d1.com.cn/images2012/product/sizeimg_01-1.jpg\" />");
	sb.append("</td>");
	sb.append("</tr>");
	sb.append("<tr>");
	sb.append("<td  align=\"left\"  width=\"200px\" >");
	sb.append("<img src=\""+s.getSizemst_photo().trim()+"\" width=\"200px\"/>");
	sb.append("</td>");
	sb.append("<td  align=\"left\" valign=\"middle\" width=\"550px\">  ");
	sb.append("<table width=\"99%\" height=\"69\" border=\"1\" align=\"center\" cellpadding=\"0\" class=\"sizetab\" cellspacing=\"0\" style=\"border:none; border:double 3px #cccccc;\">");
	sb.append("<tr>");
	int colcount=0;
	int colcount1=0;
	int colcount2=0;
	int colcount3=0;
	int colcount4=0;
	int colcount5=0;
	int colcount6=0;
	int colcount7=0;
	int colcount8=0;
	
	boolean bl1=false;boolean bl2=false;boolean bl3=false;boolean bl4=false;boolean bl5=false;boolean bl6=false;boolean bl7=false;boolean bl8=false;
	ArrayList<Sku> skulist=getSkuListViaProductId(p.getId());
	int totalcol=1;
	if(skulist!=null && skulist.size()>0){
		for(Sku sku:skulist){
			if(!Tools.isNull(sku.getSkumst_sizevalue1()) && !"--".equals(sku.getSkumst_sizevalue1())){
				bl1=true;
				totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue2()) && !"--".equals(sku.getSkumst_sizevalue2())){
				bl2=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue3()) && !"--".equals(sku.getSkumst_sizevalue3())){
				bl3=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue4()) && !"--".equals(sku.getSkumst_sizevalue4())){
				bl4=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue5()) && !"--".equals(sku.getSkumst_sizevalue5())){
				bl5=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue6()) && !"--".equals(sku.getSkumst_sizevalue6())){
				bl6=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue7()) && !"--".equals(sku.getSkumst_sizevalue7())){
				bl7=true;totalcol++;
			}
			if(!Tools.isNull(sku.getSkumst_sizevalue8()) && !"--".equals(sku.getSkumst_sizevalue8())){
				bl8=true;totalcol++;
			}
		}
	}
	String colwidth=(100/totalcol)+"%";
	if(!Tools.isNull(p.getGdsmst_skuname1())){
		colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\"  bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;\"><strong>");
			sb.append("尺码");
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size1()) && bl1){
			colcount1++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size1());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size2())&& bl2){
			colcount2++;colcount++;
			sb.append("<td width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size2());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size3())&& bl3){
			colcount3++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size3());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size4())&& bl4){
			colcount4++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\"  bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size4());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size5())&& bl5){
			colcount5++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size5());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size6())&& bl6){
			colcount6++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size6());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size7())&& bl7){
			colcount7++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size7());
			sb.append("</strong></td>");
		}
		if(!Tools.isNull(s.getSizemst_size8())&& bl8){
			colcount8++;colcount++;
			sb.append("<td  width=\"").append(colwidth).append("\" align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
			sb.append(s.getSizemst_size8());
			sb.append("</strong></td>");
		}
		sb.append("</tr>");
		

		if(skulist!=null && skulist.size()>0){
			for(Sku sku:skulist){
				sb.append("<tr>");
				if(!Tools.isNull(sku.getSkumst_sku1())){
					sb.append("<td align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\">");
					sb.append(sku.getSkumst_sku1());
					sb.append("</td>");
				}
				if(colcount1>0){
					sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue1())? "-":sku.getSkumst_sizevalue1());
					sb.append("</strong></td>");
				}
				if(colcount2>0){
					sb.append("<td align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue2())? "-":sku.getSkumst_sizevalue2());
					sb.append("</strong></td>");
				}
				if(colcount3>0){
					sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue3())? "-":sku.getSkumst_sizevalue3());
					sb.append("</strong></td>");
				}
				if(colcount4>0){
					sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue4())? "-":sku.getSkumst_sizevalue4());
					sb.append("</strong></td>");
				}
				if(colcount5>0){
					sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue5())? "-":sku.getSkumst_sizevalue5());
					sb.append("</strong></td>");
				}
				if(colcount6>0){
					sb.append("<td   align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue6())? "-":sku.getSkumst_sizevalue6());
					sb.append("</strong></td>");
				}
				if(colcount7>0){
					sb.append("<td  align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc;\"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue7())? "-":sku.getSkumst_sizevalue7());
					sb.append("</strong></td>");
				}
				if(colcount8>0){
					sb.append("<td align=\"center\" bgcolor=\"#FFFFFF\" style=\"border:none;border-bottom:solid 1px #cccccc;border-left:solid 1px #cccccc; \"><strong>");
					sb.append(Tools.isNull(sku.getSkumst_sizevalue8())? "-":sku.getSkumst_sizevalue8());
					sb.append("</strong></td>");
				}
				sb.append("</tr>");
			}
		}
		sb.append("<tr><td height=\"23\" colspan=\""+colcount+"\" bgcolor=\"#FFFFFF\" align=\"left\" >").append(s.getSizemst_memo()).append("</td></tr>");
	sb.append("</table></td></tr></table>");
}
return sb.toString();
}
%><%
/*
<?xml version="1.0" encoding=" UTF-8"?>
<products>
<productid>产品唯一ID</productid>
<producttype>产品类型 美妆：1 服装:2 其他:3</producttype>
< productcatename >分类名称</ productcatename >
<producttitle>产品名称</producttitle>
<markprice>市场价</markprice >
<unitprice>建议零售价</unitprice >
<costprice>供货价</costprice >
<showtype>产品上架状态:上架1，下架0</showtype>
<productnum>总库存</productnum >
<updatetime>上架时间</updatetime>
<goods_sn>商品货号</ goods_sn>
<goods_thumb>缩略图</goods_thumb>
<goods_img>大图</goods_img>
<original_img>原图</original_img>
<productdesc>产品描述</productdesc>
<skulist>
	<skus>
	<skuattrname>颜色:白色;尺码:L</skuattrname>
	<skuquantity>库存数量，返回int格式</skuquantity>
	</skus>
	<skus>
	<skuattrname>颜色:白色;尺码:M</skuattrname>
	<skuquantity>库存数量，返回int格式</skuquantity>
	</skus>
	<skus>
	<skuattrname>颜色:红色;尺码:M</skuattrname>
	<skuquantity>库存数量，返回int格式</skuquantity>
	</skus>
	<skus>
	<skuattrname>颜色:红色;尺码:S</skuattrname>
	<skuquantity>库存数量，返回int格式</skuquantity>
	</skus>
</skulist>
//相册
<gallerylist>
	<gallery>			
	<img_url>http://www.hstyle.com/ies/05/gooimg/3210760641.jpg</img_url>
	<thumb_url>http://www.hstyle.com/im42110760997.jpg</thumb_url>
	</gallery>
	<gallery>				<img_url>http://www.hstyle.com/ies/05/gooimg/3210760641.jpg</img_url>
	<thumb_url>http://www.hstyle.com/im42110760997.jpg</thumb_url>
	</gallery>
</gallerylist>

</products>
*/
String productid=request.getParameter("productid");
Product p=ProductHelper.getById(productid);

StringBuffer str=new StringBuffer();
str.append( "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
str.append("<products>");
if(p!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_memberprice().floatValue()>0){
	String pdetail = p.getGdsmst_detailintruduce();
	pdetail=pdetail.replace("<SCRIPT>getsize(\""+productid+"\")</SCRIPT>", getsize(p));
	ArrayList<Sku> skulist=null;
	if(!Tools.isNull(p.getGdsmst_skuname1())){
	 skulist=getSkuListViaProductId(productid);
	}
    str.append("<productid>");//	产品唯一ID
    str.append(p.getId());
	str.append("</productid>");
	str.append("<producttype></producttype>");
	str.append("<productcatename></productcatename>");
	str.append("<producttitle>");//产品名称
	str.append(Tools.clearHTML(p.getGdsmst_gdsname()));
	str.append("</producttitle>");
	str.append("<markprice>");//市场价
	str.append(p.getGdsmst_saleprice());
	str.append("</markprice>");
    str.append("<unitprice>");//   建议零售价
    str.append(p.getGdsmst_saleprice());
    str.append("</unitprice>");
    str.append("<costprice>");  //供货价
    str.append(p.getGdsmst_memberprice());
    str.append("</costprice>");
    str.append("<showtype>1");// 产品上架状态:上架1，下架0
    str.append("</showtype>");
    str.append("<productnum>");//   总库存
    str.append(p.getGdsmst_virtualstock());
    str.append("</productnum>");
    str.append("<updatetime>");//gdsmst_autoupdatedate   上架时间
    str.append(p.getGdsmst_autoupdatedate());
    str.append("</updatetime>");
    str.append("<goods_sn>");//   商品货号
    str.append("</goods_sn>");
    str.append("<goods_thumb>");//    缩略图
    String gimgsmall=p.getGdsmst_smallimg();
    if(gimgsmall!=null){
    	gimgsmall="http://images.d1.com.cn"+gimgsmall.trim();
    }
    str.append(gimgsmall);
    str.append("</goods_thumb>");
    str.append("<goods_img>");//   大图
    String gimg=p.getGdsmst_imgurl();
    if(gimg!=null){
    	gimg="http://images.d1.com.cn"+gimg.trim();
    }
    str.append(gimg);
    str.append("</goods_img>");
    str.append("<original_img>");    //原图
    String gimgbig=p.getGdsmst_bigimg();
    if(gimgbig!=null){
    	gimgbig="http://images.d1.com.cn"+gimgbig.trim();
    }
    str.append(gimgbig);
    str.append("</original_img>");
    str.append("<productdesc>");//    产品描述
    pdetail=pdetail.replaceAll("<a.*?/a>", "");
    pdetail=pdetail.replaceAll("<A.*?/A>", "");
    pdetail=pdetail.replaceAll("<MAP.*?/MAP>", "");
    pdetail=pdetail.replaceAll("<map.*?/map>", "");
	pdetail=pdetail.replaceAll("<AREA.*?>", "");
	pdetail=pdetail.replaceAll("<area.*?>", "");
	pdetail=pdetail.replaceAll("<SCRIPT.*?/SCRIPT>","");
	//pdetail=pdetail.replace("\"","&quot;");
	//pdetail=pdetail.replace("\'","&apos;");
	pdetail=pdetail.replace("&nbsp;","");
	pdetail=pdetail.replaceAll("\r\n", "");
	pdetail="<![CDATA["+pdetail+"]]> ";
	str.append(pdetail);
    str.append("</productdesc>");
    str.append("<skulist>");
    if(skulist!=null){
    for(Sku sku:skulist){
    str.append("<skus>");
    str.append("<skuattrname>");//    颜色:白色;尺码:L
    String skuname=p.getGdsmst_skuname1()+":"+sku.getSkumst_sku1();
    str.append(skuname);
    str.append("</skuattrname>");
    str.append("<skuquantity>");//    库存数量，返回int格式
    str.append(sku.getSkumst_vstock());
    str.append("</skuquantity>");
    str.append("</skus>");
    }
    }else{
    	str.append("<skus>");
    	str.append("<skuattrname>");//    颜色:白色;尺码:L
    	str.append("</skuattrname>");
    	str.append("<skuquantity>");//    库存数量，返回int格式
    	str.append("</skuquantity>");
    	str.append("</skus>");
    }
    str.append("</skulist>");
    	//相册
    str.append("<gallerylist>");
    str.append("<gallery>");
    str.append("<img_url></img_url>");
    str.append("<thumb_url></thumb_url>");
    str.append("</gallery>");
    str.append("</gallerylist>");
}
str.append("</products>");
out.print(str.toString());
%>