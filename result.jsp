<%@ page contentType="text/html; charset=UTF-8" import="java.util.regex.Matcher,java.util.regex.Pattern,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="inc/header.jsp"%>
<%!
public static int getCommentListNew(String productId ,Date times){
	if(Tools.isNull(productId)) return 0;
	
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_gdsid", productId));
	listRes.add(Restrictions.eq("gdscom_status", new Long(1)));		
    Calendar c=Calendar.getInstance();
    c.setTime(times);
	c.add(Calendar.DATE,-20);
	listRes.add(Restrictions.ge("gdscom_createdate", c.getTime()));
	return Tools.getManager(Comment.class).getLength(listRes);
}
public static ArrayList<CommentGroup> getCommentGroupListBygdsid(String gdsid)
{
	   ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(gdsid!=null&&gdsid.length()>0&&Tools.isNumber(gdsid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_gdsid",gdsid));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 10000);
	
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				  rlist.add((CommentGroupSub)b); 
		         
				}
			}
		}
		else return null;
		ArrayList<CommentGroup> cglist1=new ArrayList<CommentGroup>();
		if(rlist!=null&&rlist.size()>0)
		{
			for(CommentGroupSub cgs:rlist)
			{
				if(cgs!=null)
				{
					CommentGroup cg=(CommentGroup)Tools.getManager(CommentGroup.class).get(cgs.getCommentgroupsub_cgid().toString());
					if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1){
						cglist1.add(cg);
					}
					
				}
			}
			return cglist1;
		}
		else {
			return null;
		}
}
public static ArrayList<CommentGroupSub> getCommentGroupSubList(String subid)
{
	 ArrayList<CommentGroupSub> rlist=new   ArrayList<CommentGroupSub>();
	   List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
	   if(subid!=null&&subid.length()>0&&Tools.isNumber(subid))
	   {
		  clist.add(Restrictions.eq("commentgroupsub_cgid",new Long(subid)));
		  clist.add(Restrictions.eq("commentgroupsub_flag",new Long(1)));
	   }
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("commentgroupsub_createtime"));
		List<BaseEntity> blist=Tools.getManager(CommentGroupSub.class).getList(clist, olist, 0, 100);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
				rlist.add((CommentGroupSub)b); 
				}
			}
		}
		return rlist;
}
public static int getCommentcount(String gdsid)
{
	int count=0;
    if(gdsid==null||gdsid.length()<=0||!Tools.isNumber(gdsid))
    {
    	return count;
    }
    Product product=ProductHelper.getById(gdsid);

    ArrayList<CommentGroup> cglist=new ArrayList<CommentGroup>();
    cglist=getCommentGroupListBygdsid(gdsid);
  
    if(cglist!=null&&cglist.size()>0)
    {
    	for(CommentGroup cg:cglist)
    	{
    		if(cg!=null&&cg.getCommentgroup_flag()!=null&&cg.getCommentgroup_flag().longValue()==1)
    		{
    			ArrayList<CommentGroupSub> cgslist=getCommentGroupSubList(cg.getId());
    			if(cgslist!=null&&cgslist.size()>0)
    			{
    				for(CommentGroupSub cgs:cgslist)
    				{
    					if(cgs!=null&&cgs.getCommentgroupsub_flag()!=null&&cgs.getCommentgroupsub_flag().longValue()==1
    							&&cgs.getCommentgroupsub_gdsid()!=null&&cgs.getCommentgroupsub_gdsid().length()>0&&!cgs.getCommentgroupsub_gdsid().equals(gdsid))
    					{
    						Product p=ProductHelper.getById(cgs.getCommentgroupsub_gdsid().trim());
    						if(p!=null)
    						{
    							Date times=product.getGdsmst_createdate()!=null?product.getGdsmst_createdate():new Date();
    							count+=getCommentListNew(cgs.getCommentgroupsub_gdsid(),times);
    						}
    						
    					}
    				}
    			}
    		}
    	}
    }
    count+=CommentHelper.getCommentLength(gdsid);
    return count;
}
/**
 * 按照销量比较商品，销量是计算出来的
 * @author cg
 *
 */
public static class SalesBrandComparator implements Comparator<Brand>{
	 
	 //销售排行map
	private Map<String,Long> saleMap = null;
	
	public SalesBrandComparator(Map<String,Long> saleMap){
		this.saleMap = saleMap;
	}

	@Override
	public int compare(Brand p0, Brand p1) {
		long l0 = Tools.longValue(saleMap.get(Tools.trim(p0.getBrand_name())));
		long l1 = Tools.longValue(saleMap.get(Tools.trim(p1.getBrand_name())));
		if(l0>l1){
			return -1 ;
		}else if(l0==l1){
			return 0 ;
		}else{
			return 1 ;
		}
	}
}
public static class ProductComparator implements Comparator<Product>{

		@Override
		public int compare(Product p0, Product p1) {	
			float p0s=0f;
			float p0sv=0f;
			float p1s=0f;
			float p1sv=0f;
			if(p0.getGdsmst_sortxs()!=null)p0s=p0.getGdsmst_sortxs().floatValue();
			if(p0.getGdsmst_sortxsv()!=null)p0sv=p0.getGdsmst_sortxsv().floatValue();
			if(p1.getGdsmst_sortxs()!=null)p1s=p1.getGdsmst_sortxs().floatValue();
			if(p1.getGdsmst_sortxsv()!=null)p1sv=p1.getGdsmst_sortxsv().floatValue();
			if(p0s+p0sv>p1s+p1sv){
				return 1 ;
			}else if(p0s+p0sv==p1s+p1sv){
				return 0 ;
			}else{
				return -1 ;
			}
		}
	}
private static String urlrepstr(String url){
	if(Tools.isNull(url))return "";
	if(url.endsWith("&"))url=url.substring(0,url.length()-1);
	url=url.replace("?&", "?");
	url=url.replace("&&", "&");
	
	return url;
}

//获取推荐位
public static ArrayList<SplRck> GetPRckList(String splcode)
{
	ArrayList<SplRck> list=new ArrayList<SplRck>();
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.eq("splrck_rackcode", splcode));
	List<Order> olist=new ArrayList<Order>();
	olist.add(Order.asc("splrck_seq"));
	List<BaseEntity> b_list = Tools.getManager(SplRck.class).getList(clist, olist, 0, 100);
	if(b_list!=null){
		for(BaseEntity be:b_list){
					list.add((SplRck)be);
	     }
	}
	return list;
}
public static boolean getmsflag(Product p){
	Date nowday=new Date();
	 boolean ismiaoshao=false;
	 SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
	 if(p.getGdsmst_promotionstart()!=null&&p.getGdsmst_promotionend()!=null&&p.getGdsmst_msprice()!=null){
	 	Date sdate=p.getGdsmst_promotionstart();
	 	Date edate=p.getGdsmst_promotionend();	

	 	if(nowday.getTime()>=sdate.getTime()&&edate.getTime()> nowday.getTime()
	 			&&Tools.getDateDiff(ft.format(sdate),ft.format(edate))<31
	 			&&p.getGdsmst_msprice().floatValue()>=0f){
	 		ismiaoshao = true;
	 	}

	 }
	 return ismiaoshao;
	}

//默认顶级分类名
private String CateName = "全部";
private String parentId = "000";

//获得面包屑
private String getCateogryLink(String productsort){
	if(!Tools.isNull(productsort)&&productsort.indexOf(",")>-1){
		productsort = productsort.substring(0,productsort.indexOf(","));
	}
	if(Tools.isNull(productsort) || productsort.length() < 3 || "000".equals(productsort)) return "";
	
	int length = productsort.length();
	boolean isRoot = false;
	if(length >= 3){
		String rackcode = null;
		if(productsort.startsWith("017001")){
			rackcode = "017001";
		}else if(productsort.startsWith("017002")){
			rackcode = "017002";
		}else if(productsort.startsWith("017005")){
			rackcode = "017005";
		}else if(productsort.startsWith("017007")){
			rackcode = "017007";
		}else if(productsort.startsWith("017006")){
			rackcode = "017006";
		}else if(productsort.startsWith("017003")){
			rackcode = "017003";
		}else if(productsort.startsWith("014")){
			rackcode = "014";
		}else if(productsort.startsWith("015009")){
			rackcode = "015009";
		}else if(productsort.startsWith("015002")){
			rackcode = "015002";
		}
		else if(productsort.startsWith("020012")){//女式内衣
			rackcode = "020012";
		}else if(productsort.startsWith("030011")){//男式内衣
			rackcode = "030011";
		}
		else if(productsort.startsWith("020")){//女装
			rackcode = "020";
		}else if(productsort.startsWith("030")){//男装
			rackcode = "030";
		}else if(productsort.startsWith("023")){//女式箱包
			rackcode = "023";
		}else if(productsort.startsWith("021")){//女鞋
			rackcode = "021";
		}else if(productsort.startsWith("022")){//女配饰
			rackcode = "022";
		}else if(productsort.startsWith("032")){//男配饰
			rackcode = "032";
		}
		if(rackcode != null){
			Directory dir = DirectoryHelper.getById(rackcode);
			if(dir != null){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
				isRoot = true;
			}
		}
	}
	
	StringBuilder sb = new StringBuilder();
	for(int i=3;i<=length;i=i+3){
		String rackcode = productsort.substring(0,i);
		Directory dir = DirectoryHelper.getById(rackcode);
		if(dir != null){
			if(!isRoot && i==(length-6<3?3:length-6)){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
			}
			sb.append("<b>&gt;</b><a href=\"");
			if("014".equals(rackcode)){
				sb.append("/html/cosmetic/");
			}else if("015".equals(rackcode)){
				sb.append("/html/ornament/");
			}else if("017".equals(rackcode)){
				sb.append("/html/cloth/");
			}else{
				sb.append("/result.jsp?productsort=").append(rackcode);
			}
			if(productsort.equals(rackcode)){
				sb.append("\" class=\"dis\"");
			}else{
				sb.append("\"");
			}
			sb.append(" style=\"color:#892E3F\" target=\"_blank\">&nbsp;").append(dir.getRakmst_rackname()).append("&nbsp;</a>");
		}
	}
	return sb.toString();
}

//获得面包屑
private String getCateogryLink1(String productsort){
	if(!Tools.isNull(productsort)&&productsort.indexOf(",")>-1){
		productsort = productsort.substring(0,productsort.indexOf(","));
	}
	if(Tools.isNull(productsort) || productsort.length() < 3 || "000".equals(productsort)) return "";
	
	int length = productsort.length();
	boolean isRoot = false;
	if(length >= 3){
		String rackcode = null;
		if(productsort.startsWith("017001")){
			rackcode = "017001";
		}else if(productsort.startsWith("017002")){
			rackcode = "017002";
		}else if(productsort.startsWith("017005")){
			rackcode = "017005";
		}else if(productsort.startsWith("017007")){
			rackcode = "017007";
		}else if(productsort.startsWith("017006")){
			rackcode = "017006";
		}else if(productsort.startsWith("017003")){
			rackcode = "017003";
		}else if(productsort.startsWith("014")){
			rackcode = "014";
		}else if(productsort.startsWith("015009")){
			rackcode = "015009";
		}else if(productsort.startsWith("015002")){
			rackcode = "015002";
		}
		else if(productsort.startsWith("020012")){//女式内衣
			rackcode = "020012";
		}else if(productsort.startsWith("030011")){//男式内衣
			rackcode = "030011";
		}
		else if(productsort.startsWith("020")){//女装
			rackcode = "020";
		}else if(productsort.startsWith("030")){//男装
			rackcode = "030";
		}else if(productsort.startsWith("023")){//女式箱包
			rackcode = "023";
		}else if(productsort.startsWith("021")){//女鞋
			rackcode = "021";
		}else if(productsort.startsWith("022")){//女配饰
			rackcode = "022";
		}else if(productsort.startsWith("032")){//男配饰
			rackcode = "032";
		}
		if(rackcode != null){
			Directory dir = DirectoryHelper.getById(rackcode);
			if(dir != null){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
				isRoot = true;
			}
		}
	}
	
	StringBuilder sb = new StringBuilder();
	for(int i=3;i<=length;i=i+3){
		String rackcode = productsort.substring(0,i);
		Directory dir = DirectoryHelper.getById(rackcode);
		if(dir != null){
			String dirparent=dir.getRakmst_parentrackcode();
			if(!isRoot && i==(length-6<3?3:length-6)){
				CateName = dir.getRakmst_rackname();
				parentId = dir.getId();
			}
			if(!rackcode.equals("015")){
				if(i==3){
					sb.append("<p style=\"float:left\">");
			      }else{
					sb.append("<span>");
				}
				sb.append("&nbsp;&nbsp;<b>&gt;</b>&nbsp;&nbsp;<a  attr=\""+rackcode+"\" href=\" ");
				if("014".equals(rackcode)){
					sb.append("/html/cosmetic/");
				}else if("015".equals(rackcode)){
					sb.append("/html/ornament/");
				}else if("017".equals(rackcode)){
					sb.append("/html/cloth/");
				}else{
					sb.append("/result.jsp?productsort=").append(rackcode);
				}
				if(productsort.equals(rackcode)){
					sb.append("\" class=\"dis rmenuhead no\" ");
				}else{
					sb.append("\" class=\"rmenuhead no\" ");
				}
				sb.append(">").append(dir.getRakmst_rackname()).append(rackcode.length()>3?"<b></b>":"").append("</a>");
				if(!dirparent.equals("0")&&i>3){
					ArrayList<Directory> dirplist= DirectoryHelper.getByParentrackcode(dirparent);
					if(dirplist!=null&&dirplist.size()>0){
					  sb.append("<div class=\"rmenurck\" style=\"display:none\" id=\"rmenurck"+rackcode+"\">");
					  for(Directory dirp:dirplist){
						  sb.append("<a href=\"/result.jsp?productsort="+dirp.getId()+"\" target=\"_blank\">");
					      sb.append(dirp.getRakmst_rackname().trim()+"</a>");
					  }
					  sb.append("</div>");
					}
					}
				if(i==3){
					sb.append("</p>");
			      }else{
					sb.append("</span>");
				}
			}
			
		}
	}
	return sb.toString();
}
//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	

