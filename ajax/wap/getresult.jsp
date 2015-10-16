<%@ page contentType="text/html; charset=UTF-8" import="net.sf.json.JSONArray,net.sf.json.JSONObject,com.d1.comp.*,java.util.*,com.d1.manager.*,org.hibernate.*"%><%@include file="/html/header.jsp" %>
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
//搜索物品。
//返回一个Object数组，第一个是物品的List，第二个是品牌Set，第三个是该品牌下的所有分类
private static Object[] getResultProductList(String productprice,String rackcode, String brandcode, String order, int start, int pagesize,HttpServletRequest request,String shopd1){
	
	if(!Tools.isNull(productprice)){
		try{
		productprice=java.net.URLDecoder.decode(productprice,"utf-8");
		}catch(Exception ex){
          ex.printStackTrace();
		}
		productprice=productprice.replace("以上","-50000");
	}
	Object[] obj = new Object[]{null,null,null,null};
	
	ProductManager manager = (ProductManager)ProductHelper.manager;
	if(manager == null) return obj;
	
	String[] rackcodes = rackcode.split(",");
	List<Product> list = new ArrayList<Product>();
	
	if(brandcode!=null)brandcode = brandcode.trim();
	
	//HashMap<String,Integer> brandDirMap = new HashMap<String,Integer>();
	HashMap<String,Integer>  rckMap =new HashMap<String,Integer>();
	HashMap<String,String>  priceMap =new HashMap<String,String>();
	List<Product> list_i = manager.getTotalProductList();

	if(list_i == null || list_i.isEmpty()) return obj;
	
	Brand brand = null;

	if(!Tools.isNull(brandcode)){
		brand = BrandHelper.getBrandByCode(brandcode);
	}
	List<Product> productList = new ArrayList<Product>();
	//最终结果
	List<Product> productListr = new ArrayList<Product>();
	List<Product> pListall = new ArrayList<Product>();//全部
	Set<Brand> brandSet = new HashSet<Brand>();
	 
	//key 品牌，value 销量
	Map<String,Long> saleCount = new HashMap<String,Long>();
   
	for(Product product : list_i){
		//System.out.println(product.getId()+"===="+product.getGdsmst_gdsname());
		boolean rckflag=false;
		for(int i=0;i<rackcodes.length;i++){
			if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().startsWith(rackcodes[i])){
				rckflag=true;
				break;
			}
		}
		if(!Tools.isNull(shopd1)){
	    	   if(!product.getGdsmst_shopcode().equals("00000000"))continue;
			}
		if(!rckflag)continue;
		if(Tools.longValue(product.getGdsmst_validflag()) != 1||Tools.longValue(product.getGdsmst_ifhavegds())!=0) continue;
		boolean isms=CartHelper.getmsflag(product);
		float pprice=product.getGdsmst_memberprice().floatValue();
		if(isms)pprice=product.getGdsmst_msprice().floatValue();
		/*if(brandcode!=null&&product.getGdsmst_brand()!=null&&brandcode.equals(product.getGdsmst_brand())){
			if(brandDirMap.containsKey(product.getGdsmst_rackcode())){
                Integer iy123 = brandDirMap.get(product.getGdsmst_rackcode());
                brandDirMap.put(product.getGdsmst_rackcode(), new Integer(iy123.intValue()+1));
            }else{
                brandDirMap.put(product.getGdsmst_rackcode(), new Integer(1));
            }
		}*/
		if(!Tools.isNull(brandcode)){
			String p_brand_code = product.getGdsmst_brand();
			if(!brandcode.trim().equals(p_brand_code)) continue;
		}
		
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
		if(product.getGdsmst_validflag()!=null&&product.getGdsmst_ifhavegds()!=null&&product.getGdsmst_ifhavegds().longValue()==0&&product.getGdsmst_validflag().longValue()==1){		
	     	pListall.add(product);
		}		
		
		String gdsrck=product.getGdsmst_rackcode();
		if(!Tools.isNull(gdsrck)){
			for(int l=3;l<=gdsrck.length();l=l+3){
				 
				if(rckMap.containsKey(gdsrck.substring(0,l))){
					rckMap.put(gdsrck.substring(0,l), rckMap.get(gdsrck.substring(0,l))+1);
				}else{
					rckMap.put(gdsrck.substring(0,l), 1);
				}
			}
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

				break;
			case 3://热销商品
				Collections.sort(pListall,new SalesComparator());
				Collections.reverse(pListall);
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
	obj[2] = rckMap;	
	obj[3] = priceMap;	
	return obj;
}
%>
<%
JSONObject json = new JSONObject();
JSONArray jsonarr=new JSONArray();

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
		json.put("pstatus", "0");
		out.print(json);
		return;
	}
}else{
	json.put("pstatus", "0");
	out.print(json);
	return;
}
json.put("pstatus", "1");


