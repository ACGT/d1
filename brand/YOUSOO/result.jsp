<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp" %>
<%@include file="/html/public.jsp"%>
<%@include file="/html/getComment.jsp"%>
<%!
    private static String  getCZlog(String code,int length)
    {
		StringBuilder sb = new StringBuilder();
		if(!Tools.isMath(code) || length<=0) return "";
		ArrayList<Promotion> list=new ArrayList<Promotion>();
		list=PromotionHelper.getBrandListByCode(code,length);
		if(list!=null&&list.size()>0&&list.get(0)!=null)
		{
			Promotion p=list.get(0);
			StringBuilder map=new StringBuilder();
			ArrayList<PromotionImagePos> piplist=new ArrayList<PromotionImagePos>();
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("promotionId", p.getId()));
			List<BaseEntity> b_list = Tools.getManager(PromotionImagePos.class).getList(clist, null, 0, 100);
			if(b_list!=null){
				for(BaseEntity be:b_list){
					piplist.add((PromotionImagePos)be);
				}
			}
			
			sb.append("<div class=\"gdscsne_logo\"><img src=\""+p.getSplmst_picstr()+"\" width=\"740\" height=\"478\"  usemap=\"#pimg_1\"/><div class=\"clear\"></div>");
			map.append("<map name=\"pimg_1\" id=\"").append("pimg_1\">");
			
			for(PromotionImagePos pip:piplist)
			{
				
				if(pip!=null)
				{
					
					int left=0;
					int top=0;
					//left=(((i-1)*980)+pip.getPos_x()-24+(Tools.parseInt(pip.getExt1())-pip.getPos_x())/2);
					left=pip.getPos_x()+10;
					if(left>400)
					{
						left=pip.getPos_x()-25;
					}
					top=pip.getPos_y()-35;
					int divtop=0;
					if(top+40>350)
					{
						divtop=350;
					}
					else
						divtop=top+40;
					
						
					map.append("<area shape=\"rect\" coords=\"").append(pip.getPos_x()+",").append(pip.getPos_y()+",").append(pip.getExt1()+",").append(pip.getExt2()).append("\""); 
					Product product=ProductHelper.getById(pip.getProductId());
					if(product!=null)
					{
						map.append("href=\"").append("/product/"+product.getId()).append("\" target=\"_blank\"");
					}
					map.append(">");
					
				}
			}
			sb.append("</div>");
			map.append("</map>");
			
			sb.append(map.toString());
		}
		return sb.toString();
		
}
private static String getResourse(String code,int count,int flag)
{
    StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<Promotion> plist=new ArrayList<Promotion>();
    plist=PromotionHelper.getBrandListByCode(code, count);
    if(plist!=null&&plist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(Promotion p:plist)
    	{
    		if(p!=null)
    		{
    			sum++;
    			if(flag==1&&sum%3==0){
    			  sb.append("<li style=\"margin-right:0px\">");
    			}
    			else
    			{
    				sb.append("<li>");
    			}
    			sb.append("<a href=\"").append(p.getSplmst_url().replace("http://www.d1.com.cn/brand/YOUSOO/result.jsp", "http://yousoo.d1.com.cn/ysresult.htm").replace("http://www.d1.com.cn/brand/YOUSOO/result_rec.jsp", "http://yousoo.d1.com.cn/ysresult_rec.htm")).append("\" target=\"_blank\">");
    			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\"/></a></li>");
    		}
    	}
    	sb.append("</ul>");
    }
    return sb.toString();
}