public static String getpricestrmap(Map<String,String> priceMap){
    String pricestr="0-";
	int prnum=0;
	 if(Tools.parseInt(priceMap.get("price1"))>3){
		 pricestr=pricestr+"49,50-";
	 }else{
		 prnum=Tools.parseInt(priceMap.get("price1"));
	 }
	 if(Tools.parseInt(priceMap.get("price2"))+prnum>3){
		 pricestr=pricestr+"99,100-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price2"));
	 }
	 if(Tools.parseInt(priceMap.get("price3"))+prnum>3){
		 pricestr=pricestr+"199,200-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price3"));
	 }
	 if(Tools.parseInt(priceMap.get("price4"))+prnum>3){
		 pricestr=pricestr+"299,300-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price4"));
	 }
	 if(Tools.parseInt(priceMap.get("price5"))+prnum>3){
		 pricestr=pricestr+"399,400-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price5"));
	 }
	 if(Tools.parseInt(priceMap.get("price6"))+prnum>3){
		 pricestr=pricestr+"499,500-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price6"));
	 }
	 if(Tools.parseInt(priceMap.get("price7"))+prnum>3){
		 pricestr=pricestr+"599,600-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price7"));
	 }
	 if(Tools.parseInt(priceMap.get("price8"))+prnum>3){
		 pricestr=pricestr+"799,800-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price8"));
	 }
	 if(Tools.parseInt(priceMap.get("price9"))+prnum>3){
		 pricestr=pricestr+"999,1000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price9"));
	 }
	 if(Tools.parseInt(priceMap.get("price10"))+prnum>3){
		 pricestr=pricestr+"1999,2000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price10"));
	 }
	 if(Tools.parseInt(priceMap.get("price11"))+prnum>3){
		 pricestr=pricestr+"2999,3000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price11"));
	 }
	 if(Tools.parseInt(priceMap.get("price12"))+prnum>3){
		 pricestr=pricestr+"3999,4000-";
		 prnum=0;
	 }else{
		 prnum+=Tools.parseInt(priceMap.get("price12"));
	 }
	 if(Tools.parseInt(priceMap.get("price13"))+prnum>3&&Tools.parseInt(priceMap.get("price14"))>=3){
		 pricestr=pricestr+"4999,5000-";
		
	 }
	 prnum+=Tools.parseInt(priceMap.get("price13"));
	 prnum+=Tools.parseInt(priceMap.get("price14"));
	 if(prnum==0){
		 pricestr=pricestr.substring(0,pricestr.length()-1);
		 pricestr=pricestr.substring(0,pricestr.lastIndexOf("-")+1);
		 
	 }
	 
	return pricestr;
}

private static String repbrandstr(String bkeywords){
	if(Tools.isNull(bkeywords))return "";
	String 	regEx_html = "（[^）]+）";
	Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);  
    Matcher m_html = p_html.matcher(bkeywords);  
    bkeywords = m_html.replaceAll(""); 
    bkeywords=bkeywords.replace("系列", "");
    return bkeywords;
}

