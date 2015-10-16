<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/html/header.jsp" %><%!
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

%>

<%
String gdsid=request.getParameter("gdsid");

if(Tools.isNull(gdsid)){
	 out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}

if(!Tools.isNumber(gdsid)){
	out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}
Product p=ProductHelper.getById(gdsid);
if(p==null){
	out.print("{\"succ\":false,\"message\":\"参数错误！\"}");
	 return;
}
if(p.getGdsmst_sizeid()==null){
	out.print("{\"succ\":false,\"message\":\"无尺寸对照！\"}");
	return;
}
Size s=getsize(p.getGdsmst_sizeid().toString());
StringBuilder sb=new StringBuilder();
if(s!=null){
	//System.out.print("111111111111111111111111111111111111");
	String imgt="http://images.d1.com.cn/images2012/product/sizeimg_01-1.jpg";
	if(p.getGdsmst_brand().equals("001564")){
		
		imgt="http://images.d1.com.cn/images2013/product/titlebar-size.jpg";
	}
	//sb.append("<table width=\"750\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
	//sb.append("<tr>");
	//sb.append("<td>");
	//sb.append("<img src=\""+imgt+"\" />");
	//sb.append("</td>");
	//sb.append("</tr>");
	//sb.append("<tr>");
	//sb.append("<td  align=\"left\"  width=\"200px\" >");
	sb.append("<img src=\""+s.getSizemst_photo().trim()+"\" width=\"200px\" >");
	//sb.append("</td>");
	//sb.append("</tr></table>");
	System.out.println(sb.toString());
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
	sb.append("</table>");
}
//out.print(sb.toString());
String reg = "width=?.*?(\\s+)|height=?.*?(\\s+)|WIDTH\\s*\\:?.*?(\\;+)|width\\s*\\:?.*?(\\;+)";
Map<String,Object> map = new HashMap<String,Object>();
map.put("succ",new Boolean(true));
map.put("message",sb.toString().replaceAll (reg, "$1").replace("<br>", "").replace("<BR>", ""));
out.print(JSONObject.fromObject(map));
%>