private static String getProduct(String code,int count)
{
	StringBuilder sb=new StringBuilder();
    if(code==null||!Tools.isNumber(code)){ return "";}
    ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
    pplist=PromotionProductHelper.getPProductByCode(code, count);
    if(pplist!=null&&pplist.size()>0)
    {
    	sb.append("<ul>");
    	int sum=0;
    	for(PromotionProduct pp:pplist)
    	{
    		if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&pp.getSpgdsrcm_gdsid().length()>0)
    		{
    			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
    			if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0){
    		        sum++;
    		        if(sum%3==0){
    				   sb.append("<li style=\"margin-right:0px;\">");
    		        }
    		        else
    		        {
    		        	 sb.append("<li>");
    		        }
    		        String imgurl="";
    		        if(p.getGdsmst_img240300()!=null)
    		        {
    		        	imgurl=p.getGdsmst_img240300();
    		        }
	                sb.append(" <div class=\"lf\">");
	                sb.append("<p style=\"z-index:999;\"><a href=\"http://www.d1.com.cn/product/").append(p.getId()).append("\" target=\"_blank\">");
    		        sb.append("<img src=\"http://images.d1.com.cn").append(imgurl).append("\" width=\"240\" height=\"300\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\"/>");
    		        sb.append("</a></p>");
    		        sb.append("<p class=\"retime\" id=\"black_"+p.getId()+"\" onmouseover=\"mdm_over('"+p.getId()+"')\" onmouseout=\"mdm_out('"+p.getId()+"')\" style=\"display:none;\">");
    		        sb.append("<a href=\"http://www.d1.com.cn/product/"+p.getId()+"\" target=\"_blank\" style=\"font-size:12px; color:#fff; \">");
    		        sb.append(Tools.substring(p.getGdsmst_gdsname(), 54));
    		        sb.append("</a></p>");
    		        sb.append(" <p style=\"height:35px; font-size:13px; color:#999999; \">");
    		        sb.append(" <span class=\"newspan\"><font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice().floatValue())+"</b></font>&nbsp;&nbsp;");
    		        sb.append("<font style=\"text-decoration:line-through;\">￥"+Tools.getFormatMoney(p.getGdsmst_saleprice().floatValue())+"</font></span>");
    		        sb.append("<span class=\"newspan1\"><a href=\"http://www.d1.com.cn/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">");
    		        sb.append("评论("+getCommentList(p.getId()).size()+")</a></span> </p>");
    		        sb.append("</div><div class=\"clear\"></div>");
    		        Comment com=null;
                    List<Comment> list= CommentHelper.getCommentListByLevel(p.getId(),0,1);
                    if(list!=null&&list.size()>0&&list.get(0)!=null)
                    {
                    	com=list.get(0);
                    }
                      if(com!=null)
                      {
                    	sb.append("<div class=\"lb\" title=\""+ com.getGdscom_content() +"\"><b>"+ CommentHelper.GetCommentUid(com.getGdscom_uid())+"：</b><a href=\"http://www.d1.com.cn/product/"+p.getId()+"?st=com#cmt\" target=\"_blank\" rel=\"nofollow\">"+ StringUtils.getCnSubstring(com.getGdscom_content(),0,45)+"</a></div>");
                      }
                      else
                      {
                    	sb.append("<div class=\"lb\" ><b>暂无评论！！！</b></div>");  
                      }
            
    		        sb.append("</li>");
			       
    			}
    		}
    	}
    	sb.append("</ul>");
    }
    
    return sb.toString();
}

