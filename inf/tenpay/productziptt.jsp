<%@ page contentType="text/html;charset=UTF-8"%><%@page import="com.d1.dbcache.core.*,com.d1.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.bean.*,com.d1.helper.*,com.d1.manager.*,java.util.zip.*,java.util.Iterator,java.util.HashMap,java.util.Map,com.d1.bean.*,com.d1.helper.*,java.util.regex.Matcher,java.util.regex.Pattern,com.d1.util.*,java.util.ArrayList,java.util.List;"%><%!
static Size getsize(String sizeid){
	Size size =(Size) Tools.getManager(Size.class).get(sizeid);
	 return size;
}
static ArrayList<Sku> getsku(String gdsid){
	ArrayList<Sku> list=new ArrayList<Sku>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("skumst_gdsid", gdsid));
	List<BaseEntity> b_list = Tools.getManager(Sku.class).getList(clist, null, 0,10);
	if(b_list==null || b_list.size()==0) return null;		
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((Sku)be);
		}
	}	
	
   return list;
}
static String gdsad(){
	StringBuilder sb=new StringBuilder();
	sb.append("<table id=\"__01\" width=\"750\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	sb.append("<tr><td colspan=\"10\">");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity.shtml?sp_id=1212236301\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_01.jpg\" alt=\"\" width=\"750\" height=\"59\" border=\"0\"></a></td>");
	sb.append("</tr><tr><td colspan=\"4\">");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity.shtml?sp_id=1212236301\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_02.jpg\" alt=\"\" width=\"373\" height=\"68\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"6\"><a href=\"http://juhui.tenpay.com/commodity.shtml?sp_id=1212236301\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_03.jpg\" alt=\"\" width=\"377\" height=\"68\" border=\"0\"></a></td>");
	sb.append("</tr><tr><td>");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=03000483&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_04.jpg\" alt=\"\" width=\"128\" height=\"164\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"2\">");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=02001501&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_05.jpg\" alt=\"\" width=\"124\" height=\"164\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"3\">");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=03000497&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_06.jpg\" alt=\"\" width=\"125\" height=\"164\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"2\">");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01516553&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_07.jpg\" alt=\"\" width=\"127\" height=\"164\" border=\"0\"></a></td>");
	sb.append("	<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01505453&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_08.jpg\" alt=\"\" width=\"124\" height=\"164\" border=\"0\"></a></td>");
	sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01516150&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_09.jpg\" alt=\"\" width=\"122\" height=\"164\" border=\"0\"></a></td>");
	sb.append("</tr><tr><td>");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=03000468&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_10.jpg\" alt=\"\" width=\"128\" height=\"159\" border=\"0\"></a></td>");
	sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=02001628&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_11.jpg\" alt=\"\" width=\"121\" height=\"159\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"3\"><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=03000461&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_12.jpg\" alt=\"\" width=\"126\" height=\"159\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"2\"><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01511839&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_13.jpg\" alt=\"\" width=\"126\" height=\"159\" border=\"0\"></a></td>");
	sb.append("<td colspan=\"2\"><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01509829&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_14.jpg\" alt=\"\" width=\"127\" height=\"159\" border=\"0\"></a></td>");
	sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01510245&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_15.jpg\" alt=\"\" width=\"122\" height=\"159\" border=\"0\"></a></td>");
	sb.append("</tr><tr><td>");
	sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01720843&sp_id=1212236301&ADTAG=JUHUI.CP.9002.SJZX	\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_16.jpg\" alt=\"\" width=\"128\" height=\"165\" border=\"0\"></a></td>");
    sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=03000501&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_17.jpg\" alt=\"\" width=\"121\" height=\"165\" border=\"0\"></a></td>");
    sb.append("<td colspan=\"3\">");
    sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01721317&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_18.jpg\" alt=\"\" width=\"126\" height=\"165\" border=\"0\"></a></td>");
    sb.append("<td colspan=\"2\">");
    sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01517497&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_19.jpg\" alt=\"\" width=\"126\" height=\"165\" border=\"0\"></a></td>");
    sb.append("	<td colspan=\"2\">");
    sb.append("<a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01517343&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_20.jpg\" alt=\"\" width=\"127\" height=\"165\" border=\"0\"></a></td>");
    sb.append("<td><a href=\"http://juhui.tenpay.com/commodity_detail.shtml?product_id=01516824&sp_id=1212236301&ADTAG=JUHUI.CPSJSY.9006.SPLB\" target=\"_blank\"><img src=\"http://images.d1.com.cn/market/1305/juhui/juhui_21.jpg\" alt=\"\" width=\"122\" height=\"165\" border=\"0\"></a></td>");
    sb.append("</tr><tr><td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"128\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"121\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"3\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"121\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"2\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"2\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"124\" height=\"1\" alt=\"\"></td>");
    sb.append("	<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"3\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"124\" height=\"1\" alt=\"\"></td>");
    sb.append("<td><img src=\"http://images.d1.com.cn/market/1305/juhui/fengefu.gif\" width=\"122\" height=\"1\" alt=\"\"></td>");
    sb.append("</tr></table>");
    return sb.toString();
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
	ArrayList<Sku> skulist=getsku(p.getId());
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
}%><%
String gdsid = request.getParameter("product_id");//gds id
Product p = (Product)Tools.getManager(Product.class).get(gdsid);
response.reset();
response.setContentType("application/octet-stream");
response.setHeader("Content-Disposition", "attachment;filename=\"" + gdsid + ".zip\"");
ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
//ZipOutputStream zos = new ZipOutputStream(new java.io.FileOutputStream(new java.io.File("d://123.zip")));

