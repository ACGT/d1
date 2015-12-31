<%@ page contentType="text/html; charset=UTF-8"
	import="com.d1.util.*,com.d1.bean.*,java.util.*,com.d1.helper.*,org.hibernate.criterion.*,org.hibernate.*,com.d1.dbcache.core.*"%>
<%!
public static String  getpplist(String code,int len){
	
if(Tools.isNull(code))return "";
ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),30);
StringBuilder sb=new StringBuilder();

if(list!=null&&list.size()>0){
	int i=0;
	for(PromotionProduct pp:list){
		if(i>=len)break;
		String gdsid=pp.getSpgdsrcm_gdsid();
		Product p=ProductHelper.getById(gdsid);
		if(p==null||p.getGdsmst_validflag().longValue()!=1)continue;
		String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
		int saleprice=p.getGdsmst_saleprice().intValue();
    	int mprice=p.getGdsmst_memberprice().intValue();
    	boolean  msflag= CartHelper.getmsflag(p);
       if(msflag)mprice=p.getGdsmst_msprice().intValue();
       String img=ProductHelper.getImageTo200(p);
       
sb.append("<div class=\"pro_list01\">");
sb.append("  <ul>");
sb.append("    <li id=\"hot_buy1\"><a href=\"/product/"+gdsid+"\" target=\"_blank\" title=\""+imgalt+"\"><img src=\""+img+"\" alt=\""+imgalt+"\" width=\"160\" height=\"160\"></a></li>");
sb.append("    <li id=\"pro_text1\">");
sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
sb.append("<tbody><tr>");
sb.append("<td class=\"c_td8\"><span class=\"c_text3\">￥"+saleprice+"</span>");
sb.append("<label class=\"c_text4\">￥"+mprice+"</label></td>");
sb.append("</tr>");
sb.append("<tr>");
sb.append(" <td class=\"c_td9\"><div class=\"ctd9hid\"><a href=\"/product/"+gdsid+"\" target=\"_blank\" title=\""+imgalt+"\">"+imgalt+"</a></div></td>");
sb.append("        </tr>");
sb.append(" </tbody></table>");
sb.append(" </li>");
sb.append(" </ul>");
sb.append("</div>");
i++;
	}
}
return sb.toString();
}
//获取推荐位
public static ArrayList<SpecialProduct> GetSplRck(String splcode)
{
ArrayList<SpecialProduct> rlist = new ArrayList<SpecialProduct>();
	
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sprckmst_rackcode", splcode));
	
	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.asc("sprckmst_seq"));
	List<BaseEntity> list = Tools.getManager(SpecialProduct.class).getList(clist, null, 0, 100);
	
	if(list==null||list.size()==0)return null;
	for(BaseEntity be:list){
		rlist.add((SpecialProduct)be);
	}
	//System.out.println(rlist.size());
	return rlist ;
}
public static String getimgstr(String code,int len,int type)
{
	if(!Tools.isMath(code)) return "";
    String ret="";
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
		   if(type==1){
			   ret+="<li class=\"ct_list1\">";
		     }
			ret+="<a href=\""+url;
			ret+="\" target='_blank' title='";
		     ret+=StringUtils.clearHTML(p.getSplmst_name());
			ret+="'><img src=\"";
			ret+=p.getSplmst_picstr();
			ret+="\"  title=\"";
			ret+=StringUtils.clearHTML(p.getSplmst_name());
			ret+="\" /></a>";
			 if(type==1){
				   ret+="</li>";
			     }
		}
	}
	return ret;
}
public static String getbrandimg(String code,int len)
{
	if(!Tools.isMath(code)) return "";
    String ret="";
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
			   ret+="<li>";
			ret+="<a href=\""+url;
			ret+="\" target='_blank' title='";
		     ret+=StringUtils.clearHTML(p.getSplmst_name());
			ret+="'><img src=\"";
			ret+=p.getSplmst_picstr();
			ret+="\"  title=\"";
			ret+=StringUtils.clearHTML(p.getSplmst_name());
			ret+="\" /></a>";
			ret+="</li>";
		}
	}
	return ret;
}
public static String gettxtstr(String code,int len)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
		
			sb.append("<li class=\"ct_list2\"><a href='"+url);
			sb.append("' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append(p.getSplmst_name());
			sb.append("</a></li>");
		}
	}
	return sb.toString();
}
public static String getrck(String imgcode1,String imgcode2,String txtcode,String pprck,int num){
	StringBuilder sb=new StringBuilder();
	String codestr="";
	String cimg="";
	if(num==2){
		cimg="020";
	}else if(num==3){
		cimg="030";
	}else if(num==4){
		cimg="014";
	}else if(num==5){
		cimg="012";
	}else if(num==6){
		cimg="050";
	}else if(num==7){
		cimg="015";
	}
	sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-bottom:1px solid #eee;\">");
	sb.append("<tbody><tr>");
	sb.append("  <td class=\"c_td10\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	sb.append("<tbody><tr>");
			sb.append("<td width=\"160\" bgcolor=\"#dadada\" align=\"left\" valign=\"top\">");
			sb.append("<div class=\"clear\" style=\"height:210px;\">");
		    sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort="+cimg+"\" target=\"_blank\" >");
			sb.append("<img src=\"http://images.d1.com.cn/Index/2014/"+cimg+".jpg\" width=\"160\" height=\"210\"></a></div>");
			sb.append("<div class=\"ct_list_box1\"><ul>");
			sb.append(getimgstr(imgcode1,3,1));
			sb.append(gettxtstr(txtcode,14));
			sb.append("</ul></div>");
			sb.append("</td>");
			sb.append("<td align=\"left\" valign=\"top\">"+getimgstr(imgcode2,1,0)+"</td>");
			sb.append("</tr>");
			sb.append("</tbody></table></td>");
			sb.append("<td align=\"left\" valign=\"top\" class=\"c_td3\"><div id=\"TabbedPanels"+num+"\" class=\"TabbedPanels2\">");
			sb.append("<ul class=\"TabbedPanelsTabGroup2\">");
			ArrayList<SpecialProduct> sprcklist=GetSplRck(pprck);
			int srcount=sprcklist.size();
			 if(sprcklist!=null&&srcount>0)
			 {
				 int i=0;
			  for(SpecialProduct sr:sprcklist){
				  
			  if(i==0){
				 codestr+=sr.getId();	
			  }else{
				  codestr+=","+sr.getId();
			  }
			  sb.append("<li class=\"TabbedPanelsTab2 ").append(i==0?"TabbedPanelsTab2Selected":"").append("\" tabindex=\"0\" style=\"width:").append(100.0/srcount).append("%;\">"+sr.getSprckmst_name()+"</li>");
				i++;
			  }
			  }
			  
			 sb.append("</ul>");
			 sb.append("<div class=\"TabbedPanelsContentGroup2\">");
			 String[] codearr=codestr.split("\\,");
			 for(int j=0;j<codearr.length;j++){
	         sb.append("<div class=\"TabbedPanelsContent2 ").append(j==0?"TabbedPanelsContent2Visible":"").append("\" style=\"display: block;\"><div class=\"clear\">");
			 sb.append(getpplist(codearr[j],8));
			 sb.append("</div></div>");
			 }
                
			
	sb.append("</div></div></td></tr></tbody></table>");
	return sb.toString();
  
}
public static ArrayList<SgGdsDtl> getsghot(){
	ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));//1上架
	clist.add(Restrictions.le("sggdsdtl_sdate", new Date()));
	clist.add(Restrictions.ge("sggdsdtl_edate", new Date()));

	List<Order> olist = new ArrayList<Order>();
	olist.add(Order.desc("sggdsdtl_sort"));
	olist.add(Order.desc("sggdsdtl_sdate"));
	List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, olist, 0, 5);
	if(b_list!=null){
		for(BaseEntity be:b_list){
			list.add((SgGdsDtl)be);
		}
	}
	return list ;
}