//获取一张图
private static String getimg(String code)
{
if(!Tools.isMath(code)) return "";
StringBuilder sb=new StringBuilder();
List<Promotion> list=PromotionHelper.getBrandListByCode(code, 1);
if(list!=null&&list.size()>0)
{
	int size=0;
	
	for(Promotion p:list)
	{ 
		if(p!=null)
		{	
			
			sb.append("<a href=\"").append(StringUtils.encodeUrl(p.getSplmst_url())).append("\" target=\"_blank\">");
			sb.append("<img src=\"").append(p.getSplmst_picstr()).append("\" />");
			sb.append("</a>");
		}
	}
	
}
return sb.toString();

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
			sb.append(">").append(dir.getRakmst_rackname()).append("</a>");
		}
	}
	return sb.toString();
}
//搜索物品。
//返回一个Object数组，第一个是物品的List，第二个是品牌Set，第三个是该品牌下的所有分类
private static Object[] getResultProductList(String productprice,String productname,String rackcode, String brand_name, String fg1, String fg2, String fg3, String fg4, String fg5, String fg6, String fg7, String fg8, String order, int start, int pagesize,HttpServletRequest request){
	
	Object[] obj = new Object[]{null,null,null};
	
	ProductManager manager = (ProductManager)ProductHelper.manager;
	if(manager == null) return obj;
	
	String[] rackcodes = rackcode.split(",");
	List<Product> list = new ArrayList<Product>();
	
	if(brand_name!=null)brand_name = brand_name.trim();
	
	HashMap<String,Integer> brandDirMap = new HashMap<String,Integer>();//key=rackcode,value=商品总数
	List<Product> list_i = manager.getTotalProductList();
	
	if(rackcodes!=null&&rackcodes.length>0){
		for(int i=0;i<rackcodes.length;i++){
			if(list_i!=null){
				for(Product p_i:list_i){
					if(brand_name!=null&&p_i.getGdsmst_brandname()!=null&&brand_name.equalsIgnoreCase(p_i.getGdsmst_brandname().trim())){
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
		if(Tools.longValue(product.getGdsmst_validflag()) != 1) continue;
		
		if(!Tools.isNull(brand_name)){
			String p_brand_name = product.getGdsmst_brandname();
			if(p_brand_name!=null)p_brand_name=p_brand_name.toLowerCase().trim();
			if(!brand_name.trim().toLowerCase().equals(p_brand_name)) continue;
		}
		String stdvalue1 = product.getGdsmst_stdvalue1();
		//System.err.println(stdvalue1+"=="+fg1);
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
		
		if(!Tools.isNull(brand_name)&&product.getGdsmst_brandname()!=null){
			if(product.getGdsmst_brandname().trim().toLowerCase().indexOf(brand_name.trim().toLowerCase())<0)continue;
		}
		
		if(!Tools.isNull(productname)&&product.getGdsmst_gdsname()!=null){
			if((product.getGdsmst_gdsname()+product.getGdsmst_keyword()).toLowerCase().indexOf(productname.toLowerCase())<0)continue;
		}
		
		if(!Tools.isNull(productprice)&&product.getGdsmst_memberprice()!=null&&productprice.indexOf("-")>-1){
			String sprice = productprice.substring(0,productprice.indexOf("-"));
			String eprice = productprice.substring(productprice.indexOf("-")+1);
			
			if(!Tools.isNull(sprice)&&product.getGdsmst_memberprice().floatValue()<Tools.parseFloat(sprice))continue;
			
			if(!Tools.isNull(eprice)&&product.getGdsmst_memberprice().floatValue()>Tools.parseFloat(eprice))continue;
		}
		
		if("true".equals(request.getParameter("tj"))){//特价商品，不满足特价条件也忽略
			if(product.getGdsmst_discountenddate()!=null&&product.getGdsmst_discountenddate().getTime()-System.currentTimeMillis()>30*Tools.DAY_MILLIS){
				continue;
			}
		}
		
		String bname=product.getGdsmst_brandname().trim();
		//更改产品列表里的排序
		if(!Tools.isNull(bname)&&bname.length()>0)
		{
			if(bname.indexOf("FEEL MIND")>=0)
			{
				pListf.add(product);
			}
			else if(bname.indexOf("AleeiShe 小栗舍")>=0)
			{
				pLista.add(product);
			}
			else if(bname.indexOf("诗若漫")>=0)
			{
				pLists.add(product);
			}
			else
			{
				productList.add(product);
			}
		}
		else
		{

			productList.add(product);
		}
		
		pListall.add(product);
		
		
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
	}
	
    
	
	//System.out.print("resulttest:Feelmind:"+pListf.size()+"xiaolishe:"+pLista.size()+"srm:"+pLists.size());
	
	if(Tools.isMath(order)){
		int o = Tools.parseInt(order);
		switch(o){
			case 4 ://上架时间
			    
				Collections.sort(pListf,new CreateTimeComparator());
				Collections.reverse(pListf);
				Collections.sort(pLista,new CreateTimeComparator());
				Collections.reverse(pLista);
				Collections.sort(pLists,new CreateTimeComparator());
				Collections.reverse(pLists);
				Collections.sort(productList,new CreateTimeComparator());
				Collections.reverse(productList);
				productListr.addAll(pListf);
				productListr.addAll(pLista);
				productListr.addAll(pLists);
				productListr.addAll(productList);
				break;
			case 3://热销商品
				Collections.sort(pListf,new SalesComparator());
				Collections.reverse(pListf);
				Collections.sort(pLista,new SalesComparator());
				Collections.reverse(pLista);
				Collections.sort(pLists,new SalesComparator());
				Collections.reverse(pLists);
				Collections.sort(productList,new SalesComparator());
				Collections.reverse(productList);
				productListr.addAll(pListf);
				productListr.addAll(pLista);
				productListr.addAll(pLists);
				productListr.addAll(productList);
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
				productListr.addAll(pListall);
				break;
			default:
				if(rackcode!=null&& (rackcode.startsWith("014")|| rackcode.startsWith("015002"))){
					Collections.sort(pListf,new SalesComparator());
					Collections.reverse(pListf);
					Collections.sort(pLista,new SalesComparator());
					Collections.reverse(pLista);
					Collections.sort(pLists,new SalesComparator());
					Collections.reverse(pLists);
					Collections.sort(productList,new SalesComparator());
					Collections.reverse(productList);
					productListr.addAll(pListf);
					productListr.addAll(pLista);
					productListr.addAll(pLists);
					productListr.addAll(productList);
					//Collections.sort(productListr , new SalesComparator());
					//Collections.reverse(productListr);
				}else{
					Collections.sort(pListf,new CreateTimeComparator());
					Collections.reverse(pListf);
					Collections.sort(pLista,new CreateTimeComparator());
					Collections.reverse(pLista);
					Collections.sort(pLists,new CreateTimeComparator());
					Collections.reverse(pLists);
					Collections.sort(productList,new CreateTimeComparator());
					Collections.reverse(productList);
					productListr.addAll(pListf);
					productListr.addAll(pLista);
					productListr.addAll(pLists);
					productListr.addAll(productList);
					//Collections.sort(productListr , new CreateTimeComparator());
					//Collections.reverse(productListr);
				}
		}
	}
	
	List<Brand> brandList = new ArrayList<Brand>();
	if(brandSet != null){
		brandList.addAll(brandSet);
	}
	
	if(brandList != null && saleCount!=null){
		Collections.sort(brandList,new SalesBrandComparator(saleCount));
	}
	
	obj[0] = productListr;
	obj[1] = brandList;
	obj[2] = brandDirMap;
	
	return obj;
}


/**
 * 获得服装图 200x250
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo200250(Product product){
	String img = (product != null ? product.getGdsmst_img200250() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
	
	return img;
}




%><%
request.setCharacterEncoding("GBK");

String productsort = request.getParameter("productsort");
  
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

if(!Tools.isNull(productbrand)){
	productbrand = Tools.simpleCharReplace(productbrand);
	productbrand = productbrand.trim();
}
String orderContent = request.getParameter("order");
if(!Tools.isNull(orderContent)){
	orderContent = Tools.simpleCharReplace(orderContent);
	if(Tools.parseInt(orderContent) > 4){
		orderContent = "3";
	}
}else{
	if(productsort!=null&& (productsort.startsWith("014")|| productsort.startsWith("015002"))){
		orderContent = "3";
	}else{
		orderContent = "4";
	}
	
}
String po1 = request.getParameter("productother1");
if(po1 == null) po1 = request.getParameter("Productother1");
if(!Tools.isNull(po1)) po1 = Tools.simpleCharReplace(po1);

String po2 = request.getParameter("productother2");
if(po2 == null) po2 = request.getParameter("Productother2");
if(!Tools.isNull(po2)) po2 = Tools.simpleCharReplace(po2);

String po3 = request.getParameter("productother3");
if(po3 == null) po3 = request.getParameter("Productother3");
if(!Tools.isNull(po3)) po3 = Tools.simpleCharReplace(po3);

String po4 = request.getParameter("productother4");
if(po4 == null) po4 = request.getParameter("Productother4");
if(!Tools.isNull(po4)) po4 = Tools.simpleCharReplace(po4);

String po5 = request.getParameter("productother5");
if(po5 == null) po5 = request.getParameter("Productother5");
if(!Tools.isNull(po5)) po5 = Tools.simpleCharReplace(po5);

String po6 = request.getParameter("productother6");
if(po6 == null) po6 = request.getParameter("Productother6");
if(!Tools.isNull(po6)) po6 = Tools.simpleCharReplace(po6);

String po7 = request.getParameter("productother7");
if(po7 == null) po7 = request.getParameter("Productother7");
if(!Tools.isNull(po7)) po7 = Tools.simpleCharReplace(po7);

String po8 = request.getParameter("productother8");
if(po8 == null) po8 = request.getParameter("Productother8");
if(!Tools.isNull(po8)) po8 = Tools.simpleCharReplace(po8);

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
Object[] obj = getResultProductList(productprice,productname,productsort,productbrand,po1,po2,po3,po4,po5,po6,po7,po8,orderContent,0,10,request);

boolean onlyShowBrand = false ;//左侧菜单只显示品牌相关的分类
if("1".equals(request.getParameter("bf"))&&!Tools.isNull(productbrand))onlyShowBrand = true ;

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
	


%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【正品行货】<%= headtitle %>_<%= topcat %>_<%= headtitle %>品牌_价格_图片<%  if(request.getParameter("pageno")!=null&&request.getParameter("pageno").length()>0) out.print("-第"+request.getParameter("pageno")+"页"); %>
-D1优尚网</title>
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<style type="text/css" >
    .middle{background:#585252;+margin-top:10px;}
   .middle_top{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/ystest1.jpg') repeat-x; height:127px; overflow:hidden;}
    .ysdh{ background:url('http://images.d1.com.cn/images2012/YOUSOO/images/YStest_05_1.jpg'); height:46px; width:980px; line-height:48px; 
           font-size:16px;  margin:0px; padding:0px;}
    .ysdh span{ display:block; text-align:center; float:left;}
    .ysdh a{ color:#aaa8b3;padding:3px 6px;font-family:'微软雅黑';}
    .ysdh a:hover{color:#aaa8b3; text-decoration:underline; }
    .middle_center{ width:980px; margin:0px auto;}
    .mleft{ float:left; width:220px; background:#36333e; padding-bottom:45px;height:3670px;+height:3635px;}
    .mleft ul{margin:0px; padding:0px; }
    .mleft ul li{ margin-top:10px;}
    .mright{ background:#fff; width:730px;_width:725px; _overflow:hidden; padding-left:30px; float:left; padding-top:10px; float:left;}
    .newlist {width:740px;overflow:hidden; padding:0px; margin:0px; }
	.newlist ul {width:740px;padding:0px; margin:0px;  margin-top:10px;}
	.newlist li {float:left; margin-right:30px; height:348px; border:solid 1px #ccc;overflow:hidden; width:210px; text-align:center; margin-bottom:10px;  }
	.newlist p {text-align:left; }
	.newlist p strong {font-weight:bold; font-size:15px; color:#a63c4f;margin-right:10px;}
	.newlist .retime {background:rgba(0,0,0,0.5);font-size:12px;text-align:left;line-height:16px;overflow:hidden; bottom:0px; margin-top:-41px; position:relative; width:210px; padding-top:3px; padding-bottom:2px;
	*background:transparent;filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#b3000000,endColorstr=#b3000000); z-index:1111; height:36px; display:none;  }
	.retime a{text-decoration:none; }
	.lf{background-color:#fff; over-flow:hidden; }
	.newlist p .newspan{ display:block; width:120px; height:35px; margin-top:5px; text-align:center; line-height:35px; border-right:solid 1px #f3f3f3; float:left;}
	.newlist p .newspan1{ display:block; width:79px; height:35px; margin-top:5px; text-align:center; line-height:35px; color:#333;float:left;}
	.lb{background-color:#f7f7f7;  padding:5px;  width:210px; height:42px; line-height:20px; font-size:12px;color:#7b7b7b; overflow:hidden;
	 text-align:left; vertical-align:middle; padding-top:8px;}
	.newlist .lf .di{position:absolute;z-index:999;width:79px;height:79px;border:none; +margin-left:-105px;}
	.sSort {float:left;width:730px;  line-height:40px;background:url(http://images.d1.com.cn/images2012/New/result/spjs_7.gif);text-align:left; margin-left:-15px; _margin-left:-7px;}
    .sSort dd {float:left;margin:5px; _margin-top:8px;}
    .floatdp{ position:absolute; z-index:22222; background:#fff; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px;+margin-left:-365px;
}
.floatdp1{ position:absolute; z-index:22222; background:url('http://images.d1.com.cn/images2012/index2012/xsj1.png') no-repeat;
          background-position:right 250px; width:278px; overflow:hidden;margin-top:-430px; margin-left:-265px; +margin-left:-365px;
}
.dpdisplay{ width:246px;}
.dpdisplay ul { list-decoration:none; margin:0px; padding:0px; }
.dpdisplay ul li{  float:left; background:url('http://images.d1.com.cn/images2012/aleeishe/images/0031.jpg') no-repeat; margin:0px; padding:0px; position:none; width:246px;}
.pj{background:#ccc; padding:5px;padding-top:0px; padding-left:6px; padding-bottom:2px;overflow:hidden;}
.pj a{ float:left; margin-right:3px; margin-bottom:3px;}

.allb {width:246; overflow:hidden; position:relative; margin:0px; padding:0px; background:#808080;}
.allimglist{ overflow:hidden;}
.allimglist img {border:0px;}
.allb ul {position:absolute; display:block; list-style-type:none;z-index:10000;margin:0; padding:0; top:330px; right:10px; width:auto;}
.allb ul li { padding:0px 3px;float:left;display:block; margin:0px;background:url('http://images.d1.com.cn/images2012/index2012/c2.png') no-repeat;cursor:pointer; height:14px; width:14px; }
.allb ul li.on { background:url('http://images.d1.com.cn/images2012/index2012/c1.png') no-repeat; margin:0px; }

.allimglist span{ width:246px; display:block;}
.allimglist ul li{ float:left;}

.next{position:absolute; right:0px; top:310px; curson:hand;}
.pre{position:absolute; left:0px; top:310px; curson:hand;}
.newbanner1120 {
position: fixed;
z-index: 20000;
top: 0;
background: white;
background: url(http://images.d1.com.cn/images2012/New/result/spjs_7.gif);
text-align: left;
}
</style>
<script type="text/javascript" language="javascript">
function scrollresult(imglistobj,cicleobj,flag)
{
    var t = n = 0; 
    var count=$(imglistobj+" span").length;
	$(imglistobj+" span:not(:first-child)").hide();
	$("#pre2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj-1<=0) obj=count+1;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj-1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	$("#next2012"+flag).click(function(){
		var obj=$(imglistobj+" span").filter(":visible").attr("attr");
		if(obj>=count) obj=0;
		obj=obj-1;
		$(imglistobj+" span").filter(":visible").hide().parent().children().eq(obj+1).fadeIn(500);
		$("#commensapn"+flag).css("display","block");
	});
	}

function mdmover(flag)
{
	var obj=$("#floatdp"+flag);
	obj.css("display","block");
	}


 function mdm_out(flag)
{
	 $("#floatdp"+flag).css("display","none");
	
}

function getFloatdp(gdsid,count)
{
	var obj=$("#floatdp"+count);
	if(obj!=null)
	{
		    $(obj).addClass("floatdp");//css("background","#fff");
			$(obj).html("<img src='http://images.d1.com.cn/images2012/New/Loading.gif' style=\"margin-left:120px; margin-top:120px; margin-bottom:120px; \"/>");
			$.post("/html/resulthtml.jsp",{"gdsid":gdsid,"count":count},function(data){
				$(obj).html(data);
				$(obj).removeClass("floatdp");
				$(obj).addClass("floatdp1");
				
			});
	
    }
}

function mdm_over(gdsid,flag)
{
	var obj=$("#floatdp"+flag);
	if(obj!=null)
		{
		   getFloatdp(gdsid,flag);
		   obj.css("display","block");
		}
    
}

function view_time2(){
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
    	var the_D=Math.floor((lasttime/3600)/24)
        var the_H=Math.floor((lasttime-the_D*24*3600)/3600);
        var the_M=Math.floor((lasttime-the_D*24*3600-the_H*3600)/60);
        var the_S=Math.floor((lasttime-the_H*3600)%60);
       if(the_D!=0){$("#topd").text(the_D);}
        if(the_D!=0 || the_H!=0) {$("#toph").text(the_H);}
        if(the_D!=0 || the_H!=0 || the_M!=0) {$("#topm").text(the_M);}
        $("#tops").text(the_S);
       // $getid(objid).innerHTML = html+html2+html1;
        lasttime--;
    }
}	
$(document).ready(function() {
	var startDate= new Date();
	var endDate= new Date("2012/07/20 15:00:00");
	var lasttime=(endDate.getTime()-startDate.getTime())/1000;
    if(lasttime>0){
  setInterval(view_time2,1000);
    }
});

</script>
</head>

<body >
<!--头部-->
	<%@include file="/inc/head.jsp" %>
	<div class="clear"></div>
	<!-- 头部结束-->

    <!-- 中间位置 -->
    <div class="middle">
        <div class="middle_top">
           <div style="width:980px; margin:0px auto;">
              <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_03.jpg"/>
               <div class="ysdh">
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/"   style="background:#6e6a78; color:#fff;">商品分类</a></span>
                <span style=" width:125px;"><a href="http://yousoo.d1.com.cn/yscxsp.htm" >畅销商品</a></span>
                 <span style=" width:120px;"><a href="http://yousoo.d1.com.cn/ys/brandstory.htm"  >品牌故事</a></span>
               
                 <div class="clear"></div>

              </div>
           </div>
           </div>
           <div class="middle_center">
              <div class="mleft">
                  <table>
                      <tr>
                          <td  style="padding-left:24px;">
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_08.jpg"/>
                                  <%=getResourse("3090",15,0) %>
                              </div>
                              <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_22.jpg"/>
                                 <%=getResourse("3091",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_28.jpg"/>
                                  <%=getResourse("3092",15,0) %>
                              </div>
                               <div style=" margin-top:45px;">
                                  <img src="http://images.d1.com.cn/images2012/YOUSOO/images/YStest_35.jpg"/>
                                  <%=getResourse("3093",15,0) %>
                              </div>
                          </td>
                      </tr>
                  </table>
              </div>
              
              
              <div class="mright">
                  <div class="r_right">
				<%
		//获取分类图
		ArrayList<Promotion> prolist=PromotionHelper.getBrandListByCode("3089", -1);
	    if(prolist!=null&&prolist.size()>0){
	    	for(Promotion p:prolist)
	    	{
	    		if(p!=null&&p.getSplmst_name()!=null&&p.getSplmst_name().length()>0&&p.getSplmst_name().equals(productsort)&&p.getSplmst_picstr()!=null&&p.getSplmst_picstr().length()>0)
	    		{%>
	    			<div style=" margin-left:5px;"><a href="<%= p.getSplmst_url()!=null&&p.getSplmst_url().length()>0?p.getSplmst_url():"" %>" target="_blank"><img src="<%= p.getSplmst_picstr() %>"/></a></div>
	    		<%}
	    	}
	    }
		
		%>
		
		<%
		List<ProductStandardHelper.Standard> psList = ProductStandardHelper.getGGByRackcode(productsort);
		if(psList != null && !psList.isEmpty()&&!onlyShowBrand){
		%>
			<div class="top"><%
			for(ProductStandardHelper.Standard ps : psList){
				String atrdtl = ps.getAtrdtl();
				long atrFlag = ps.getAtrFlag();
				if(Tools.isNull(atrdtl)) continue;
				String pos = request.getParameter("productother"+atrFlag);
				pos = Tools.simpleCharReplace(pos);
				String newURL = ggURL.replaceAll("productother"+atrFlag+"=[^&]*","");
				if(!newURL.endsWith("&")) newURL = newURL + "&";
				String[] arrdtl = atrdtl.split(";");
				%><dl>
					<dt><%=ps.getAtrname() %>：</dt>
					<dd>
						<div><a href="<%=newURL %>"<%if(Tools.isNull(pos)){ %> class="curr"<%} %> rel="nofollow">不限</a></div><%
						for(int i=0;i<arrdtl.length;i++){
							%><div><a href="<%=newURL %>productother<%=atrFlag %>=<%=URLEncoder.encode(arrdtl[i],"UTF-8") %>"<%if(arrdtl[i].equals(pos)){ %> class="curr"<%} %> rel="nofollow"><%=arrdtl[i] %></a></div><%
						}
						%>
					</dd>
				</dl><%
			}
			%></div><%
		}
		
		List<Product> productList = (List<Product>)obj[0];
		int totalLength = (productList != null ?productList.size() : 0);
		
		int PAGE_SIZE = 30 ;
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
		orderURL=orderURL.replace("brand/YOUSOO/", "ys").replace("jsp", "htm");
		String pageURL = ggURL.replaceAll("pageno=[0-9]+","&");
		
 	    if(!pageURL.endsWith("&")) pageURL = pageURL + "&";
 	    pageURL = pageURL.replaceAll("&+", "&");
 	    
		%>
			<div Class = 'sSort'>
               <span style='float:left'>&nbsp;&nbsp;<img src='http://images.d1.com.cn/images2012/New/result/red2.gif' style="_padding-top:4px;padding-top:2px;"/>&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style='float:left;color:#555555; font-weight:bold; font-size:14px;'>共有<font style=" color:#f00"><%=totalLength %></font>个产品&nbsp;&nbsp;&nbsp;&nbsp;</span>
               <span style='float:left;color:#555555; font-size:12px;'>排序方式</span>
               <span style='float:right;color:#555555; font-size:12px;'><%if(pBean.hasPreviousPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getPreviousPage()%>">上一页</a><%}%>&nbsp;&nbsp;
               	<%if(pBean.hasNextPage()){%><a href="<%=pageURL%>pageno=<%=pBean.getNextPage()%>">下一页</a><%}%>&nbsp;&nbsp;
               </span>
               <dd style=" margin-left:15px;">
                   <a href='<%=orderURL%>order=4' rel="nofollow"><img src='<%="4".equals(orderContent)?"http://images.d1.com.cn/images2012/New/result/newsale2.gif":"http://images.d1.com.cn/images2012/New/result/newsale1.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=3' rel="nofollow"><img src='<%="3".equals(orderContent)?"http://images.d1.com.cn/images2012/New/result/saletop2.gif":"http://images.d1.com.cn/images2012/New/result/saletop1.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=2' rel="nofollow"><img src='<%="2".equals(orderContent)?"http://images.d1.com.cn/images2012/New/result/price21.gif":"http://images.d1.com.cn/images2012/New/result/price2.gif" %>' border="0"/></a>&nbsp;&nbsp;
                   <a href='<%=orderURL%>order=1' rel="nofollow"><img src='<%="1".equals(orderContent)?"http://images.d1.com.cn/images2012/New/result/price11.gif":"http://images.d1.com.cn/images2012/New/result/price1.gif" %>' border="0"/></a>&nbsp;&nbsp;
               </dd>
               
           </div>
           <div class="clear"></div>
           <%
           if(productList != null && !productList.isEmpty()){
        	  
        	   List<Product> gList = productList.subList(pBean.getStart(),end);
        	   if(gList != null && !gList.isEmpty()){
        		   int count=0;
           %>
           <div class="newlist" >
           <table><tr><td>
<ul><%
 for(Product goods : gList){
	 count++;
        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
        	   String id = goods.getId();
        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
        	   long currentTime = System.currentTimeMillis();
        	%>
        	<%
        	if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
				{
        		   out.print("<li style=\"height:400px;\">");
				}
        	else
        	{
        		out.print("<li>");
        	}
        	%>
         
    		<div class="lf">
           				<p style="z-index:999; padding:5px;"><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" >
           				<% 
           				if(goods.getGdsmst_rackcode().length()>=6&&(goods.getGdsmst_rackcode().substring(0,3).equals("020")||goods.getGdsmst_rackcode().substring(0,3).equals("030")))
           					{
           					%>
           					<img src="<%= getImageTo200250(goods) %>" width="200" height="250" />
           	           
           				<%	}
           				    else
           				    {%>
           				    	<img src="<%= ProductHelper.getImageTo200(goods) %>" width="200" height="200" />
           	           
           				    <%}%>           				      
           				</a>  
           				<%  //每个商品对应的搭配列表
                              ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(goods.getId()); 
           				      if(gdscolllist!=null&&gdscolllist.size()>0)
           				      {%>
           				    	  <div style="position:absolute; margin-top:-46px; +margin-top:-49px; +margin-left:-102px;" onmouseover="mdm_over('<%= goods.getId() %>','<%= count%>')" onmouseout="mdm_out('<%= count%>')"><img src="http://images.d1.com.cn/images2012/index2012/da1.png"/></div>
			   
           				      <%}             %>   
                      </p>
           			  <p style="height:35px; font-size:13px; color:#999999;">
			               <span class="newspan">
			               <%
           			if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
           			%>
           			<font color="#b80024" style=" font-family:'微软雅黑'"><b>特价:￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>
           						<%     			}
			               else{%>
			               <font color="#b80024" style=" font-family:'微软雅黑'"><b>￥<%=Tools.getFormatMoney(goods.getGdsmst_memberprice()) %></b></font>
			               <%} %>
			               &nbsp;&nbsp;
			               <font style="text-decoration:line-through;">￥<%=Tools.getFormatMoney(goods.getGdsmst_saleprice()) %></font></span>			               
			               <span class="newspan1" id="commensapn<%= count%>"><a href="http://www.d1.com.cn/product/<%= goods.getId() %>#cmt2" target="_blank" rel="nofollow">评论(<%= CommentHelper.getCommentLength(id) %>)</a></span>
			           </p>
			          
             </div>
           
             
             
              <p style="height:38px; background:#e6e6e6; line-height:18px; text-align:left; padding:5px;" ><a href="http://www.d1.com.cn<%=ProductHelper.getProductUrl(goods) %>" target="_blank" style="font-size:12px; color:#606060; "><%=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname()),0,54)%></a></p>
             
              <div class="clear"></div>
              <%
                Comment com=null;
                List<Comment> list= CommentHelper.getCommentList(id,0,1000);
                if(list!=null&&list.size()>0)
                {
                	for(Comment c:list)
                	{
                		if(c.getGdscom_level().longValue()==5)
                		{
                			com=c;
                			break;
                		}
                		else
                		{
                			continue;
                		}
                	}
                	if(com==null)
                	{
                		for(Comment c:list)
                    	{
                    		if(c.getGdscom_level().longValue()==4)
                    		{
                    			com=c;
                    			break;
                    		}
                    		else
                    		{
                    			continue;
                    		}
                    	}
                		if(com==null)
                		{
                			for(Comment c:list)
                        	{
                        		if(c.getGdscom_level().longValue()==3)
                        		{
                        			com=c;
                        			break;
                        		}
                        		else
                        		{
                        			continue;
                        		}
                        	}
                		}
                	}
                }
              %>
              <%
                  if(com!=null)
                  {%>
                	  <div class="lb" title="<%= com.getGdscom_content() %>"><b><%= CommentHelper.GetCommentUid(com.getGdscom_uid())+"：" %></b><a href="/product/<%=id %>#cmt2" target="_blank"><%= StringUtils.getCnSubstring(com.getGdscom_content(),0,45) %></a></div>
                  <% 
                  }
                  else
                  {%>
                	<div class="lb" ><b>暂无评论！！！</b></div>  
                  <%}
              %>
              <%
                  //获取搭配浮层
                  
                  if(gdscolllist!=null&&gdscolllist.size()>0)
                  {%>

                	  <div  id="floatdp<%= count %>" onmouseover="mdmover('<%= count %>')" onmouseout="mdm_out('<%= count%>')">

                      </div>
                  <%}
              %>
             
              </li>
            <%
           } %>
</ul>
</td></tr></table>
</div>
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
           }}else{
        	   %><div style="color:red;text-align:center;">没有满足条件的搜索结果！！！</div><%
           } %>
       
           <% 
         Directory dir= DirectoryHelper.getById(productsort);
		if(dir!=null)
		{
			  String str=dir.getRakmst_rackname();
			  if(str.length()>0)
    {%>
   	
   	
       <%  //String newtag=getXGSS(id).replace('，', ',');
   	     ArrayList<Tag> elist=new ArrayList<Tag>();
   	     ArrayList<Tag> alist=new ArrayList<Tag>();
   	     ArrayList<Tag> list=TagHelper.getTags();
   	     if(list!=null&&list.size()>0)
   	     {
   	    	 for(Tag t:list)
   	    	 {
   	    		 if(t!=null&&t.getTag_key()!=null&&t.getTag_key().length()>0&&t.getTag_key().indexOf(str)>=0)
   	    		 {
   	    			 alist.add(t);
   	    		 }
   	    	 }
   	     }
   	     
   	     if(alist!=null)
   	     {
   	    	 for(int i=0;i<alist.size();i++)
   	    	 {
   	    		
   	    		 for(int j=i;j<alist.size()-1;j++)
   	    		 {
   	    			 Tag ti=alist.get(i);
   	    			 Tag tj=alist.get(j+1);
   	    			 if(ti.getTag_key().equals(tj.getTag_key()))
   	    			 {
   	    				 ti=null;
   	    			 }
   	    			 elist.add(tj);
   	    		 }
   	    	 }
   	     }
			
   	     if(elist!=null&&elist.size()>0)
   	     {
   	        
   	     %>
   	    	   <div class="xgss" id="xgss">
   	               <em style="border:none;">相关搜索：  </em>
   	    	<%  
   	    	    if(elist.size()<=15)
   	    	    {
   	    	    	for(int i=0;i<elist.size();i++)
   					{
   						Tag cc=elist.get(i);
   						if(cc!=null)
   						{
   						
   					%>
   		            	<em><a href="/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
   		            <%
   						}
   					}
   	    	    }
   	    	    else
   	    	    {
   	    	    	
   	   			    int num = new Random().nextInt(elist.size()-15);
       	   			for(int i=num;i<num+15;i++)
   					{
   						Tag cc=elist.get(i);
   						if(cc!=null)
   						{
   						
   					%>
   		            	<em><a href="/channel/<%= cc.getId() %>" target="_blank"><%=cc.getTag_key() %></a></em>
   		            <%
   						}
   					}
   	    	    }
   	    	   
   	              out.print(" </div>");
   	    }
           
   }
   
}%>
            <div class="clear"></div>
           
           
           
		</div>
	</div>
 
	              
	              
              </div>
              
           </div>
  
           
           <div class="clear"></div>
    </div>
    <!-- 中间位置结束 -->
    <%@include file="/inc/foot.jsp" %>
</body>
</html>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">
$(document).ready(function() {
	var objs=$("#xgss");
	if(objs!=null)
	{
	    objs.css("display","none");	
	}
	 //导航栏浮动
	var m=$(".sSort").offset().top;  
	$(window).bind("scroll",function(){
    var i=$(document).scrollTop(),
    g=$(".sSort");
	if(i>=m)
	{
		 g.addClass('newbanner1120');
	}
    else{g.removeClass('newbanner1120');}
	});
    $(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
