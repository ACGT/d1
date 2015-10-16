<%@ page contentType="text/html; charset=UTF-8"%><%@include file="/inc/header.jsp" %><%!
static ArrayList<HWeightManDtl> getHeightDtl(String gdsid,Long weight){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wheightman_gdsid", gdsid));
	clist.add(Restrictions.ge("wheightman_dtlweight", weight));

	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, null, 0, 10);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
static ArrayList<HWeightManDtl> getAllHeightDtl(Long mid){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wheightman_id", mid));
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("wheightman_dtlweight"));
	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, null, 0, 20);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
static ArrayList<HWeightWomanDtl> getAllWomanHeightDtl(Long mid){
	ArrayList<HWeightWomanDtl> list=new ArrayList<HWeightWomanDtl>();
	ArrayList<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("wheightwoman_id", mid));
	List<BaseEntity> list2=	Tools.getManager(HWeightWomanDtl.class).getList(clist, null, 0, 1000);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightWomanDtl)be);
	}
	return list;
}
static ArrayList<HWeightManDtl> getAllHeightDtl(String gdsid,String weight){
	ArrayList<HWeightManDtl> list=new ArrayList<HWeightManDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	if(!Tools.isNull(gdsid)){
		clist.add(Restrictions.eq("wheightman_gdsid", gdsid));
	}
	if(!Tools.isNull(weight)){
		clist.add(Restrictions.eq("wheightman_dtlweight", new Long(weight)));
	}
	
	List<BaseEntity> list2=	Tools.getManager(HWeightManDtl.class).getList(clist, null, 0, 12);
	if(list2==null||list2.size()==0)return null;
	for(BaseEntity be:list2){
		list.add((HWeightManDtl)be);
	}
	return list;
}
static String getHeightInfo(String gdsid){

Product p=ProductHelper.getById(gdsid);

StringBuilder sb=new StringBuilder();
//Long mid=1l;
Long weight1=78l;Long weight2=50l;Long weight3=65l;Long weight4=75l;
Long height1=184l;Long height2=170l;Long height3=175l;Long height4=179l;
boolean isman=false;
String size1="";String size2="";String size3="";String size4="";

//int column=5;int type=0;
//if(p.getGdsmst_mwgid()!=null && p.getGdsmst_mwgid()>0){
	//mid=p.getGdsmst_mwgid();
	//HWeightMan m=(HWeightMan)Tools.getManager(HWeightMan.class).get(mid+"");
	//if(m!=null){
		ArrayList<HWeightManDtl> dtllist= getAllHeightDtl( gdsid,"");
	if(dtllist!=null && dtllist.size()>0){
		if(p.getGdsmst_rackcode().length()>3 && p.getGdsmst_rackcode().startsWith("030")){
			 weight1=78l; weight2=50l; weight3=65l; weight4=75l;
			 height1=184l; height2=170l; height3=175l; height4=179l;
			 isman=true;
		}else if(p.getGdsmst_rackcode().length()>3 && p.getGdsmst_rackcode().startsWith("020")){
			 weight1=50l; weight2=40l; weight3=51l; weight4=63l;
			 height1=170l; height2=155l; height3=168l; height4=160l;
			 isman=false;
		}
		if(p.getGdsmst_brand().equals("001564")){
			 weight1=54l; weight2=43l; weight3=46l; weight4=65l;
			 height1=167l; height2=155l; height3=162l; height4=171l;
			 isman=false;
		}
		ArrayList<HWeightManDtl> list1= getHeightDtl( gdsid, weight1);
		if(list1!=null && list1.size()>0){
			HWeightManDtl d=list1.get(0);
			if(isman){
				//if(160>=height1) size1=d.getWheightman_dtlsize1();
				if(165>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize1();
				if(170>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize2();
				if(175>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize3();
				if(180>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize4();
				if(185>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize5();
			}else{
				if(150>=height1) size1=d.getWheightman_dtlsize1();
				if(155>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize2();
				if(160>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize3();
				if(165>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize4();
				if(170>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize5();
				if(175>=height1 && Tools.isNull(size1)) size1=d.getWheightman_dtlsize6();
			}
			
		}
		ArrayList<HWeightManDtl> list2= getHeightDtl( gdsid, weight2);
		if(list2!=null && list2.size()>0){
			HWeightManDtl d=list2.get(0);
			if(isman){
				//if(160>=height2) size2=d.getWheightman_dtlsize1();
				if(165>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize1();
				if(170>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize2();
				if(175>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize3();
				if(180>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize4();
				if(185>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize5();
			}else{
				if(150>=height2) size2=d.getWheightman_dtlsize1();
				if(155>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize2();
				if(160>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize3();
				if(165>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize4();
				if(170>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize5();
				if(175>=height2 && Tools.isNull(size2)) size2=d.getWheightman_dtlsize6();
			}
		}	
		ArrayList<HWeightManDtl> list3= getHeightDtl( gdsid, weight3);
		if(list3!=null && list3.size()>0){
			HWeightManDtl d=list3.get(0);
			if(isman){
				//if(160>=height3) size3=d.getWheightman_dtlsize1();
				if(165>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize1();
				if(170>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize2();
				if(175>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize3();
				if(180>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize4();
				if(185>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize5();
			}else{
				if(150>=height3) size3=d.getWheightman_dtlsize1();
				if(155>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize2();
				if(160>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize3();
				if(165>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize4();
				if(170>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize5();
				if(175>=height3 && Tools.isNull(size3)) size3=d.getWheightman_dtlsize6();
			}
		}	
		ArrayList<HWeightManDtl> list4= getHeightDtl( gdsid, weight4);
		if(list4!=null && list4.size()>0){
			HWeightManDtl d=list4.get(0);
			if(isman){
				//if(160>=height4) size4=d.getWheightman_dtlsize1();
				if(165>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize1();
				if(170>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize2();
				if(175>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize3();
				if(180>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize4();
				if(185>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize5();
			}else{
				if(150>=height4) size4=d.getWheightman_dtlsize1();
				if(155>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize2();
				if(160>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize3();
				if(165>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize4();
				if(170>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize5();
				if(175>=height4 && Tools.isNull(size4)) size4=d.getWheightman_dtlsize6();
			}
		}		
		sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"color:#393939;font-size:13px; font-family:'微软雅黑'; \">");
		sb.append("<tr>");
		sb.append(" <td colspan=\"8\">");
		String topimg="";String img1="";String img2="";String img3="";String img4="";
		if(isman){
			topimg="http://images.d1.com.cn/images2012/product/cm_03-1-2.jpg";
			img1="http://images.d1.com.cn/images2012/product/cm_05.jpg";
			img2="http://images.d1.com.cn/images2012/product/cm_07.jpg";
			img3="http://images.d1.com.cn/images2012/product/cm_09.jpg";
			img4="http://images.d1.com.cn/images2012/product/cm_11.jpg";
		}else{
			
			if(p.getGdsmst_brand().equals("001564")){
				topimg="http://images.d1.com.cn/images2012/product/wheight/mt_01.jpg";
				img1="http://images.d1.com.cn/images2012/product/wheight/mt_02.jpg";
			}
			else if(p.getGdsmst_brand().equals("001691")){
				topimg="http://images.d1.com.cn/images2012/product/wheight/smt_01-1.jpg";
				img1="http://images.d1.com.cn/images2012/product/wheight/smt_02-1.jpg";
			}
			else{
				topimg="http://images.d1.com.cn/images2012/product/women-size_03-2.jpg";
				img1="http://images.d1.com.cn/images2012/product/women-size_05.jpg";
			}
			
			img2="http://images.d1.com.cn/images2012/product/women-size_07.jpg";
			img3="http://images.d1.com.cn/images2012/product/women-size_09.jpg";
			img4="http://images.d1.com.cn/images2012/product/women-size_11.jpg";
		}
			sb.append("<img src=\"").append(topimg).append("\" width=\"750\" ></td></tr>");
			sb.append("<tr>");
			if(p.getGdsmst_brand().equals("001691")){
				sb.append(" <td width=\"102\" rowspan=\"3\" ><img src=\"").append(img1).append("\"  ></td>");
			}else{
				sb.append(" <td width=\"92\" rowspan=\"3\"><img src=\"").append(img1).append("\"  ></td>");
			}
			
			sb.append(" <td width=\"83\" height=\"25\" valign=\"middle\">&nbsp;&nbsp; 穿:<span class=\"STYLE4\">").append(size1).append("</span>号</td>");
			sb.append("<td width=\"81\" rowspan=\"3\" valign=\"middle\"><img src=\"").append(img2).append("\" /></td>");
			sb.append(" <td width=\"91\" valign=\"middle\">&nbsp;&nbsp; 穿:<span class=\"STYLE4\">").append(size2).append("</span>号</td>");
			sb.append("<td width=\"80\" rowspan=\"3\" valign=\"middle\"><img src=\"").append(img3).append("\" /></td>");
			sb.append("<td width=\"88\" valign=\"middle\">&nbsp;&nbsp; 穿:<span class=\"STYLE4\">").append(size3).append("</span>号</td>");
			sb.append(" <td width=\"83\" rowspan=\"3\" align=\"center\"><img src=\"").append(img4).append("\" /></td>");
			sb.append("<td width=\"85\" valign=\"middle\">&nbsp;&nbsp; 穿:<span class=\"STYLE4\">").append(size4).append("</span>号</td>");
			sb.append("</tr><tr>");
			sb.append("<td width=\"83\" height=\"25\" valign=\"middle\">身高:").append(height1).append("</td>");
			sb.append(" <td width=\"91\" valign=\"middle\">身高:").append(height2).append("</td>");
			sb.append("<td width=\"88\" valign=\"middle\">身高:").append(height3).append("</td>");
			sb.append("<td width=\"85\" valign=\"middle\">身高:").append(height4).append("</td>");
			sb.append("</tr><tr>");
			sb.append(" <td width=\"83\" height=\"25\" valign=\"middle\">体重:").append(weight1).append("kg</td>");
			sb.append("<td width=\"91\" valign=\"middle\">体重:").append(weight2).append("kg</td>");
			sb.append("<td width=\"88\" valign=\"middle\">体重:").append(weight3).append("kg</td>");
			sb.append(" <td width=\"85\" valign=\"middle\">体重:").append(weight4).append("kg</td>");
			sb.append("</tr>");
		
			
			
			sb.append("<tr><td colspan=\"8\" height=\"20\">&nbsp;</td></tr>");
			sb.append(" <tr><td colspan=\"8\" align=\"center\">");
			sb.append("<table width=\"605\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
			sb.append("<tr>");
			sb.append("<td style=\"border:#A9A9A9 solid 2px;\">  <table width=\"605\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-size:14px;text-align:center;\">");
			sb.append("<tr style=\"background:#D5D5D3;\">");
			sb.append("<td width=\"105\"><img src=\"http://images.d1.com.cn/images2012/product/wheight.JPG\" width=\"104\" height=\"48\" /></td>");
			int column=6;
			if(!isman){
				
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">150cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">155cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">160cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">165cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">170cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">175cm</td>");
			}else{
				column=5;
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">165cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">170cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">175cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">180cm</td>");
				sb.append(" <td width=\"").append(500/(column-1)).append("\"  style=\"border-left:#FFFFFF solid 2px;\">185cm</td>");
			}
			
			sb.append("</tr>");
			for(int i=0;i<dtllist.size();i++){
				if(i%2==0){
					sb.append("<tr>");
				}else{
					sb.append("<tr style=\"background:#D5D5D3;\">");
				}
				sb.append("<td>").append(dtllist.get(i).getWheightman_dtlweight()).append("kg</td>");
				sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize1())? "/":dtllist.get(i).getWheightman_dtlsize1()).append("</td>");
				sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize2())? "/":dtllist.get(i).getWheightman_dtlsize2()).append("</td>");
				sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize3())? "/":dtllist.get(i).getWheightman_dtlsize3()).append("</td>");
				sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize4())? "/":dtllist.get(i).getWheightman_dtlsize4()).append("</td>");
				sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize5())? "/":dtllist.get(i).getWheightman_dtlsize5()).append("</td>");
				if(!isman){
					sb.append("<td  style=\"border-left:#FFFFFF solid 2px;\">").append(Tools.isNull(dtllist.get(i).getWheightman_dtlsize6())? "/":dtllist.get(i).getWheightman_dtlsize6()).append("</td>");
				}
				sb.append("</tr>");
			}
			
			sb.append("</table></td></tr></table></td></tr><tr><td colspan=\"8\" height=\"20\">&nbsp;</td></tr></table>");
			
		}
	//}
//}
/**
if(p.getGdssmt_wwgid()!=null && p.getGdssmt_wwgid()>0){
	mid=p.getGdssmt_wwgid();
	HWeightWoman w=(HWeightWoman)Tools.getManager(HWeightWoman.class).get(mid+"");
	int colcount=1;
	if(w!=null){
		sb.append("<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("<tr><td height=\"37\" bgcolor=\"#D5D5D3\"><div align=\"center\" class=\"STYLE5\">试穿体验报告</div></td></tr>");
		sb.append("<tr> <td><table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"line-height:25px; text-align:center;\">");
		
		sb.append("<tr bgcolor=\"#EFFOEB\"  style=\"background:#EFFOEB;\">");
		sb.append("<td>").append(w.getWheightwoman_stu1()).append("</td>");
		if(!Tools.isNull(w.getWheightwoman_stu2())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu2()).append("</td>");
			colcount++;
		}
		if(!Tools.isNull(w.getWheightwoman_stu3())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu3()).append("</td>");
			colcount++;
		}
		if(!Tools.isNull(w.getWheightwoman_stu4())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu4()).append("</td>");
			colcount++;
		}
		if(!Tools.isNull(w.getWheightwoman_stu5())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu5()).append("</td>");
			colcount++;
		}
		if(!Tools.isNull(w.getWheightwoman_stu6())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu6()).append("</td>");
			colcount++;
		}
		if(!Tools.isNull(w.getWheightwoman_stu7())){
			sb.append("<td style=\"border-left:#fff solid 2px;\">").append(w.getWheightwoman_stu7()).append("</td>");
			colcount++;
		}
		sb.append("</tr>");
		ArrayList<HWeightWomanDtl> wlist=getAllWomanHeightDtl(mid);
		if(wlist!=null && wlist.size()>0){
			for(int i=0;i<wlist.size();i++){
				HWeightWomanDtl wd=wlist.get(i);
				sb.append("<tr><td bgcolor=\"#EFFOEB\" width=\"").append(750/(colcount)).append("\" style=\"background:#EFFOEB;border-top:#fff solid 2px;\">").append(wd.getWheightwoman_dtlsize1()).append("</td>");
				if(!Tools.isNull(w.getWheightwoman_stu2())){
					sb.append("<td width=\"").append(750/(colcount)).append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize2()).append("</td>");
				}
				if(!Tools.isNull(w.getWheightwoman_stu3())){
					sb.append("<td  width=\"").append(750/(colcount)).append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize3()).append("</td>");
				}
				if(!Tools.isNull(w.getWheightwoman_stu4())){
					sb.append("<td width=\"");
					if(colcount==4){
						sb.append(750*2/(colcount));
					}else{
						sb.append(750/(colcount));
					}
					sb.append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize4()).append("</td>");
				}
				if(!Tools.isNull(w.getWheightwoman_stu5())){
					sb.append("<td width=\"");
					if(colcount==5){
						sb.append(750*2/(colcount));
					}else{
						sb.append(750/(colcount));
					}
					sb.append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize5()).append("</td>");
				}
				if(!Tools.isNull(w.getWheightwoman_stu6())){
					sb.append("<td width=\"");
					if(colcount==6){
						sb.append(750*2/(colcount));
					}else{
						sb.append(750/(colcount));
					}
					sb.append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize6()).append("</td>");
				}
				if(!Tools.isNull(w.getWheightwoman_stu7())){
					sb.append("<td width=\"");
					if(colcount==7){
						sb.append(750*2/(colcount));
					}else{
						sb.append(750/(colcount));
					}
					sb.append("\" style=\"border-top:#ccc 1px solid;border-right:#ccc 1px solid;\">").append(wd.getWheightwoman_dtlsize7()).append("</td>");
				}
				sb.append("</tr>");
			
			}
		}
		sb.append("</table></td></tr>");
		sb.append("<tr>");
		sb.append("<td align=\"center\" style=\"border:#ccc 1px solid;\">").append(w.getWheightwoman_memo()).append("</td>");
		sb.append("</tr>");
		sb.append("<tr><td height=\"20\">&nbsp;</td></tr>");
		sb.append("</table>");
	}
	
}
**/
return sb.toString();
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
String reg = "width=?.*?(\\s+)|height=?.*?(\\s+)|WIDTH\\s*\\:?.*?(\\;+)|width\\s*\\:?.*?(\\;+)";
Map<String,Object> map = new HashMap<String,Object>();
map.put("succ",new Boolean(true));
map.put("message",getHeightInfo(gdsid).replaceAll (reg, "$1").replace("<br>", "").replace("<BR>", ""));
out.print(JSONObject.fromObject(map));

%>