<%@ page contentType="text/html; charset=UTF-8" import="com.d1.comp.*,com.d1.manager.*"%><%@include file="/inc/header.jsp"%>
<%@include file="/html/public.jsp"%>
<%@include file="/html/getComment.jsp"%>
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

private String parentId = "030";

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
	if(!Tools.isNull(img)){
		if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim().replace('\\','/');
			}else{
				img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
			}
	}
	
	return img;
}
/**
 * 获得服装图 240*300
 * @param product - 商品对象
 * @return String
 */
public static String getImageTo240300(Product product){
	String img = (product != null ? product.getGdsmst_img240300() : null);
	if(!Tools.isNull(img)) {
		if(img!=null&&img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim().replace('\\','/');
			}else{
				img = "http://images.d1.com.cn"+img.trim().replace('\\','/');
			}
	}
	
	return img;
}

//获取推荐商品
private static String getProductList(String code,int count)
{
	if(Tools.isNull(code)||!Tools.isNumber(code)) return "";
	StringBuilder sb=new StringBuilder();

	ArrayList<PromotionProduct> pplist=new ArrayList<PromotionProduct>();
	pplist=PromotionProductHelper.getPProductByCode(code, count);
	if(pplist!=null&&pplist.size()>0)
	{
		int counts=0;
		
        
		 sb.append("<div>");
	 sb.append("<ul>");
	 for(PromotionProduct pp:pplist)
	 {
		 if(pp!=null&&pp.getSpgdsrcm_gdsid()!=null&&Tools.isNumber(pp.getSpgdsrcm_gdsid()))
			 {
			 counts++;
			Product p=ProductHelper.getById(pp.getSpgdsrcm_gdsid());
				if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0)
				{
	      		   //String title = Tools.clearHTML(p.getGdsmst_gdsname()).trim();
	           	   String id = p.getId();
	           	   long endTime = Tools.dateValue(p.getGdsmst_discountenddate());
	           	   long currentTime = System.currentTimeMillis();
	           	String gname=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_gdsname()),0,52) ;
	        	String gtitle=StringUtils.getCnSubstring(Tools.clearHTML(p.getGdsmst_title()),0,30) ;
	           	   if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   			   {
	   	               sb.append("<li class=\"libox\">");
	   	              // 
	   			   }
	           	   else
	           	   {
	           		sb.append("<li class=\"libox\">");
	           		   //sb.append("<div class=\"lf\" style=\"padding-left:25px;\">");
	           	   }
	           	   sb.append("<div class=\"lf\">");
	           	   //if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
	   	           	  //sb.append("<a href=\""+ProductHelper.getProductUrl(p)+"\" ><img src=\"http://images.d1.com.cn/images2010/tejia2.gif\" class=\"di\" /></a>");
	   	           // } 
	           	    if(p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   	           {  
	           	    	if(Tools.isNull(getImageTo240300(p))){
	 	           	   sb.append("<p style=\"z-index:999;height:260px; padding-top:40px;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	           	    	}else{
	 		           	   sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");

	           	    	}
	           	    }
	   	           else
	   	           {
		           	   sb.append("<p style=\"z-index:999;text-align:center;\"><a href=\""+ProductHelper.getProductUrl(p)+"\" target=\"_blank\" >");
	   	           }
	   	           if(!Tools.isNull(getImageTo200250(p))&&p.getGdsmst_rackcode().length()>=6&&(p.getGdsmst_rackcode().substring(0,3).equals("020")||p.getGdsmst_rackcode().substring(0,3).equals("030")))
	   	           {  
	   	           		sb.append("<img src=\""+ getImageTo200250(p)+"\" width=\"200\" height=\"250\" />");
	   	           }
	   	           else
	   	           {
	                      sb.append("<img src=\""+ ProductHelper.getImageTo200(p)+"\" width=\"200\" height=\"200\" />");
	   	           }
	   	           sb.append("</a></p>");
	   	           //每个商品对应的搭配列表
              //ArrayList<Gdscoll> gdscolllist=GdscollHelper.getGdscollByGdsid(p.getId()); 
				     // if(gdscolllist!=null&&gdscolllist.size()>0)
				     // {
				    	//sb.append("<div style=\"position:absolute; margin-top:-46px; +margin-top:-15px; \" onmouseover=\"mdm_over('"+p.getId()+"','"+ counts+"')\" onmouseout=\"mdm_out('"+ p.getId()+"','"+counts+"')\"><img src=\"http://images.d1.com.cn/images2012/index2012/da1.png\"/></div>");

				    // }
				   sb.append("</p>");
	   	          
	   	           if(endTime >= currentTime && endTime <= currentTime+Tools.MONTH_MILLIS){
		   	    	 sb.append("<p style=\" text-align:center\"><strong>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"priced\">￥"+Tools.getFormatMoney(p.getGdsmst_oldmemberprice())+"</span></p>");
			       
	   	           }
		   	       else
		   	       {
		   	          // sb.append("<font color=\"#b80024\" style=\" font-family:'微软雅黑'\"><b>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</b></font>&nbsp;&nbsp;");
		   	        sb.append("<p style=\" text-align:center\"><strong>￥"+Tools.getFormatMoney(p.getGdsmst_memberprice()) +"</strong></p>");       
		   	       }
	   	        sb.append("<p class=\"gdst\"><a href=\"http://www.d1.com.cn"+ProductHelper.getProductUrl(p)+"\" target=\"_blank\">"+gname+"</a></p>");
	   	        sb.append("<p class=\"gdst2\"><span style=\"color:#fff\">.</span>&nbsp;"+gtitle +"</p>");
	           	   sb.append("</div>");
	           	 sb.append("<div class=\"clear\"></div>");
	           	 sb.append("</li>");
		 }
		}
	 }   	 
	 sb.append("</ul>");
	 sb.append("</div>");
	}	
	return sb.toString();
}
%><%
request.setCharacterEncoding("GBK");