public static String getNewSalsP(String code,int num){
	StringBuilder sb=new StringBuilder();
	if(Tools.isNull(code))return "";
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),20);
	if(list!=null&&list.size()>0){
		int i=0;
		for(PromotionProduct pp:list){
			if(i==num)break;
			String gdsid=pp.getSpgdsrcm_gdsid();
			Product p=ProductHelper.getById(gdsid);
			if(p==null||p.getGdsmst_validflag().longValue()!=1)continue;
			String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
		   	String ptitle=StringUtils.replaceHtml(p.getGdsmst_title());
			int saleprice=p.getGdsmst_saleprice().intValue();
	    	int mprice=p.getGdsmst_memberprice().intValue();
	    	boolean  msflag= CartHelper.getmsflag(p);
	       if(msflag)mprice=p.getGdsmst_msprice().intValue();
	       String img=ProductHelper.getImageTo200(p);
	       
	sb.append("<div class=\"hot_buy_list\" id=\"pro_box1\">");
	sb.append("<ul>");
    sb.append("  <li id=\"hot_buy1\">");
    sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
    sb.append("<img  src=\""+ProductHelper.getImageTo200(p)+"\" width=\"200\" height=\"200\">");
    sb.append("</a></li>");
	sb.append("<li style=\" margin-top:5px;\">");
	sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	sb.append("<tbody><tr>");
	sb.append("<td colspan=\"2\" class=\"c_td4\">");
	 sb.append("<div class=\"ctd9hid\"><a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
	    sb.append(""+imgalt+"");
    sb.append("</a></div></td></tr>");
    sb.append("<tr>");
    sb.append("<td colspan=\"2\" class=\"c_td5\">");
    sb.append("<div class=\"ctd10hid\">");
    sb.append(!Tools.isNull(ptitle)?ptitle:"");
    sb.append("</div></td></tr><tr>");
    sb.append("<td colspan=\"2\" class=\"c_td6\"><label class=\"c_text1\">￥"+mprice+"</label>");
    sb.append("<span class=\"c_text2\">￥"+saleprice+"</span></td>");
    sb.append("</tr> <tr>");
    sb.append("<td valign=\"bottom\" class=\"c_Td7\"></td>");
    sb.append("<td align=\"right\" valign=\"top\">");
    sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
    sb.append("<img src=\"http://images.d1.com.cn/Index/2014/btn_buy2.jpg\"></a></td>");
    sb.append("</tr></tbody></table> </li></ul></div>");
    i++;
		}
	}
return sb.toString();

}


