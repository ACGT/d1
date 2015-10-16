<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/public.jsp"%>
<%!




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


//搜索物品。
//返回一个Object数组，第一个是物品的List，第二个是品牌Set，第三个是该品牌下的所有分类
private static Object[] getResultProductList(String productprice,String productname,String rackcode, String brand_name, String fg1, String fg2, String fg3, String fg4, String fg5, String fg6, String fg7, String fg8, String order, int start, int pagesize,HttpServletRequest request){
	
	Object[] obj = new Object[]{null,null,null};
	
	ProductManager manager = (ProductManager)ProductHelper.manager;
	if(manager == null) return obj;
	
	String[] rackcodes = rackcode.split(",");
	List<Product> list = new ArrayList<Product>();
	
	if(brand_name!=null&&brand_name.length()>0)brand_name = brand_name.trim();
	
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
		if(Tools.longValue(product.getGdsmst_validflag()) != 1||Tools.longValue(product.getGdsmst_ifhavegds())!=0) continue;
		
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
				if(rackcode!=null&& (rackcode.startsWith("02")|| rackcode.startsWith("03"))){
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
					
				}else{
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
/**
 * 获得服装图 240*300
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo240300(Product product){
	String img = (product != null ? product.getGdsmst_img240300() : null);
	if(!Tools.isNull(img)) img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
	
	return img;
}
//根据商品编号获取搭配（如果商品编号为空，获取全部搭配）
private static ArrayList<Gdscoll>  getGdscollByGdsid(String gdsid)
{
	  boolean flag=false;
	  ArrayList<Gdscoll> result=new ArrayList<Gdscoll>();
	  ArrayList<Gdscoll> list=new ArrayList<Gdscoll>();
	
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		//clist.add(Restrictions.ge("gdscoll_cate",new Long(3)));
		clist.add(Restrictions.eq("gdscoll_flag",new Long(1)));
		
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.asc("gdscoll_sort"));
		olist.add(Order.desc("gdscoll_createdate"));
		List<BaseEntity> blist=Tools.getManager(Gdscoll.class).getList(clist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity b:blist)
			{
				if(b!=null)
				{
					list.add((Gdscoll)b);
				}
			}
		}
		
		if(list!=null&&list.size()>0)
		{
			if(gdsid.length()==0)
			{
				result=list;
			}
			else
			{
				for(Gdscoll gdscoll:list)
				{
					if(gdscoll!=null)
					{
						ArrayList<Gdscolldetail> gdlist=GdscollHelper.getGdscollBycollid1(gdscoll.getId());
						if(gdlist!=null)
						{
							for(Gdscolldetail gd:gdlist)
							{
								if(gd.getGdscolldetail_gdsid().equals(gdsid))
								{
									flag=true;
								}
							}
						}
						if(flag)
						{
							result.add(gdscoll);
						}
						flag=false;
					}
					
				}
				return result;
			}
		}
		return result;
}
//获取推荐商品
private static String getProductList(String code,int count)
{
 	if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();
	List<PromotionProduct> list=PromotionProductHelper.getPProductByCode(code, count);
	if(list!=null&&list.size()>0)
	{
		int j=0;
		for(int i=0;i<count&&i<list.size();i++)
		{
			PromotionProduct p=list.get(i);
			Product product=ProductHelper.getById(p.getSpgdsrcm_gdsid());
			//if(product == null || Tools.longValue(product.getGdsmst_validflag())!=1 || Tools.longValue(product.getGdsmst_ifhavegds()) != 0) continue;
			if(!ProductHelper.isNormal(product)) continue;
			//if(j<8)
			//{
				String title=StringUtils.clearHTML(p.getSpgdsrcm_gdsname());
				String imgurl=ProductHelper.getImageTo200(product);
				j++;
				if(j%4==0)
				{
					sb.append("<div class=\"gdmstlist_sub\" style=\" margin-right:0px;\">");
				}
				else
				{
					sb.append("<div class=\"gdmstlist_sub\" >");
				}
				
				sb.append(" <a href='http://www.d1.com.cn/product/").append(product.getId())
				.append("' target=\"_blank\" title=\"")
				.append(title).append("\"><img src='").append(imgurl)
				.append("' width=\"160\" height=\"160\" title=\"")
				.append(StringUtils.clearHTML(p.getSpgdsrcm_gdsname()))
				.append("\"/></a><br/>");
				sb.append("<span class=\"spans\"><a href='http://www.d1.com.cn/product/")
				.append(product.getId()).append("' target=\"_blank\" title=\"")
				.append(title).append("\">")
				.append(StringUtils.getCnSubstring(StringUtils.clearHTML(p.getSpgdsrcm_gdsname()), 0, 40))
				.append("</a>");
				sb.append("</span>");
				sb.append("<span><font class=\"font1\">￥")
				.append(Tools.getFormatMoney(product.getGdsmst_memberprice())).append("</font><font class=\"font2\">￥")
				.append(Tools.getFormatMoney(product.getGdsmst_saleprice()))
				.append("</font></span></div>");
			//}
		}
	}
	return sb.toString();
}


%><%
request.setCharacterEncoding("GBK");

String productsort = "030";
  
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


Object[] obj = getResultProductList(null,null,productsort,null,null,null,null,null,null,null,null,null,null,0,10,request);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D1优尚网-美女最爱鞋包专场，OL款，职业包，个性包包，各类精品款，一律热卖中！</title>
<meta name="description" content="D1优尚网时尚扮靓网专营精品鞋包，欧美品牌，日韩品牌，潮包，办公OL系列，活动多多，礼品多多，更有好多惊喜，欢迎选购！" />
<meta name="keywords" content="D1优尚网,男包,女包,包包,时尚包包" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/newcloth.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/subpage.css")%>" type="text/css" rel="Stylesheet" media="screen" />
<script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
<style type="text/css">

.gdmstlist_sub .spans {display: block;height: 40px;overflow: hidden; margin-top:5px;}

.font1,.font2{ font-size:14px;}
</style>     
</head>

<body style=" margin:0px auto; background:#fff;">
<%@include file="/inc/head.jsp" %>
<div class="all">
	<div id="r_middle" class="r_b">
		<div class="r_left">
		
			<div class="box">
				<div class="CatTitle">女包分类</div><%
				
				List<Directory> dirList = DirectoryHelper.getByParentcode("023");
				//System.out.print(dirList.size());
				if(dirList != null && !dirList.isEmpty()){
				%>
				<div class="classList">
					<div class="water"></div>
					<ul class="foldheader1"><%
					for(Directory dir : dirList){
						if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())>0){
						%><li class="parent"><a href="http://www.d1.com.cn/result.jsp?productsort=<%=dir.getId() %>"<%if(productsort.equals(dir.getId())){ %> class="on"<%} %> target="_blank"><%=dir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())%>)</a></li><%
						List<Directory> childDirList = DirectoryHelper.getByParentcode(dir.getId());
						if(childDirList != null && !childDirList.isEmpty()){
							for(Directory childDir : childDirList){
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())>0){
								%><li><a href="http://www.d1.com.cn/result.jsp?productsort=<%=childDir.getId() %>"<%if(productsort.equals(childDir.getId())){ %> class="on"<%} %> target="_blank"><%=childDir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())%>)</a></li><%
							}
							}
						}
					}
					}
				%></ul></div><%
			
				}%>
				
				
					<div class="CatTitle">男包分类</div><%
				
				List<Directory> dirList1 = DirectoryHelper.getByParentcode("033");
				//System.out.print(dirList.size());
				if(dirList1 != null && !dirList1.isEmpty()){
				%>
				<div class="classList">
					<div class="water"></div>
					<ul class="foldheader1"><%
					for(Directory dir : dirList1){
						if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())>0){
						%><li class="parent"><a href="http://www.d1.com.cn/result.jsp?productsort=<%=dir.getId() %>"<%if(productsort.equals(dir.getId())){ %> class="on"<%} %> target="_blank"><%=dir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(dir.getId())%>)</a></li><%
						List<Directory> childDirList = DirectoryHelper.getByParentcode(dir.getId());
						if(childDirList != null && !childDirList.isEmpty()){
							for(Directory childDir : childDirList){
								if(((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())>0){
								%><li><a href="http://www.d1.com.cn/result.jsp?productsort=<%=childDir.getId() %>"<%if(productsort.equals(childDir.getId())){ %> class="on"<%} %> target="_blank"><%=childDir.getRakmst_rackname() %>(<%=((ProductManager)Tools.getManager(Product.class)).getRackcodeProductLength(childDir.getId())%>)</a></li><%
							}
							}
						}
					}
					}
				%></ul></div><%
			
				}%>
				
				
			</div>
		</div>
		<div class="r_right">
		    <div class="scrollimglist">
               
                <script>ShowCenter(<%= ScrollImg("3222") %>,<%= ScrollText("3222") %>)</script>
            
         </div>
           <div class="clear"></div>
           <div style="width:770px; margin-top:1px; border-top:solid 3px #9b0101;">
           <img src="http://images.d1.com.cn/images2012/cloth/tbtj.jpg" usemap="#map1"/>
           
           </div>
           <%=getProductList("7990",4) %>
           <div class="clear"></div>
           <%=getProductList("7989",4) %>
           <div class="clear"></div>
           <div style="width:770px;border-top:solid 3px #9b0101; ">
          <img src="http://images.d1.com.cn/images2012/cloth/cxnv.jpg" usemap="#map2"/>
           <map name="map2" id="map2">
              <area shape="rect" coords="685,0,768,47" href="http://www.d1.com.cn/result.jsp?productsort=023" target="_blank" />
           </map>
           </div>
           <%=getProductList("7991",12) %>
           <div class="clear"></div>
           <div style="width:770px; border-top:solid 3px #9b0101;">
          <img src="http://images.d1.com.cn/images2012/cloth/cxnan.jpg" usemap="#map3"/>
           <map name="map3" id="map3">
              <area shape="rect" coords="685,0,768,47" href="http://www.d1.com.cn/result.jsp?productsort=033" target="_blank" />
           </map>
           </div>
           <%=getProductList("7992",12) %>          
             
            <div class="clear"></div>
           
           
           
		</div>
	</div>
</div>
<%@include file="/inc/foot.jsp" %>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">

$(document).ready(function() {
    $(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
</body>
</html>