String productsort = "014";
  
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
<title>D1优尚网－化妆品、美容护肤品网上购物商城-化妆品、欧美大牌、美容美体用品全部正品、特价销售，假一罚二</title>
<meta name="description" content="D1优尚网是最品质最专业的化妆品店，大牌美容护肤品、化妆品、纤体美体品，L’oreal 欧莱雅、Elizabeth Arden雅顿、Clinique 倩碧、Biotherm碧欧泉、Avene雅漾，全场特价、货到付款、100%正品，假一罚二。免费咨询电话400-680-8666" />
<meta name="keywords" content="D1优尚网,男士,女士,化妆品, 护肤品, 护理用品,香水" /><script type="text/javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/d1.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/SubScrollImg.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/product/listCart.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/subpage.js")%>"></script>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/twoindex.js")%>"></script>
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/module_box.css")%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/css/twocsshzp.css")%>" rel="stylesheet" type="text/css"  />
    <script type="text/javascript">
	$(function(){
		//当鼠标滑入时将div的class换成divOver
		$('.libox').hover(function(){
				//$(this).addClass('liOver');	
				$(this).css('border', 'solid 1px #e4e4e4');
			},function(){
				//鼠标离开时移除divOver样式
				//$(this).removeClass('liOver');	
				// 删除一个属性
            $(this).css('border',  'solid 1px #fff');	
			}
		);
		var wd=window.screen.width;
		
		if(wd>=1200){			  
			$('#clsad').removeClass('mbodyrmin')
			$('#clsad').addClass('mbodyrbig')
			
		  }
		  else{
			  $('#clsad').removeClass('mbodyrbig')
			  $('#clsad').addClass('mbodyrmin')
		  }
		Getmen_left(wd,"<%=productsort %>");
		if(wd>=1200){	
			Getmen_rec(wd,"6584",10,1);
			Getmen_rec(wd,"6585",10,2);
			Getmen_rec(wd,"6586",10,3);
			Getmen_rec(wd,"6587",10,4);
			Getmen_rec(wd,"6588",10,5);	
		
		}else{
			Getmen_rec(wd,"6584",8,1);
			Getmen_rec(wd,"6585",8,2);
			Getmen_rec(wd,"6586",8,3);
			Getmen_rec(wd,"6587",8,4);
			Getmen_rec(wd,"6588",8,5);
		}
	});
	
</script>
</head>
<%
                   String flagsmen=session.getAttribute("flaghead")==null?"2":session.getAttribute("flaghead").toString();//默认为北方
               %>
<body style=" margin:0px auto; background:#fff;">
<%
		    ArrayList<Promotion> ptoplist=PromotionHelper.getBrandListByCodeAndArea("3256",flagsmen, 1);
		    if(ptoplist!=null&&ptoplist.size()>0)
		    {
		    	if(ptoplist.get(0)!=null)
		    	{%>
		    	<div align="center">
		    		<a href="<%= ptoplist.get(0).getSplmst_url().trim() %>" target="_blank">
		            <img src="<%=ptoplist.get(0).getSplmst_picstr()  %>" />
		            </a>
		        </div>
		    	<%}
		    }
		%>
<%@include file="/inc/head201309_1.jsp" %>
<div class="all" id="resultall">
<div class="mbody" id="mbody">
    <div class="mbodyl" id="mbodyl">
	    
			
		</div>
		<div id="mbodyr">
		<div class="clsad " id="clsad">
	   <div class="lbad">
		    <div class="scrollimglist">
               
                <script>                     		
                ShowCenter(<%= ScrollImg("2549") %>,<%= ScrollText("2549") %>)
                </script>
            
         </div>
         </div>
	   <div class="picad" id="picad">
	   <%
		   String showad=PromotionHelper.getImgPromotion("3634",1);
	   out.println(showad);
		    //男3633  化妆品
		%>
	   </div>
	   </div>
           <div class="clear"></div>
           <div  id="newlist">
           <div id="rec1">      
           <%//=getProductList("7987",6) %>
          </div>
          <div id="rec2">
           <%//=getProductList("8536",6) %>
         </div>
             <div id="rec3">
           <%//=getProductList("8537",6) %>
          </div>
          <div id="rec4">
           <%//=getProductList("8211",6) %>
             </div>
            <div id="rec5">
              <%//=getProductList("8538",6) %> 
                 </div>
           
           </div>
		</div>
	</div>
</div>
<div class="clear"></div>
<%@include file="/inc/foot.jsp" %>
<script type="text/javascript" language="javascript" src="<%=com.d1.helper.ResourceHelper.getResourceVersion("/res/js/lazyload.js")%>"></script>
<script type="text/javascript">

$(document).ready(function() {
    //$(".newlist").find("img").lazyload({ effect: "fadeIn", placeholder: "http://images.d1.com.cn/Index/images/grey.gif" });
});

</script>
</body>
</html>