//2015首页推荐位

public static String getrck2015(String codeleft,String pprck,int num){
	StringBuilder sb=new StringBuilder();
	String[] arrcode=codeleft.split(",");
	String codestr="";
	String cimg="";
	if(num==2){
		cimg="014001";
	}else if(num==3){
		cimg="014003,014002";
	}else if(num==4){
		cimg="014005";
	}else if(num==5){
		cimg="014010";
	}else if(num==6){
		cimg="012";
	}
	sb.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border-bottom:1px solid #eee;\">");
	sb.append("<tbody><tr>");
	sb.append("  <td class=\"c_td10\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	sb.append("<tbody><tr>");
			sb.append("<td width=\"190\" bgcolor=\"#f5f5f5\" align=\"left\" valign=\"top\">");
			sb.append("<div style=\"width:190px\">");
		    sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort="+cimg+"\" target=\"_blank\" >");
			sb.append("<img src=\"http://images.d1.com.cn/Index/2015/rck"+num+".jpg\" ></a>");
			sb.append(getrcktxt(arrcode[0],20,"护肤分类"));
			sb.append(getrcktxt(arrcode[1],20,"功效分类")); 
			sb.append(getrcktxt(arrcode[2],20,"肤质分类"));
			sb.append(getrcktxt(arrcode[3],20,"推荐品牌"));
		    sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort="+cimg+"\" target=\"_blank\" >");
			sb.append("<img src=\"http://images.d1.com.cn/Index/2015/rck"+num+"_2.jpg\" ></a>");
			sb.append("</div>");
			sb.append("</td>");
			sb.append("<td align=\"left\" valign=\"top\">"+getimgstr(arrcode[4],1,0)+"</td>");
			sb.append("</tr>");
			sb.append("</tbody></table></td>");
			sb.append("<td align=\"left\" valign=\"top\" class=\"c_td3\"><div id=\"TabbedPanels"+num+"\" class=\"TabbedPanels2\">");
			sb.append("<ul class=\"TabbedPanelsTabGroup2\">");
			ArrayList<SpecialProduct> sprcklist=GetSplRck(pprck);
			int srcount=sprcklist.size();
			 if(sprcklist!=null&&srcount>0)
			 {
				 int i=0;
			  for(SpecialProduct sr:sprcklist){
				  
			  if(i==0){
				 codestr+=sr.getId();	
			  }else{
				  codestr+=","+sr.getId();
			  }
			  sb.append("<li class=\"TabbedPanelsTab2 ").append(i==0?"TabbedPanelsTab2Selected":"").append("\" tabindex=\"0\" style=\"width:").append(100.0/srcount).append("%;\">"+sr.getSprckmst_name()+"</li>");
				i++;
			  }
			  }
			  
			 sb.append("</ul>");
			 sb.append("<div class=\"TabbedPanelsContentGroup2\">");
			 String[] codearr=codestr.split("\\,");
			 for(int j=0;j<codearr.length;j++){
	         sb.append("<div class=\"TabbedPanelsContent2 ").append(j==0?"TabbedPanelsContent2Visible":"").append("\" style=\"display: block;\"><div class=\"clear\">");
			 sb.append(getpplist(codearr[j],8));
			 sb.append("</div></div>");
			 }
                
			
	sb.append("</div></div></td></tr></tbody></table>");
	return sb.toString();
  
}
public static String getbrandhot(String code,int len)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		int i=1;
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
			sb.append("<li ").append(i%3==1?"":"class=\"pd\"").append("><div class=\"item\">");
			sb.append("<a href='"+url+"' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append("<image src=\""+p.getSplmst_picstr()+"\" width=\"398\" height=\"200\" /></a>");
			sb.append("<div class=\"bm\">");
			sb.append("<span class=\"l\">");
			sb.append("<a href='"+url+"' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append(p.getSplmst_name()+"</a></span>");
			sb.append("<span class=\"r\">");
			sb.append("<a href='"+url+"' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append("<img src=\"http://images.d1.com.cn/Index/2015/index_03.jpg\" /></a></span>");
			sb.append("</div></div></li>");
			i++;
		}
	}
	return sb.toString();
}