String brand = request.getParameter("brand");

String shopd1 = request.getParameter("shopd1");
String orderContent = request.getParameter("order");
if(Tools.isNull(orderContent)){
	orderContent = "0";
}
String productname = request.getParameter("productname");
if(productname == null) productname = request.getParameter("Productname");

if(productname==null)productname="";
else productname=productname.trim();

String productprice = request.getParameter("pprice");
if(Tools.isNull(productprice))productprice="";

String ggURL = Tools.addOrUpdateParameter(request,null,null);
if(ggURL != null) ggURL.replaceAll("pageno=[0-9]*","");
//////////////
Object[] obj = getResultProductList(productprice,productsort,brand,orderContent,0,10,request,shopd1);

List<Directory> dirList1 = new ArrayList<Directory>();		
HashMap<String,Integer> rckmap = (HashMap<String,Integer>)obj[2];
	dirList1=DirectoryHelper.getByParentcode(productsort);
	
	JSONArray jsonrackarr=new JSONArray();
	if(dirList1!=null&&dirList1.size()>0){
		JSONObject jsonrack = new JSONObject();
	for(Directory dir2 : dirList1){
		if(dir2.getRakmst_gdscount().longValue()>0){

			jsonrack.put("rckname", dir2.getRakmst_rackname());
			jsonrack.put("rckcode", dir2.getId());
			jsonrackarr.add(jsonrack);
		}
	}
	}

json.put("rcklist", jsonrackarr);

JSONArray jsonbrandarr=new JSONArray();
List<Brand> brandList = (List<Brand>)obj[1];
if(brandList != null && !brandList.isEmpty()){
	JSONObject jsonbrand = new JSONObject();
	for(Brand brand2 : brandList){
		if(brand2!=null){			
		String brand_name = brand2.getBrand_name();
		String brand_code=brand2.getBrand_code();
		if(brand_name != null) brand_name = brand_name.trim();
		if(brand_code != null) brand_code = brand_code.trim();
		
		jsonbrand.put("brandname", brand_name);
		jsonbrand.put("brandcode", brand_code);
		jsonbrandarr.add(jsonbrand);
	}
}
}

json.put("brandlist", jsonbrandarr);

JSONArray jsonpricearr=new JSONArray();
//0-49   99  199  299 399 499  599  799   999  1999 2999 3999  4999-	

HashMap<String,String> priceMap = (HashMap<String,String>)obj[3];
if(priceMap!=null&&priceMap.size()>0){
	  String pricestr=getpricestrmap(priceMap);
	  if(pricestr.length()>0){
	  pricestr=pricestr.substring(0,pricestr.length()-1)+"以上";
	  String[] pricearr=pricestr.split(",");
	if(pricearr.length>=3){
	JSONObject jsonprice = new JSONObject();
	String stdkeys=",";
    for(int j=0;j<pricearr.length;j++){
    	jsonprice.put("pricep", pricearr[j]);
		jsonpricearr.add(jsonprice);
	}
}
}
}
json.put("pricelist", jsonpricearr);