//搜索物品。
//返回一个Object数组，第一个是物品的List，第二个是品牌Set，第三个是该品牌下的所有分类
private static Object[] getResultProductList(String productprice,String productname,String rackcode, String brand_name, String fg1, String fg2, String fg3, String fg4, String fg5, String fg6, String fg7, String fg8, String fg9, String fg10, String fg11, String fg12, String order, int start, int pagesize,HttpServletRequest request,String brandcode,String msflag,String shopd1,String bkey,String iftkt){
	if(!Tools.isNull(productprice))productprice=productprice.replace("以上","-50000");
	Object[] obj = new Object[]{null,null,null,null,null,null};
	
	ProductManager manager = (ProductManager)ProductHelper.manager;
	if(manager == null) return obj;
	
	String[] rackcodes = rackcode.split(",");
	List<Product> list = new ArrayList<Product>();
	
	if(brand_name!=null)brand_name = brand_name.trim();
	if(brandcode!=null)brandcode = brandcode.trim();
	
	
	HashMap<String,Integer> brandDirMap = new HashMap<String,Integer>();//key=rackcode,value=商品总数
	HashMap<String,String> stdsMap = new HashMap<String,String>();
	HashMap<String,String>  rckMap =new HashMap<String,String>();
	HashMap<String,String>  priceMap =new HashMap<String,String>();
	HashMap<String,Integer>  bkeyMap =new HashMap<String,Integer>();
	String bkeywords="";
	/*if(!Tools.isNull(brandcode)){
		BrandMst brandm=(BrandMst)Tools.getManager(BrandMst.class).get(brandcode);
		if(brandm!=null){
			bkeywords=brandm.getBrandmst_keywords();
			if(!Tools.isNull(bkeywords)){
				bkeywords=bkeywords.replace(",", "，");
				String bkeyarr[]=bkeywords.split("，");
				int bkeylen=bkeyarr.length;
				for(int i=0;i<bkeylen;i++){
					bkeyMap.put(bkeyarr[i], 0);
				}
			}
		}
	}*/
	
	for(int i=1;i<=12;i++){
		stdsMap.put("stdv"+i,"");
	}
	//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	
			for(int i=1;i<=14;i++){
				priceMap.put("price"+i,"0");
			}
	List<Product> list_i = manager.getTotalProductList();
	
	if(rackcodes!=null&&rackcodes.length>0){
		for(int i=0;i<rackcodes.length;i++){
			if(list_i!=null){
				for(Product p_i:list_i){
					if((brand_name!=null&&p_i.getGdsmst_brandname()!=null&&brand_name.equalsIgnoreCase(p_i.getGdsmst_brandname().trim()))
							||(brandcode!=null&&p_i.getGdsmst_brand()!=null&&brandcode.equals(p_i.getGdsmst_brand()))){
						if(brandDirMap.containsKey(p_i.getGdsmst_rackcode())){
	                        Integer iy123 = brandDirMap.get(p_i.getGdsmst_rackcode());
	                        brandDirMap.put(p_i.getGdsmst_rackcode(), new Integer(iy123.intValue()+1));
		                }else{
		                    brandDirMap.put(p_i.getGdsmst_rackcode(), new Integer(1));
		                }
					}
					if(Tools.longValue(p_i.getGdsmst_validflag())==1){
						if(p_i.getGdsmst_rackcode()!=null&&p_i.getGdsmst_rackcode().startsWith(rackcodes[i])){
							list.add(p_i);	
						}
					}
								
				}
			}
		}
	}

	if(list == null || list.isEmpty()) return obj;
	
	Brand brand = null;
	if(!Tools.isNull(brand_name)){
		brand = BrandHelper.getBrandByName(brand_name);
	}
	if(!Tools.isNull(brandcode)){
		brand = BrandHelper.getBrandByCode(brandcode);
	}
	List<Product> productList = new ArrayList<Product>();
	//最终结果
	List<Product> productListr = new ArrayList<Product>();
	List<Product> pListf = new ArrayList<Product>();//feelmind
	List<Product> pLista = new ArrayList<Product>();//xiaolishe
	List<Product> pLists = new ArrayList<Product>();//诗若漫
	List<Product> pListall = new ArrayList<Product>();//全部
	Set<Brand> brandSet = new HashSet<Brand>();
	 
	//key 品牌，value 销量
	Map<String,Long> saleCount = new HashMap<String,Long>();
     
	for(Product product : list){
		if(Tools.longValue(product.getGdsmst_validflag()) != 1||Tools.longValue(product.getGdsmst_ifhavegds())!=0) continue;
		
		if(!Tools.isNull(brand_name)){
			String p_brand_name = product.getGdsmst_brandname();
			if(p_brand_name!=null)p_brand_name=p_brand_name.toLowerCase().trim();
			if(!brand_name.trim().toLowerCase().equals(p_brand_name)) continue;
		}
		if(!Tools.isNull(brandcode)){
			String p_brand_code = product.getGdsmst_brand();
			if(!brandcode.trim().equals(p_brand_code)) continue;
		}
		
		if(!Tools.isNull(msflag)){
			if(!CartHelper.getmsflag(product))continue;
		}
		
       if(!Tools.isNull(shopd1)){
    	   if(!product.getGdsmst_shopcode().equals("00000000"))continue;
		}
       if(!Tools.isNull(iftkt)){
    	   if(product.getGdsmst_specialflag().longValue()==1)continue;
		}
		String stdvalue1 = product.getGdsmst_stdvalue1();
	
		if(!Tools.isNull(fg1) && (stdvalue1 == null || stdvalue1.indexOf(fg1) == -1)) continue;
		String stdvalue2 = product.getGdsmst_stdvalue2();
		if(!Tools.isNull(fg2) && (stdvalue2 == null || stdvalue2.indexOf(fg2) == -1)) continue;
		String stdvalue3 = product.getGdsmst_stdvalue3();
		if(!Tools.isNull(fg3) && (stdvalue3 == null || stdvalue3.indexOf(fg3) == -1)) continue;
		String stdvalue4 = product.getGdsmst_stdvalue4();
		if(!Tools.isNull(fg4) && (stdvalue4 == null || stdvalue4.indexOf(fg4) == -1)) continue;
		String stdvalue5 = product.getGdsmst_stdvalue5();
		if(!Tools.isNull(fg5) && (stdvalue5 == null || stdvalue5.indexOf(fg5) == -1)) continue;
		String stdvalue6 = product.getGdsmst_stdvalue6();
		if(!Tools.isNull(fg6) && (stdvalue6 == null || stdvalue6.indexOf(fg6) == -1)) continue;
		String stdvalue7 = product.getGdsmst_stdvalue7();
		if(!Tools.isNull(fg7) && (stdvalue7 == null || stdvalue7.indexOf(fg7) == -1)) continue;
		String stdvalue8 = product.getGdsmst_stdvalue8();
		if(!Tools.isNull(fg8) && (stdvalue8 == null || stdvalue8.indexOf(fg8) == -1)) continue;
		String stdvalue9 = product.getGdsmst_stdvalue9();
		if(!Tools.isNull(fg9) && (stdvalue9 == null || stdvalue9.indexOf(fg9) == -1)) continue;
		String stdvalue10 = product.getGdsmst_stdvalue10();
		if(!Tools.isNull(fg10) && (stdvalue10 == null || stdvalue10.indexOf(fg10) == -1)) continue;
		String stdvalue11 = product.getGdsmst_stdvalue11();
		if(!Tools.isNull(fg11) && (stdvalue11 == null || stdvalue11.indexOf(fg11) == -1)) continue;
		String stdvalue12 = product.getGdsmst_stdvalue12();
		if(!Tools.isNull(fg12) && (stdvalue12 == null || stdvalue12.indexOf(fg12) == -1)) continue;
		
		if(!Tools.isNull(bkey)&&product.getGdsmst_gdsname().indexOf(repbrandstr(bkey))==-1)continue;
		
		
		if(!Tools.isNull(bkeywords)&&Tools.isNull(bkey)){
			String bkeyarr[]=bkeywords.split("，");
			int bkeylen=bkeyarr.length;
			for(int i=0;i<bkeylen;i++){
			if(product.getGdsmst_gdsname().indexOf(repbrandstr(bkeyarr[i]))>=0){
					bkeyMap.put(bkeyarr[i], bkeyMap.get(bkeyarr[i])+1);
			}
			}
		}
		
		String gdsrck=product.getGdsmst_rackcode();
		int rcklen=rackcode.length()+3;
        if (rackcode.indexOf(",")>=0){
        	String[] arrrck= rackcode.split(",");
			for(int i=0;i<arrrck.length;i++){
			   if(gdsrck.startsWith(arrrck[i]))rcklen=arrrck[i].length()+3;
			}
		}
        if(gdsrck.length()<rcklen)rcklen=rcklen-3;
		if(rckMap!=null&&rckMap.size()>0)
		{
			if(!rckMap.containsKey(gdsrck.substring(0,rcklen))){
				rckMap.put(gdsrck.substring(0,rcklen), gdsrck);
			}
			
		}else{
			rckMap.put(gdsrck.substring(0,rcklen), gdsrck);
		}
		
		if(!Tools.isNull(rackcode)&&rackcode.length()>3){
		if(!Tools.isNull(stdvalue1)){
			stdvalue1=stdvalue1.replace("，", ",");
				String[] arrstd1= stdvalue1.split(",");
				for(int i=0;i<arrstd1.length;i++){
					String stdv=arrstd1[i];
					if(!Tools.isNull(stdv))stdv=stdv.trim();
			       if(!Tools.isNull(stdsMap.get("stdv1"))){
			    	   if(stdsMap.get("stdv1").indexOf(stdv)==-1){
			       
			    	   stdsMap.put("stdv1",stdsMap.get("stdv1")+","+ stdv);
			    	   }
                    }else{
                    	stdsMap.put("stdv1",stdv);
                    }
			}
		}
		if(!Tools.isNull(stdvalue2)){
			stdvalue2=stdvalue2.replace("，", ",");
			String[] arrstd2= stdvalue2.split(",");
			for(int i=0;i<arrstd2.length;i++){
				String stdv=arrstd2[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv2"))){
		    	   if(stdsMap.get("stdv2").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv2",stdsMap.get("stdv2")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv2",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue3)){
			stdvalue3=stdvalue3.replace("，", ",");
			String[] arrstd3= stdvalue3.split(",");
			for(int i=0;i<arrstd3.length;i++){
				String stdv=arrstd3[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv3"))){
		    	   if(stdsMap.get("stdv3").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv3",stdsMap.get("stdv3")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv3",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue4)){
			stdvalue4=stdvalue4.replace("，", ",");
			String[] arrstd4= stdvalue4.split(",");
			for(int i=0;i<arrstd4.length;i++){
				String stdv=arrstd4[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv4"))){
		    	   if(stdsMap.get("stdv4").indexOf(stdv)==-1){
		      
		    	   stdsMap.put("stdv4",stdsMap.get("stdv4")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv4",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue5)){
			stdvalue4=stdvalue4.replace("，", ",");
			String[] arrstd5= stdvalue5.split(",");
			for(int i=0;i<arrstd5.length;i++){
				String stdv=arrstd5[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv5"))){
		    	   if(stdsMap.get("stdv5").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv5",stdsMap.get("stdv5")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv5",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue6)){
			stdvalue6=stdvalue6.replace("，", ",");
			String[] arrstd6= stdvalue6.split(",");
			for(int i=0;i<arrstd6.length;i++){
				String stdv=arrstd6[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv6"))){
		    	   if(stdsMap.get("stdv6").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv6",stdsMap.get("stdv6")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv6",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue7)){
			stdvalue7=stdvalue7.replace("，", ",");
			String[] arrstd7= stdvalue7.split(",");
			for(int i=0;i<arrstd7.length;i++){
				String stdv=arrstd7[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv7"))){
		    	   if(stdsMap.get("stdv7").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv7",stdsMap.get("stdv7")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv7",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue8)){
			stdvalue8=stdvalue8.replace("，", ",");
			String[] arrstd8= stdvalue8.split(",");
			for(int i=0;i<arrstd8.length;i++){
				String stdv=arrstd8[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv8"))){
		    	   if(stdsMap.get("stdv8").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv8",stdsMap.get("stdv8")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv8",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue9)){
			stdvalue9=stdvalue9.replace("，", ",");
			String[] arrstd9= stdvalue9.split(",");
			for(int i=0;i<arrstd9.length;i++){
				String stdv=arrstd9[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv9"))){
		    	   if(stdsMap.get("stdv9").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv9",stdsMap.get("stdv9")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv9",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue10)){
			stdvalue10=stdvalue10.replace("，", ",");
			String[] arrstd10= stdvalue10.split(",");
			for(int i=0;i<arrstd10.length;i++){
				String stdv=arrstd10[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv10"))){
		    	   if(stdsMap.get("stdv10").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv10",stdsMap.get("stdv10")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv10",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue11)){
			stdvalue11=stdvalue11.replace("，", ",");
			String[] arrstd11= stdvalue11.split(",");
			for(int i=0;i<arrstd11.length;i++){
				String stdv=arrstd11[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv11"))){
		    	   if(stdsMap.get("stdv11").indexOf(stdv)==-1){
		       
		    	   stdsMap.put("stdv11",stdsMap.get("stdv11")+","+ stdv);
		    	   }
                }else{
                	stdsMap.put("stdv11",stdv);
                }
		     }
	    }
		if(!Tools.isNull(stdvalue12)){
			stdvalue12=stdvalue12.replace("，", ",");
			String[] arrstd12= stdvalue12.split(",");
			for(int i=0;i<arrstd12.length;i++){
				String stdv=arrstd12[i];
				if(!Tools.isNull(stdv))stdv=stdv.trim();
		       if(!Tools.isNull(stdsMap.get("stdv12"))){
                      if(stdsMap.get("stdv12").indexOf(stdv)==-1){
		    	         stdsMap.put("stdv12",stdsMap.get("stdv12")+","+ stdv);
                      }
                }else{
                	stdsMap.put("stdv12",stdv);

                }
		     }
	    }
		}
			
		 
		
		
		if(!Tools.isNull(brand_name)&&product.getGdsmst_brandname()!=null){
			if(product.getGdsmst_brandname().trim().toLowerCase().indexOf(brand_name.trim().toLowerCase())<0)continue;
		}
		if(!Tools.isNull(brandcode)&&product.getGdsmst_brand()!=null){
			if(product.getGdsmst_brand().trim().indexOf(brandcode.trim())<0)continue;
		}
		if(!Tools.isNull(productname)&&product.getGdsmst_gdsname()!=null){
			if((product.getGdsmst_gdsname()+product.getGdsmst_keyword()).toLowerCase().indexOf(productname.toLowerCase())<0)continue;
		}
		boolean isms=getmsflag(product);
		float pprice=product.getGdsmst_memberprice().floatValue();
		if(isms)pprice=product.getGdsmst_msprice().floatValue();
		if(!Tools.isNull(productprice)&&productprice.indexOf("-")>-1){
			String sprice = productprice.substring(0,productprice.indexOf("-"));
			String eprice = productprice.substring(productprice.indexOf("-")+1);
			
			if(!Tools.isNull(sprice)&&pprice<Tools.parseFloat(sprice))continue;
			
			if(!Tools.isNull(eprice)&&pprice>Tools.parseFloat(eprice))continue;
		}
		
		if("true".equals(request.getParameter("tj"))){//特价商品，不满足特价条件也忽略
			if(product.getGdsmst_discountenddate()!=null&&product.getGdsmst_discountenddate().getTime()-System.currentTimeMillis()>30*Tools.DAY_MILLIS){
				continue;
			}
		}
		
		String bname=product.getGdsmst_brandname().trim();
		//更改产品列表里的排序
		//if(!Tools.isNull(bname)&&bname.length()>0)
		//{
			//if(bname.indexOf("FEEL MIND")>=0)
			//{
				//pListf.add(product);
			//}
			//else if(bname.indexOf("AleeiShe 小栗舍")>=0)
			//{
				//pLista.add(product);
			//}
			//else if(bname.indexOf("诗若漫")>=0)
			//{
				//pLists.add(product);
			//}
			//else
			//{
			//	productList.add(product);
			//}
		//}
		//else
		//{

			//productList.add(product);
		//}
		if(product.getGdsmst_validflag()!=null&&product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1){		
	     	pListall.add(product);
		}		
		
		
		if(brand == null){
			String brand_code = product.getGdsmst_brand();
			if(!Tools.isNull(brand_code)){
				Brand gds_brand = BrandHelper.getBrandByCode(brand_code);
				if(gds_brand != null){
					brandSet.add(gds_brand);
					String brandName = Tools.trim(gds_brand.getBrand_name());
					long sale_count = Tools.longValue(product.getGdsmst_salecount());
					if(saleCount.containsKey(brandName)){
						Long ix = saleCount.get(brandName);
						saleCount.put(brandName, new Long(sale_count+ix.longValue()));
					}else{
						saleCount.put(brandName, new Long(sale_count));
					}
				}
			}
		}
		
        
            if(pprice<=49){
  	         priceMap.put("price1",(Tools.parseInt(priceMap.get("price1"))+1)+"");
            }else if(pprice<=99){
     	         priceMap.put("price2",(Tools.parseInt(priceMap.get("price2"))+1)+"");
            }else if(pprice<=199){
    	         priceMap.put("price3",(Tools.parseInt(priceMap.get("price3"))+1)+"");
            }else if(pprice<=299){
    	         priceMap.put("price4",(Tools.parseInt(priceMap.get("price4"))+1)+"");
            }else if(pprice<=399){
    	         priceMap.put("price5",(Tools.parseInt(priceMap.get("price5"))+1)+"");
            }else if(pprice<=499){
    	         priceMap.put("price6",(Tools.parseInt(priceMap.get("price6"))+1)+"");
            }else if(pprice<=599){
    	         priceMap.put("price7",(Tools.parseInt(priceMap.get("price7"))+1)+"");
            }else if(pprice<=799){
    	         priceMap.put("price8",(Tools.parseInt(priceMap.get("price8"))+1)+"");
            }else if(pprice<=999){
    	         priceMap.put("price9",(Tools.parseInt(priceMap.get("price9"))+1)+"");
            }else if(pprice<=1999){
    	         priceMap.put("price10",(Tools.parseInt(priceMap.get("price10"))+1)+"");
            }else if(pprice<=2999){
    	         priceMap.put("price11",(Tools.parseInt(priceMap.get("price11"))+1)+"");
            }else if(pprice<=3999){
    	         priceMap.put("price12",(Tools.parseInt(priceMap.get("price12"))+1)+"");
            }else if(pprice<=4999){
   	             priceMap.put("price13",(Tools.parseInt(priceMap.get("price13"))+1)+"");  
            }else if(pprice>4999){
  	             priceMap.put("price14",(Tools.parseInt(priceMap.get("price14"))+1)+""); 
            }
            

	}
	
	
	if(Tools.isMath(order)){
		int o = Tools.parseInt(order);
		switch(o){
		      case 6://热销商品升
			Collections.sort(pListall,new SalesComparator());
			productListr.addAll(pListall);
		    case 5 ://上架时间升
			 
			Collections.sort(pListall,new CreateTimeComparator());
			productListr.addAll(pListall);
			break;
			case 4 ://上架时间降
			 
				Collections.sort(pListall,new CreateTimeComparator());
				Collections.reverse(pListall);
				//Collections.sort(pListf,new CreateTimeComparator());
				//Collections.reverse(pListf);
				//Collections.sort(pLista,new CreateTimeComparator());
				//Collections.reverse(pLista);
				//Collections.sort(pLists,new CreateTimeComparator());
				//Collections.reverse(pLists);
				//Collections.sort(productList,new CreateTimeComparator());
				//Collections.reverse(productList);
				//productListr.addAll(pListf);
				//productListr.addAll(pLista);
				//productListr.addAll(pLists);
				//productListr.addAll(productList);
				break;
			case 3://热销商品
				Collections.sort(pListall,new SalesComparator());
				Collections.reverse(pListall);
				//Collections.sort(pListf,new SalesComparator());
				//Collections.reverse(pListf);
				//Collections.sort(pLista,new SalesComparator());
				//Collections.reverse(pLista);
				//Collections.sort(pLists,new SalesComparator());
				//Collections.reverse(pLists);
				//Collections.sort(productList,new SalesComparator());
				//Collections.reverse(productList);
				//productListr.addAll(pListf);
				//productListr.addAll(pLista);
				//productListr.addAll(pLists);
				//productListr.addAll(productList);
				//Collections.sort(productListr , new SalesComparator());
				//Collections.reverse(productListr);
				break;
			case 2://价格，升序
				Collections.sort(pListall , new PriceComparator());
				productListr.addAll(pListall);
				break;
			case 1://价格，倒序
				Collections.sort(pListall , new PriceComparator());
				Collections.reverse(pListall);
				break;
			default:

					Collections.sort(pListall,new ProductComparator());
					Collections.reverse(pListall);
		}
	}
	
	List<Brand> brandList = new ArrayList<Brand>();
	if(brandSet != null){
		brandList.addAll(brandSet);
	}
	
	if(brandList != null && saleCount!=null){
		Collections.sort(brandList,new SalesBrandComparator(saleCount));
	}
	
	obj[0] = pListall;
	obj[1] = brandList;
	obj[2] = stdsMap;
	obj[3] = rckMap;
	obj[4] = priceMap;
	obj[5] =bkeyMap;
	return obj;
}


/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) 
	{
		 if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			 img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
	}
	
	return img;
}

public static String GetPid(String rackcode){
	ArrayList<SplRck> rcklist=new ArrayList<SplRck>();
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("splrck_name", "类目头图"));
	listRes.add(Restrictions.eq("splrck_rackcode", rackcode));
	
	
	List<BaseEntity> list = Tools.getManager(SplRck.class).getList(listRes, null, 0, 1);
	String pid="";
	if(list==null||list.size()==0){
		if(rackcode.length()>3){
			return GetPid(rackcode.substring(0,rackcode.length()-3));
		}
	}else{
		SplRck  srck =(SplRck)list.get(0);
		pid=srck.getId();
		}
	return pid;
}

%><%
request.setCharacterEncoding("GBK");

String productsort = request.getParameter("productsort");
String productsort1=request.getParameter("productsort");
if(!Tools.isNull(productsort)){
	productsort = productsort.trim();
	productsort = Tools.simpleCharReplace(productsort);
	String ps123 = productsort;
	//如果传了多个分类，只取第一个，原来有传多个分类的链接
	if(ps123.indexOf(",")>-1){
		ps123 = ps123.substring(0,ps123.indexOf(","));
	}
	Directory dir = DirectoryHelper.getById(ps123);
	if(dir == null){
		response.sendRedirect("/index.jsp");
		return;
	}
}else{
	response.sendRedirect("/index.jsp");
	return;
}
String productbrand = request.getParameter("productbrand");
String productbrand2=productbrand;

if(!Tools.isNull(productbrand)){
	productbrand = Tools.simpleCharReplace(productbrand);
	productbrand = productbrand.trim();
}
String brand = request.getParameter("brand");
if(!Tools.isNull(brand)){
	Brand bd=(Brand)Tools.getManager(Brand.class).findByProperty("brand_code", brand);
	if(bd!=null)productbrand2=bd.getBrand_name().trim();
	
}


String orderContent = request.getParameter("order");
if(Tools.isNull(orderContent)){

	orderContent="0";
}
String msflag=request.getParameter("msflag");
String shopd1=request.getParameter("shopd1");
String po1 = request.getParameter("productother1");
String bkey=request.getParameter("bkey");
String iftkt=request.getParameter("iftkt");
String stdtitle="";
String postd1="";
if(po1 == null) po1 = request.getParameter("Productother1");
if(!Tools.isNull(po1)) {
	po1 = Tools.simpleCharReplace(po1);
	postd1=po1+",";
	stdtitle=postd1;
}

String po2 = request.getParameter("productother2");
String postd2="";
if(po2 == null) po2 = request.getParameter("Productother2");
if(!Tools.isNull(po2)){
	po2 = Tools.simpleCharReplace(po2);
	postd2=po2+",";
	stdtitle=stdtitle+" "+postd2;
}

String po3 = request.getParameter("productother3");
String postd3="";
if(po3 == null) po3 = request.getParameter("Productother3");
if(!Tools.isNull(po3)){
	po3 = Tools.simpleCharReplace(po3);
	postd3=po3+",";
	stdtitle=stdtitle+" "+postd3;
}

String po4 = request.getParameter("productother4");
String postd4="";
if(po4 == null) po4 = request.getParameter("Productother4");
if(!Tools.isNull(po4)){
	po4 = Tools.simpleCharReplace(po4);
	postd4=po4+",";
	stdtitle=stdtitle+" "+postd4;
}

String po5 = request.getParameter("productother5");
String postd5="";
if(po5 == null) po5 = request.getParameter("Productother5");
if(!Tools.isNull(po5)){
	po5 = Tools.simpleCharReplace(po5);
	postd5=po5+",";
	stdtitle=stdtitle+" "+postd5;
}

String po6 = request.getParameter("productother6");
String postd6="";
if(po6 == null) po6 = request.getParameter("Productother6");
if(!Tools.isNull(po6)){
	po6 = Tools.simpleCharReplace(po6);
	postd6=po6+",";
	stdtitle=stdtitle+" "+postd6;
}

String po7 = request.getParameter("productother7");
String postd7="";
if(po7 == null) po7 = request.getParameter("Productother7");
if(!Tools.isNull(po7)){
	po7 = Tools.simpleCharReplace(po7);
	postd7=po7+",";
	stdtitle=stdtitle+" "+postd7;
}

String po8 = request.getParameter("productother8");
String postd8="";
if(po8 == null) po8 = request.getParameter("Productother8");
if(!Tools.isNull(po8)){
	po8 = Tools.simpleCharReplace(po8);
	postd8=po8+",";
	stdtitle=stdtitle+" "+postd8;
}

String po9 = request.getParameter("productother9");
String postd9="";
if(po9 == null) po9 = request.getParameter("Productother9");
if(!Tools.isNull(po9)){
	po9 = Tools.simpleCharReplace(po9);
	postd9=po9+",";
	stdtitle=stdtitle+" "+postd9;
}

String po10 = request.getParameter("productother10");
String postd10="";
if(po10 == null) po10 = request.getParameter("Productother10");
if(!Tools.isNull(po10)){
	po10 = Tools.simpleCharReplace(po10);
	postd10=po10+",";
	stdtitle=stdtitle+" "+postd10;
}

String po11 = request.getParameter("productother11");
String postd11="";
if(po11 == null) po11 = request.getParameter("productother11");
if(!Tools.isNull(po11)){
	po11 = Tools.simpleCharReplace(po11);
	postd11=po11+",";
	stdtitle=stdtitle+" "+postd11;
}

String po12 = request.getParameter("productother12");
String postd12="";
if(po12 == null) po12 = request.getParameter("Productother12");
if(!Tools.isNull(po12)){
	po12 = Tools.simpleCharReplace(po12);
	postd12=po12+",";
	stdtitle=stdtitle+" "+postd12;
}

stdtitle=stdtitle.replace(",", " ");
stdtitle=stdtitle.replace("，", " ");
String productname = request.getParameter("productname");
if(productname == null) productname = request.getParameter("Productname");

if(productname==null)productname="";
else productname=productname.trim();

String productprice = request.getParameter("productprice");
if(productprice == null) productprice = request.getParameter("Productprice");
if(Tools.isNull(productprice))productprice="";

String img123 = request.getParameter("img");

String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
//////////////
Object[] obj = getResultProductList(productprice,productname,productsort,productbrand,po1,po2,po3,po4,po5,po6,po7,po8,po9,po10,po11,po12,orderContent,0,10,request,brand,msflag,shopd1,bkey,iftkt);

boolean onlyShowBrand = false ;//左侧菜单只显示品牌相关的分类
//if("1".equals(request.getParameter("bf"))&&!Tools.isNull(productbrand))onlyShowBrand = true ;

//获取关键字
String headtitle="";
String topcat="";
if(!Tools.isNull(productsort)&&productsort.indexOf(",")>-1){
		productsort = productsort.substring(0,productsort.indexOf(","));
	}
	if(Tools.isNull(productsort) || productsort.length() < 3 || "000".equals(productsort)) headtitle="";
	
	int length = productsort.length();
	boolean isRoot = false;
	if(length >= 3){
	
		if(productsort != null){
			Directory dir = DirectoryHelper.getById(productsort);
			if(dir != null){
				headtitle = dir.getRakmst_rackname();
				parentId = dir.getRakmst_parentrackcode();
			}
			if(parentId!=null)
			{
				Directory dirs= DirectoryHelper.getById(parentId);
				if(dirs!=null)
				{
					topcat=dirs.getRakmst_rackname();
				}
			}
		}
	}
	


%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<title>【正品行货】<%=!Tools.isNull(productbrand2)?productbrand2+"_":""%><%= headtitle %>_<%= topcat+"("+stdtitle+")" %>_<%= headtitle %>品牌_价格_图片<%  if(request.getParameter("pageno")!=null&&request.getParameter("pageno").length()>0) out.print("-第"+request.getParameter("pageno")+"页"); %>
-D1优尚网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="D1优尚网<%= headtitle %>, <%= topcat %>频道，提供最新款<%= headtitle %>品牌、<%= headtitle %>价格、<%= headtitle %>图片以及<%= headtitle %>搭配图。想通过网上购物买到名牌<%= headtitle %>，又享受比商场优惠得多的价格、比商场更优质的服务？来D1网上购物商城吧！" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css"  />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart2014.js")%>"></script>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/result.js")%>"></script>
<script type="text/javascript"  src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/wapcheck.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript"  src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/rollImageKP.js?"+System.currentTimeMillis())%>"></script>
<script type="text/javascript">

<%if(session.getAttribute("wapurl_flag")==null){%>
if(checkMobile()){
	var url=document.URL;
	var rackcode="";
	 if(url.lastIndexOf("?")>0)
	   {
	        para=url.substring(url.lastIndexOf("?")+1,url.length);
			var arr=para.split("&");
			para="";
			for(var i=0;i<arr.length;i++)
			{
			   if(arr[i].split("=")[0]=="productsort"){
				   rackcode=arr[i].split("=")[1];
			   }
			}
	   }
	 if(rackcode!=""){
	   window.location.href="http://m.d1.cn/wap/result.html?rackcode="+rackcode+"";
	 }
}
<%}%>
var sumWidth =0;
	/*$(function(){
		var wd=window.screen.width;
		if(wd>1200){			
			// document.getElementsByTagName("body")[0].className="root2";
		}
	});
	*/
	
	 function pad(num, n) {
	    var len = num.toString().length;
	    while(len < n) {
	        num = "0" + num;
	        len++;
	    }
	    return num;
	}
   
   function $getid(id)
   {
       return document.getElementById(id);
   }

 //限时抢购
	var the_s=new Array();
	function view_time(the_s_index,objid){
		 if(the_s[the_s_index]>=0){
	        var the_D=Math.floor((the_s[the_s_index]/3600)/24)
	        var the_H=Math.floor((the_s[the_s_index]-the_D*24*3600)/3600);
	        var the_M=Math.floor((the_s[the_s_index]-the_D*24*3600-the_H*3600)/60);
	        var the_S=(the_s[the_s_index]-the_H*3600)%60;
	        html = "";
	        if(the_D!=0) html += the_D+"天 ";
	        if(the_D!=0 || the_H!=0) {html += pad(the_H,2)+"小时"
	        	}else if(the_D==0 && the_H==0){html += "00小时"};
	        if(the_D!=0 || the_H!=0 || the_M!=0){ html += pad(the_M,2)+"分"}
	        else if(the_D==0 && the_H==0 && the_M==0){html += "00分"};
	        html += pad(the_S,2)+ "秒";
	        $getid(objid).innerHTML = html;
	        the_s[the_s_index]--;
	    }
	}
	$(function(){
			var lazyheight = 0; 
			function showload(){ 
			//lazyheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop()); 
			if ($(window).scrollTop()-450>0 ) { 
			$(".brandmleft").show();
			} else{
			$(".brandmleft").hide();	
			}
			} 

			$(window).bind("scroll", function(){ 
			showload();
			}); 

		$('.cm_l>span').mouseover(function(){	
			srck = $(this).find("a").attr('attr');
			$("#rmenurck"+srck).show();
			$(this).css("border","solid 1px #cc0033");
			 $(this).find("a").removeClass("no");
			 $(this).find("a").addClass("on");
		});
		$('.cm_l>span').mouseout(function(){
			srck = $(this).find("a").attr('attr');
			$("#rmenurck"+srck).hide();
			$(this).css("border","solid 1px #ffffff");
			$(this).find("a").removeClass("on");
			$(this).find("a").addClass("no");
		});

	});

		</script>
<style type="text/css">
#imgrollys {height: 300px;width: 100%;overflow: hidden;}
#imgrollys #imgslideys{width: 100%;height: 300px;background-color: white;margin: 0 auto;position: relative;}
#imgRollOuterys{position: absolute;top: 0;height: 300px;width: 100%;z-index: 9;left: 0;overflow: hidden;}
#imgRollOuterys div {height: 300px;margin: 0 auto;width: 100%;overflow: hidden;background: url("") no-repeat scroll center center transparent;}
#imgRollOuterys div a {height: 300px;margin: 0 auto;width: 980px;;display: block;z-index: 99;}
#imgrollys #imgslideys p {margin-right: 50%;bottom: 14px;display: block;position: absolute;right: -89px;z-index: 100;}
#imgrollys .left {background: url("http://images.d1.com.cn/images2012/index2012/13january/white-left.png") no-repeat scroll 0 0 transparent;left: -480px;margin-left: 50%;}
#imgrollys .left, #imgrollys .right {width: 50px;height: 50px;position: absolute;top: 45%;cursor: pointer;z-index: 999;display:none;}
#imgrollys .right {background: url("http://images.d1.com.cn/images2012/index2012/13january/white-right.png") no-repeat scroll 0 0 transparent;right: -480px;margin-right: 50%;}
#imgrollys #imgslideys p a {width: 20px;height: 20px;line-height: 20px;_line-height: 20px;margin-left: 10px;background:url('http://images.d1.com.cn/images2012/index2012/des/y-1.png');color: #FFF7F9;text-align: center;display: inline-block;font-family: Arial;font-size: 12px;}
#imgrollys #imgslideys p a.cur{background:url('http://images.d1.com.cn/images2012/index2012/des/y-2.png');font-weight:bold;}
.cm_l span{padding-right:10px;display:block;position:relative;float:left;}
.cm_l span a.no b{position:absolute;right: 2px;
top: 14px;border-width: 4px 4px 0;
border-style: solid dashed dashed;
border-color: #666 transparent transparent;
}
.cm_l span a.on b{position:absolute;right: 2px;
top: 14px;
border-width: 0 4px 4px;
border-style: dashed dashed solid;
border-color: transparent transparent #aa2e44;
}
.rmenurck{position:absolute;top:32px;left:0px;border:1px solid #cc0033;background:#fff;padding:5px;width:360px;z-index:1000}
.rmenurck a{width:120px;display:block;height:30px;float:left;}


.brandmleft{display:none;position: fixed;_position: absolute;left: 50%;margin-left:-650px;top: 20px;width: 150px;font-size: 12px;_top: expression(documentElement.scrollTop+documentElement.clientHeight-this.offsetHeight);overflow: hidden;z-index: 200000;}
</style>
</head>

<body style=" margin:0px auto; background:#fff;">

<%@include file="inc/head.jsp" %>

<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/result2014.css")%>" rel="stylesheet" type="text/css"  />
<a name="top"></a>
<div class="clear"></div>
 <div class="clsmenu resultw">
   <div class="cm_l f_l">
   <%
   String stdnamestr="";
   Map<String,Object> mapstdn = new HashMap<String,Object>();
   Map<String,Object> mapstdndtl = new HashMap<String,Object>();
   List<ProductStandardHelper.Standard> psList = ProductStandardHelper.getGGByRackcode(productsort);
 	if(psList != null && !psList.isEmpty()){
 		for(ProductStandardHelper.Standard ps : psList){
 			mapstdn.put(ps.getAtrFlag()+"", ps.getAtrname());
 			mapstdndtl.put(ps.getAtrFlag()+"", ps.getAtrdtl());
 		}
 		if(stdnamestr.length()>0){
 		stdnamestr=stdnamestr.substring(0,stdnamestr.length()-1);
 		}
 	}
 	/*String[] arrstdname =null;
 	if(stdnamestr!=null&&stdnamestr.length()>0){
 	arrstdname=stdnamestr.split("@");
 	}*/
   
   
    if(productsort1.indexOf(",")==-1){
%><p style="float:left;"><a href="http://www.d1.com.cn/" target="_blank">首页</a></p>
            	<%
            	 if(!onlyShowBrand)out.print(getCateogryLink1(productsort));
            	else{
            		out.print("&nbsp;&nbsp;<b>&gt;</b>&nbsp;&nbsp;<a href='###' class='dis'>"+productbrand+"</a>");
            	}%>
  
	<%} %> </div><div class="cstd_l f_l">
	<%
	String stdurl="";
	if(!Tools.isNull(po1)&&mapstdn.get("1")!=null&&!Tools.isNull(mapstdn.get("1").toString())) {
		stdurl= ggURL.replaceAll("productother1=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("1")+":"+po1 %><b></b></a></span>
	<%} 
	if(!Tools.isNull(po2)&&mapstdn.get("2")!=null&&!Tools.isNull(mapstdn.get("2").toString())) {
		stdurl= ggURL.replaceAll("productother2=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("2")+":"+po2 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po3)&&mapstdn.get("3")!=null&&!Tools.isNull(mapstdn.get("3").toString())) {
		stdurl= ggURL.replaceAll("productother3=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("3")+":"+po3 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po4)&&mapstdn.get("4")!=null&&!Tools.isNull(mapstdn.get("4").toString())) {
		stdurl= ggURL.replaceAll("productother4=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("4")+":"+po4 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po5)&&mapstdn.get("5")!=null&&!Tools.isNull(mapstdn.get("5").toString())) {
		stdurl= ggURL.replaceAll("productother5=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("5")+":"+po5 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po6)&&mapstdn.get("6")!=null&&!Tools.isNull(mapstdn.get("6").toString())) {
		stdurl= ggURL.replaceAll("productother6=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("6")+":"+po6 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po7)&&mapstdn.get("7")!=null&&!Tools.isNull(mapstdn.get("7").toString())) {
		stdurl= ggURL.replaceAll("productother7=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("7")+":"+po7 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po8)&&mapstdn.get("8")!=null&&!Tools.isNull(mapstdn.get("8").toString())) {
		stdurl= ggURL.replaceAll("productother8=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("8")+":"+po8 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po9)&&mapstdn.get("9")!=null&&!Tools.isNull(mapstdn.get("9").toString())) {
		stdurl= ggURL.replaceAll("productother9=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("9")+":"+po9 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po10)&&mapstdn.get("10")!=null&&!Tools.isNull(mapstdn.get("10").toString())) {
		stdurl= ggURL.replaceAll("productother10=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("10")+":"+po10 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po11)&&mapstdn.get("11")!=null&&!Tools.isNull(mapstdn.get("11").toString())) {
		stdurl= ggURL.replaceAll("productother11=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("11")+":"+po11 %><b></b></a></span>
	<%}
	if(!Tools.isNull(po12)&&mapstdn.get("12")!=null&&!Tools.isNull(mapstdn.get("12").toString())) {
		stdurl= ggURL.replaceAll("productother12=[^&]*","");
		stdurl=urlrepstr(stdurl);
	%>
	<span><a href="<%=stdurl%>"><%=mapstdn.get("12")+":"+po12 %><b></b></a></span>
	<%}
	if(!Tools.isNull(productbrand)){
		stdurl= ggURL.replaceAll("productbrand=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="品牌:"+productbrand %><b></b></a></span>
		<%	
	}
	if(!Tools.isNull(brand)){
		stdurl= ggURL.replaceAll("brand=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="品牌:"+productbrand2 %><b></b></a></span>
		<%	
	}
	if(!Tools.isNull(productprice)){
		stdurl= ggURL.replaceAll("productprice=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="价格:"+productprice %><b></b></a></span>
		<%	
	}
	if(!Tools.isNull(bkey)){
		stdurl= ggURL.replaceAll("bkey=[^&]*","");
		stdurl=urlrepstr(stdurl);
		%>
		<span><a href="<%=stdurl%>"><%="品牌系列:"+bkey %><b></b></a></span>
		<%	
	}
	%>
	
	
	</div>
  <div class="clear"></div>
  </div>

 <!--轮播-->
 <%

 String lbpcode="";
 boolean showad=false;
 if(Tools.isNull(productprice)&&Tools.isNull(productbrand)&&Tools.isNull(brand)
		 &&Tools.isNull(msflag)&&Tools.isNull(shopd1)&&Tools.isNull(request.getParameter("order"))
		 &&Tools.isNull(request.getParameter("pageno"))){
	 showad=true;
 }
 if(productsort.equals("020")&&showad){
 	lbpcode="3687";
 }else if(productsort.equals("030")&&showad){
 	lbpcode="3688";
 }else if(productsort.equals("014")&&showad){
 	lbpcode="3686";
 }else if(productsort.equals("012")&&showad){
 	lbpcode="3689";
 }else if(productsort.equals("021")&&showad){
 	lbpcode="3688";
 }else if(productsort.equals("050")&&showad){
 	lbpcode="3691";
 }else if(productsort.equals("040")&&showad){
 	lbpcode="3690";
 }else if(productsort.equals("015")&&showad){
 	lbpcode="3690";
 }
 ArrayList<Promotion> pttlist=new ArrayList<Promotion>();
 StringBuilder sbtt1219=new StringBuilder();
 StringBuilder sbtt1219img=new StringBuilder();
 if(!Tools.isNull(lbpcode)){

    pttlist=PromotionHelper.getBrandListByCode(lbpcode, 15);//轮播3685
    
    if(pttlist!=null&&pttlist.size()>0)
    { %>
<div id="imgrollys">
	     <div id="imgslideys" style=" background-color: transparent;">
		    <div id="imgRollOuterys">
		    <%  
		    
		    	   for(int i=0;i<pttlist.size();i++)
		    	   {
		    		   Promotion ptt=pttlist.get(i);
		    		   if(ptt!=null)
		    		   {
		    			   out.print("<div  img_index=\""+i+"\" style=\"background:url('"+ptt.getSplmst_picstr()+"') no-repeat center center;\"><a href=\""+ptt.getSplmst_url()+"\" title=\""+Tools.clearHTML(ptt.getSplmst_name())+"\" target=\"_blank\"></a></div>");
		    		       sbtt1219.append("<a href=\""+ptt.getSplmst_url()+"\"  target=\"_blank\" img_index=\""+i+"\" >"+(i+1)+"</a>");
			    		   if(i==pttlist.size()-1)
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\"");
			    		   }
			    		   else
			    		   {
			    			   sbtt1219img.append("\""+ptt.getSplmst_picstr()+"\",");
			    		   }
		    		   }
		    	   }
		     
		    %>
		    </div>
		    <%if(pttlist.size() != 1){%>
		    	<p style="right:-<%=12*pttlist.size() %>px">
		    	<% out.print(sbtt1219.toString()); %>
				</p>
		    <%}%>
		     <div class="imgrollboxys">
			     <div class="left" ></div>
			     <div class="right" ></div>
		     </div>
	     </div>
</div>
<%} 
 }
%>
<!--轮播结束-->

<% boolean showbrand=false;
if(productsort.length()==3&&!Tools.isNull(brand)&&Tools.isNull(productbrand)&&Tools.isNull(po1)&&Tools.isNull(po2)&&Tools.isNull(po3)&&Tools.isNull(po4)&&Tools.isNull(po5)&&Tools.isNull(po6)
  		&&Tools.isNull(po7)&&Tools.isNull(po8)&&Tools.isNull(po9)&&Tools.isNull(po10)&&Tools.isNull(po11)&&Tools.isNull(po12)&&Tools.isNull(bkey)&&Tools.isNull(productprice)){
	 showbrand=true;
} 
String bkeyword="";
BrandMst brandm=null;
if(productsort.length()==3&&!Tools.isNull(brand)){
 brandm=(BrandMst)Tools.getManager(BrandMst.class).get(brand);
 if(brandm!=null){
		bkeyword=brandm.getBrandmst_keywords();
 }
}
if(showbrand){ 
	
	if(brandm!=null){
	if(brandm.getBrandmst_tl()!=null&&brandm.getBrandmst_tl().length()>0){
		
	
	%>
	<style type="text/css">
.rbrandm_bannert {width: 100%;margin:0px auto}
.rbrandm_banner {
	background-repeat: no-repeat;
	background-position: center;
	height:420px;
}

</style>
<div class="rbrandm_bannert" align="center">
<div class="rbrandm_banner" style="background-image:url(<%=brandm.getBrandmst_tl()%>)" >

</div>
</div>
<%	}
	if(brandm.getBrandmst_body()!=null&&brandm.getBrandmst_body().length()>0){
		%>
<div style="margin:0px auto" align="center">
<div style="width:980px;">
<%=brandm.getBrandmst_body() %>
</div>
</div>	
	<%
	}
	if(brandm.getBrandmst_menu()!=null&&brandm.getBrandmst_menu().length()>0){
	%>
	<div class="brandmleft">
	<%=brandm.getBrandmst_menu() %>
	</div>
	<%}
	}
}
%>

<div class="listbody resultw">

  
 
 <div>
 


  <div class="stds m_t10">
  
  <%
 if(!Tools.isNull(brand)&&Tools.isNull(bkey)&&!Tools.isNull(bkeyword)){
	 bkeyword=bkeyword.replace(",", "，");
		String bkeyarr[]=bkeyword.split("，");
		int bkeylen=bkeyarr.length;
		
	 HashMap<String,Integer> bkeymap = (HashMap<String,Integer>)obj[5];
	if(bkeymap != null && bkeymap.size()>0){
		boolean sflag=false;
		for(int i=0;i<bkeylen;i++){
			  if(bkeymap.get(bkeyarr[i])>0){
				  sflag=true;
				  break;
			  }
		}
		if(sflag){
	%>
	<div class="std-attrs" >
       <div class="stda_h">品牌系列
       </div>
       <div  class="stda_vt">
          <ul class="stda_v"><%
          for(int i=0;i<bkeylen;i++){
  			  if(bkeymap.get(bkeyarr[i])<=0)continue;
					String newURL = ggURL.replaceAll("bkey=[^&]*","");
					%>
					 <li><a href="<%=newURL %>&bkey=<%=URLEncoder.encode(bkeyarr[i],"UTF-8") %>" title="<%=bkeyarr[i] %>"  <%if(showbrand)out.print("target=\"_blank\""); %>><%=bkeyarr[i] %></a></li>
        <% 
			}
		%>
			</ul>
       </div>
         <div class="clear"></div>
</div><%}
	  }}%>
  
  <%
  boolean showmenu=false;
  if(Tools.isNull(brand)&&Tools.isNull(productbrand)&&Tools.isNull(po1)&&Tools.isNull(po2)&&Tools.isNull(po3)&&Tools.isNull(po4)&&Tools.isNull(po5)&&Tools.isNull(po6)
  		&&Tools.isNull(po7)&&Tools.isNull(po8)&&Tools.isNull(po9)&&Tools.isNull(po10)&&Tools.isNull(po11)&&Tools.isNull(po12)&&Tools.isNull(bkey)&&Tools.isNull(productprice)){
  	showmenu=true;
  }
   
 List<Directory> dirList1 = new ArrayList<Directory>();		
  if(!productsort.equals("014")||Tools.isNull(brand)&&Tools.isNull(productbrand)){
	  if(productsort.length()==3&&!showmenu||productsort.length()>3||"1".equals(shopd1)){
	dirList1=DirectoryHelper.getByParentcode(productsort);
if(dirList1 != null && !dirList1.isEmpty()){
 Directory dir = DirectoryHelper.getById(productsort);
	if(dir != null){
		CateName = dir.getRakmst_rackname();
	}
	%>
	<div class="std-attrs" >
       <div class="stda_h"><%=CateName %>
       </div>
       <div  class="stda_vt">
          <ul class="stda_v">
	<% 
	int rcknamelen=0;
	int rcklen=0;
	HashMap<String,String> rckmap = (HashMap<String,String>)obj[3];
	//for(int i=0;i<rckmap.size();i++){
	//	System.out.println("resultrck----------------"+rckmap.get((i)+"").toString());

	//}
	for(Directory dir2 : dirList1){
	if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir2.getId())>0){
		
		CateName = dir2.getRakmst_rackname();
	
		String newURL = ggURL.replaceAll("productsort=[^&]*","");
		if(!rckmap.containsKey(dir2.getId()))continue;
		rcknamelen+= dir2.getRakmst_rackname().length();
		rcklen+=1;
		%>
		 <li><a href="<%=newURL %><%=newURL.endsWith("&")||newURL.endsWith("?")?"":"&" %>productsort=<%=dir2.getId() %>" <%if(showbrand)out.print("target=\"_blank\""); %>><%=CateName %></a></li>
		<% 
	}
	}
	%>
	 </ul>
          <%//if((rcknamelen*12+rcklen*20)>740){ %>
           <!-- <div class="stdmore" onclick="stdmore(this);" style="display: block;">更多&nbsp;<span style="font-size:10px">∨</span></div>
       <div class="stdmore" onclick="stdless(this);" style="display: none;">收起&nbsp;<span style="font-size:10px">∧</span></div>
       --><%//} %>
       </div>
         <div class="clear"></div>
</div>
	<%
}
}
}else{
		dirList1=DirectoryHelper.getByParentcode(productsort);
	if(dirList1 != null && !dirList1.isEmpty()){
	 Directory dir = DirectoryHelper.getById(productsort);
	 HashMap<String,String> rckmap = (HashMap<String,String>)obj[3];
	 int k=0;
	 int dllen=dirList1.size();
		for(Directory dir2 : dirList1){
			String rckcodeitem=dir2.getId();
		if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(rckcodeitem)>0){
			if(!rckmap.containsKey(dir2.getId()))continue;
			Object[] objitem = getResultProductList(productprice,productname,rckcodeitem,productbrand,po1,po2,po3,po4,po5,po6,po7,po8,po9,po10,po11,po12,orderContent,0,10,request,brand,msflag,shopd1,bkey,iftkt);
			
			List<Directory>  dirList2=DirectoryHelper.getByParentcode(rckcodeitem);
			 Directory diritem = DirectoryHelper.getById(rckcodeitem);
				if(diritem != null){
					CateName = diritem.getRakmst_rackname();
				}
				String newURL1 = ggURL.replaceAll("productsort=[^&]*","");
					%>
	
				<div class="std-attrs" >
			       <div class="stda_h"><a href="<%=newURL1 %><%=newURL1.endsWith("&")||newURL1.endsWith("?")?"":"&" %>productsort=<%=dir2.getId() %>"  <%if(showbrand)out.print("target=\"_blank\""); %>><%=CateName %></a>
			       </div>
			       <div  class="stda_vt">
			          <ul class="stda_v">
				<% 
				int rcknamelen=0;
				int rcklen=0;
				HashMap<String,String> rckmapitem = (HashMap<String,String>)objitem[3];
                      
				for(Directory diritem2 : dirList2){
				if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(diritem2.getId())>0){
					
					CateName = diritem2.getRakmst_rackname();
				
					String newURL = ggURL.replaceAll("productsort=[^&]*","");
					if(!rckmapitem.containsKey(diritem2.getId()))continue;
					%>
					 <li><a href="<%=newURL %><%=newURL.endsWith("&")||newURL.endsWith("?")?"":"&" %>productsort=<%=diritem2.getId() %>" <%if(showbrand)out.print("target=\"_blank\""); %>><%=CateName %></a></li>
					<% 
				}
				}
				%>
				 </ul>
			       </div>
			         <div class="clear"></div>
			</div>
				<%
			

			String stdnamestritem="";
			   Map<String,Object> mapstdnitem = new HashMap<String,Object>();
			   Map<String,Object> mapstdnitemdtl = new HashMap<String,Object>();
			   List<ProductStandardHelper.Standard> psListitem = ProductStandardHelper.getGGByRackcode(dir2.getId());
			 	if(psListitem != null && !psListitem.isEmpty()){
			 		for(ProductStandardHelper.Standard ps : psListitem){
			 			mapstdnitem.put(ps.getAtrFlag()+"", ps.getAtrname());
			 			mapstdnitemdtl.put(ps.getAtrFlag()+"", ps.getAtrdtl());
			 		}
			 		if(stdnamestritem.length()>0){
			 			stdnamestritem=stdnamestritem.substring(0,stdnamestritem.length()-1);
			 		}
			 	}
	HashMap<String,String> stdsMap2 = (HashMap<String,String>)objitem[2];
	  if(stdsMap2!=null&&stdsMap2.size()>0){
	  //String[] arrstd =retstr.split("@");
	 
		for(int i=0;i<stdsMap2.size();i++){
			if(!Tools.isNull(postd1)&&i==0)continue;
			if(!Tools.isNull(postd2)&&i==1)continue;
			if(!Tools.isNull(postd3)&&i==2)continue;
			if(!Tools.isNull(postd4)&&i==3)continue;
			if(!Tools.isNull(postd5)&&i==4)continue;
			if(!Tools.isNull(postd6)&&i==5)continue;
			if(!Tools.isNull(postd7)&&i==6)continue;
			if(!Tools.isNull(postd8)&&i==7)continue;
			if(!Tools.isNull(postd9)&&i==8)continue;
			if(!Tools.isNull(postd10)&&i==9)continue;
			if(!Tools.isNull(postd11)&&i==10)continue;
			if(!Tools.isNull(postd12)&&i==11)continue;

			
			if(mapstdnitem.get((i+1)+"")==null||Tools.isNull(mapstdnitem.get((i+1)+"").toString()))continue;
			String stdvalues=stdsMap2.get("stdv"+(i+1));
			String stdvalueall=mapstdnitemdtl.get((i+1)+"")!=null?mapstdnitemdtl.get((i+1)+"").toString():"";

			if(Tools.isNull(stdvalues))continue;
			stdvalues=stdvalues.replace("，", ",").replace(" ", "");
			String[] arrstdvalues=stdvalues.split(",");
			if(arrstdvalues.length==0)continue;
			long atrFlag =i+1;
			String newURL = ggURL.replaceAll("productother"+atrFlag+"=[^&]*","");
			newURL=newURL.replaceAll("productsort=[^&]*","");;
	  %>
	    <div class="std-attrs" <%//if (stdshow>5){ out.print("class=\"std-attrs hide\" overfour=\"true\""); }else{ out.print("class=\"std-attrs\"");} %> >
	       <div class="stda_h"><%=mapstdnitem.get((i+1)+"") %>
	       </div>
	       <div class="stda_vt" id="stda_v<%=i%>">
	          <ul class="stda_v">
	          <%
	         int stdlen=0;
	          String stdkeys=",";
	          for(int j=0;j<arrstdvalues.length;j++){
	        	  stdlen+= arrstdvalues[j].length();
	        	  if(stdkeys.indexOf(","+arrstdvalues[j]+",")==-1){
	        	  stdkeys+=arrstdvalues[j]+",";
	        	  }else{
	        		  continue;
	        	  }
	        	  if(stdvalueall.indexOf(arrstdvalues[j])==-1) continue;
	        	  %>
	             <li><a href="<%=newURL %>&productsort=<%=rckcodeitem %>&productother<%=atrFlag %>=<%=URLEncoder.encode(arrstdvalues[j],"UTF-8") %>" rel="nofollow" <%if(showbrand)out.print("target=\"_blank\""); %>><%=arrstdvalues[j] %></a></li>
	             <%}
	          %>
	          </ul>
	       </div>
	         <div class="clear"></div>
	    </div>
	    <%
			
			}
		
}
}
		k++	;
		
}
}
}

ArrayList<SplRck> r_prcklist=new ArrayList<SplRck>();
ArrayList<Promotion> r_plist=new ArrayList<Promotion>();



String rckcode="";
if(productsort.equals("020")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016007";
}else if(productsort.equals("030")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016008";
}else if(productsort.equals("014")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016009";
}else if(productsort.equals("012a")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016012";
}else if(productsort.equals("050")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016010";
}else if(productsort.equals("040")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016011";
}else if(productsort.equals("015")&&showmenu&&!"1".equals(shopd1)){
	rckcode="013016011";
}
r_prcklist.clear();
r_prcklist=GetPRckList(rckcode);

String npcode=",3521,3522,3523,3524,3525,3526,3527,3528,3529,";

if(r_prcklist!=null&&r_prcklist.size()>0)
{
	for(int j=1;j<r_prcklist.size()-1;j++)
	{
		SplRck  srl=r_prcklist.get(j);
		if(npcode.indexOf(","+srl.getId()+",")==-1){
		 r_plist.clear();
		 r_plist=PromotionHelper.getBrandListByCode(srl.getId(),-1);
		 if( r_plist!=null&& r_plist.size()>0)
		 { 
			 int rcknamelen=0;
				int rcklen=0;
		     for(int i=0;i<r_plist.size();i++)
			 {
				 Promotion p=r_plist.get(i);
				 if(p!=null)
				 { 
					 
					
	             	rcknamelen+= p.getSplmst_name().length();
							rcklen+=1;
if(i==0){
	String splurl=p.getSplmst_url();
	if(!Tools.isNull(splurl))splurl=splurl.trim();
	%>
	<div class="std-attrs" >
     <div class="stda_h"><%=splurl.equals("#")||Tools.isNull(splurl)?p.getSplmst_name():"<a href=\""+ splurl+"\" target=\"_blank\" >"+p.getSplmst_name()+"</a>" %>
     </div>
     <div  class="stda_vt">
          <ul class="stda_v">
<%  }else{

		%>
		 <li><a href="<%= p.getSplmst_url()!=null?p.getSplmst_url():"" %>" target="_blank" ><%=p.getSplmst_name() %></a></li>
		<% 
	}
	}}
	%>
	 </ul>
        <%//if((rcknamelen*12+rcklen*20)>740){ %>
        <!--  <div class="stdmore" onclick="stdmore(this);" style="display: block;">更多&nbsp;<span style="font-size:10px">∨</span></div>
     <div class="stdmore" onclick="stdless(this);" style="display: none;">收起&nbsp;<span style="font-size:10px">∧</span></div>
   -->
    <%//} 
        %>
          </div>
       <div class="clear"></div>
</div>
  <%}
	}}
}


if(productsort.length()>3){
	List<Brand> brandList = (List<Brand>)obj[1];
	if(brandList != null && !brandList.isEmpty()){
	%>
	<div class="std-attrs" >
       <div class="stda_h">品牌
       </div>
       <div  class="stda_vt">
          <ul class="stda_v"><%
			int i = 0;
          int brandlen=0;
          int rcknamelen=0;
       	int rcklen=0;
				for(Brand brand2 : brandList){
					if(brand2!=null){			
					
					String brand_name = brand2.getBrand_name();
					String brand_code=brand2.getBrand_code();
					if(brand_name != null) brand_name = brand_name.trim();
					if(brand_code != null) brand_code = brand_code.trim();
					brandlen+= brand_name.length();
					i++;
					String newURL = ggURL.replaceAll("productbrand=[^&]*","");
					rcknamelen+= brand_name.length();
		    		rcklen+=1;
					%>

					 <li><a href="<%=newURL %>&brand=<%=brand_code %>" title="<%=brand_name %>" <%if(showbrand)out.print("target=\"_blank\""); %>><%=brand_name %></a></li>
<%
					}
			}
		%>
			</ul>
          <%if((rcknamelen*12+rcklen*20)>1600){ %>
       <div class="stdmore" onclick="stdmore(this);" style="display: block;">更多&nbsp;<span style="font-size:10px">∨</span></div>
       <div class="stdmore" onclick="stdless(this);" style="display: none;">收起&nbsp;<span style="font-size:10px">∧</span></div>
        <%} %>
       </div>
         <div class="clear"></div>
</div><%
	  }}



if(!productsort.equals("014")||Tools.isNull(brand)&&Tools.isNull(productbrand)){
  int stdshow=0;
  HashMap<String,String> stdsMap = (HashMap<String,String>)obj[2];
  if(stdsMap!=null&&stdsMap.size()>0){
  //String[] arrstd =retstr.split("@");
 
	for(int i=0;i<stdsMap.size();i++){
		if(!Tools.isNull(postd1)&&i==0)continue;
		if(!Tools.isNull(postd2)&&i==1)continue;
		if(!Tools.isNull(postd3)&&i==2)continue;
		if(!Tools.isNull(postd4)&&i==3)continue;
		if(!Tools.isNull(postd5)&&i==4)continue;
		if(!Tools.isNull(postd6)&&i==5)continue;
		if(!Tools.isNull(postd7)&&i==6)continue;
		if(!Tools.isNull(postd8)&&i==7)continue;
		if(!Tools.isNull(postd9)&&i==8)continue;
		if(!Tools.isNull(postd10)&&i==9)continue;
		if(!Tools.isNull(postd11)&&i==10)continue;
		if(!Tools.isNull(postd12)&&i==11)continue;

		
		if(mapstdn.get((i+1)+"")==null||Tools.isNull(mapstdn.get((i+1)+"").toString()))continue;
		String stdvalues=stdsMap.get("stdv"+(i+1));
		String stdvalueall=mapstdndtl.get((i+1)+"")!=null?mapstdndtl.get((i+1)+"").toString():"";
		if(Tools.isNull(stdvalues))continue;
		stdvalues=stdvalues.replace("，", ",").replace(" ", "");
		String[] arrstdvalues=stdvalues.split(",");
		if(arrstdvalues.length==0)continue;
		long atrFlag =i+1;
		String newURL = ggURL.replaceAll("productother"+atrFlag+"=[^&]*","");
		stdshow+=1;
  %>
    <div class="std-attrs" <%//if (stdshow>5){ out.print("class=\"std-attrs hide\" overfour=\"true\""); }else{ out.print("class=\"std-attrs\"");} %> >
       <div class="stda_h"><%=mapstdn.get((i+1)+"") %>
       </div>
       <div class="stda_vt" id="stda_v<%=i%>">
          <ul class="stda_v">
          <%
         int stdlen=0;
          String stdkeys=",";
          for(int j=0;j<arrstdvalues.length;j++){
        	  stdlen+= arrstdvalues[j].length();
        	  if(stdkeys.indexOf(","+arrstdvalues[j]+",")==-1){
        	  stdkeys+=arrstdvalues[j]+",";
        	  }else{
        		  continue;
        	  }
        	  if(stdvalueall.indexOf(arrstdvalues[j])==-1)continue;
        	  %>
             <li><a href="<%=newURL %>&productother<%=atrFlag %>=<%=URLEncoder.encode(arrstdvalues[j],"UTF-8") %>" rel="nofollow"  <%if(showbrand)out.print("target=\"_blank\""); %>><%=arrstdvalues[j] %></a></li>
             <%}
          %>
          </ul>
          <%//if((stdlen*12+arrstdvalues.length*20)>740){ %>
<!-- 
           <div class="stdmore" id="mstdmore<%=i%>" onclick="stdmore(this);" style="display: block;">更多&nbsp;<span style="font-size:10px">∨</span></div>
       <div class="stdmore" id="sstdmore<%=i%>"   onclick="stdless(this);" style="display: none;">收起&nbsp;<span style="font-size:10px">∧</span></div>
      -->  <%//} %>
       </div>
         <div class="clear"></div>
    </div>
    <%
		
		}
  }
}
//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	

HashMap<String,String> priceMap = (HashMap<String,String>)obj[4];
if(priceMap!=null&&priceMap.size()>0){
	  String pricestr=getpricestrmap(priceMap);
	  if(pricestr.length()>0){
	  pricestr=pricestr.substring(0,pricestr.length()-1)+"以上";
	  String[] pricearr=pricestr.split(",");
	if(pricearr.length>=3){
%>
  <div class="std-attrs" <%//if (stdshow>5){ out.print("class=\"std-attrs hide\" overfour=\"true\""); }else{ out.print("class=\"std-attrs\"");} %> >
     <div class="stda_h">价格
     </div>
     <div class="stda_vt">
        <ul class="stda_v">
        <%
       int stdlen=0;
        String stdkeys=",";
        for(int j=0;j<pricearr.length;j++){
      	  String newURL = ggURL.replaceAll("productprice"+pricearr[j]+"=[^&]*","");
      	  %>
           <li><a href="<%=newURL %>&productprice=<%=pricearr[j] %>" rel="nofollow"  <%if(showbrand)out.print("target=\"_blank\""); %>><%=pricearr[j] %></a></li>
           <%}
        %>
        </ul>
     </div>
       <div class="clear"></div>
  </div>
  <%
	}
		}
}
	%>
    
    
  </div>
  <%//if(stdshow>5){ %>
    <!--  <div class="stdbottom" id="morestd" onclick="morestd(this);" style="display: block;"><div class="stdbtxt">更多选项<span style="font-size:10px">∨</span></div></div>
    <div class="stdbottom hide" id="lessstd" onclick="lessstd(this);" style="display: none;"><div class="stdbtxt">收起<span style="font-size:10px">∧</span></div></div>
     --> <%//} %>
    </div>
  
  <!--列表开始-->

  <div class="r_list m_t10" id="r_list">
  <%
  List<Product> productList = (List<Product>)obj[0];
	int totalLength = (productList != null ?productList.size() : 0);
	
	int PAGE_SIZE = 48 ;
   int currentPage = 1 ;
   String pg = request.getParameter("pageno");
   if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
   PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
  
   int end = pBean.getStart()+PAGE_SIZE;
   if(end > totalLength) end = totalLength;
	
	String orderURL = ggURL.replaceAll("order=[^&]*","");
	orderURL = orderURL.replaceAll("pageno=[0-9]+","&");
	orderURL = orderURL.replaceAll("&+", "&");
	if(!orderURL.endsWith("&")) orderURL = orderURL + "&";
	
	String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
	
   if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
   pageURL = pageURL.replaceAll("&+", "&");
   

  %>
    <div class="rl_sort">
    <dl>
    <%/*orderContent
     case 6://热销商品升
  case 5 ://上架时间升
  case 4 ://上架时间降
  	case 3://热销商品
	case 2://价格，升序
	case 1://价格，倒序*/
		 %>
       <dd <%=Tools.isNull(orderContent)||orderContent.equals("0")?"class=\"rls_02 cur\"":""%>><a href='<%=orderURL%>' rel="nofollow">综合</a></dd>
      <dd <%//if(!Tools.isNull(orderContent)&&orderContent.equals("6")){
    	 // out.print("class=\"rls_02u cur\"");
      //}else 
    	  if(!Tools.isNull(orderContent)&&orderContent.equals("3")){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      %> >
      <%if(!Tools.isNull(orderContent)&&!orderContent.equals("3")){ %>
      <a href='<%=orderURL%>order=3' rel="nofollow">
      <%}else{ %>
       <a href='#' rel="nofollow">
      <%} %>
           销量&nbsp;</a></dd>
      <dd <%//if(!Tools.isNull(orderContent)&&orderContent.equals("5")){
    	  //out.print("class=\"rls_02u cur\"");
     // }else 
    	 if(!Tools.isNull(orderContent)&&orderContent.equals("4")){
    	  out.print("class=\"rls_02 cur\"");
      }else{
    	  out.print("class=\"rls_02\"");
      }      
      %>>
      <%if(!Tools.isNull(orderContent)&&!orderContent.equals("4")){ %>
      <a href='<%=orderURL%>order=4' rel="nofollow">
      <%}else{ %>
       <a href='#' rel="nofollow">
      <%} %>
         新品&nbsp;</a></dd>
      <dd <%if(!Tools.isNull(orderContent)&&orderContent.equals("1")){
    	  out.print("class=\"rls_04 cur\"");
      }else if(!Tools.isNull(orderContent)&&orderContent.equals("2")){
    	  out.print("class=\"rls_05 cur\"");
      }else{
    	  out.print("class=\"rls_03\"");
      }      
      %>><a href='<%=orderURL%>order=<%=!Tools.isNull(orderContent)&&orderContent.equals("1")?"2":"1" %>' rel="nofollow">价格&nbsp;</a></dd>
    </dl>
      <div class="sort_price">
      <!--  按价格选择：<input name="gprice_s" class="sort_pinput" type="text" value="￥" />--<input name="gprice_e" class="sort_pinput"  type="text" value="￥" />-->
     <input name="gourl" id="gourl"  type="hidden" value="<%=orderURL %>" />
      <input name="msflag" id="msflag" type="checkbox" <%if(!Tools.isNull(msflag)) out.print("checked");%> value="1" onclick="goresult()" />&nbsp;限时特价&nbsp;&nbsp;&nbsp;&nbsp;<input name="shopd1" id="shopd1" type="checkbox" <%if(!Tools.isNull(shopd1)) out.print("checked");%> onclick="goresult()" value="1" />&nbsp;D1自营
       </div>
       <div class="sort_page">
       <span><%=pBean.getCurrentPage() %>/<%=pBean.getTotalPages() %>&nbsp;&nbsp;</span><span>
       <%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-left.gif" width="21" height="20" />
       </a><%}%>
       &nbsp;&nbsp;&nbsp;&nbsp;<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>"><img src="http://images.d1.com.cn/images2014/result/pagearrow-right.gif" width="21" height="20" /></a><%}%></span> </div>
    </div>
     <%
           if(productList != null && !productList.isEmpty()){
        	  
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        		   int count=0;
           %>
    <ul class="m_t10">
    <%
    SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String	nowtime2= DateFormat.format( new Date());
 for(Product goods : gList){
	 count++;
        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
        	   String id = goods.getId();
        	   String shopcode=goods.getGdsmst_shopcode();
        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
        	   long currentTime = System.currentTimeMillis();
        	   boolean ismiaoshao=false; 
        	   boolean issgflag=false; 
        	   String brandname=goods.getGdsmst_brandname();
        	   String brandcode=goods.getGdsmst_brand();
        	   if(!Tools.isNull(brandcode))brandcode=brandcode.trim();
        	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
        	String gtitle="";
        	if(gname.length()<32){
        	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
        	}
        	
        			//ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
        			//String shopname="";
        			//if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
        			ismiaoshao=getmsflag(goods);
        		boolean	clsflag=false;
        		if(!productsort.startsWith("020")&&!productsort.startsWith("030"))clsflag=true;
        		D1ActTb acttb=CartHelper.getShopD1actFlag(shopcode,id);
        		long gdsnum=0;
        		long buynum=0;
        		long gdsnum2=0;
        		if(ismiaoshao){
        		SgGdsDtl sg=(SgGdsDtl)Tools.getManager(SgGdsDtl.class).findByProperty("sggdsdtl_gdsid", id);
        		  if(sg!=null&&sg.getSggdsdtl_status().longValue()==1){
        			   gdsnum= sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue();
        	             gdsnum2=sg.getSggdsdtl_maxnum().longValue()-sg.getSggdsdtl_realbuynum().longValue();
        	        	
        	         	 buynum= sg.getSggdsdtl_vbuynum().longValue()+sg.getSggdsdtl_vusrnum().longValue();

        	             if (gdsnum<=0||gdsnum2<=0 ||goods.getGdsmst_validflag().longValue()==2){
        	             	  gdsnum=0;
  
        	             }
        			  
    			     if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
    					&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
    			    	 issgflag=true ;
    			     }
        		  }
        		}
        			%>
       <li class="libox" style="<%=clsflag?"height:370px":""%>">
       <div class="rl_gds">
               <div class="g_simg">
               <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank">
               <% 
               if(clsflag){
        			out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" />");
        			}else{
        				if(!Tools.isNull(getImageTo200250(goods))){
        				out.print("<img src=\""+getImageTo200250(goods)+"\"  alt=\""+gname+"\" width=\"200\" height=\"250\" />");	
        				}else{
                			out.print("<img src=\""+ProductHelper.getImageTo200(goods)+"\" alt=\""+gname+"\" width=\"200\" height=\"200\" style=\"padding:25px 0px;\" />");
        				}
        			}
        			
        			%>
        			<%if(acttb!=null){ 
        			String acttxt="满"+acttb.getD1acttb_snum1()+"<br>减"+acttb.getD1acttb_enum1();
        			%>
        			<div class="gsimg_acttxt"><%=acttxt %></div>
        			<%} %>
        			<%if (issgflag){ 
        				 String endtime2= DateFormat.format(goods.getGdsmst_promotionend());
        			%>
        			<div class="list_bg listsg_show"> </div>
        			<div class="list_sg  listsg_show">
        			已有<%=buynum %>人购买</br>
        			仅剩余<%=gdsnum %>件</br>
        			<div class="lsgtm" id="tjjs_<%=count%>">
  
						     <SCRIPT language="javascript">
                             var startDate= new Date("<%=nowtime2%>");
                             var endDate= new Date("<%=endtime2%>");
                             the_s[<%=count%>]=(endDate.getTime()-startDate.getTime())/1000;
                             setInterval("view_time(<%=count%>,'tjjs_<%=count%>')",1000);
                             </SCRIPT>
        			</div>
        			</div>
        			<%} %>
           </a>
            </div>
              <div class="g_price">
              <span class="g_mprice">￥<font style="font-size:21px;">
<%
if(ismiaoshao){
	out.print(Tools.getFormatMoney(goods.getGdsmst_msprice()));
}else{
	out.print(Tools.getFormatMoney(goods.getGdsmst_memberprice()));
}
int comnum= getCommentcount(id);
int numflag=goods.getGdsmst_buylimit().intValue();

%>
</font></span><span class="m_t10">&nbsp;&nbsp;￥<s><%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></s>&nbsp;&nbsp;</span>
<%//if(ismiaoshao&&!issgflag){ %>
<!-- <span class="g_hot">直降</span>   -->
<%//}else if(issgflag){ %>
<!--<span class="g_hot"><img src="http://images.d1.com.cn/images2014/result/list_sg.png"></img></span>   -->
<%//} %>
<%if(goods.getGdsmst_virtualstock().longValue()>0&&("00000000").equals(goods.getGdsmst_shopcode())){%>
<span class="g_hot"><img title="晚上22点前支付，即可在当日由圆通快递发出" src="http://images.d1.com.cn/images2015/act/listsf.jpg" /></span>  
<%} %>
          </div>
           <div class="clear"></div>
               <div class="g_title">
              <span class="g_name"> 
               <a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods)%>" title="<%=gname %>" target="_blank"> <%=gname %>
             <%if(!gtitle.equals("null")&&gtitle.length()>0) {%>
              <span style="color:#c51520"><%=gtitle %></span>
              <%} %>
              </a>
              </span>
               <span class="<%=comnum>0?"g_com":""%>">
               <%=comnum>0?"<a href=\"http://www.d1.com.cn/product/"+id+"#cmt\" target=\"_blank\">"+comnum+"篇评论</a>":"&nbsp;" %></span>
               </div>
               <%if(clsflag){ %>
                  <div class="g_incart" style="text-align:center">
                   <span><input name="gdsnum<%=id %>"  id="gdsnum<%=id %>" class="gdsnum" value="1" type="text" /></span>
          <span class="g_numbut m_l10"><a href="###" onclick="addnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-up.gif" width="16" height="14" /></a><br />
               <a href="###" onclick="lessnum('<%=id %>','<%=numflag%>')"><img src="http://images.d1.com.cn/images2014/result/amountarrow-down.gif" width="16" height="14" /></a></span><span class="m_l10">
                 <a href="###" attr="<%=goods.getId() %>" onclick="addlistCart(this);"><img src="http://images.d1.com.cn/images2014/result/addcart.jpg" width="108" height="26" /></a>
               </div>
               
               <%} %>
               <%if (!Tools.isNull(brandname)&&!brandname.equals("D1推荐")){ %>
               <div class="g_shop">
                   <%="<a href=\"http://www.d1.com.cn/result.jsp?productsort="+productsort.substring(0,3)+"&brand="+brandcode+"\" target=\"_blank\">"+brandname+"</a>" %>
          </div><%} %>
       </div>
       </li>
        <%
           } %>
     </ul>
      <div class="clear"></div>
     <%
           if(pBean.getTotalPages()>1){
           %>
           <div class="GPager">
           	<span>共<font class="rd"><%=pBean.getTotalPages() %></font>页-当前第<font class="rd"><%=pBean.getCurrentPage() %></font>页</span>
           	<%if(pBean.getCurrentPage()>1){ %><a href="<%=pageURL.substring(0, pageURL.length()-1) %>">首页</a><%}%><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL.substring(0, pageURL.length()-1)%><% if(pBean.getPreviousPage()!=1) {%>&pageno=<%=pBean.getPreviousPage()%><%}%>">上一页</a><%}%><%
           	for(int i=pBean.getStartPage();i<=pBean.getEndPage()&&i<=pBean.getTotalPages();i++){
           		if(i==currentPage){
           		%><span class="curr"><%=i %></span><%
           		}else{
           			if(i==1)
           			{%>
           				<a href="<%=pageURL.substring(0, pageURL.length()-1) %>"><%=i %></a>
           			<%}
           			else
           			{
           		%><a href="<%=pageURL %>pageno=<%=i %>"><%=i %></a><%
           		    }
           		}
           	}%>
           	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>
           	<%if(pBean.getCurrentPage()<pBean.getTotalPages()){%><a href="<%=pageURL %>pageno=<%=pBean.getTotalPages() %>">尾页</a><%} %>
           </div><%}
           }
        	   }else{
        	   %><div style="color:red;text-align:center;">没有满足条件的搜索结果！！！</div><%
           } %>
  </div>
  
 
  <!--列表结束-->
  
</div>
<script  type="text/javascript">
$(function(){
		//当鼠标滑入时将div的class换成divOver
		$('.libox').hover(function(){
				$(this).css('border', 'solid 1px #c51520');
				$(this).addClass("cur")
			},function(){
            $(this).css('border',  'solid 1px #fff');	
            $(this).removeClass("cur")
			}
		);
		});
		
function addlistCart(obj){
	    var counts=$("#gdsnum"+$(obj).attr("attr")).val();
	    $.inCart(obj,{ajaxUrl:'/ajax/flow/listInCart.jsp',width:400,align:'center',gdscount:counts});

}
function goresult(){
    var gourl=$("#gourl").val();
    var msflag='';
    $("input[name='msflag']:checkbox").each(function(){
 	   if($(this).attr("checked")){
 		  msflag += $(this).val()	  
 	   }
    });
    
    var shopd1='';
    $("input[name='shopd1']:checkbox").each(function(){
 	   if($(this).attr("checked")){
 		  shopd1 += $(this).val()		  
 	   }
    });
    if(msflag!=""){
    	gourl=gourl+"msflag="+msflag;
    }else{
    	//gourl=gourl.replace("msflag=[^&]*","");
    	gourl=gourl.replace(/msflag=(.+?)$/,"");
    }
    if(shopd1!=""){
    	gourl=gourl+"shopd1="+shopd1;
    }else{
    	gourl=gourl.replace(/shopd1=(.+?)$/,"");
    }
    
     window.location.href = gourl;

   }	
function addnum(id, flag)
{

    if (flag == 1) {
        $.alert('该商品只能买一件！！！');
        return;
    }
    var new_val = Number($("#gdsnum"+id).val());
    $("#gdsnum"+id).val(new_val+1);
}
function ShowAJax1(param1){
	var counts=$("#gdsnum"+param1).val();
	$.ajax({
		type: "get",
		dataType: "json",
		url: '/ajax/flow/InCartnew.jsp',
		cache: false,
		data: {gdsid:param1,count:counts},
		error: function(XmlHttpRequest){
			alert("加入购物车出错，请稍后重试或者联系客服处理！");
		},success: function(json){
			if(json.success){
				$.alert(json.message);
			}else{
				$.alert(json.message);
			}
		},beforeSend: function(){
		},complete: function(){
		}
	});
}

function lessnum(id, flag)
{
    var new_val = Number($("#gdsnum"+id).val());
    if(new_val>1){
    	 $("#gdsnum"+id).val(new_val-1);
    }
}
function stdmore(t){
    $(t).hide().next().show();
   // $(t).parent().css('height', 'auto');
	 $(t).parent().addClass("hg_auto");
}
function stdless(t){
    $(t).hide().prev().show();
	// $(t).parent().css('height', '32px');
	  $(t).parent().removeClass("hg_auto");

}
function morestd(t){
            $(t).hide();
            $('#lessstd').show();
            $('[overFour]').show();

        }

function lessstd(t){
            $(t).hide();
            $('#morestd').show();
            $('[overFour]').hide();
        }

</script>
<div class="clear"></div>
<%@include file="inc/foot.jsp" %>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script>
$(document).ready(function() {
	    var obj=$("#xgss");
	    if(obj!=null){
		  $(obj).css("display","none");
	    }
	    //导航栏浮动
		var m=$("#ssort").offset().top;  
		$(window).bind("scroll",function(){
	    var i=$(document).scrollTop(),
	    g=$("#ssort");
		if(i>=m)
		{
			 g.addClass('newbanner1120');
		}
	    else{g.removeClass('newbanner1120');}
		});
		
		/*大图轮播*/
		rollimgs='<%= sbtt1219img.toString()%>';
	if(rollimgs.length>0){
        var roll_images=[<%= sbtt1219img.toString()%>];
	     var imgrollbg=['#fff','#fff','#fff','#fff','#fff','#fff','#fff','#fff'];
	 	 var bg = imgrollbg || null;
	 	<%if(pttlist.size() != 1){%>
	 	 new RollImage(roll_images, $("#imgRollOuterys"), $("#imgslideys>p>a"), null, $("#imgrollys .left"), $("#imgrollys .right"), bg).run(1);
	 	<%}%>
	 	 $("#imgrollys").hover(function (){
	 		<%if(pttlist.size() != 1){%><!-- 只有一张图片时，不执行 -->
				$(this).find(".left,.right").fadeIn();
		    <%}%>
		  },
		  function ()
		  {
			    $(this).find(".left,.right").fadeOut();
		  });       
	}
		
		
    //$(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});
</script>
</body>
</html>