String photo = p.getGdsmst_detailintruduce();
photo=photo.replace("<SCRIPT>getsize(\""+p.getId()+"\")</SCRIPT>", getsize(p));
//String photo = "http://images.d1.com.cn/zt2011/aleeishe.com/images/title_01.jpg";




//img图片链接
if(true)
{

		
		//Pattern pa = Pattern.compile("http://images\\.d1\\.com\\.cn/[^\\.]+\\.jpg");
		//String photo = "http://images.d1.com.cn/sdlifjskldfjl/sdfujkf/sdfdff.jpg sldfj93485sdfjljdf aljt http://images.d1.com.cn/sdlifjskldfjl/sdfujkf/sff777dfdff.jpg";
		Pattern pa = Pattern.compile("http://images\\.d1\\.com\\.cn/[\\-\\._/a-zA-Z0-9]+\\.jpg");
		Pattern pa2 = Pattern.compile("http://images\\.d1\\.com\\.cn/[\\-\\._/a-zA-Z0-9]+\\.gif");
		Matcher m = pa.matcher(photo);
		Matcher m2 = pa2.matcher(photo);
		Map<String,Object> map=new HashMap<String,Object>();
		while(m.find())
		{
			map.put(m.group(),"");
		}
		while(m2.find())
		{
			map.put(m2.group(),"");
		}
		Iterator it = map.keySet().iterator();
		while(it.hasNext()){
			String imageurl=it.next().toString();
			String iname = imageurl.substring(imageurl.lastIndexOf("/")+1);
			
			ZipEntry ze = new ZipEntry(p.getId()+"/image/"+iname);
			
			photo = photo.replace(imageurl, "image/"+iname);
			byte[] bs =HttpUtil.getUrlBytes(imageurl);
			ze.setSize(bs.length);
			ze.setTime(System.currentTimeMillis());
			//将ZipEntry加到zos中，再写入实际的文件内容
			zos.putNextEntry(ze);
			zos.write(bs,0,bs.length);
			zos.closeEntry();
			zos.flush();
		}
		//http://images.d1.com.cn/images2012/cftinf/qus_01.jpg
		
		/*
		while(m.find()){
			String imageurl=m.group();
			String iname = imageurl.substring(imageurl.lastIndexOf("/")+1);
			
			ZipEntry ze = new ZipEntry(p.getId()+"/image/"+iname);
			
			photo = photo.replace(imageurl, "image/"+iname);
			byte[] bs =HttpUtil.getUrlBytes(imageurl);
			ze.setSize(bs.length);
			ze.setTime(System.currentTimeMillis());
			//将ZipEntry加到zos中，再写入实际的文件内容
			zos.putNextEntry(ze);
			zos.write(bs,0,bs.length);
			zos.closeEntry();
			zos.flush();
		}
		*/
}