List<Product> productList = (List<Product>)obj[0];
	int totalLength = (productList != null ?productList.size() : 0);
	

  String pg = request.getParameter("pageno");
  String psize = request.getParameter("psize");

  if(Tools.isNull(psize))psize="12";
	int PAGE_SIZE = Tools.parseInt(psize) ;
	  int currentPage = 1 ;
  if(StringUtils.isDigits(pg))currentPage = Integer.parseInt(pg);
  PageBean pBean = new PageBean(totalLength,PAGE_SIZE,currentPage);
 
  int end = pBean.getStart()+PAGE_SIZE;
  if(end > totalLength) end = totalLength;
  json.put("page_total", totalLength);
  if(productList != null && !productList.isEmpty()){
	  
	   List<Product> gList = productList.subList(pBean.getStart(),end);
	   if(gList != null && !gList.isEmpty()){
		   int count=0;
		   
		   SimpleDateFormat DateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		    String	nowtime2= DateFormat.format( new Date());
		    DecimalFormat df2 = new DecimalFormat("0.00");
		 for(Product goods : gList){
			 JSONObject jsonitem = new JSONObject();
			 count++;
		        	   String title = Tools.clearHTML(goods.getGdsmst_gdsname()).trim();
		        	   String id = goods.getId();
		        	   String shopcode=goods.getGdsmst_shopcode();
		        	   long endTime = Tools.dateValue(goods.getGdsmst_discountenddate());
		        	   long currentTime = System.currentTimeMillis();
		        	   boolean ismiaoshao=false; 
		        	   boolean issgflag=false; 
		        	   String brandname=goods.getGdsmst_brandname();
		        	String gname=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_gdsname().trim()),0,64) ;
		        	String gtitle="";
		        	if(gname.length()<32){
		        	 gtitle=StringUtils.getCnSubstring(Tools.clearHTML(goods.getGdsmst_title()),0,(32-gname.length())*2) ;
		        	}
		        	
		        			//ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
		        			//String shopname="";
		        			//if(shpmst!=null)shopname=shpmst.getShpmst_shopname();
		        			ismiaoshao=CartHelper.getmsflag(goods);
		        		boolean	clsflag=false;
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
		        		float msprice=0f;
		        		if(goods.getGdsmst_msprice()!=null)msprice=goods.getGdsmst_msprice().floatValue();
		        		//int comnum= getCommentcount(id);
		        		
		        		jsonitem.put("p_gdsid",id);
		        		jsonitem.put("p_gdsname",title);
		        		jsonitem.put("p_img",ProductHelper.getImageTo200(goods));
		        		jsonitem.put("p_mprice",df2.format(goods.getGdsmst_memberprice()) );
		        		jsonitem.put("p_saleprice",df2.format(goods.getGdsmst_saleprice()));
		        		jsonitem.put("p_msprice",df2.format(msprice));
		        		jsonitem.put("p_ismiaoshao",ismiaoshao);
		        		jsonitem.put("p_issgflag",issgflag);
		        		jsonitem.put("p_shopcode",goods.getGdsmst_shopcode());
		        		jsonitem.put("p_tktflag", goods.getGdsmst_specialflag().longValue()==1?true:false);
		        		//jsonitem.put("p_comnum",comnum);
		        		if(acttb!=null){ 
	        			     String acttxt="满"+acttb.getD1acttb_snum1()+"减"+acttb.getD1acttb_enum1();
	        			     if(acttb.getD1acttb_enum2()>0){
	        					 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum2()+"减"+acttb.getD1acttb_enum2();
	        				 }
	        				 if(acttb.getD1acttb_enum3()>0){
	        					 acttxt+="&nbsp;&nbsp;满"+acttb.getD1acttb_snum3()+"减"+acttb.getD1acttb_enum3();
	        				 }
	        			     jsonitem.put("p_acttxt",acttxt);
			        		}else{
			        			 jsonitem.put("p_acttxt","");
			        		}
		        		jsonarr.add(jsonitem);
		        		
		 }
		 Directory dir= DirectoryHelper.getById(productsort);
		 Brand brandi = BrandHelper.getBrandByCode(brand);
		 json.put("rackname", dir!=null?dir.getRakmst_rackname():"");
		 json.put("brandname", brandi!=null?brandi.getBrand_name():"");
		 json.put("products", jsonarr);
	   }
  }
  out.print(json);
%>
