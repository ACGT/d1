package com.d1.helper;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.bean.Sku;
import com.d1.comp.SalesComparator;
import com.d1.comp.SalesSequenceComparator;
import com.d1.comp.SalesViewPNameCom;
import com.d1.comp.SalesViewsCreateCom;
import com.d1.comp.SalesViewsPriceCom;
import com.d1.comp.SalesViewsSalesCom;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.manager.ProductManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;



/**
 * 商品常用工具类
 * @author chengang
 *
 */
public class ProductHelper {
	
	public static final BaseManager manager = Tools.getManager(Product.class);
	
	/**
	 * 通过ID找到商品对象
	 * @param id
	 * @return Product
	 */
	public static Product getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Product)manager.get(id);
	}
	public synchronized static String getPid(String rackcode){
		String gdsid="";
		ArrayList<Product> list=ProductHelper. getMaxgdsid(rackcode);
		if(list!=null && list.size()>0){
			Product p=list.get(0);
			int maxid=Tools.parseInt(p.getId().substring(3, p.getId().length()));
			gdsid=p.getId().substring(0,3)+new DecimalFormat("00000").format(maxid+1);
			
		} 
		else
		{
			gdsid=rackcode.substring(0,3)+"00001";
		}
		return gdsid;
	} 
	/**
	 * 通过ID找到商品对象---未下架且有库存
	 * @param id
	 * @return Product
	 */
	public static ArrayList<Product> getProductById(String id) {
		ArrayList<Product> list=new ArrayList<Product>();
		Product p = (Product)Tools.getManager(Product.class).get(id);
		if(p!=null&&p.getGdsmst_validflag()!=null&&p.getGdsmst_validflag().longValue()==1
				&&p.getGdsmst_ifhavegds()!=null&&p.getGdsmst_ifhavegds().longValue()==0){
			list.add(p);
		}
		return list;
	}
	/**
	 * 通过品牌名找到商品对象---未下架且有库存
	 * @param id
	 * @return Product
	 */
	public static ArrayList<Product> getProductByBrandname(String gdsmst_brandname) {
		ArrayList<Product> list = ((ProductManager)Tools.getManager(Product.class)).getProductListByBrand(gdsmst_brandname);
		Collections.sort(list,new SalesComparator());
		return list ;
	}
	
	/**
	 * 查看一件物品是否没有下架的
	 * @param product - Product
	 * @return True or False
	 */
	public static boolean isShow(Product product){
		if(product == null) return false;
		if(Tools.longValue(product.getGdsmst_validflag()) == 1) return true;
		return false;
	}
	
	/**
	 * 查看一件物品是否是有库存并且没有下架的
	 * @param product - Product
	 * @return True or False
	 */
	public static boolean isNormal(Product product){
		if(product == null) return false;
		if(Tools.longValue(product.getGdsmst_validflag()) == 1 && Tools.longValue(product.getGdsmst_ifhavegds()) == 0) return true;
		return false;
	}
	
	/**
	 * 判断一件商品是否参加“X件Y折”的商品促销！TODO
	 * @param productId
	 * @return
	 */
	public static boolean isOnPromotion(String productId){
		return false ;
	}
	
	/**
	 * 判断一个商品是否有sku
	 */
	public static boolean hasSku(Product product){
		return SkuHelper.hasSku(product);
	}
	
	/**
	 * 商品访问url
	 * @param p
	 * @return
	 */
	public static String getProductUrl(Product p){
		return "/product/"+p.getId();
	}

	/**
	 * 商品id商品信息列表
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListById(String salesmst_recid,String orderid){
		ArrayList<PromotionProduct> promotionplist =PromotionProductHelper.getPProductByCode(salesmst_recid , 1000);

		ArrayList<Product> list=new ArrayList<Product>();
		if(promotionplist!=null){
			for(PromotionProduct product:promotionplist){
				Product p=getById(product.getSpgdsrcm_gdsid());
				if(p!=null){
					p.setSequence(product.getSpgdsrcm_seq().intValue());
					list.add(p);
				}
			}
		}
		//排序
		if(orderid.equals("1")){
			Collections.sort(list,new SalesViewsCreateCom());// order by   gdsmst_createdate desc
		}
		else if(orderid.equals("2")){
			Collections.sort(list,new SalesViewsSalesCom());// order by   gdssale_weeksalecount desc
			//Collections.reverse(list);
		}
		else if(orderid.equals("3")){
			Collections.sort(list,new SalesViewPNameCom());// order by   gdsmst_gdsname 
			Collections.reverse(list);
		}
		else if(orderid.equals("4")){
			Collections.sort(list,new SalesViewsPriceCom());// order by   gdsmst_memberprice desc
			Collections.reverse(list);
		}
		else if(orderid.equals("5")){
			Collections.sort(list,new SalesViewsPriceCom());// order by   gdsmst_memberprice 
			
		}
		else{
			Collections.sort(list,new SalesSequenceComparator());// order by gdsmst_updatedate desc
		}
		
		//System.out.println(list.size());
		return list;
	}
	
	/**
	 * 根据特价编号 ,商品编号且上架标志为“审核通过”商品信息
	 *
	 */
	public static ArrayList<Product> getProductListBySCode(String rackcode,String name){
		ArrayList<Product> list=new ArrayList<Product>();
		ArrayList<PromotionProduct> pproductlist=PromotionProductHelper.getPromotionProductBySCode(rackcode, name);
		if(pproductlist!=null){
			for(PromotionProduct pproduct: pproductlist){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("id", pproduct.getSpgdsrcm_gdsid()));
				clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 100);
				
				if(b_list!=null){
					for(BaseEntity be:b_list){
						list.add((Product)be);
					}
				}	
			}
		}
		
		return list;
	}
	/**
	 * 根据特价编号 ,商品编号且上架标志为“审核通过”且还有余货的商品信息
	 *
	 */
	public static ArrayList<Product> getProductListBySCode2(String rackcode,String name){
		ArrayList<Product> list=new ArrayList<Product>();
		ArrayList<PromotionProduct> pproductlist=PromotionProductHelper.getPromotionProductBySCode(rackcode, name);
		if(pproductlist!=null){
			//System.out.println("jjjjjjjjj"+pproductlist.size());
			for(PromotionProduct pproduct: pproductlist){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("id", pproduct.getSpgdsrcm_gdsid()));
				clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
				clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 100);
				
				if(b_list!=null){
					for(BaseEntity be:b_list){
						list.add((Product)be);
					}
				}	
			}
		}
		//System.out.println("wwwwwwwwww"+list.size());
		return list;
	}
	
	/**
	 * 根据特价编号 ,商品编号且上架标志为“审核通过”商品信息
	 *
	 */
	public static ArrayList<Product> getProductInfoById(ArrayList gdsidlist){
		ArrayList<Product> list=new ArrayList<Product>();
		if(gdsidlist==null || gdsidlist.size()==0){
			return null;
		}
		if(gdsidlist!=null){
			for(int i=0;i<gdsidlist.size();i++){
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.eq("id", gdsidlist.get(i)));
				clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 100);
				
				if(b_list!=null){
					for(BaseEntity be:b_list){
						list.add((Product)be);
					}
				}	
			}
		}
		//System.out.println(list.size());
		return list;
	}
	
	
	/**
	 * 通过商品分类过滤商品信息
	 *
	 */
	public static ArrayList<Product> showlist(ArrayList gdsidlist,int num){
		ArrayList<Product> list=getProductInfoById(gdsidlist);
		ArrayList<Product> list2=new ArrayList<Product> ();
		if(list!=null){
			for(int i=0;i<list.size();i++){
				Product product=list.get(i);
				if(DirectoryHelper.getById(product.getGdsmst_rackcode())!=null && i<num){
					list2.add(product);
				}
			}
		}
		if(list2.size()==0){
			return null;
		}
		
		return list;
	}
	
	/**
	 * 通过商品id过滤商品信息--有货
	 *
	 */
	public static ArrayList<Product> getExistProductById(ArrayList gdsidlist ,int num){
		
		ArrayList<Product> list=new ArrayList<Product> ();
		if(gdsidlist!=null){
			for(int i=0;i<gdsidlist.size();i++){
				ArrayList<Product> plist= getProductById(gdsidlist.get(i).toString());
				if(plist!=null && plist.size()>0){
					if(list.size()<=num){
						list.add(plist.get(0));
					}
				}
			}
		}
		if(list==null || list.size()==0){
			return null;
		}
		
		return list;
	}
	
	/**
	 * 得到商品的虚拟库存，如果商品有sku，skuId必须有值
	 * @param productId
	 * @param skuId sku id
	 * @return
	 */
	public static int getVirtualStock(String productId,String skuId){
		Product product = (Product)Tools.getManager(Product.class).get(productId);
		if(product==null)return 0;
		if(!ProductHelper.hasSku(product)){
			if(product.getGdsmst_virtualstock()==null)return 0;
			return product.getGdsmst_virtualstock().intValue();
		}else{
			if(Tools.isNull(skuId))return 0;
			Sku sku123 = (Sku)Tools.getManager(Sku.class).get(skuId);
			if(sku123==null||sku123.getSkumst_vstock()==null)return 0;
			return sku123.getSkumst_vstock().intValue();
		}
	}
	
	/**
	 * 得到一个商品的总库存，这里是商品总库存
	 * @param productId
	 * @return -1表示出错 >=0是真实库存
	 */
	public static long getStock(String productId){
		if(!StringUtils.isDigits(productId))return -1;
		Product p = getById(productId);
		if(p==null)return -1;
		
		if(hasSku(p)){
			ArrayList<Sku> list = SkuHelper.getSkuListViaProductId(productId);
			if(list!=null&&list.size()>0){
				long r = 0;
				for(Sku s:list){
					if(s.getSkumst_stock()!=null){
						r+=s.getSkumst_stock().longValue();
					}
				}
				return r;
			}
		}
		else{
			if(p.getGdsmst_stock()!=null)return p.getGdsmst_stock().longValue();
		}
		
		return -1;
		
	}
	
	/**
	 * 得到具体sku商品的库存
	 * @param productId
	 * @param sku
	 * @return
	 */
	public static long getStock(String productId,String sku){
		Sku s = SkuHelper.getSku(productId, sku);
		if(s!=null&&s.getSkumst_stock()!=null){
			return s.getSkumst_stock().longValue();
		}
		return -1;
	}
	
	private static final String HISTORY_COOKIE = "D1_gdsshow_history";//浏览记录

	//添加浏览历史记录
	public static void addHistory(HttpServletRequest request , HttpServletResponse response , String productId){
		if(Tools.isNull(productId)) return;
		try{
			String history = Tools.getCookie(request,HISTORY_COOKIE);
			if(history != null){
				history = URLDecoder.decode(history,"UTF-8");
				history = history.replaceAll("([,]+"+productId+")|("+productId+"[,]+)|"+productId+"","");
				if(history.length()==0){
					history = productId;
				}else{
					String[] s = history.split(",");
					if(s.length < 8){
						history = productId+","+history;
					}else{
						history = productId+"," + history.substring(0,history.lastIndexOf(","));
					}
				}
				Tools.setCookie(response,HISTORY_COOKIE , URLEncoder.encode(history,"UTF-8") , (int)(Tools.YEAR_MILLIS/1000));
			}else{
				Tools.setCookie(response,HISTORY_COOKIE , URLEncoder.encode(productId,"UTF-8") , (int)(Tools.YEAR_MILLIS/1000));
			}
		} catch(UnsupportedEncodingException e){
			
		}
	}

	//获得记录浏览记录
	public static List<Product> getHistoryList(HttpServletRequest request){
		String history = Tools.getCookie(request,HISTORY_COOKIE);
		if(history != null){
			try{
				history = URLDecoder.decode(history,"UTF-8");
				String[] s = history.split(",");
				if(s != null && s.length>0){
					List<Product> list = new ArrayList<Product>();
					for(int i=0;i<s.length;i++){
						Product product = ProductHelper.getById(s[i]);
						if(product != null){
							list.add(product);
						}
					}
					return list;
				}
			}catch(UnsupportedEncodingException e){
				
			}
		}
		return null;
	}
	
	/**
	 * 商品类型获得商品信息列表
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListByRCode(String brandname,String productname,String sequence,String productsort,String sequenceprice,int PageIndex,int pageSize){
		ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.like("gdsmst_rackcode", productsort));
			if(productname.trim().length()!=0){
				clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
			}
			
			List<Order> olist = new ArrayList<Order>();
			//olist.add(Order.desc("gdsmst_createdate"));
			
			boolean flag = true ;
			
			if(sequence.equals("1")){
				olist.add(Order.desc("gdsmst_createdate"));
			}
			else if(sequence.equals("4")){
				olist.add(Order.desc("gdsmst_memberprice"));
				flag = false ;
			}
			else if(sequence.equals("2")){
				olist.add(Order.desc("gdsmst_salecount"));
			}
			else{
				olist.add(Order.desc("gdsmst_createdate"));
			}
			
			if(flag){
				if(sequenceprice.equals("1")){
					olist.add(Order.desc("gdsmst_memberprice"));
				}
				else if(sequenceprice.equals("0")){
					olist.add(Order.asc("gdsmst_memberprice"));
				}
			}
			
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, (PageIndex-1)*pageSize, pageSize);
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}
			if(sequence.equals("2")){
			Collections.sort(list,new SalesComparator());
			}
		return list;
	}
	/**
	 * 商品类型获得商品信息列表行数
	 * @param p
	 * @return
	 */
	public static int getPageTotalByRCode(String brandname,String productname,String productsort){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.like("gdsmst_rackcode", productsort));
			if(productname.trim().length()!=0){
				clist.add(Restrictions.like("gdsmst_keyword", "%"+productname+"%"));
			}
			int total = Tools.getManager(Product.class).getLength(clist);
			
		return total;
	}
	
	/**
	 * 商品类型获得商品信息列表
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListForMini(String col1rck,String col1name){
		ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			clist.add(Restrictions.like("gdsmst_rackcode", col1rck.substring(0, col1rck.length()-1)+"%"));
			//if(!Tools.isNull(col1name)){
			//	clist.add(Restrictions.like("gdsmst_keyword", "%"+col1name+"%"));
			//}
			
			List<Order> olist = new ArrayList<Order>();
			//olist.add(Order.desc("gdsmst_createdate"));
			
			if(col1rck.contains("a")){
				olist.add(Order.desc("gdsmst_createdate"));
			}
			else if(col1rck.contains("b")){
				olist.add(Order.desc("gdsmst_memberprice"));
			}
			else if(col1rck.contains("c")){
				olist.add(Order.asc("gdsmst_gdsname"));
			}
			else if(col1rck.contains("d")){
				olist.add(Order.asc("gdsmst_brandname"));
			}
			else{
				olist.add(Order.desc("gdsmst_createdate"));
			}
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,500);
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}
		return list;
	}
	/**
	 * gdsmst_rackcode like ‘%’
	 *   and (gdsmst_gdsname like '%"+rsmini("minimst_col1name")+"%' or gdsmst_keyword like '%"+rsmini("minimst_col1name")+"%')
	 */
	public static ArrayList<Product> getRealProductListForMini(String col1rck,String col1name){
		ArrayList<Product> list=new ArrayList<Product>();
		ArrayList<Product> plist=getProductListForMini(col1rck,col1name);
		if(plist!=null){
			for(Product product:plist){
				if(product.getGdsmst_gdsname().contains(col1name) && product.getGdsmst_keyword().contains(col1name)){
					list.add(product);
				}
				else if(product.getGdsmst_gdsname().contains(col1name) && (!product.getGdsmst_keyword().contains(col1name))){
					list.add(product);
				}
				else if(!(product.getGdsmst_gdsname().contains(col1name)) && product.getGdsmst_keyword().contains(col1name)){
					list.add(product);
				}
			}
		}
		if(list==null || list.size()==0){
			 return null;
			
		}
		return list;
	}
	
	/**
	 * 处理商品名称
	 */
	public static String getProductName(String gdsname,int length){
		String productname="";
		int actuallen=0;
		if(length==0){
			productname=gdsname;
		}else{
			for(int i=1;i<gdsname.length();i++){
				int letter=gdsname.substring(i-1, i).toCharArray()[0];
				if(letter>=0 && letter<=122){
					actuallen = actuallen+1;
				}else{
					actuallen = actuallen+2;
				}
				if(i>length*2){
					productname=Tools.substring(gdsname,i)+"...";
					break;
				}
				if(i<=length*2){
					productname=gdsname.trim();
				}
			}
		}
		return productname;
	}
	/**
	 * 
	 */
	public static ArrayList<Product> getProductByCodeAndBName(String rackcode,String name,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		
			
				List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
				clist.add(Restrictions.gt("gdsmst_memberprice", new Float(50)));
				clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
				clist.add(Restrictions.like("gdsmst_rackcode", rackcode+"%"));
				clist.add(Restrictions.like("gdsmst_gdsname","%"+ name+"%"));
				List<Order> olist = new ArrayList<Order>();
				olist.add(Order.desc("gdsmst_salecount"));
				olist.add(Order.desc("gdsmst_hitcount"));
				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, num);
				
				if(b_list!=null){
					for(BaseEntity be:b_list){
						list.add((Product)be);
					}
				}	
			
		
		return list;
	}
	
	/**
	 * 商品类型获得商品信息列表 brand 页面
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductList_Brand(String brandname,String sequence,String productname){
		ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			//clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
			
			List<Order> olist = new ArrayList<Order>();
			//olist.add(Order.desc("gdsmst_createdate"));
			 
			if(sequence.equals("1")){
				olist.add(Order.desc("gdsmst_createdate"));
			}
			
			else if(sequence.equals("2")){
				olist.add(Order.desc("gdsmst_wsalecount"));
			}
			else if(sequence.equals("3")){
				olist.add(Order.asc("gdsmst_gdsname"));
			}
			else if(sequence.equals("4")){
				olist.add(Order.desc("gdsmst_memberprice"));
			}
			else if(sequence.equals("5")){
				olist.add(Order.asc("gdsmst_memberprice"));
			}
			else if(sequence.equals("6")){
				olist.add(Order.asc("gdsmst_rackcode"));
			}
			else{
				olist.add(Order.desc("gdsmst_createdate"));
			}
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 1000);
			//if(!Tools.isNull(productname)){
				// b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 1000);
			//}
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}
			if(sequence.equals("2")){
			  Collections.sort(list,new SalesComparator());
			  Collections.reverse(list);
			}
			if(!Tools.isNull(productname)){
				list=getExistPName(list,productname);
			}
			if(list==null || list.size()==0) return null;
		return list;
	}
	/**
	 * 根据productname
	 */
	public static ArrayList<Product> getExistPName(ArrayList<Product> plist,String pname){
		ArrayList<Product> list=new ArrayList<Product>();
		if(plist!=null && (!Tools.isNull(pname))){
			for(Product product:plist){
				if(product.getGdsmst_gdsname().contains(pname) && product.getGdsmst_keyword().contains(pname)){
					list.add(product);
				}
				else if(product.getGdsmst_gdsname().contains(pname) && (!product.getGdsmst_keyword().contains(pname))){
					list.add(product);
				}
				else if(!(product.getGdsmst_gdsname().contains(pname)) && product.getGdsmst_keyword().contains(pname)){
					list.add(product);
				}
			}
		}
		if(list==null || list.size()==0){
			 return null;
			
		}
		return list;
	}
	
	/**
	 * 商品类型获得商品信息列表行数 brand
	 * @param p
	 * @return
	 */
	public static int getPageTotal_Brand(String brandname,String productsort,String productname){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
			
			int total = Tools.getManager(Product.class).getLength(clist);
			
			if(!Tools.isNull(productname)){
				ArrayList<Product> list=new ArrayList<Product>();
				List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, null, 0, 1000);
				if(b_list==null||b_list.size()==0)return 0;
				if(b_list!=null){
					for(BaseEntity be:b_list){
						list.add((Product)be);
					}
				}
				list=getExistPName(list,productname);
				if(list!=null && list.size()>0){
					total=list.size();
				}
			}
		return total;
	}
	
	
	
	/**
	 * 商品分类获得商品信息列表
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListByRCode(String productsort,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		clist.add(Restrictions.ge("gdsmst_createdate", new Date(System.currentTimeMillis()-Tools.DAY_MILLIS*90)));
		if(productsort!=null&&productsort.length()>0)
		{
			clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		}
		
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
	
	
	/**
	 * 商品分类获得商品信息列表
	 * (根据销量排序)
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListByRCodeOrdercount(String productsort,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		if(productsort!=null&&productsort.length()>0)
		{
			clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		}
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_sendcount"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
	
	/**
	 * 商品分类获得商品信息列表
	 * @param p
	 * @return
	 */
	public static ArrayList<Product> getProductListByRCodeSub(String productsort,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		if(productsort.length()>0)
		{
			clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		}
		
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
				
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
	
	/**
	 * 商品分类获得商品信息列表
	 * @param p按照周排序
	 * @return
	 */
	public static ArrayList<Product> getProductListByRCodeSubByWsale(String productsort,int num){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
		clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
		if(productsort.length()>0)
		{
			clist.add(Restrictions.like("gdsmst_rackcode", productsort+"%"));
		}
		
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_wsalecount"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,num);
				
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		else
		{
			return null;
		}
	     return list;
	}
	
	
	/**
	 * 商品分类获得商品信息列表行数 rackcode
	 * @param p
	 * @return
	 */
	public static int getPageTotal_rackcode(String rackcode){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(0)));
			clist.add(Restrictions.like("gdsmst_rackcode", rackcode+"%"));
			
			int total = Tools.getManager(Product.class).getLength(clist);
			
		return total;
	}
	
	/**
	 * 获得物品小图的路径 80X80
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo80(Product product){
		String img = (product != null ?product.getGdsmst_smallimg() : null);
		if(!Tools.isNull(img)){
			if(img.startsWith("/shopimg/gdsimg")){
				img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
			}
		else
			{img = "http://images.d1.com.cn/images/nopic75.gif";
			}
		
		return img;
	}
	
	/**
	 * 获得物品的中图片 120x120
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo120(Product product){
		String img = (product != null ? product.getGdsmst_otherimg3() : null);
		if(!Tools.isNull(img)){
			if(img.startsWith("/shopimg/gdsimg")){
				img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
			}
		
		return img;
	}
	
	/**
	 * 获得物品的中图片 160x160
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo160(Product product){
		String img = (product != null ? product.getGdsmst_recimg() : null);
		if(!Tools.isNull(img)){
			if(img.startsWith("/shopimg/gdsimg")){
				img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
			}
		
		return img;
	}
	
	/**
	 * 获得物品的大图片 200x200
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo200(Product product){
		String img = (product != null ? product.getGdsmst_imgurl() : null);
		if(!Tools.isNull(img)){
			if(img.startsWith("/shopimg/gdsimg")){
				img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
			}
		
		return img;
	}
	
	/**
	 * 获得物品的特大图 370x370
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo370(Product product){
		String img = (product != null ? product.getGdsmst_bigimg() : null);
		if(!Tools.isNull(img)){
			if(img.startsWith("/shopimg/gdsimg")){
				img = "http://images1.d1.com.cn"+img.trim();
			}else{
				img = "http://images.d1.com.cn"+img.trim();
			}
			}
		
		return img;
	}
	
	/**
	 * 获得物品的特大图 400x400
	 * @param product - 商品对象
	 * @return String
	 */
	public static String getImageTo400(Product product){
		String img = (product != null ? product.getGdsmst_midimg() : null);
		if(!Tools.isNull(img)){
		if(img.startsWith("/shopimg/gdsimg")){
			img = "http://images1.d1.com.cn"+img.trim();
		}else{
			img = "http://images.d1.com.cn"+img.trim();
		}
		}
		return img;
	}
	
	
	//商户管理——商品查询
	public static ArrayList<Product> getProductList(String shopcode,String gdsid,String gdsname,String txtkey,Date txtcreatestime,Date txtcreateetime,String sgdsflag,String req_promotion,String iftj,String req_stock,String gdsmst_ifhavegds,String gdsmst_giftselecttype,int start,int end,String shopgdsid){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("gdsmst_shopcode", shopcode));
		if(!Tools.isNull(gdsid)){
			clist.add(Restrictions.eq("id", gdsid));
		}
		if(txtcreatestime!=null){
			clist.add(Restrictions.ge("gdsmst_createdate", txtcreatestime));
		}
		if(txtcreateetime!=null){
			clist.add(Restrictions.le("gdsmst_createdate", txtcreateetime));
		}
		if(!Tools.isNull(sgdsflag) && !sgdsflag.equals("-1")){
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(sgdsflag)));
		}
		if(!Tools.isNull(gdsmst_ifhavegds) && !gdsmst_ifhavegds.equals("-1")){
			clist.add(Restrictions.eq("gdsmst_ifhavegds", new Long(gdsmst_ifhavegds)));
		}
		if(!Tools.isNull(gdsmst_giftselecttype) && !gdsmst_giftselecttype.equals("-1")){
			clist.add(Restrictions.eq("gdsmst_giftselecttype", new Long(gdsmst_giftselecttype)));
		}
		if(!Tools.isNull(req_promotion)){
			clist.add(Restrictions.ne("gdsmst_promotionstart", ""));
			clist.add(Restrictions.ne("gdsmst_promotionend", ""));
			clist.add(Restrictions.ne("gdsmst_promotionword", ""));
		}
		if(!Tools.isNull(iftj)){
			clist.add(Restrictions.gt("gdsmst_discountenddate", new Date()));
		}
		if(!Tools.isNull(req_stock)){
			clist.add(Restrictions.gt("gdsmst_stock", new Long(0)));
		}
		if(!Tools.isNull(shopgdsid)){
			clist.add(Restrictions.eq("gdsmst_shopgoodscode", shopgdsid));
		}
		if(!Tools.isNull(gdsname)){
			clist.add(Restrictions.like("gdsmst_gdsname", "%"+gdsname+"%"));
		}
		if(!Tools.isNull(txtkey)){
			clist.add(Restrictions.like("gdsmst_keyword", "%"+txtkey+"%"));
		}
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("gdsmst_createdate"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, start,end);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		
	     return list;
	}
	/**
	public static String getgdsid(String rackcode){
		Session session = null ;
		Transaction tx = null ;
		CallableStatement cstmt = null;  
		try{
			session = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
			tx = session.beginTransaction() ;
			cstmt =session.connection().prepareCall("{call sp_getGdsid(?,?) }");                         
			cstmt.setString("@rackcode", rackcode);                   
			cstmt.registerOutParameter("@gdsid", java.sql.Types.NVARCHAR);                   
			cstmt.executeUpdate();                   
			tx.commit();     
			return cstmt.getString("@gdsid");
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			ex.printStackTrace();
			return "";
		}finally{
			MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE) ;
		}
	}**/
	public static ArrayList<Product> getMaxgdsid(String rackcode){
		ArrayList<Product> list=new ArrayList<Product>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.like("id", rackcode+"%"));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("id"));
		List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,1);
		if(b_list==null || b_list.size()==0) return null;		
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Product)be);
			}
		}	
		return list;
	}
	
	
	//获得品牌下的分类
	public static HashMap<String, String> getRackByBrand(String brandcode,String rackcode){
		ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brand", brandcode));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			List<Order> olist = new ArrayList<Order>();
			olist.add(Order.asc("gdsmst_rackcode"));
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0,1000);
			if(b_list==null || b_list.size()==0) return null;		
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}
			//去掉重复分类
		
			HashMap<String, String> racklist=new HashMap<String, String>();
			if(list!=null && list.size()>0){
				for(Product product:list){
					if(!Tools.isNull(rackcode)){
						if(product.getGdsmst_rackcode().trim().startsWith(rackcode)){
							racklist.put(product.getGdsmst_rackcode().trim(), brandcode);
						}
					}
					
				}
			}
			return racklist;
	}
	
	public static ArrayList<Product> getProductListByRCode(String brandname,String sequence,String productsort){
		ArrayList<Product> list=new ArrayList<Product>();
	
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("gdsmst_brandname", brandname));
			clist.add(Restrictions.eq("gdsmst_validflag", new Long(1)));
			clist.add(Restrictions.eq("gdsmst_rackcode", productsort));
			
			
			List<Order> olist = new ArrayList<Order>();
			//olist.add(Order.desc("gdsmst_createdate"));
			
			boolean flag = false ;
			
			if(sequence.equals("4")){
				olist.add(Order.desc("gdsmst_createdate"));
			}
			else if(sequence.equals("1")){
				olist.add(Order.desc("gdsmst_memberprice"));
			}
			else if(sequence.equals("2")){
				olist.add(Order.asc("gdsmst_memberprice"));
			}
			else if(sequence.equals("3")){
				//olist.add(Order.desc("gdsmst_salecount"));
			}
			else{
				if(productsort!=null&& (productsort.startsWith("020")|| productsort.startsWith("030"))){
					flag=true;
				}else{
					olist.add(Order.desc("gdsmst_createdate"));
				}
			}
			
			List<BaseEntity> b_list = Tools.getManager(Product.class).getList(clist, olist, 0, 3000);
			if(b_list==null||b_list.size()==0)return null;
			if(b_list!=null){
				for(BaseEntity be:b_list){
					list.add((Product)be);
				}
			}
			if(sequence.equals("3") || flag){
			Collections.sort(list,new SalesComparator());
			}
		return list;
	}
	
}