//获取商品详细
if(true){
	String detail = "";
	detail=detail+"<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\" />";
	detail=detail+"<meta name=\"keywords\" content=\"财付通,支付/付款/汇款,在线/网上,我的钱包/安全/方便/快捷,手机充值/信用卡还款/送红包/酒店/机票/预定/Q币打折/购物/优惠\" />";
	detail+="<meta name=\"description\" content=\"财付通，在线支付专家，带给您安全快捷的网上付款体验。\" />";
	detail+="<link href=\"css/juhui_min.css\" rel=\"stylesheet\" type=\"text/css\" >";
	detail+="</head><body>";

	photo=photo.replaceAll("<a.*?/a>", "");
	photo=photo.replaceAll("<A.*?/A>", "");
	photo=photo.replaceAll("<MAP.*?/MAP>", "");
	photo=photo.replaceAll("<map.*?/map>", "");
	photo=photo.replaceAll("<AREA.*?>", "");
	photo=photo.replaceAll("<area.*?>", "");
	photo=photo.replaceAll("<SCRIPT.*?/SCRIPT>", "");
	String des=photo;
	
	String gdsad=gdsad();
	Pattern pa = Pattern.compile("http://images\\.d1\\.com\\.cn/[\\-\\._/a-zA-Z0-9]+\\.jpg");
	Pattern pa2 = Pattern.compile("http://images\\.d1\\.com\\.cn/[\\-\\._/a-zA-Z0-9]+\\.gif");
	Matcher m3 = pa.matcher(gdsad);
	Matcher m4 = pa2.matcher(gdsad);
	Map<String,Object> map3=new HashMap<String,Object>();
	while(m3.find())
	{
		map3.put(m3.group(),"");
	}
	while(m4.find())
	{
		map3.put(m4.group(),"");
	}
	Iterator it3 = map3.keySet().iterator();
	while(it3.hasNext()){
		String imageurl=it3.next().toString();
		String iname = imageurl.substring(imageurl.lastIndexOf("/")+1);
		
		ZipEntry ze = new ZipEntry(p.getId()+"/image/"+iname);
		
		gdsad = gdsad.replace(imageurl, "image/"+iname);
		byte[] bs =HttpUtil.getUrlBytes(imageurl);
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//将ZipEntry加到zos中，再写入实际的文件内容
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		zos.closeEntry();
		zos.flush();
	}
	detail+=gdsad;
    detail+="<div class=\"center\" >"+des+"</div>";
    detail+="<script type=\"text/javascript\" src=\"http://juhui.tenpay.com/res/js/juhui/juhui_basic/auto_set_height.js\"></script></body></html>";
	detail+="</body></html>";
	//创建一个ZipEntry，并设置Name和其它的一些属性
	//ZipEntry ze = new ZipEntry("img/123313.jpg");
	ZipEntry ze = new ZipEntry(p.getId()+"/detail.html");
	byte[] bs = detail.getBytes("GBK");
	ze.setSize(bs.length);
	ze.setTime(System.currentTimeMillis());
	//将ZipEntry加到zos中，再写入实际的文件内容
	zos.putNextEntry(ze);
	zos.write(bs,0,bs.length);
	zos.closeEntry();
	zos.flush();
}

//获取商品评价
/*if(true){	
	String detail="";
	//测试数据商品iD   01414502
    List<Comment> commentlist=CommentHelper.getCommentList(p.getId(), 0, 100);
    detail=detail+"<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\" />";
	detail=detail+"<meta name=\"keywords\" content=\"财付通,支付/付款/汇款,在线/网上,我的钱包/安全/方便/快捷,手机充值/信用卡还款/送红包/酒店/机票/预定/Q币打折/购物/优惠\" />";
	detail+="<meta name=\"description\" content=\"财付通，在线支付专家，带给您安全快捷的网上付款体验。\" />";
	detail+="<link href=\"css.css\" rel=\"stylesheet\" type=\"text/css\" >";
	detail+="</head><body>";
    if(commentlist.size()>0)
    {
    	detail+="<div class=\"center\"><table><th>评论人</th><th>评论内容</th><th>回复内容</th><th>回复时间</th>";
    	
    	for(Comment com:commentlist)
    	{
    	  detail+="<tr><td>"+ CommentHelper.GetCommentUid(com.getGdscom_uid())+"</td><td>"+ com.getGdscom_content() +"</td><td>"+ com.getGdscom_replyContent() +"</td><td>"+ com.getGdscom_replydate()+"</td>";
    	  detail+=" 	</tr>";
    	}
      detail+="    	</table></div>";
    }
    detail+="</body></html>";
	
	//创建一个ZipEntry，并设置Name和其它的一些属性
	ZipEntry ze = new ZipEntry(p.getId()+"/evaluate.html");
	
	byte[] bs = detail.getBytes("GBK");
	ze.setSize(bs.length);
	ze.setTime(System.currentTimeMillis());
	//将ZipEntry加到zos中，再写入实际的文件内容
	zos.putNextEntry(ze);
	zos.write(bs,0,bs.length);
	zos.closeEntry();
	zos.flush();
}
*/
//获取商品评价(json)
/*
if(true){	
	String detail="";
	//测试数据商品iD   01414502
    List<Comment> commentlist=CommentHelper.getCommentList(p.getId(), 0, 100);
    
    if(commentlist.size()>0)
    {
    	detail+="{";
    	detail+="\"evaluate\": [";
    	int i=0;
    	for(Comment com:commentlist)
    	{
    		i++;
    	  detail+="{\"time\": \""+Tools.stockFormatDate(com.getGdscom_createdate()) +
    		  "\", user: \""+ com.getGdscom_uid().trim()+"\", \"content\": \""+com.getGdscom_content()+"\"},";
    	}
    	detail=detail.substring(0, detail.length()-1);
    	
      detail+="]";
      detail+="}";
    //创建一个ZipEntry，并设置Name和其它的一些属性
  	ZipEntry ze = new ZipEntry(p.getId()+"/evaluate.json");
  	byte[] bs = detail.getBytes("UTF-8");
  	ze.setSize(bs.length);
  	ze.setTime(System.currentTimeMillis());
  	//将ZipEntry加到zos中，再写入实际的文件内容
  	zos.putNextEntry(ze);
  	zos.write(bs,0,bs.length);
  	zos.closeEntry();
  	zos.flush();
    }
    
	
	
}*/