public static String gethotrec(String code,int num){
	StringBuilder sb=new StringBuilder();
	if(Tools.isNull(code))return "";
	ArrayList<PromotionProduct> list=PromotionProductHelper. getPProductByCode(code.trim(),20);
	if(list!=null&&list.size()>0){
		int i=0;
		for(PromotionProduct pp:list){
			if(i==num)break;
			String gdsid=pp.getSpgdsrcm_gdsid();
			Product p=ProductHelper.getById(gdsid);
			if(p==null||p.getGdsmst_validflag().longValue()!=1)continue;
			String imgalt=StringUtils.replaceHtml(p.getGdsmst_gdsname());
		   	String ptitle=StringUtils.replaceHtml(p.getGdsmst_title());
			int saleprice=p.getGdsmst_saleprice().intValue();
	    	int mprice=p.getGdsmst_memberprice().intValue();
	    	boolean  msflag= CartHelper.getmsflag(p);
	       if(msflag)mprice=p.getGdsmst_msprice().intValue();
	       String img=ProductHelper.getImageTo200(p);
	       sb.append("<li><div class=\"item\">");
	       sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
	       sb.append("<img src=\""+ProductHelper.getImageTo200(p)+"\" width=\"200\" height=\"200\" >");
	       sb.append("</a><div class=\"itemt\">");
	       
	       int totalTitleLength = 45;
	       
	       if (imgalt.length() > totalTitleLength){
	    	   imgalt = imgalt.substring(0, totalTitleLength);
	       }
	       
	       
	       sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
	       sb.append(imgalt+"</a>");
	       
	       if (imgalt.length() < totalTitleLength){
	    	   if (ptitle.length() > (totalTitleLength-imgalt.length())){
	    		   ptitle = ptitle.substring(0,totalTitleLength-imgalt.length());
	    	   }
	       }
	       else{
	    	   ptitle = "";
	       }
	    	   
	       
	       
	       sb.append(!Tools.isNull(ptitle)?"<br>"+ptitle:"");
	       sb.append("</div>");
	       sb.append("<div class=\"itemb\">");
	    	sb.append("<span class=\"p1\">￥"+mprice+"</span>");
	    	sb.append("<span class=\"p2\">￥"+saleprice+"</span>");
	    	sb.append("<span class=\"p3\">");
	        sb.append("<a href=\"http://www.d1.com.cn/product/"+gdsid+"\" target=\"_blank\"  title=\""+imgalt+"\">");
	        sb.append("<img src=\"http://images.d1.com.cn/Index/2014/btn_buy2.jpg\"></a></span>");
	    	sb.append("</div></div>	</li>");
	       
    i++;
		}
	}
return sb.toString();

}
public static String getrcktxt(String code,int len,String headtxt)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		SplRck sp=(SplRck)Tools.getManager(SplRck.class).get(code);
		sb.append("<div class=\"rckrec\">");
		sb.append("<div class=\"rr_list bot\">");
		sb.append("<h3>·"+sp.getSplrck_name()+"</h3><ul>");
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
			
			sb.append("<li><a href='"+url);
			sb.append("' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append(p.getSplmst_name());
			sb.append("</a></li>");
		}
		sb.append("<div class=\"clear\"></div></div></div>");
	}
	return sb.toString();
}
public static String gettxt(String code,int len)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
		
			sb.append("<a href='"+url);
			sb.append("' target=\"_blank\" title=\"").append(p.getSplmst_name()).append("\">");
			sb.append(p.getSplmst_name());
			sb.append("</a>");
		}
	}
	return sb.toString();
}
public static String getimg(String code,int len)
{
	if(!Tools.isMath(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<Promotion> recommendList = PromotionHelper.getBrandListByCode(code , len);
	if(recommendList != null && !recommendList.isEmpty()){
		for(Promotion p:recommendList)
		{
			String url=p.getSplmst_url();
		
			sb.append("<a href=\""+url);
			sb.append("\" target='_blank' title='");
			sb.append(StringUtils.clearHTML(p.getSplmst_name()));
			sb.append("'><img src=\"");
			sb.append(p.getSplmst_picstr());
			sb.append("\"  title=\"");
			sb.append(StringUtils.clearHTML(p.getSplmst_name()));
			sb.append("\" /></a>");
		}
	}
	return sb.toString();
}
public static String getmenrec(String code,String headtxt)
{
	if(Tools.isNull(code)) return "";
	String[] arrcode=code.split(",");
	StringBuilder sb=new StringBuilder();
	//System.out.println(arrcode[5]+gettxt(arrcode[5],10));
	  sb.append("<div class=\"men_tit\">");
	  sb.append("<span>");
	  if(headtxt.equals("男人馆")){
		sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=030\" target=\"_blank\" >");
	  }else{
		    sb.append("<a href=\"http://www.d1.com.cn/result.jsp?productsort=020\" target=\"_blank\" >");  
	  }
	  sb.append(headtxt+"</a></span><i></i>");
	  sb.append("<div class=\"menu\">");
	  sb.append(gettxt(arrcode[5],10));
	  sb.append("</div></div>");
	    sb.append("<div class=\"body\">");
		sb.append("<div class=\"bigl\">");
		sb.append("<div class=\"minl\">");
	    sb.append(getimg(arrcode[0],1));
		sb.append("<div class=\"txt\">");
		sb.append(gettxt(arrcode[1],18));
		sb.append("</div></div>");
		sb.append("<div class=\"minr\">");
		sb.append(getimg(arrcode[2],1));
		sb.append("</div></div>");
		sb.append("<div class=\"bigr\">");
		sb.append(getimg(arrcode[3],1));
		sb.append(getimg(arrcode[4],1));
		sb.append("</div></div>");
	return sb.toString();
}
%>