//商品规格
/*
if(true){	
	String detail="";
    detail=detail+"<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\" />";
	detail=detail+"<meta name=\"keywords\" content=\"财付通,支付/付款/汇款,在线/网上,我的钱包/安全/方便/快捷,手机充值/信用卡还款/送红包/酒店/机票/预定/Q币打折/购物/优惠\" />";
	detail+="<meta name=\"description\" content=\"财付通，在线支付专家，带给您安全快捷的网上付款体验。\" />";
	detail+="<link href=\"css/juhui_min.css\" rel=\"stylesheet\" type=\"text/css\" >";
	detail+="</head><body>";
	/**
获取规格
**/
    //String pid="01101871";  
   
  /*  if(p!=null)  
    {
    	if(p.getGdsmst_stdid()!=null&&p.getGdsmst_stdid()!="")
    	{
    		Standard sd=(Standard)Tools.getManager(Standard.class).get(p.getGdsmst_stdid());
             //Standard sd=StandardHelper.GetStandarBysid(p.getGdsmst_stdid());
		       if(sd!=null)
		       {
		    	   detail+="<table><th>规格名称</th><th>规格值</th>";
		    	   if(sd.getStdmst_showflag1()==1)
		           {
		        	   detail+="<tr><td>"+sd.getStdmst_atrname1()+"</td><td>"+p.getGdsmst_stdvalue1()+"</td></tr>";        	   
		           }
					if(sd.getStdmst_showflag2()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname2()+"</td><td>"+p.getGdsmst_stdvalue2()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag3()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname3()+"</td><td>"+p.getGdsmst_stdvalue3()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag4()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname4()+"</td><td>"+p.getGdsmst_stdvalue4()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag5()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname5()+"</td><td>"+p.getGdsmst_stdvalue5()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag6()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname6()+"</td><td>"+p.getGdsmst_stdvalue6()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag7()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname7()+"</td><td>"+p.getGdsmst_stdvalue7()+"</td></tr>";        	   
					}
					if(sd.getStdmst_showflag8()==1)
					{
						detail+="<tr><td>"+sd.getStdmst_atrname8()+"</td><td>"+p.getGdsmst_stdvalue8()+"</td></tr>";        	   
					}
		            detail+="</table>";
		        }
       }
    }
    
    detail+="</body></html>";
	
	//创建一个ZipEntry，并设置Name和其它的一些属性
	ZipEntry ze = new ZipEntry(p.getId()+"/spec.html");
	
	byte[] bs = detail.getBytes("GBK");
	ze.setSize(bs.length);
	ze.setTime(System.currentTimeMillis());
	//将ZipEntry加到zos中，再写入实际的文件内容
	zos.putNextEntry(ze);
	zos.write(bs,0,bs.length);
	zos.closeEntry();
	zos.flush();
}
*/
//css样式
if(true){
	
	/*String detail="body,p,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,form,fieldset,legend,input,select,textarea,button,th,td,blockquote,address,pre{margin:0;padding:0;}h1,h2,h3,h4,h5,h6,input,textarea,select,button,label{font-size:100%;vertical-align:middle;}";
	detail+="ul,dl,ol{list-style:none;}img,fieldset{border:none;}img{display:inline-block;overflow:hidden;vertical-align:top;}em,address{font-style:normal;}sup,sub{vertical-align:baseline;}table{border-collapse:collapse;border-spacing:0;}q:before{content:\"\";}q:after{content:\"\";}";
	detail+="button{cursor:pointer;}textarea{word-wrap:break-word;resize:none;}article,aside,dialog,figure,footer,header,hgroup,nav,section{display:block;}menu{margin:0;padding:0;}mark{background-color:transparent;}body{background-color:#fff;color:#333;font:12px/1.5 Tahoma,Arial,\5b8b\4f53;}legend,button,select,textarea,input{color:#333;font-family:Tahoma,Arial,Simsun;}";
	detail+="button{min-width:68px;min-width:52px\\9;*min-width:auto;height:24px;padding:0 5px 1px;*padding:0 10px 1px;}a{color:#1163a3;text-decoration:none;}a:hover{text-decoration:underline;}a:focus{outline:none;}.font-12{font-size:12px;}.font-14{font-size:14px;}.highlight{color:#f63;}.money{color:#f63;font-weight:700;}";
	detail+=".gray-links a{color:#999;}.gray-links a:hover{color:#1163a3;text-decoration:none;}.gray{color:#999;}a.gray:hover{color:#1163a3;text-decoration:none;}.dark-gray{color:#666;}a.dark-gray:hover{color:#1163a3;text-decoration:none;}.light-gray{color:#ccc;}.black{color:#333;}.red{color:#c00;}.bold{font-weight:700;}.italic{font-style:italic;}.line-through{text-decoration:line-through;}.container:after,.col-wrap:after{display:block;visibility:hidden;height:0;content:\".\";clear:both;}.container,.col-wrap{zoom:1;}.header,.container,.footer{margin:0 auto;}.col-l,.col-m,.col-inner-l,.col-inner-m{display:inline;float:left;width:auto;}.col-r,.col-inner-r{display:inline;float:right;width:auto;}.clearfix:after{content:\".\";clear:both;display:block;height:0;visibility:hidden;}.clearfix{zoom:1;}.juhui-index .juhui-content{width:996px;margin:0 auto;}.juhui-index .market-price{text-decoration:line-through;margin-right:23px;color:#333333;}";
	detail+=".juhui-index .qq,.juhui-index .tqq,.juhui-index .sina,.juhui-index .qzone,.juhui-index .renren{width:16px;height:16px;display:inline-block;vertical-align:middle;margin-right:5px;background:url(../image/index.png) no-repeat;}.juhui-index .qzone{background-position:-15px -18px;}.juhui-index .qq{background-position:-32px -18px;}.juhui-index .tqq{background-position:-47px -18px;}.juhui-index .sina{background-position:-15px -35px;}.juhui-index .renren{background-position:-32px -35px;}.high-btn-blue,.high-btn-blue span,.high-btn-mini,.high-btn-mini span{height:42px;display:inline-block;background:url(../image/index.png) no-repeat;}.high-btn-blue span,.high-btn-mini span{font-family:\"微软雅黑\";vertical-align:top;color:#fff;}";
	detail+=".high-btn-blue{padding-left:20px;background-position:-62px -24px;}.high-btn-blue span{background-position:right -24px;padding:0 16px 0 8px;line-height:42px;font-size:22px;}.high-btn-mini,.high-btn-mini span{height:32px;}.high-btn-mini{padding-left:13px;background-position:-74px -91px;}.high-btn-mini span{padding:0 16px 0 8px;line-height:32px;background-position:right -91px;font-size:18px;}.main-header-nav .ico-arrow-right{margin:0 7px 0 8px;}.main-content,.side-bar{margin-top:12px;}.main-content-nav,.side-content-nav{padding-top:1px;border:1px solid #F3F1F1;border-bottom:1px solid #00A7F9;}.side-content-nav h3{padding-left:12px;height:34px;line-height:34px;background-color:#FAFAFA;border-bottom:1px solid #A0E1FF;}";
	detail+=".main-content-nav ul{background-color:#FAFAFA;border-bottom:1px solid #A0E1FF;}.main-content-nav ul li{position:relative;float:left;margin-bottom:-2px;}.main-content-nav ul li.on{margin:-1px 0 0;border:1px solid #00A7F9;border-bottom:0 none;}.main-content-nav ul li.on span,.main-content-nav ul li a{height:34px;line-height:34px;padding:0 20px;display:block;}.main-content-nav ul li.on span{position:relative;border:1px solid #A0E1FF;border-bottom:0 none;background-color:#fff;overflow:hidden;margin-bottom:-2px;}.commodity-detail .detail-info{padding:7px;margin:12px 0 13px;border:1px solid #D4DFEA;}.commodity-detail .pic-panel{width:605px;float:left;margin-right:25px;}.commodity-detail .pic-panel ul{margin:8px 0 0 -15px;}.commodity-detail .pic-panel li{position:relative;float:left;margin-left:15px;}";
	detail+=".commodity-detail .pic-panel li .mask{position:absolute;left:0;top:0;width:105px;height:70px;z-index:1;border:2px solid #FF0000;display:none;}.commodity-detail .pic-panel li a:hover .mask{display:block;}.commodity-detail .share-line{height:36px;line-height:36px ;text-align:center;}.commodity-detail .share-line a{color:#333333;margin-right:16px;}.commodity-detail .detail-info dl{float:left;width:350px;}.commodity-detail .detail-info .name,.commodity-detail .detail-info .price,.commodity-detail .detail-info .btn-line{padding-left:20px;}.commodity-detail .detail-info .name{font-size:24px;line-height:36px;font-weight:bold;}.commodity-detail .detail-info .price{margin-top:8px;}.commodity-detail .detail-info dt a{width:335px;display:inline-block;margin-left:10px;padding:10px 0 8px 5px;border-bottom:1px solid #D4DFEA;}";
	detail+=".commodity-detail .detail-info .price-unit,.commodity-detail .detail-info .juhui-price{color:#FF4E00;font-weight:bold;}.commodity-detail .detail-info .price-unit{font-size:14px;margin-right:4px;}.commodity-detail .detail-info .juhui-price{font-size:27px;vertical-align:middle;}.commodity-detail .detail-info .discount{width:41px;height:17px;line-height:17px;display:inline-block;text-align:center;margin-left:9px;background:url(../image/index.png) -185px -141px no-repeat;color:#FFFFFF;font-weight:700px;}.commodity-detail .detail-info .info-panel{margin:24px 0 23px;background-color:#FFF5EC;padding:21px 20px 17px 20px;}.commodity-detail .detail-info .account em{color:#E50303;margin-right:4px;}.commodity-detail .detail-info .other-info{margin-top:40px;padding:15px 0 12px 18px;border-top:1px solid #D4DFEA;}";
	detail+=".commodity-detail .detail-info .service-line span{margin-right:25px;}.commodity-detail .detail-info .select-line{line-height:22px;margin-bottom:9px;}.commodity-detail .select-line .title,.commodity-detail .select-line ul{float:left;}.commodity-detail .select-line li{float:left;margin-right:9px;}.commodity-detail .select-line li a{width:40px;height:20px;line-height:22px;text-align:center;display:block;padding:1px;border:1px solid #D7DDE3;background-color:#F2F7FB;text-decoration:none;}.commodity-detail .select-line li a:hover{border-color:#0079EC;}.commodity-detail .select-line li a.on{border-color:#FF0000;border-width:2px;padding:0;}.other-info .btn-add{vertical-align:middle;margin:0 38px 0 21px;}.other-info p{line-height:28px;}.other-info em{margin:0 8px 0 7px;color:#E50303;}.detail-content{margin-bottom:44px;}";
	detail+=".detail-content .main,.detail-content .side-bar{float:left;}.detail-content .main{width:647px;margin-right:36px;}.detail-content .main p{margin-top:13px;}.detail-content .main .big,.detail-content .main .introduction-panel{margin:13px 0;display:block;}.detail-content .side-bar{width:313px;}.introduction-panel{margin-bottom:23px;}.introduction-panel .medium{float:left;margin-right:27px;}.introduction-panel dt{font-size:14px;font-weight:bold;margin-bottom:11px;}.side-bar-common{margin-bottom:10px;padding-top:1px;border:1px solid #DBE4ED;}.side-bar-common h3{height:35px;line-height:35px;padding-left:11px;font-weight:bold;font-size:14px;background-color:#EAF2F9;}.side-bar-common dl{width:126px;float:left;}.side-bar-common dt{line-height:24px;margin-bottom:10px;}.side-bar-common li{padding:5px 5px 5px 10px;margin-top:9px;float:left;}.side-bar-common li .pic{position:relative;width:158px;height:158px;float:right;margin-left:10px;border:1px solid #E8EEF4;}";
	detail+=".side-bar-common li .pic .mask{position:absolute;left:0;top:0;width:155px;height:155px;z-index:1;border:2px solid #017BE5;display:none;}.side-bar-common li .pic:hover .mask{display:block;}.price-line{margin-bottom:22px;}.price-line .juhui-price{font-size:18px;color:#E50303;vertical-align:middle;}.common-commodity{margin-top:28px;}.common-commodity h4{font-weight:bold;font-size:14px;margin-bottom:11px;}.common-commodity p{line-height:22px;}.common-commodity .commodity-list{margin-top:24px;}.common-commodity li{float:left;margin-right:22px;}.common-commodity li a{padding:4px 3px;border:1px solid #E8EEF4;}.common-commodity li img{width:62px;height:62px;}.comment{margin-top:42px;}.comment h4{height:34px;line-height:34px;padding-left:11px;background-color:#EDF2F7;border-bottom:1px solid #D6D6D7;}.comment h4 em{color:#CC0000;}.comment-content{margin-top:22px;}.comment-content .user-name,.comment-content dl{float:left;}.comment-content .user-name{margin:20px 18px 0 14px;}";
	detail+=".comment-content dl{width:520px;}.comment-content dt{font-weight:bold;margin-bottom:10px;}img,a img{border:0;margin:0;padding:0;max-width:590px;}";
	*/
	
	String detail="body,p,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,form,fieldset,legend,input,select,textarea,button,th,td,blockquote,address,pre{margin:0;padding:0;}";
	detail+="h1,h2,h3,h4,h5,h6,input,textarea,select,button,label{font-size:100%;vertical-align:middle;}";
	detail+="ul,dl,ol{list-style:none;}img,fieldset{border:none;}img{display:inline-block;overflow:hidden;vertical-align:top;}";
	detail+="em,address{font-style:normal;}table{border-collapse:collapse;border-spacing:0;}q:before{content:\"\";}q:after{content:\"\";}";
	detail+="body{background-color:#fff;color:#333;font:12px/1.5 Tahoma,Arial,\5b8b\4f53;}a{color:#1163a3;text-decoration:none;}a:hover{text-decoration:underline;}a:focus{outline:none;}";
	detail+=".highlight{color:#f63;}	.money{color:#f63;font-weight:700;}	.bold{font-weight:700;}";
	detail+=".clearfix:after{content:\".\";clear:both;display:block;height:0;visibility:hidden;}.clearfix{zoom:1;}";
	detail+=".detail-content{margin-bottom:44px;}.detail-content .main,.detail-content .side-bar{float:left;}";
	detail+=".detail-content .main{width:800px;margin-right:36px;}	.detail-content .main p{margin-top:13px;}";
	detail+=".detail-content .main .big,.detail-content .main .introduction-panel{margin:13px 0;display:block;}";
	detail+=".detail-content .side-bar{width:313px;}	.introduction-panel{margin-bottom:23px;}.introduction-panel .medium{float:left;margin-right:27px;}";
	detail+=".introduction-panel dt{font-size:14px;font-weight:bold;margin-bottom:11px;}	.price-line .juhui-price{font-size:18px;color:#E50303;vertical-align:middle;}";
	detail+=".common-commodity{margin-top:28px;}	.common-commodity h4{font-weight:bold;font-size:14px;margin-bottom:11px;}";
	detail+=".common-commodity p{line-height:22px;}.common-commodity .commodity-list{margin-top:24px;}.common-commodity li{float:left;margin-right:22px;}";
	detail+=".common-commodity li a{padding:4px 3px;border:1px solid #E8EEF4;}.common-commodity li img{width:62px;height:62px;}";
	detail+="img,a img{border:0;margin:0;padding:0;max-width:800px;}	.comment{margin-top:42px;}";
	detail+=".comment h4{height:34px;line-height:34px;padding-left:11px;background-color:#EDF2F7;border-bottom:1px solid #D6D6D7;}";
	detail+=".comment h4 em{color:#CC0000;}.comment-content{margin-top:15px;}.comment-content .user-name,.comment-content dl{float:left;}";
	detail+=".comment-content .user-name{width:75px;height:20px;overflow:hidden;margin:0 18px 0 14px;}.comment-content dl{width:680px;max-height:54px;_height:54px;overflow:hidden;}";
	detail+=".comment-content p{margin-top:0;}";
	//创建一个ZipEntry，并设置Name和其它的一些属性
		ZipEntry ze = new ZipEntry(p.getId()+"/css/juhui_min.css");
		
		byte[] bs = detail.getBytes("GBK");
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//将ZipEntry加到zos中，再写入实际的文件内容
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		zos.closeEntry();
		zos.flush();
	
}

if(true)
{
	for(int i=1;i<=6;i++){
		String strname="0"+i;
		if(strname.length()>2){
			strname=i+"";
		}
		String imageurl="http://images.d1.com.cn/images2012/cftinf/qus_"+strname+".jpg";
		String iname = imageurl.substring(imageurl.lastIndexOf("/")+1);
		
		ZipEntry ze = new ZipEntry(p.getId()+"/image/"+iname);
		
		photo = photo.replace(imageurl, "image/"+iname);
		byte[] bs =HttpUtil.getUrlBytes(imageurl);
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//将ZipEntry加到zos中，再写入实际的文件内容
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		zos.closeEntry();
		zos.flush();
	}
	
	String detail="";
    detail=detail+"<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\" />";
	detail=detail+"<meta name=\"keywords\" content=\"财付通,支付/付款/汇款,在线/网上,我的钱包/安全/方便/快捷,手机充值/信用卡还款/送红包/酒店/机票/预定/Q币打折/购物/优惠\" />";
	detail+="<meta name=\"description\" content=\"财付通，在线支付专家，带给您安全快捷的网上付款体验。\" />";
	detail+="<link href=\"css/juhui_min.css\" rel=\"stylesheet\" type=\"text/css\" >";
	detail+="</head><body>";
	detail+="<table id=\"__01\" width=\"646\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
	detail+="<tr><td><img src=\"image/qus_01.jpg\" width=\"646\" height=\"94\" alt=\"\"></td></tr>";
	detail+="<tr><td><img src=\"image/qus_02.jpg\" width=\"646\" height=\"93\" alt=\"\"></td></tr>";
	detail+="<tr><td><img src=\"image/qus_03.jpg\" width=\"646\" height=\"100\" alt=\"\"></td></tr>";
	detail+="<tr><td><img src=\"image/qus_04.jpg\" width=\"646\" height=\"125\" alt=\"\"></td></tr>";
	detail+="<tr><td><img src=\"image/qus_05.jpg\" width=\"646\" height=\"62\" alt=\"\"></td></tr>";
	detail+="<tr><td><img src=\"image/qus_06.jpg\" width=\"646\" height=\"108\" alt=\"\"></td></tr>";
	detail+="</table>";
    detail+="<script type=\"text/javascript\" src=\"http://juhui.tenpay.com/res/js/juhui/juhui_basic/auto_set_height.js\"></script></body></html>";
    //创建一个ZipEntry，并设置Name和其它的一些属性
  	ZipEntry ze = new ZipEntry(p.getId()+"/service.html");
  	byte[] bs = detail.getBytes("UTF-8");
  	ze.setSize(bs.length);
  	ze.setTime(System.currentTimeMillis());
  	//将ZipEntry加到zos中，再写入实际的文件内容
  	zos.putNextEntry(ze);
  	zos.write(bs,0,bs.length);
  	zos.closeEntry();
  	zos.flush();
    
}
if(true)
{
	for(int i=1;i<=9;i++){
		String strname="0"+i;
		if(strname.length()>2){
			strname=i+"";
		}
		String imageurl="http://images.d1.com.cn/images2012/cftinf/decs2_"+strname+".jpg";
		String iname = imageurl.substring(imageurl.lastIndexOf("/")+1);
		
		ZipEntry ze = new ZipEntry(p.getId()+"/image/"+iname);
		
		photo = photo.replace(imageurl, "image/"+iname);
		byte[] bs =HttpUtil.getUrlBytes(imageurl);
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//将ZipEntry加到zos中，再写入实际的文件内容
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		zos.closeEntry();
		zos.flush();
	}
	//http://images.d1.com.cn/images2012/cftinf/qus_01.jpg
	
	String detail="";
    detail=detail+"<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />";
    detail=detail+"<meta name=\"keywords\" content=\"财付通,支付/付款/汇款,在线/网上,我的钱包/安全/方便/快捷,手机充值/信用卡还款/送红包/酒店/机票/预定/Q币打折/购物/优惠\" />";
    detail=detail+"<meta name=\"description\" content=\"财付通，在线支付专家，带给您安全快捷的网上付款体验。\" />";
    detail=detail+"<meta name=\"page\" content=\",TENPAY_V2,CHARGE,HOME,\" />";
    detail=detail+"<title>财付通 - 会支付 会生活</title>";
    detail=detail+"<link href=\"css/juhui_min.css\" rel=\"stylesheet\" type=\"text/css\" />";
    detail=detail+"</head>";
    detail=detail+"<body id=\"account_charge\" class=\"juhui-index highlight-nav-youhui\">";
    detail=detail+"<table id=\"__01\" width=\"800\" height=\"1046\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
    detail=detail+"<tr><td><img src=\"image/decs2_01.jpg\" width=\"800\" height=\"90\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_02.jpg\" width=\"800\" height=\"168\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_03.jpg\" width=\"800\" height=\"96\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_04.jpg\" width=\"800\" height=\"172\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_05.jpg\" width=\"800\" height=\"90\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_06.jpg\" width=\"800\" height=\"139\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_07.jpg\" width=\"800\" height=\"116\" alt=\"\"></td></tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_08.jpg\" width=\"800\" height=\"96\" alt=\"\"></td>	</tr>";
    detail=detail+"<tr><td><img src=\"image/decs2_09.jpg\" width=\"800\" height=\"79\" alt=\"\"></td></tr>";
    detail=detail+"</table>";
    detail=detail+"<script type=\"text/javascript\" src=\"http://juhui.tenpay.com/res/js/juhui/juhui_basic/auto_set_height.js\"></script></body></html>";
    //创建一个ZipEntry，并设置Name和其它的一些属性
  	ZipEntry ze = new ZipEntry(p.getId()+"/desc.html");
  	byte[] bs = detail.getBytes("UTF-8");
  	ze.setSize(bs.length);
  	ze.setTime(System.currentTimeMillis());
  	//将ZipEntry加到zos中，再写入实际的文件内容
  	zos.putNextEntry(ze);
  	zos.write(bs,0,bs.length);
  	zos.closeEntry();
  	zos.flush();
    
}


zos.flush();
zos.close();//关闭
return;
//response.sendRedirect("product_query.jsp");
%>