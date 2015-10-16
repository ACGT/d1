package com.d1.helper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.Const;
import com.d1.bean.Award;
import com.d1.bean.Brand;
import com.d1.bean.BrandPromotion;
import com.d1.bean.BrandPromotionItem;
import com.d1.bean.Cart;
import com.d1.bean.D1ActTb;
import com.d1.bean.Gift;
import com.d1.bean.GiftGroup;
import com.d1.bean.GiftGroupItem;
import com.d1.bean.GiftItem;
import com.d1.bean.GiftProduct;
import com.d1.bean.Product;
import com.d1.bean.ProductExpPrice;
import com.d1.bean.ProductExpPriceItem;
import com.d1.bean.ProductGroup;
import com.d1.bean.ProductPackage;
import com.d1.bean.ProductPackageItem;
import com.d1.bean.ProductXsY;
import com.d1.bean.PromotionProduct;
import com.d1.bean.SecKill;
import com.d1.bean.SgGdsDtl;
import com.d1.bean.ShpMst;
import com.d1.bean.Sku;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.MD5;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * 购物车辅助工具类
 * @author kk
 */
public class CartHelper {
	
	public static BaseManager manager = Tools.getManager(Cart.class);
	
	/**
	 * 根据ID获得购物车  OK
	 * @param id - ID
	 * @return Cart
	 */
	public static Cart getById(String id){
		if(Tools.isNull(id)) return null;
		return (Cart)manager.get(id);
	}
	
	/**
	 * 得到购物车积分换购商品的总积分
	 * @param request
	 * @param response
	 * @return
	 */
	public static long getTotalProductPoint(HttpServletRequest request,HttpServletResponse response){
		return getCartTotalPoint(request,response);
	}
	
	/**
	 * 得到购物车里商品已经订购的数量
	 * @param productId 商品id
	 * @param skuId sku id
	 * @return
	 */
	public static int getCartProductCount(HttpServletRequest request,HttpServletResponse response,Product product,String skuId){
		int countInCart_1239 = 0;
		if(product==null)return 0;
		ArrayList<Cart> cartList8734587p = getCartItems(request, response);
		if(cartList8734587p!=null&&cartList8734587p.size()>0){
			for(Cart c_4577kfu:cartList8734587p){
				if(c_4577kfu.getType().longValue()>=0&&product.getId().equals(c_4577kfu.getProductId())){
					if(!Tools.isNull(skuId)){
						if(skuId.equals(c_4577kfu.getSkuId()))countInCart_1239+=c_4577kfu.getAmount().intValue();
					}else{
						if(Tools.isNull(c_4577kfu.getSkuId()))countInCart_1239+=c_4577kfu.getAmount().intValue();
					}
				}
			}
		}
		return countInCart_1239;
	}
	
	/**
	 * 得到购物车总支付价，不包括运费！
	 * @param request
	 * @param response
	 * @return 保留两位小数
	 */
	public static float getTotalPayMoney(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()>=0){
					long actmoney=0;
					if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
				
					total+=cart.getMoney()-actmoney;

					}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	/**
	 * 得到一个分类商品总支付价，用于获取赠品判断
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getTotalRackcodePayMoney(HttpServletRequest request,HttpServletResponse response,String rackcode,String shopcode){
		if(rackcode!=null)rackcode = rackcode.trim();
		
		if(Tools.isNull(rackcode))return getTotalPayMoney(request,response);
		
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()>=0&&(cart.getShopcode().equals(shopcode)||shopcode.equals("11111111"))&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14&&cart.getType().longValue()!=18){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(p!=null&&p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith(rackcode)||(rackcode.equals("002")&&!p.getGdsmst_rackcode().startsWith("014")))){
						total+=cart.getMoney();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	/**
	 * 得到购物车一个分类下的总金额，判断目录startsWith即可，000表示全场。用于获取能用券金额判断，不让用券的不计算在内
	 * @param request
	 * @param response
	 * @param rackcode
	 * @return
	 */
	public static float getTotalRackcodePayMoney2(HttpServletRequest request,HttpServletResponse response,String rackcode,String shopcode){
		if(Tools.isNull(shopcode))shopcode="00000000";
		if(rackcode!=null)rackcode=rackcode.trim();
		//System.out.println(rackcode+"=========2222=========="+shopcode+getNormalProductMoney(request,response));
		if((Tools.isNull(rackcode)||"000".equals(rackcode))&&shopcode.equals("11111111"))return getNormalProductMoney(request,response);
		if(Tools.isNull(rackcode)||"000".equals(rackcode))return getShopNormalProductMoney(request,response,shopcode);

		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()>=0){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if( p!=null&&(p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))&&p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith(rackcode)
							||(rackcode.equals("017")&& 
							(p.getGdsmst_rackcode().startsWith("02")||p.getGdsmst_rackcode().startsWith("03")||p.getGdsmst_rackcode().startsWith("015009"))
							))){
						if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//让用券
							long actmoney=0;
							if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
							total+=cart.getMoney()-actmoney;
						}
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	/**
	 * 得到购物车总商品数量，包括赠品数，这个数目就是库房要发货的总件数！
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getTotalProductCount(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把总数加起来
		if(cartList==null||cartList.size()==0){
			return 0;
		}else{
			int total = 0;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0)total+=cart.getAmount();
			}
			
			return total;
		}
	}
	
	/**
	 * 判断一个赠品是否在购物车里
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean existsGiftProductId(HttpServletRequest request,HttpServletResponse response,String productId){
		ArrayList<Cart> allList = getCartItems(request, response);
		if(productId==null||allList==null||allList.size()==0)return false;
		
		for(Cart cart:allList){
			if(cart.getType().longValue()==0&&productId.equals(cart.getProductId())){
				return true;
			}
		}
		
		return false;
	}
	public static boolean existsGiftidProductId(HttpServletRequest request,HttpServletResponse response,String productId,long giftmstid){
		ArrayList<Cart> allList = getCartItems(request, response);
		//System.out.println("查看赠品主ID："+productId+"----"+allList.size()+"---"+giftmstid);
		if(allList==null||allList.size()==0)return false;

		for(Cart cart:allList){
			String gifttype="";
			String mstid="";
			String giftselect="";
			if(cart.getType().longValue()==0){
				gifttype=cart.getGiftType();
				String[] arrgifttype=null;
				if (gifttype!=null&&gifttype.indexOf("||")>-1){
					arrgifttype=gifttype.split("\\|\\|");
					mstid=arrgifttype[0];
					giftselect=arrgifttype[1];
				
				}
				if(mstid!=null&&mstid.equals(giftmstid+"")&&(giftselect.equals("0")
						||productId.equals(cart.getProductId()))){
		    	    return true;
			     }
			}
		}
		
		return false;
	}
	
	/**
	 * 获取购物车里的品牌减免列表。如果有记录，说明该购物车有品牌优惠。优惠多少参看BrandPromotion的定义<br/>
	 * 支付时，如果有多个品牌减免，则合并成一张虚拟优惠券（不插数据库）！！！！<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<BrandPromotion> getCartBrandPromotion(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Brand> brandList = getCartBrands(request,response);
		if(brandList==null||brandList.size()==0)return null;
		
		ArrayList<BrandPromotion> resList = new ArrayList<BrandPromotion>();//返回品牌减免定义
		
		//满足品牌减免的条件
		for(int i=0;i<brandList.size();i++){
			Brand b = brandList.get(i);
			BrandPromotion bp = BrandHelper.getBrandPromotionViaBrandId(b.getBrand_code());
			
			if(bp==null)continue;
			
			//满足品牌减免的条件：有效、没有过期、满足金额限制
			//if(bp.getBrdtktmst_validflag()!=null&&(bp.getBrdtktmst_validflag().longValue()==1)){
				if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()&&
						System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()&&
						bp.getBrdtktmst_gdsvalue()!=null){
					//满足总金额
					if(b.getBrand_name()!=null&&CartHelper.getCartBrandPayMoney2(request, response, b.getBrand_name().trim(),"00000000")>=bp.getBrdtktmst_gdsvalue().floatValue()){
						resList.add(bp);
					}
				}
			//}
		}
		return resList ;
	}
	
	/**
	 * 获取购物车里的品牌减免列表。如果有记录，说明该购物车有品牌优惠。优惠多少参看BrandPromotion的定义<br/>
	 * 支付时，如果有多个品牌减免，则合并成一张虚拟优惠券（不插数据库）！！！！<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<BrandPromotion> getCartBrandPromotion2(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Brand> brandList = getCartBrands(request,response);
		if(brandList==null||brandList.size()==0)return null;
		
		ArrayList<BrandPromotion> resList = new ArrayList<BrandPromotion>();//返回品牌减免定义
		
		//满足品牌减免的条件
		for(int i=0;i<brandList.size();i++){
			Brand b = brandList.get(i);
			BrandPromotion bp = BrandHelper.getBrandPromotionViaBrandId(b.getBrand_code());
			
			if(bp==null)continue;
			
			//满足品牌减免的条件：有效、没有过期、满足金额限制
			//if(bp.getBrdtktmst_validflag()!=null&&(bp.getBrdtktmst_validflag().longValue()==1)){
				if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()&&
						System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()&&
						bp.getBrdtktmst_gdsvalue()!=null){
					//满足总金额
					if(b.getBrand_name()!=null&&CartHelper.getCartBrandPayMoney2(request, response, b.getBrand_name().trim(),"00000000")>=bp.getBrdtktmst_gdsvalue().floatValue()){
						resList.add(bp);
					}
				}
			//}
		}
		return resList ;
	}
	
	/**
	 * 获取购物车里某个品牌商品的总支付价，用于计算赠品条件，不参加E券的商品也算
	 * @param request
	 * @param response
	 * @param brandName brand name
	 * @return
	 */
	public static float getCartBrandPayMoney(HttpServletRequest request,HttpServletResponse response,String brandName,String shopcode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(brandName!=null)brandName=brandName.trim();
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if((cart.getShopcode().equals(shopcode)||shopcode.equals("11111111"))&&cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14&&cart.getType().longValue()!=18){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(p==null)continue ;
					
					//如果是正常商品或组合优惠商品并且商品是该品牌下的，则把钱加起来
					if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().trim().equals(brandName)&&cart.getType().longValue()!=2){
						total+=cart.getMoney();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	/**
	 * 得到品牌可以用券的金额，不参加E券的不算，用于计算品牌减免
	 * @param request
	 * @param response
	 * @param brandName
	 * @return
	 */
	public static float getCartBrandPayMoney2(HttpServletRequest request,HttpServletResponse response,String brandName,String shopcode){
		if(Tools.isNull(shopcode))shopcode="00000000";
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(brandName!=null)brandName=brandName.trim();
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(p==null)continue ;
					
					//如果是正常商品或组合优惠商品并且商品是该品牌下的，则把钱加起来
					if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().trim().equals(brandName)
							&&(p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))){
						if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//让用券
							long actmoney=0;
							if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
							total+=cart.getMoney()-actmoney;
						}
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	/**商户满减
	 * 获取购物车里某个商品减免活动的总金额，用于计算商户满减活动条件
	 * @param request
	 * @param response
	 * @param shopcode shopcode name
	 * @return
	 */
	public static float getCartShopActPayMoney(HttpServletRequest request,HttpServletResponse response,D1ActTb act){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		//把支付价加起来
		
		if(act==null||cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			String shopcode=act.getD1acttb_shopcode();
			long actid=Tools.parseLong(act.getId());
			int acttype= act.getD1acttb_acttype().intValue();
			String ppcode=act.getD1acttb_ppcode();
			String brandcode=act.getD1acttb_brandcode();
			String actmemo=act.getD1acttb_memo();
			
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				boolean ppactflag=false;
				String productid=cart.getProductId();
				if(acttype==0&&cart.getShopcode().equals(shopcode)){
					ppactflag=true;
				}else if(acttype==1&&cart.getShopcode().equals(shopcode)){
					if(!Tools.isNull(ppcode)){
					ppcode=ppcode.replace("，", ",");
					  if(ppcode.indexOf(",")>=0){			
					     String[] arrppcode=ppcode.split(",");
					     for(int j=0;j<arrppcode.length;j++){
					    	 ppactflag=	PromotionProductHelper.getPProductByCodeGdsidExist(arrppcode[j],productid);
					    	 if(ppactflag)break;
					     }
					   }else{
						  ppactflag=	PromotionProductHelper.getPProductByCodeGdsidExist(ppcode,productid);
					   }
					}
				}else if(acttype==2&&cart.getShopcode().equals(shopcode)){
					if(!Tools.isNull(brandcode)){
						Product p=ProductHelper.getById(productid);
						if(p!=null&&p.getGdsmst_brand().equals(brandcode))ppactflag=true;
						
					}
				}else if(acttype==3&&cart.getShopcode().equals(shopcode)){
					if(!Tools.isNull(ppcode)){
						Product p=ProductHelper.getById(productid);
						if(p!=null&&p.getGdsmst_rackcode().startsWith(ppcode))ppactflag=true;
						
					}
				}
				if(ppactflag){
				if(cart.getType().longValue()>=0
						&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13
						&&cart.getType().longValue()!=14&&cart.getType().longValue()!=18&&cart.getType().longValue()!=22
						&&(Tools.isNull(actmemo)||actmemo.indexOf(cart.getProductId())==-1)
						){
				
						total+=cart.getMoney();
						cart.setActid(new Long(actid));
						Tools.getManager(Cart.class).update(cart, false);
				}
			  }
			}
			
			return Tools.getFloat(total,2);
		}
	}
	

	
	public static D1ActTb getShopAct(List<Cart> cartList,String Shopcode,String actid){
		
		
		D1ActTb d1act=(D1ActTb)Tools.getManager(D1ActTb.class).get(actid);
		 if(d1act==null)return null;
		 if(d1act.getD1acttb_status().longValue()==1&&d1act.getD1acttb_shopcode().equals(Shopcode)
				 &&d1act.getD1acttb_starttime().getTime()<=new Date().getTime()&&d1act.getD1acttb_endtime().getTime()>=new Date().getTime()){
			 return d1act;
		 }else{
			 for(int i=0;i<cartList.size();i++){
					Cart cart = cartList.get(i);
					if(cart.getActid()!=null&&cart.getActid().longValue()==Tools.parseLong(actid)){
					cart.setActid(new Long(0));
					cart.setActmoney(new Long(0));
					Tools.getManager(Cart.class).update(cart, false);
					}
				}
		 }
		 return null;
	}
	/***
	 * 用于商户满减促销查询
	 * @param shopcode
	 * @return
	 */
	public static ArrayList<D1ActTb> getShopD1actList(String shopcode){
		ArrayList<D1ActTb>  d1actlist=new ArrayList<D1ActTb>();
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		 clist.add(Restrictions.eq("d1acttb_status",new Long(1)));
		 clist.add(Restrictions.le("d1acttb_starttime", new java.util.Date()));
		 clist.add(Restrictions.ge("d1acttb_endtime", new java.util.Date()));
		 clist.add(Restrictions.eq("d1acttb_shopcode",shopcode));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("d1acttb_createdate"));
		
		 
		 List<BaseEntity> rlist=Tools.getManager(D1ActTb.class).getList(clist, olist, 0, 30);
		if(rlist==null||rlist.size()==0)return null;        
		for(BaseEntity b:rlist){
			D1ActTb act= (D1ActTb)b;
			d1actlist.add(act);
		}

		return d1actlist;
	}
	/***
	 * 返回满足条件的商户满活动
	 * @param shopcode
	 * @param gdsid
	 * @return
	 */
	public static D1ActTb getShopD1actFlag(String shopcode,String gdsid){
		boolean actflag=false;
	    ArrayList<D1ActTb> actlist=getShopD1actList(shopcode);
	    if(actlist!=null&&actlist.size()>0){
	    for(D1ActTb acttb:actlist){
	    	long acttype=acttb.getD1acttb_acttype().longValue();
	    	String actmemo=acttb.getD1acttb_memo();
	    	String brandcode=acttb.getD1acttb_brandcode();
	    	String ppcode=acttb.getD1acttb_ppcode();
	    	if(!Tools.isNull(actmemo)&&actmemo.indexOf(gdsid)>=0){
	    		return null;
	    	}
	    		
	    	if(acttype==0){
	    		actflag=true;
	    		if(actflag)return acttb;
			}else if(acttype==1){
				
				if(!Tools.isNull(ppcode)){
				ppcode=ppcode.replace("，", ",");
				  if(ppcode.indexOf(",")>=0){			
				     String[] arrppcode=ppcode.split(",");
				     for(int j=0;j<arrppcode.length;j++){
				    	 actflag=	PromotionProductHelper.getPProductByCodeGdsidExist(arrppcode[j],gdsid);
				    	 if(actflag)return acttb;
				     }
				   }else{
					   actflag=	PromotionProductHelper.getPProductByCodeGdsidExist(ppcode,gdsid);
					   if(actflag)return acttb;
				   }
				}
			}else if(acttype==2){
				if(!Tools.isNull(brandcode)){
					Product p=ProductHelper.getById(gdsid);
					if(p!=null&&p.getGdsmst_brand().equals(brandcode)&&p.getGdsmst_shopcode().equals(shopcode))actflag=true;
					 if(actflag)return acttb;
					
				}
			}else if(acttype==3){
				if(!Tools.isNull(ppcode)){
					Product p=ProductHelper.getById(gdsid);
					if(p!=null&&p.getGdsmst_rackcode().startsWith(ppcode)&&p.getGdsmst_shopcode().equals(shopcode))actflag=true;
				    if(actflag)return acttb;
				}
			}
	    }
	    }
		return null;
	}
	
	/***
	 * 商户满减  ---取单个商户活动优惠金额
	 * @param cartmoney
	 * @return
	 */
	
	public static float getShopActMoney(HttpServletRequest request,HttpServletResponse response,String Shopcode){
		float cutmoney=0f;
		ArrayList<BrandPromotion> list = new ArrayList<BrandPromotion>();
		ArrayList<BrandPromotion> resultlist = new ArrayList<BrandPromotion>();
		
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		 clist.add(Restrictions.eq("d1acttb_status",new Long(1)));
		 clist.add(Restrictions.le("d1acttb_starttime", new Date()));
		 clist.add(Restrictions.ge("d1acttb_endtime", new Date()));
		 clist.add(Restrictions.eq("d1acttb_shopcode",Shopcode));
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("d1acttb_createdate"));
		
		 
		 List<BaseEntity> rlist=Tools.getManager(D1ActTb.class).getList(clist, olist, 0, 30);
		if(rlist==null||rlist.size()==0)return 0f;
		//System.out.println("=======================gjl:"+rlist.size());
		        //获取购物车里所有记录
				ArrayList<Cart> cartList = getCartItems(request,response) ;
        
		for(BaseEntity b:rlist){
			D1ActTb act= (D1ActTb)b;
			String actid=act.getId();
			int acttype= act.getD1acttb_acttype().intValue();
			float itemactmoney=0f;
			String itemactmemo="";
			 float shopactcartmoney=getCartShopActPayMoney(request, response,act);
			if(acttype==0||acttype==1||acttype==2||acttype==3){
			if(act.getD1acttb_snum3().floatValue()>0f&&shopactcartmoney>=act.getD1acttb_snum3().floatValue()){
				cutmoney+=act.getD1acttb_enum3().floatValue() ;
				itemactmoney=act.getD1acttb_enum3().floatValue();
				itemactmemo="该商品参加满"+act.getD1acttb_snum3()+"减"+itemactmoney;
			}else if(act.getD1acttb_snum2().floatValue()>0f&&shopactcartmoney>=act.getD1acttb_snum2().floatValue()){
				cutmoney+=act.getD1acttb_enum2().floatValue() ;
				itemactmoney=act.getD1acttb_enum2().floatValue();
				itemactmemo="该商品参加满"+act.getD1acttb_snum2()+"减"+itemactmoney;
			}else if(act.getD1acttb_snum1().floatValue()>0f&&shopactcartmoney>=act.getD1acttb_snum1().floatValue()){
				cutmoney+=act.getD1acttb_enum1().floatValue() ;
				itemactmoney=act.getD1acttb_enum1().floatValue();
				itemactmemo="该商品参加满"+act.getD1acttb_snum1()+"减"+itemactmoney;
			}
			}
			int actnum=0;
			for(Cart c:cartList){
				if(c.getActid()!=null&&c.getActid().longValue()==Tools.parseLong(actid)){
					actnum++;
				}
			}
			int num=0;
			long actallnum=0;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getActid()!=null&&cart.getActid().longValue()==Tools.parseLong(actid)){
					//System.out.println(cutmoney +"-------------111------------商品优惠金额"+new Long(Tools.parseLong(cutmoney+"")));
					num++;
					long cartactmoney=(long)Math.rint(itemactmoney*cart.getMoney()/shopactcartmoney); 
					cart.setActmemo(itemactmemo);
					if(num==actnum){
					cart.setActmoney(new Long((long)itemactmoney-actallnum));
					}else{
					cart.setActmoney(new Long(cartactmoney));
					}
					actallnum+=cartactmoney;
				Tools.getManager(Cart.class).update(cart, true);
				}
			}

		}
		return cutmoney ;
	}
	/***
	 * 商户满减活动 购物车总的优惠金额 
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getShopActCutMoney(HttpServletRequest request,HttpServletResponse response){
		float cutmoney=0f;
		 ArrayList<ShpMst> rlist=CartShopCodeHelper.getCartShopCode(request, response);
		 if (rlist==null)return 0f;
		 for(int i=0;i<rlist.size();i++){
			 ShpMst b = (ShpMst)rlist.get(i);
             if (b==null)continue;
             cutmoney+=getShopActMoney(request, response,b.getId());
		 }
		return cutmoney;
	}
	/***
	 * 商户满减活动 返回商户号和商户满减金额
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getShopActCutStr(HttpServletRequest request,HttpServletResponse response){
		String cutstr="";
		 ArrayList<ShpMst> rlist=CartShopCodeHelper.getCartShopCode(request, response);
		 if (rlist==null)return "";
			 for(int i=0;i<rlist.size();i++){
			 ShpMst b = (ShpMst)rlist.get(i);
				float cutmoney=0f;
             if (b==null)continue;
                 cutmoney=getShopActMoney(request, response,b.getId());
                 if(cutmoney>0f){
                	 cutstr+=b.getId()+":"+cutmoney+"@";
                 }
		 }
			 if(!Tools.isNull(cutstr)){
				 cutstr=cutstr.substring(0, cutstr.length()-1);
			 }
			
		return cutstr;
	}
	
	
	
	
	/***
	 * 推荐位券
	 * @param request
	 * @param response
	 * @param sprckcode
	 * @return
	 */
	public static float getCartSprckcodePayMoney(HttpServletRequest request,HttpServletResponse response,String sprckcode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(sprckcode!=null)sprckcode=sprckcode.trim();
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){
					boolean ppflag  = PromotionProductHelper.getPProductByCodeGdsidExist(sprckcode,cart.getProductId());
					if(!ppflag)continue ;
					long actmoney=0;
					if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
					total+=cart.getMoney()-actmoney;
				}
			}
			return Tools.getFloat(total,2);
		}
	}
	/***
	 * 获取推荐位券的购物车商品
	 * @param request
	 * @param response
	 * @param sprckcode
	 * @return
	 */
	public static String getCartSprckcodegdslist(HttpServletRequest request,HttpServletResponse response,String sprckcode){
		String retglist="";
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(sprckcode!=null)sprckcode=sprckcode.trim();
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return retglist;
		}else{
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){
					boolean ppflag  = PromotionProductHelper.getPProductByCodeGdsidExist(sprckcode,cart.getProductId());
					if(!ppflag)continue ;
					retglist+=cart.getProductId()+",";
				}
				if(retglist.length()>0)retglist=retglist.substring(0, retglist.length()-1);
			}
			return retglist;
		}
	}

	/**
	 * id是购物车里有的品牌，品牌名
	 * @param request
	 * @param response
	 * @return 非空的Map
	 */
	public static HashMap<String,String> getCartBrandsMap(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Brand> list = getCartBrands(request,response);
		HashMap<String,String> map = new HashMap<String,String>();
		if(list!=null&&list.size()>0){
			for(Brand b:list){
				if(b.getBrand_name()!=null)map.put(b.getBrand_name().trim(), "1");
			}
		}
		return map;
	}
	
	/**
	 * 得到购物车里所有商品的品牌（已经去重），用于计算品牌减免
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Brand> getCartBrands(HttpServletRequest request,HttpServletResponse response){
		//正常商品列表
		ArrayList<Cart> carts = CartHelper.getCartNormalProducts(request, response) ;
		if(carts==null||carts.size()==0)return null;
		
		HashMap<String,String> bmap = new HashMap<String,String>();
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			//000000表示没有品牌
			if(p.getGdsmst_brand()!=null&&p.getGdsmst_brand().trim().length()>0&&!"000000".equals(p.getGdsmst_brand().trim()))bmap.put(p.getGdsmst_brand().trim(), "");
		}
		
		ArrayList<Brand> resList = new ArrayList<Brand>();
		Iterator<String> it = bmap.keySet().iterator();
		while(it.hasNext()){
			Brand b = (Brand)Tools.getManager(Brand.class).findByProperty("brand_code", (String)it.next());
			if(b!=null)resList.add(b);
		}
		return resList ;
	}
	
	/**
	 * 得到购物车品牌减免应该减掉的钱！不能减运费！！！
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getBrandCutMoney(HttpServletRequest request,HttpServletResponse response){
		/*ArrayList<BrandPromotion> bplist = getCartBrandPromotion(request,response);
		if(bplist!=null&&bplist.size()>0){//如果满足品牌减免，合并生成一张品牌减免券
			float moneycut = 0f;
			for(BrandPromotion bp:bplist){
				if(bp.getBrdtktmst_value()!=null)moneycut+=bp.getBrdtktmst_value().floatValue();
			}
			float res = Tools.getFloat(moneycut, 2);
			
			//判断一下，以防万一
			if(res>CartHelper.getNormalProductMoney(request, response)){
				res = CartHelper.getNormalProductMoney(request, response) ;
			}
			
			return Tools.getFloat(res,2) ;//保留两位小数
		}else{
			return 0f ;
		}*/
		float res =0f;
		res=getBrandCutLists(request,response);
		if (res>0){
			 res = Tools.getFloat(res, 2);
			//判断一下，以防万一
				if(res>CartHelper.getNormalProductMoneypp(request, response)){
					//res = CartHelper.getNormalProductMoney(request, response) ;
					res =0f ;
				}
				return res;
		}
		else{
			return 0f;
		}
		
	}
	/**
	 * 返回所有可以打折商品的总价，用于判断是否满足E券和打折条件，不让用券的商品不算<br/>品牌减免
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoneypp(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null && !Tools.isNull(product.getGdsmst_rackcode())&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13){//让用券
						long actmoney=0;
						if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
						total+=cart.getMoney()-actmoney;
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	private static ArrayList<BrandPromotion> getBrandPromotionList(float cartmoney){
		ArrayList<BrandPromotion> list = new ArrayList<BrandPromotion>();
		ArrayList<BrandPromotion> resultlist = new ArrayList<BrandPromotion>();
		
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		 clist.add(Restrictions.eq("brdtktmst_validflag",new Long(1)));
		 clist.add(Restrictions.le("brdtktmst_startdate", new Date()));
		 clist.add(Restrictions.ge("brdtktmst_enddate", new Date()));
		 clist.add(Restrictions.le("brdtktmst_gdsvalue",cartmoney));
		 List<Order> olist=new ArrayList<Order>();
		 olist.add(Order.desc("brdtktmst_gdsvalue"));
		 List<BaseEntity> rlist=Tools.getManager(BrandPromotion.class).getList(clist, olist, 0, 500);
		if(rlist==null||rlist.size()==0)return null;
		//System.out.println("gjl:"+rlist.size());
		for(BaseEntity b:rlist){
			list.add((BrandPromotion)b);
			
		}
		resultlist.add(list.get(0));
		return resultlist ;
	}
	public static float getBrandCutLists(HttpServletRequest request,HttpServletResponse response){
		float cutmoney=0f;
		 ArrayList<BrandPromotion> rlist= getBrandPromotionList(CartHelper.getNormalProductMoneypp(request, response));
		 if (rlist==null)return 0f;
		 for(int i=0;i<rlist.size();i++){
			BrandPromotion b = (BrandPromotion)rlist.get(i);
			//System.out.println("gjl:"+b.getBrdtktmst_title());
             if (b==null)continue;
			ArrayList<BrandPromotionItem> rlistitem= getBrandPromotionitemList(Tools.parseLong(b.getId()));
			float mallmoney=0f;
			for(int j=0;j<rlistitem.size();j++){
				 BrandPromotionItem bitem = (BrandPromotionItem)rlistitem.get(j);
				 mallmoney+=getbrandPMoney(request,response,bitem.getBrdtktdtl_brand());
				// System.out.println("gjl:"+mallmoney);
			 }
			/*long ibs=0;
			if (((long)mallmoney)/b.getBrdtktmst_gdsvalue().longValue()>=2){
				ibs=1;
			}
			else{
				ibs=((long)mallmoney)/b.getBrdtktmst_gdsvalue().longValue();
			}
			cutmoney+=(float)(ibs*b.getBrdtktmst_value().longValue());*/
			
			if(b.getBrdtktmst_gdsvalue3().floatValue()>0f&&mallmoney>=b.getBrdtktmst_gdsvalue3().floatValue()){
				cutmoney+=(float)(b.getBrdtktmst_value3().longValue());
			}else if(b.getBrdtktmst_gdsvalue2().floatValue()>0f&&mallmoney>=b.getBrdtktmst_gdsvalue2().floatValue()){
				cutmoney+=(float)(b.getBrdtktmst_value2().longValue());
			}else if(mallmoney>=b.getBrdtktmst_gdsvalue().floatValue()){
				cutmoney+=(float)(b.getBrdtktmst_value().longValue());
			}
			//System.out.println(mallmoney+"gjl:"+cutmoney);
			
			
		 }
	
		
		return cutmoney;
	}
	public static String getBrandPitemLists(HttpServletRequest request,HttpServletResponse response){
		String resultbrandpitem="";
		 ArrayList<BrandPromotion> rlist= getBrandPromotionList(CartHelper.getNormalProductMoneypp(request, response));
		 if (rlist==null)return null;
		 for(int i=0;i<rlist.size();i++){
			BrandPromotion b = (BrandPromotion)rlist.get(i);
             if (b==null)continue;
			ArrayList<BrandPromotionItem> rlistitem= getBrandPromotionitemList(Tools.parseLong(b.getId()));
			float mallmoney=0f;
			for(int j=0;j<rlistitem.size();j++){
				 BrandPromotionItem bitem = (BrandPromotionItem)rlistitem.get(j);
				 mallmoney+=getbrandPMoney(request,response,bitem.getBrdtktdtl_brand());
			 }
			if(mallmoney>=b.getBrdtktmst_gdsvalue().floatValue()){
				for(int j=0;j<rlistitem.size();j++){
					 BrandPromotionItem bitem = (BrandPromotionItem)rlistitem.get(j);
					 resultbrandpitem+=","+bitem.getBrdtktdtl_brand();
				 }
			}
			
		 }
		 if (!Tools.isNull(resultbrandpitem)){
			 resultbrandpitem=resultbrandpitem+",";
		 }
	
		
		return resultbrandpitem;
	}
	
	private static float getbrandPMoney(HttpServletRequest request,HttpServletResponse response,String brand){
		float total=0f;
		ArrayList<Cart> carts = CartHelper.getCartNormalProductspp(request, response) ;
		if(carts==null||carts.size()==0)return 0f;
		for(int k=0;k<carts.size();k++){
			Cart cart = carts.get(k);
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			//if(p.getGdsmst_brand()!=null&&p.getGdsmst_brand().trim().equals(brand)){
			if(brand!=null&&brand.trim().length()>0&&p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(brand.trim())){//分类减免
				if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&!p.getGdsmst_rackcode().startsWith("014")){//让用券
					total+=cart.getMoney();
				}
			}
			
		}
		return total;
	}
	/**
	 * 得到购物车里所有正常商品（包括组合商品），赠品、虚拟品、其他优惠的商品都不算。///品牌减免用到的
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartNormalProductspp(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()>0&&c.getType().longValue()!=2&&c.getType().longValue()!=9&&c.getType().longValue()!=13&&c.getType().longValue()!=10){//独立商品，组合的也算
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	private static ArrayList<BrandPromotion> getBrandPromotionList(){
		ArrayList<BrandPromotion> list = new ArrayList<BrandPromotion>();
		
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		 clist.add(Restrictions.eq("brdtktmst_validflag",new Long(1)));
		 clist.add(Restrictions.le("brdtktmst_startdate", new Date()));
		 clist.add(Restrictions.ge("brdtktmst_enddate", new Date()));
		 List<BaseEntity> rlist=Tools.getManager(BrandPromotion.class).getList(clist, null, 0, 500);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((BrandPromotion)b);
		}
		
		return list ;
	}
	private static ArrayList<BrandPromotionItem> getBrandPromotionitemList(Long mid){
		ArrayList<BrandPromotionItem> list = new ArrayList<BrandPromotionItem>();
		
		List<SimpleExpression> clist=new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brdtktdtl_validflag",new Long(1)));
		clist.add(Restrictions.eq("brdtktdtl_mstid",mid));
		 List<BaseEntity> rlist=Tools.getManager(BrandPromotionItem.class).getList(clist, null, 0, 500);
		if(rlist==null||rlist.size()==0)return null;
		
		for(BaseEntity b:rlist){
			list.add((BrandPromotionItem)b);
		}
		
		return list ;
	}
	
	
	/**
	 * 返回所有可以打折商品的总价，用于判断是否满足E券和打折条件，不让用券的商品不算<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoney(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())
							&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9){//让用券
						long actmoney=0;
						if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
						total+=cart.getMoney()-actmoney;
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	/**
	 * 获取商户的可用优惠券的商品
	 * @param request
	 * @param response
	 * @param shopcode
	 * @return
	 */
	public static float getShopNormalProductMoney(HttpServletRequest request,HttpServletResponse response,String shopcode){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&!Tools.isNull(product.getGdsmst_shopcode())&&(product.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))
							&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//让用券
						long actmoney=0;
						if(cart.getActmoney()!=null&&cart.getActmoney()>0)actmoney=cart.getActmoney();
						total+=cart.getMoney()-actmoney;
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	
	/**
	 * 得到登录用户id下的购物车，只管userid
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getLoginUserCartItems(HttpServletRequest request,HttpServletResponse response){
		//获取登录状态的userid，不是登录状态返回null
		String loginUserId = UserHelper.getLoginUserId(request, response);
		
		ArrayList<Cart>	userCartList = getCartItemsViaUserId(loginUserId);
		
		ArrayList<Cart> rlist = new ArrayList<Cart>();
		String cookieValue = CartHelper.getCartCookieValue(request, response);
		if(userCartList!=null){
			for(Cart c:userCartList){
				if(c.getCookie()!=null&&c.getCookie().equals(cookieValue))continue;
				rlist.add(c);
			}
		}
			
		return rlist ;
	}
	
	/**
	 * 获取购物车里所有记录，只管cookie
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartItems(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> cookieCartList = null;
		Cookie cartCookie = Tools.getClientCookie(request,Const.CART_COOKIE_NAME);
		
		HttpSession session = request.getSession();

		if(cartCookie!=null&&cartCookie.getValue()!=null){
			cookieCartList = getCartItemsViaCookie(cartCookie.getValue());
		}else{
			cookieCartList = getCartItemsViaCookie((String)session.getAttribute("CART_COOKIE_ATTRIBUTE_VALUE"));
		}
		
		return cookieCartList ;
	}
	
	/**
	 * 根据cookie的值获取购物车里所有信息
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaCookie(String cookieValue){
		return getCartItems("cookie",cookieValue,true);
	}
	
	/**
	 * 根据userId的值获取购物车里所有信息
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaUserId(String userId){
		return getCartItems("userId",userId,true);
	}
	
	/**
	 * 获取购物车第一层商品，配合getCartItemsViaParentId方法可实现遍历购物车层级关系，也可直接用getCartItem方法获取所有购物车商品。
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getTopCartItems(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> allCarts = getCartItems(request,response);
		if(allCarts==null||allCarts.size()==0)return null;
		
		ArrayList<Cart> resList = new ArrayList<Cart>();
		for(int i=0;i<allCarts.size();i++){
			Cart c = allCarts.get(i);
			if(c.getHasFather().longValue()==0){
				resList.add(c);
			}
		}
		return resList ;
	}
	
	/**
	 * 根据父级cart id获取cart列表
	 * @param parentId cart对应的ParentId
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaParentId(String parentId){
		return getCartItems("parentId",parentId,false);
	}
	
	/**
	 * 把物品和2级物品排序放入一个list中
	 * @param request
	 * @param response
	 * @return ArrayList<Cart>
	 */
	public static ArrayList<Cart> getCartItemsOrder(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> listCart = null;
		
		ArrayList<Cart> list = getTopCartItems(request,response);
		if(list != null && !list.isEmpty()){
			listCart = new ArrayList<Cart>();
			for(Cart cart : list){
				listCart.add(cart);
				
				if(Tools.longValue(cart.getHasChild())==1){
					ArrayList<Cart> listChild = getCartItemsViaParentId(cart.getId());
					if(listChild != null && !listChild.isEmpty()){
						for(Cart childCart : listChild){
							listCart.add(childCart);
						}
					}
				}
			}
		}
		return listCart;
	}
	
	/**
	 * 清除购物车，删除购物车里的所有东西
	 * @param request
	 * @param response
	 */
	public static void clearAllCarts(HttpServletRequest request,HttpServletResponse response){
		clearAllCookieCarts(request,response);
		
		clearAllLoginUserCarts(request,response);
	}
	
	/**
	 * 清除cookie下的购物车所有条目
	 */
	public static void clearAllCookieCarts(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		String cookie = getCartCookieValue(request, response);
		
		
		if(!Tools.isNull(cookie)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("cookie", cookie));
			
			//获取列表
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//逐个删除
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//删除cart
					Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * 清除登录id下的购物车所有项目
	 * @param request
	 * @param response
	 */
	public static void clearAllLoginUserCarts(HttpServletRequest request,HttpServletResponse response){
		String userId = getCartUserId(request, response);
		
		if(!Tools.isNull(userId)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("userId", userId));
			
			//获取列表
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//逐个删除
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//删除cart
					Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * 根据字段名和字段值获取cart列表，根据层级关系获取！
	 * @param fieldName
	 * @param fieldValue
	 * @param getChild true表示连child一起加进来，false表示不加child
	 * @return
	 */
	private static ArrayList<Cart> getCartItems(String fieldName,String fieldValue,boolean getChild){
		//加入查询条件
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq(fieldName, fieldValue));
		
		//先取父级的，然后取子级cart
		if(getChild)clist.add(Restrictions.eq("hasFather", new Long(0)));
		
		//加入排序条件，按加入购物车时间排序
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("createDate"));
		
		//获取列表
		List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, olist, 0, 1000);
		
		//强制转换
		ArrayList<Cart> resList = new ArrayList<Cart>();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Cart cart = (Cart)list.get(i);
				resList.add(cart);
				if(getChild){
					if(cart.getHasChild().longValue()==1){//如果有子cart，也加入到列表里
						ArrayList<Cart> childList = getCartItemsViaParentId(cart.getId());
						if(childList!=null&&childList.size()>0){
							//全部加入到结果中
							for(int j=0;j<childList.size();j++)resList.add(childList.get(j));
						}
					}
				}//end if(getChild)
			}
		}
		
		return resList ;
	}
	
	/**
	 * 看一个商品是否在购物车里了，如果在的话修改数量即可
	 * @param request
	 * @param response
	 * @param productId 不能为null
	 * @param skuId 可以为null
	 * @param type type，不能为null
	 * @return cart 不为null表示存在
	 */
	private static Cart getCartViaProductId(HttpServletRequest request,HttpServletResponse response,String productId,String skuId,Long type){
		ArrayList<Cart> carts = getCartItems(request,response);
		if(carts==null||carts.size()==0||productId==null)return null ;
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			if(productId.equals(cart.getProductId())&&cart.getType().longValue()==type.longValue()){
				if(Tools.isNull(skuId)){
					return cart ;
				}else{
					if(skuId.equals(cart.getSkuId())){
						return cart ;
					}
				}
			}
		}
		return null ;
	}
	
	/**
	 * 把单个商品加入购物车，此处修改cookie或userId然后创建数据库，其他数据在jsp中设置。
	 * @param request 
	 * @param response
	 * @param cart Cart对象，非数据库对象，没有设置cookie或userId，但其他数据都设置好了。
	 * @return -1=购物车超过100条记录了，-2=参数错误，1=加入成功
	 */
	public static int addCart(HttpServletRequest request,HttpServletResponse response,Cart cart) {
		//如果同一个用户的购物车记录已经有100个，则不加入，避免被攻击
		ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);
		if(cartList!=null&&cartList.size()>100)return -1;
		
		if(cart==null)return -2;
		cart.setIp(request.getRemoteHost());//set the ip
		
		if(cart.getType().longValue()==1){
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			//如果是不让用券的商品，自动修改type
			if(p!=null&&p.getGdsmst_specialflag()!=null&&p.getGdsmst_specialflag().longValue()==1){
				cart.setType(new Long(10));
			}
			
			//如果是秒杀商品，设置一下tuanCode，这里的tuanCode=SecKill表示为秒杀商品
			SecKill sk_34434 = (SecKill)Tools.getManager(SecKill.class).findByProperty("mstjgds_gdsid", cart.getProductId());
			if(sk_34434!=null&&sk_34434.getMstjgds_state()!=null&&sk_34434.getMstjgds_state().longValue()==1){
				cart.setTuanCode("SecKill");//这里的tuanCode不是真正的tuanCode，借用一下
			}
		}
		
		Cart pcart = getCartViaProductId(request,response,cart.getProductId(),cart.getSkuId(),cart.getType().longValue()) ;
		
		//如果购物车不存在这件商品则创建，如果已经存在则修改数量即可
		if(pcart==null){
			//如果是非登录状态
			cart.setCookie(getCartCookieValue(request,response));
			cart.setUserId(getCartUserId(request,response));
			//创建时间
			cart.setCreateDate(new Date());
			cart.setIp(request.getRemoteHost());
			
			//创建cart到数据库
			Tools.getManager(Cart.class).create(cart);
		}else{
			pcart.setAmount(new Long(pcart.getAmount().longValue()+cart.getAmount().longValue()));
			pcart.setMoney(Tools.getFloat(new Float(pcart.getMoney().floatValue()+cart.getMoney().floatValue()),2));
			
			//修改数量即可，money在后面有修改
			Tools.getManager(Cart.class).update(pcart, false);
		}
		
		
		
		CartHelper.updateCartPrice(request, response, cart);
		
		//重新计算购物车所有Item，包括价格，赠品！！！！！！！！！
		updateAllCartItems(request,response);
		
		return 1;
	} 
	
	/**
	 * 获取购物车里所有积分兑换需要的积分，用以判断积分够不够支付
	 * @param request
	 * @param response
	 * @return
	 */
	public static long getCartTotalPoint(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> list = getCartItems(request, response);
		if(list==null|list.size()==0)return 0;
		long total = 0;
		for(Cart c:list){
			if(c.getType().longValue()==2||c.getType().longValue()==-5){//积分换购商品和兑换券需要的积分
				total+=c.getPoint().longValue();
			}
		}
		return total ;
	}
	
	/**
	 * 得到本次购物车的cookie值，如果没有，创建cookie
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getCartCookieValue(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();

		Cookie cartCookie = Tools.getClientCookie(request,Const.CART_COOKIE_NAME);
		if(cartCookie==null){
			//第一次用sessionId记录cookie
			if(session.getAttribute("CART_COOKIE_ATTRIBUTE_VALUE")==null){
				Cookie userCartCookie = new Cookie(Const.CART_COOKIE_NAME, MD5.toMD5(session.getId()+"#"+new Random().nextInt(1000000)));
				userCartCookie.setPath("/");
				userCartCookie.setDomain("d1.com.cn");
				userCartCookie.setMaxAge(60*60*24*30);//30天有效期
				response.addCookie(userCartCookie);
				session.setAttribute("CART_COOKIE_ATTRIBUTE_VALUE", userCartCookie.getValue());
				return userCartCookie.getValue();
			}else{
				return (String)session.getAttribute("CART_COOKIE_ATTRIBUTE_VALUE");
			}
		}else{
			return cartCookie.getValue();
		}
	}
	
	/**
	 * 得到本次购物车的userId
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getCartUserId(HttpServletRequest request,HttpServletResponse response){
		User loginUser = UserHelper.getLoginUser(request, response);
		if(loginUser!=null)return loginUser.getId();

		return null;
	}
	
	/**
	 * 把组合商品加入购物车
	 * @param request
	 * @param response
	 * @param packageId 商品组合id，就是套餐的id
	 * @param pmap key=商品id，value=skuid如果有sku的话
	 * @return -1=商品组合不存在，-2商品组合的明细为空，-3=传入的商品id不是套餐里的商品，-4=套餐已经加过一次了，-5=购物车超过100条记录了
	 */
	public static int addPackageProductToCart(HttpServletRequest request,HttpServletResponse response,String packageId,HashMap<String,String> pmap) {
		ProductPackage pp = (ProductPackage)Tools.getManager(ProductPackage.class).get(packageId);
		if(pp==null)return -1;
		
		List<BaseEntity> list = ProductPackageItemHelper.getGdsmstByGdspid(packageId);
		if(list==null||list.size()==0)return -2;
		
		Iterator<String> it = pmap.keySet().iterator();
		while(it.hasNext()){
			String ppid = it.next();//商品id
			boolean flag = false ;
			for(BaseEntity be:list){
				ProductPackageItem ppi = (ProductPackageItem)be;
				if(ppi.getGdspktdtl_gdsid().equals(ppid)){
					flag = true ;
					break ;
				}
			}
			
			if(!flag){
				return -3;
			}
		}
		
		ArrayList<Cart> cartList = getCartItems(request, response);
		
		if(cartList!=null&&cartList.size()>100)return -5;
		
		Cart cartAdded = null ;//该套餐是否加过购物车
		if(cartList!=null){
			for(Cart c23:cartList){
				if(c23.getType().longValue()==-1&&pp.getId().equals(c23.getProductId())){
					cartAdded = c23 ;
					break;
				}
			}
		}
		if(cartAdded==null){//第一次加入套餐
			Cart pcart = new Cart();
			pcart.setAmount(new Long(1));
			pcart.setCreateDate(new Date());
			pcart.setCookie(getCartCookieValue(request,response));
			pcart.setHasChild(new Long(1));
			pcart.setHasFather(new Long(0));
			pcart.setIp(request.getRemoteHost());
			pcart.setMoney(new Float(0));
			pcart.setOldPrice(new Float(0));
			pcart.setPoint(new Long(0));
			pcart.setPrice(new Float(0));//后面会修改Price的
			pcart.setTitle("【组合购买】"+Tools.clearHTML(pp.getGdspkt_title()));
			pcart.setType(new Long(-1));//-1表示虚拟商品
			pcart.setVipPrice(new Float(0));
			pcart.setUserId(getCartUserId(request,response));
			pcart.setProductId(pp.getId());//这里放入套餐的id
			
			Tools.getManager(Cart.class).create(pcart);
			
			Iterator<String> it2 = pmap.keySet().iterator();
			
			float total_money_pcart = 0,old_total_money_pcart=0;//本次套餐单价，原价
			
			while(it2.hasNext()){
				String ppid = it2.next();//商品id
				
				ProductPackageItem ppi123 = null ;
				for(BaseEntity be:list){
					ProductPackageItem ppi = (ProductPackageItem)be;
					if(ppi.getGdspktdtl_gdsid().equals(ppid)){
						ppi123 = ppi ;
						break ;
					}
				}
	
				//创建套餐子项
				Product pc = (Product)Tools.getManager(Product.class).get(ppid);
				boolean ismiaoshao=CartHelper.getmsflag(pc);
				float mprice=pc.getGdsmst_memberprice().floatValue();
				if(ismiaoshao)mprice=pc.getGdsmst_msprice().floatValue();
				Cart ccart = new Cart();
				ccart.setAmount(new Long(1));
				ccart.setCreateDate(new Date());
				ccart.setCookie(getCartCookieValue(request,response));
				ccart.setHasChild(new Long(0));
				ccart.setHasFather(new Long(1));
				ccart.setIp(request.getRemoteHost());
				ccart.setMoney(Tools.getFloat(mprice-ppi123.getGdspktdtl_savemoney().floatValue(),2));//套餐的价格
				ccart.setOldPrice(Tools.getFloat(mprice, 2));
				ccart.setPoint(new Long(0));
				ccart.setSkuId(pmap.get(ppid));
				ccart.setPrice(Tools.getFloat(mprice-ppi123.getGdspktdtl_savemoney().floatValue(),2));
				ccart.setTitle("【组合购买】"+Tools.clearHTML(pc.getGdsmst_gdsname()));
				ccart.setProductId(pc.getId());
				ccart.setType(new Long(8));//8表示组合商品
				ccart.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*mprice, 2));
				ccart.setUserId(getCartUserId(request,response));
				ccart.setParentId(pcart.getId());
				Tools.getManager(Cart.class).create(ccart);
				
				total_money_pcart+=ccart.getPrice().floatValue();
				old_total_money_pcart+=mprice;
			}
			
			pcart.setPrice(Tools.getFloat(total_money_pcart,2));
			pcart.setOldPrice(Tools.getFloat(old_total_money_pcart, 2));
			pcart.setMoney(Tools.getFloat(pcart.getAmount().longValue()*total_money_pcart,2));
			
			Tools.getManager(Cart.class).update(pcart, false);//修改套餐单价
		}else{//多次加入同一个套餐，不允许
			return -4 ;
		}
		
		updateAllCartItems(request,response);
		
		return 1;
	}
	
	/**
	 * 得到团购商品的数量，用于限制团购商品总数
	 * @param request
	 * @param response
	 * @param productId 商品id
	 * @return
	 */
	private static int getTuanProductCount(HttpServletRequest request,HttpServletResponse response,String productId){
		ArrayList<Cart> list = getCartItems(request,response);
		if(list==null||list.size()==0)return 0;
		int total = 0 ;
		for(Cart c:list){
			if(c.getType().longValue()==6&&c.getProductId()!=null
					&&c.getProductId().equals(productId)){
				total++;
			}
		}
		return total;
	}
	
	/**
	 * 把团购商品加入购物车
	 * @param request
	 * @param response
	 * @param pgid ProductGroup的id，注意，不是商品id
	 * @param skuId sku id一般为null，比如团化妆品的时候
	 * @param amount 数量
	 * @return -1对应的ProductGroup为空，-2=商品为空，-3=超过团购限制数量了，1=成功，-4=数据库操作失败，-5=购物车超过100条记录了
	 * 			-6 团购还未开始，-7团购结束。-8数量错误。
	 */
	public static int addTuanProductToCart(HttpServletRequest request,HttpServletResponse response,String pgid,String skuId,int amount){
		ProductGroup pg = (ProductGroup)Tools.getManager(ProductGroup.class).get(pgid);
		if(pg==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(pg.getTgrpmst_gdsid());
		if(product==null)return -2;
		
		if(amount <= 0) return -8;
		
		//大于商品团购总数了
		if(amount+getTuanProductCount(request,response,product.getId())>pg.getTgrpmst_maxcount().intValue())return -3;
		
		long currentTime = System.currentTimeMillis();
		if(currentTime < Tools.dateValue(pg.getTgrpmst_starttime())) return -6;
		if(currentTime > Tools.dateValue(pg.getTgrpmst_endtime())) return -7;
		
		Cart cartAdded = null ; //是否加过了
		
		ArrayList<Cart> list = getCartItems(request,response);
		
		if(list!=null&&list.size()>100)return -5;
		
		if(list!=null){
			for(Cart c:list){
				if(c.getType().longValue()==6&&c.getProductId().equals(product.getId())){
					if(skuId!=null&&skuId.equals(c.getSkuId())){
						cartAdded = c ;
						break ;
					}else if(Tools.isNull(skuId)&&Tools.isNull(c.getSkuId())){
						cartAdded = c ;
						break ;
					}
				}
			}
		}
		
		if(cartAdded==null){
			Cart c = new Cart();
			c.setAmount(new Long(amount));
			c.setCookie(getCartCookieValue(request, response));
			c.setCreateDate(new Date());
			c.setHasChild(new Long(0));
			c.setHasFather(new Long(0));
			c.setIp(request.getRemoteHost());
			c.setMoney(Tools.getFloat(pg.getTgrpmst_sprice().floatValue(), 2));
			c.setPrice(Tools.getFloat(pg.getTgrpmst_sprice().floatValue(), 2));
			c.setOldPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
			c.setPoint(new Long(0));
			c.setProductId(product.getId());
			c.setSkuId(skuId);
			c.setTitle("【团购商品】"+Tools.clearHTML(product.getGdsmst_gdsname()));
			c.setType(new Long(6));
			c.setUserId(getCartUserId(request,response));
			c.setAwardId(pg.getId());//award id 放入了ProductGroup的id
			c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
			Tools.getManager(Cart.class).create(c);
			
			updateAllCartItems(request,response);
			if(c.getId()!=null){
				return 1;
			}else{
				return -4;
			}
		}else{//修改数量即可
			cartAdded.setAmount(new Long(cartAdded.getAmount().longValue()+amount));
			cartAdded.setMoney(Tools.getFloat(new Float(cartAdded.getPrice().floatValue()*cartAdded.getAmount().longValue()),2));
			boolean ret = Tools.getManager(Cart.class).update(cartAdded, false);
			
			updateAllCartItems(request,response);
			if(ret){
				return 1;
			}else{
				return -4;
			}
		}
	}
	
	
	/**
	 * 把团购商品加入购物车(2012-3-16)
	 * @param request
	 * @param response
	 * @param pgid PromotionProduct的id，注意，不是商品id
	 * @param skuId sku id一般为null，比如团化妆品的时候
	 * @param amount 数量
	 * @return -1对应的PromotionProduct为空，-2=商品为空，-3=超过团购限制数量了，1=成功，-4=数据库操作失败，-5=购物车超过100条记录了
	 * 			-6 团购还未开始，-7团购结束。-8数量错误。
	 */
	public static int addTuanProductToCartNew(HttpServletRequest request,HttpServletResponse response,String pgid,String skuId,int amount){
		PromotionProduct pg = (PromotionProduct)Tools.getManager(PromotionProduct.class).get(pgid);
		if(pg==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(pg.getSpgdsrcm_gdsid());
		if(product==null)return -2;
		
		if(amount <= 0) return -8;
		
		//大于商品团购总数了
		if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().longValue()!=0)
		{
		    if(amount+getTuanProductCount(request,response,product.getId())>product.getGdsmst_buylimit().longValue())return -3;
		}
		long currentTime = System.currentTimeMillis();
		if(currentTime < Tools.dateValue(pg.getSpgdsrcm_begindate())) return -6;
		if(currentTime > Tools.dateValue(pg.getSpgdsrcm_enddate())) return -7;
		
		Cart cartAdded = null ; //是否加过了
		
		ArrayList<Cart> list = getCartItems(request,response);
		
		if(list!=null&&list.size()>100)return -5;
		
		if(list!=null){
			for(Cart c:list){
				if(c.getType().longValue()==6&&c.getProductId().equals(product.getId())){
					if(skuId!=null&&skuId.equals(c.getSkuId())){
						cartAdded = c ;
						break ;
					}else if(Tools.isNull(skuId)&&Tools.isNull(c.getSkuId())){
						cartAdded = c ;
						break ;
					}
				}
			}
		}
		
		if(cartAdded==null){
			Cart c = new Cart();
			c.setAmount(new Long(amount));
			c.setCookie(getCartCookieValue(request, response));
			c.setCreateDate(new Date());
			c.setHasChild(new Long(0));
			c.setHasFather(new Long(0));
			c.setIp(request.getRemoteHost());
			c.setMoney(Tools.getFloat(pg.getSpgdsrcm_tjprice().floatValue(), 2));
			c.setPrice(Tools.getFloat(pg.getSpgdsrcm_tjprice().floatValue(), 2));
			c.setOldPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
			c.setPoint(new Long(0));
			c.setProductId(product.getId());
			c.setSkuId(skuId);
			c.setTitle("【团购商品】"+Tools.clearHTML(product.getGdsmst_gdsname()));
			c.setType(new Long(6));
			c.setUserId(getCartUserId(request,response));
			c.setAwardId(pg.getId());//award id 放入了ProductGroup的id
			c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
			Tools.getManager(Cart.class).create(c);
			
			updateAllCartItems(request,response);
			if(c.getId()!=null){
				return 1;
			}else{
				return -4;
			}
		}else{//修改数量即可
			cartAdded.setAmount(new Long(cartAdded.getAmount().longValue()+amount));
			cartAdded.setMoney(Tools.getFloat(new Float(cartAdded.getPrice().floatValue()*cartAdded.getAmount().longValue()),2));
			boolean ret = Tools.getManager(Cart.class).update(cartAdded, false);
			
			updateAllCartItems(request,response);
			if(ret){
				return 1;
			}else{
				return -4;
			}
		}
	}
	
	
	
	
	/**
	 * 把赠品加入购物车
	 * @param request
	 * @param response
	 * @param gf 相关参数
	 * @param skuid sku id
	 * @return -1=参数错误，-2=商品为空，-3=数据库创建错误，-5=已经加过一次了
	 */
	public static int addGiftProductToCart(HttpServletRequest request,HttpServletResponse response,GiftHelper.GiftGoods gf,String skuId){
		if(gf==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(gf.getProductId());
		if(product==null)return -2;
		
		Cart cartAdded = null ; //是否加过了
		
		ArrayList<Cart> list = getCartItems(request,response);
		
		if(list!=null&&list.size()>100)return -5;
		
		if(list!=null){
			for(Cart c:list){
				if(c.getType().longValue()==0&&c.getProductId().equals(product.getId())){
					if(skuId!=null&&skuId.equals(c.getSkuId())){
						cartAdded = c ;
						break ;
					}else if(Tools.isNull(skuId)&&Tools.isNull(c.getSkuId())){
						cartAdded = c ;
						break ;
					}
				}
			}
		}
	     String  gfgdsid= product.getId();
	     
		//第二个条件：然后判断排他性，先判断“单选”的赠品组是否选择了多个！！！！！！				
				ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
				
				if(gifts!=null&&gifts.size()>0){
					for(int j=0;j<gifts.size();j++){
						Gift gift = gifts.get(j);
					
						//比较单选下面的赠品是否选择了多个
						if(gift.getGiftrckmst_selecttype()!=null&&gift.getGiftrckmst_selecttype().longValue()==0){
							//分类赠品明细
							ArrayList<GiftItem> itemList = GiftHelper.getGiftItems(gift.getId());
							if(itemList==null||itemList.size()==0)continue;
							int gfhaveflag=0;
							int gfhaveflag2=0;
								for(Cart c:list){
									if(itemList!=null&&itemList.size()>0){
										for(int b=0;b<itemList.size();b++){
											GiftItem gi = itemList.get(b);
											if(gfgdsid.equals(gi.getGiftrckdtl_gdsid())){
												gfhaveflag=1;
											}
											if(c.getProductId()!=null&&c.getType()!=null&&c.getType().longValue()==0
													&&c.getProductId().equals(gi.getGiftrckdtl_gdsid())){//存在
												gfhaveflag2=1;
											}
											

										} 
									}
						}//cart
							if(gfhaveflag==1&&gfhaveflag2==1) {
								return -6;
							}
					} 
			  }
		}
		
		

		if(cartAdded==null){
			Cart c = new Cart();
			c.setAmount(new Long(1));
			c.setCookie(getCartCookieValue(request, response));
			c.setCreateDate(new Date());
			c.setHasChild(new Long(0));
			c.setHasFather(new Long(0));
			c.setIp(request.getRemoteHost());
			c.setMoney(Tools.getFloat(gf.getPrice(), 2));
			c.setPrice(Tools.getFloat(gf.getPrice(), 2));
			c.setOldPrice(Tools.getFloat(product.getGdsmst_memberprice(),2));
			c.setPoint(new Long(0));
			c.setProductId(product.getId());
			c.setSkuId(skuId);
			c.setTitle("【赠品】"+Tools.clearHTML(gf.getName()));
			c.setType(new Long(0));
			c.setGiftRackcode(gf.getRackcode());
			c.setGiftType(gf.getGiftMstId()+"||"+gf.getValue());
			c.setShopcode(product.getGdsmst_shopcode());
			c.setUserId(getCartUserId(request,response));
			c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
			Tools.getManager(Cart.class).create(c);
			
			updateAllCartItems(request,response);
			if(c.getId()!=null){
				return 1;
			}else{
				return -3;
			}
		}else{//修改数量即可
			return -5;
		}
	}
	
	/**
	 * X元选Y件加入购物车
	 * @param request
	 * @param response
	 * @param code 推荐位号，也就是ProductXsY的id
	 * @param pmap key=商品id，value=skuId如果有的话
	 * @return -1=ProductXsY不存在，-2=参数错误，-3=没有推荐位商品，-4=商品不属于x元选Y件的商品，-5=已经加过了(加过的只能修改数量)，-6=数量不对，必须选X件，-7=购物车超过100件商品了
	 */
	public static int addXsYProductToCart(HttpServletRequest request,HttpServletResponse response,String code,HashMap<String,String> pmap) {
		ProductXsY pxy = (ProductXsY)Tools.getManager(ProductXsY.class).get(code);
		if(pxy==null)return -1;
		
		if(pmap==null)return -2;
		
		ArrayList<PromotionProduct> list=PromotionProductHelper.getPromotionProductByCode(code);
		if(list==null||list.size()==0)return -3;
		
		Iterator<String> it = pmap.keySet().iterator();
		int maxcount=0;
		while(it.hasNext()){
			maxcount++;
			String gdsid = it.next();
			boolean flag = false ;//是否合法
			for(PromotionProduct pp:list){
				if(gdsid.equals(pp.getSpgdsrcm_gdsid())){
					flag = true ;
					break ;
				}
			}
			if(!flag){
				return -4;
			}
		}
		
		if(maxcount!=pxy.getGdsmstxsy_maxcount().intValue())return -6;
		
		Cart cartAdded = null ;//是否已经选过了
		ArrayList<Cart> cartList = getCartItems(request, response);
		
		if(cartList!=null&&cartList.size()>100)return -7;
		
		if(cartList!=null){
			for(Cart c123:cartList){
				//这里ProductId放入XsY的推荐位id
				if(c123.getType().longValue()==-2&&c123.getProductId().equals(code)){
					cartAdded = c123;
					break ;
				}
			}
		}
		
		if(cartAdded==null){
			Cart pcart = new Cart();
			pcart.setAmount(new Long(1));
			pcart.setCreateDate(new Date());
			pcart.setCookie(getCartCookieValue(request,response));
			pcart.setHasChild(new Long(1));
			pcart.setHasFather(new Long(0));
			pcart.setIp(request.getRemoteHost());
			pcart.setMoney(new Float(0));
			pcart.setOldPrice(new Float(0));
			pcart.setPoint(new Long(0));
			pcart.setParentId("0");
			pcart.setPrice(new Float(0));//后面会修改price
			pcart.setTitle("【组合特惠】"+Tools.clearHTML(pxy.getGdsmstxsy_title()));
			pcart.setType(new Long(-2));//-2表示X元选Y件父节点
			pcart.setVipPrice(new Float(0));
			pcart.setUserId(getCartUserId(request,response));
			pcart.setProductId(code);//这里放入XsY的推荐位id
			
			Tools.getManager(Cart.class).create(pcart);
			
			Iterator<String> it2 = pmap.keySet().iterator();
			
			float total_money_pcart = Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue(),2);//本次XsY套餐单价
			float total_old_money = 0f ;
			
			while(it2.hasNext()){
				String ppid = it2.next();//商品id
				
				//创建套餐子项
				Product pc = (Product)Tools.getManager(Product.class).get(ppid);
				Cart ccart = new Cart();
				ccart.setAmount(new Long(1));
				ccart.setProductId(pc.getId());
				ccart.setTitle(Tools.clearHTML(pc.getGdsmst_gdsname()));
				ccart.setSkuId(pmap.get(pc.getId()));
				ccart.setCreateDate(new Date());
				ccart.setCookie(getCartCookieValue(request,response));
				ccart.setHasChild(new Long(0));
				ccart.setHasFather(new Long(1));
				ccart.setIp(request.getRemoteHost());
				ccart.setMoney(Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue()/pxy.getGdsmstxsy_maxcount().longValue(),2));
				ccart.setOldPrice(Tools.getFloat(pc.getGdsmst_memberprice(), 2));
				ccart.setPoint(new Long(0));
				ccart.setSkuId(pmap.get(ppid));
				ccart.setPrice(Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue()/pxy.getGdsmstxsy_maxcount().longValue(),2));
				ccart.setType(new Long(4));//4表示XsY组合商品
				ccart.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*pc.getGdsmst_memberprice().floatValue(), 2));
				ccart.setUserId(getCartUserId(request,response));
				ccart.setParentId(pcart.getId());
				Tools.getManager(Cart.class).create(ccart);
				
				total_old_money+=pc.getGdsmst_memberprice().floatValue();
			}
			
			pcart.setPrice(Tools.getFloat(new Float(total_money_pcart),2));
			pcart.setOldPrice(Tools.getFloat(new Float(total_old_money),2));
			pcart.setMoney(Tools.getFloat(total_money_pcart*pcart.getAmount().longValue(), 2));
			Tools.getManager(Cart.class).update(pcart, false);//修改套餐单价
		}else{
			return -5;
		}
		
		updateAllCartItems(request,response);
		return 1;
	}
	

	/**
	 * 把积分商品放入购物车，外围程序要判断用户是否登陆、积分是否足够！！！
	 * @param request
	 * @param response
	 * @param gdsid 商品id
	 * @param skuId 商品的skuid，如果有的话
	 * @param awardId Award的id
	 * @return -1=商品为空，-2=award记录为空，-3=不是登陆用户，-4=用户积分不够，1=加入成功，-5=数据库创建失败，-6=购物车超过100调记录了
	 */
	public static int addJifenProductToCart(HttpServletRequest request,HttpServletResponse response,String gdsid,String skuId,String awardId) {
		if(!"00000000".equals(gdsid)){//000000表示兑换券
			Product product =  (Product)Tools.getManager(Product.class).get(gdsid);
			if(product==null)return -1;
			
			//积分换购对应关系
			Award award = (Award)Tools.getManager(Award.class).get(awardId);
			if(award==null||award.getAward_value()==null)return -2 ;
			
			User loginUser = UserHelper.getLoginUser(request, response);
			if(loginUser==null)return -3 ;
			
			float ppoint = award.getAward_value().floatValue();//兑换商品的积分值
			long upoint = UsrPointHelper.getUseScore(loginUser.getId());//用户的总积分
			
			if(ppoint+getCartTotalPoint(request,response)>upoint)return -4 ;
			
			Cart c_added = null ;//商品是否加入过购物车
			ArrayList<Cart> list = getCartItems(request, response);
			
			if(list!=null&&list.size()>100)return -6;
			
			if(list!=null){
				for(Cart cart:list){
					if(gdsid.equals(cart.getProductId()) && cart.getType().longValue()==2){
						if(skuId!=null&&skuId.equals(cart.getSkuId())){
							c_added = cart ;
							break ;
						}else if(Tools.isNull(skuId)&&Tools.isNull(cart.getSkuId())){
							c_added = cart ;
							break ;
						}
					}
				}
			}
			
			if(c_added==null){
				Cart c = new Cart();
				c.setTitle("【积分换购】"+Tools.clearHTML(product.getGdsmst_gdsname()));
				c.setParentId("0");
				c.setProductId(product.getId());
				c.setAmount(new Long(1));
				c.setCreateDate(new Date());
				c.setCookie(getCartCookieValue(request,response));
				c.setHasChild(new Long(0));
				c.setHasFather(new Long(0));
				c.setIp(request.getRemoteHost());
				c.setMoney(Tools.getFloat(award.getAward_price(),2));//加多少钱
				c.setPrice(Tools.getFloat(award.getAward_price(),2));//单个要多少钱
				c.setOldPrice(product.getGdsmst_memberprice());
				c.setPoint(award.getAward_value());
				c.setShopcode(product.getGdsmst_shopcode());
				c.setSkuId(skuId);
				c.setType(new Long(2));//积分换购
				c.setUserId(loginUser.getId());
				c.setAwardId(award.getId());
				c.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*product.getGdsmst_memberprice(),2));
				
				Tools.getManager(Cart.class).create(c);
				
				updateAllCartItems(request,response);
				
				if(c.getId()!=null){
					return 1;
				}else{
					return -5;
				}
			}else{//修改数量即可
				c_added.setAmount(new Long(c_added.getAmount().longValue()+1));
				c_added.setMoney(Tools.getFloat(c_added.getAmount().longValue()*award.getAward_price(),2));
				c_added.setUserId(loginUser.getId());
				c_added.setPoint(new Long(c_added.getAmount().longValue()*award.getAward_value().longValue()));
				boolean ret = Tools.getManager(Cart.class).update(c_added, false);
				
				updateAllCartItems(request,response);
				
				if(ret)return 1;
				else return -5;
			}
		}else{//兑换券
			//积分换购对应关系
			Award award = (Award)Tools.getManager(Award.class).get(awardId);
			if(award==null||award.getAward_value()==null)return -2 ;
			
			User loginUser = UserHelper.getLoginUser(request, response);
			if(loginUser==null)return -3 ;
			
			
			float ppoint = award.getAward_value().floatValue();//兑换商品的积分值
			float upoint = UserScoreHelper.getRealScore(loginUser.getId());//用户的总积分
			
			if(ppoint+getCartTotalPoint(request,response)>upoint)return -4 ;
			
			Cart c_added = null ;//商品是否加入过购物车
			ArrayList<Cart> list = getCartItems(request, response);
			
			if(list!=null&&list.size()>100)return -6;
			
			if(list!=null){
				for(Cart cart:list){
					if(award.getId().equals(cart.getProductId()) && cart.getType().longValue()==-5){
							c_added = cart ;
							break ;
					}
				}
			}
			
			if(c_added==null){//没有兑换过则创建
				Cart c = new Cart();
				c.setTitle("【积分换购】"+Tools.clearHTML(award.getAward_gdsname()));
				c.setParentId("0");
				c.setProductId(award.getId());//注意，这里放入的是award id
				c.setAmount(new Long(1));
				c.setCreateDate(new Date());
				c.setCookie(getCartCookieValue(request,response));
				c.setHasChild(new Long(0));
				c.setHasFather(new Long(0));
				c.setIp(request.getRemoteHost());
				c.setMoney(Tools.getFloat(award.getAward_price(),2));//加多少钱
				c.setPrice(Tools.getFloat(award.getAward_price(),2));//单个要多少钱
				c.setOldPrice(Tools.getFloat(award.getAward_price().floatValue(),2));
				c.setPoint(award.getAward_value());
				c.setShopcode(award.getAward_shopcode());
				c.setSkuId("");
				c.setType(new Long(-5));//type=-5
				c.setUserId(loginUser.getId());
				c.setVipPrice(Tools.getFloat(award.getAward_price(),2));
				c.setAwardId(award.getId());
				
				Tools.getManager(Cart.class).create(c);
				
				updateAllCartItems(request,response);
				
				if(c.getId()!=null){
					return 1;
				}else{
					return -5;
				}
			}else{
				c_added.setAmount(new Long(c_added.getAmount().longValue()+1));
				c_added.setMoney(Tools.getFloat(c_added.getAmount().longValue()*award.getAward_price(),2));
				c_added.setUserId(loginUser.getId());
				c_added.setPoint(new Long(c_added.getAmount().longValue()*award.getAward_value().longValue()));
				boolean ret = Tools.getManager(Cart.class).update(c_added, false);
				
				updateAllCartItems(request,response);
				
				if(ret)return 1;
				else return -5;
			}
		}
	}
	
	/**
	 * 把一个商品从购物车里删除
	 * @param request
	 * @param response
	 * @param productId
	 */
	public static ArrayList<Cart> deleteCart(HttpServletRequest request,HttpServletResponse response,String cartId){
		//从数据库删除
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		
		if(cart==null)return null;
		
		ArrayList<Cart> list1 = new ArrayList<Cart>();
		
		String cookie_v = CartHelper.getCartCookieValue(request, response);
		String userId_v = CartHelper.getCartUserId(request, response);
		
		if((cookie_v!=null&&cookie_v.equals(cart.getCookie()))||(userId_v!=null&&userId_v.equals(cart.getUserId()))){
			
			if(cart.getHasChild().longValue()==1){
				//获取子cart列表
				ArrayList<Cart> childCart = getCartItemsViaParentId(cart.getId());
				//删子节点
				if(childCart!=null&&childCart.size()>0){
					for(int i=0;i<childCart.size();i++){
						Cart cc = childCart.get(i);
						if(Tools.getManager(Cart.class).delete(cc)){
							list1.add(cc);
						}
					}
				}
			}
			//删主节点，主节点删除后不显示提示信息，所以不用加入到list1中
			if(Tools.getManager(Cart.class).delete(cart)){
				//list1.add(cart);
			}
			
		}else{
			System.err.println("deleteCart:删除失败，权限不够，cart id="+cart.getId()+"，来源ip="+request.getRemoteHost());
		}
		
		//重新计算购物车所有Item，包括价格，赠品！！！！！！！！！
		List<Cart> list2 = updateAllCartItems(request,response);
		
		ArrayList<Cart> rlist = new ArrayList<Cart>();
		if(list1!=null&&list1.size()>0){
			for(Cart c_123:list1)rlist.add(c_123);
		}
		
		if(list2!=null&&list2.size()>0){
			for(Cart c_123:list2)rlist.add(c_123);
		}
		
		return rlist ;
	}
	
	/**
	 * 修改购物车里某个商品的数量，修改数量不能修改成0，若修改成0，用deleteCart方法！！！
	 * @param request
	 * @param response
	 * @param cartId 购物车id
	 * @param amount 修改的目标数量 
	 */
	public static List<Cart> updateCartAmount(HttpServletRequest request,HttpServletResponse response,String cartId,int amount) {
		//从数据库删除
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		if(cart==null){
			return null ;
		}else{
			//获取子cart列表
			ArrayList<Cart> childCart = getCartItemsViaParentId(cart.getId());
			//修改所有子节点数量，支付价在后面修改
			if(childCart!=null&&!childCart.isEmpty()){
				for(Cart c : childCart){
					c.setAmount(new Long(amount));
					c.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(c, false);
				}
			}
			//修改购物车
			cart.setAmount(new Long(amount));
			cart.setIp(request.getRemoteHost());
			Tools.getManager(Cart.class).update(cart,false);
		}
				
		//重新计算购物车所有Item，包括价格，赠品！！！！！！！！！
		return updateAllCartItems(request,response);		
	}
	
	/**
	 * 修改购物车里某个商品的skuid
	 * @param request
	 * @param response
	 * @param cartId 购物车id
	 * @param skuid 修改的目标数量 
	 */
	public static boolean updateCartSkuId(HttpServletRequest request,HttpServletResponse response,String cartId,String skuid) {
		//从数据库删除
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		if(cart==null){
			return false ;
		}else{
			
			//修改购物车
			cart.setSkuId(skuid);
			cart.setIp(request.getRemoteHost());
			return Tools.getManager(Cart.class).update(cart,false);
		}
	
	}
	
	
	
	/**
	 * 更新购物车里所有信息，购物车只要有变动都要重新算一遍。逻辑非常复杂，注意！
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 删除的Cart
	 */
	public static List<Cart> updateAllCartItems(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		synchronized(session){
			//检查更新购物车价格，不同会员级别价格不同
			updateCartPrice(request,response);
			
			//检查更新购物车赠品，把不符合条件的赠品删除，把符合条件的单品赠品自动加入购物车
			return updateCartGift(request,response);
		}
	}
	
	/**
	 * 检查并更新购物车赠品对不对
	 * @param request
	 * @param response
	 * @return 返回删除掉的Cart
	 */
	private static List<Cart> updateCartGift(HttpServletRequest request,HttpServletResponse response){
		List<Cart> list = new ArrayList<Cart>();
		
		
		//检查或删除单品赠品
		List<Cart> list1 = checkOrDeleteProductGift(request,response);

		//检查其他赠品是否有效，如果无效自动删除！！！
		List<Cart> list2 = checkOrDeleteGift(request,response);
		
		//自动删除下架的商品
		List<Cart> list0 = checkOrDeleteValidProduct(request,response);
		
		
		if(list0!=null&&list0.size()>0){
			for(Cart cc123:list0){
				list.add(cc123);
			}
		}
		
		if(list1!=null&&list1.size()>0){
			for(Cart cc123:list1){
				list.add(cc123);
			}
		}
		
		if(list2!=null&&list2.size()>0){
			for(Cart cc123:list2){
				list.add(cc123);
			}
		}
		
		return list ;
	}
	
	/**
	 * 删除下架的商品
	 * @param request
	 * @param response
	 * @return
	 */
	private static List<Cart> checkOrDeleteValidProduct(HttpServletRequest request,HttpServletResponse response){
		//购物车所有数据
		ArrayList<Cart> carts = getCartItems(request,response);
		if(carts==null||carts.size()==0)return null;
		
		List<Cart> rlist = new ArrayList<Cart>();
		
		for(Cart cart:carts){
			if(cart.getType().longValue()>=0){//检查所有商品
				Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
				
				//商品下架了，删除商品、所有孩子和所有父亲
				if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1&&product.getGdsmst_validflag().longValue()!=4){
					if(cart.getHasChild().longValue()==1){//如果有孩子
						ArrayList<Cart> childCarts = CartHelper.getCartItemsViaParentId(cart.getId());
						if(childCarts!=null&&childCarts.size()>0){
							for(Cart cc90:childCarts){
								if(Tools.getManager(Cart.class).delete(cc90)){
									rlist.add(cc90);
									System.out.println("自动删除购物车，父级商品已经下架，cookie="+cc90.getCookie()+" userId="+cc90.getUserId());
								}
							}
						}
						
						Tools.getManager(Cart.class).delete(cart);
						rlist.add(cart);
						System.out.println("自动删除购物车，商品已经下架，cookie="+cart.getCookie()+" userId="+cart.getUserId());
						
					}else if(cart.getHasFather().longValue()==1){//如果是子Cart
						ArrayList<Cart> childCarts = CartHelper.getCartItemsViaParentId(cart.getParentId());
						if(childCarts!=null&&childCarts.size()>0){
							for(Cart cc90:childCarts){
								if(Tools.getManager(Cart.class).delete(cc90)){
									rlist.add(cc90);
									System.out.println("自动删除购物车，子商品已经下架，cookie="+cc90.getCookie()+" userId="+cc90.getUserId());
								}
							}
						}
						
						Cart pcart = (Cart)Tools.getManager(Cart.class).get(cart.getParentId());
						if(pcart!=null&&pcart.getType().longValue()<0){
							if(Tools.getManager(Cart.class).delete(pcart)){
								rlist.add(pcart);
								System.out.println("自动删除购物车父商品，子商品已经下架，cookie="+pcart.getCookie()+" userId="+pcart.getUserId());
							}
						}
					}else{
						if(Tools.getManager(Cart.class).delete(cart)){
							rlist.add(cart);
							System.out.println("自动删除购物车，商品已经下架，cookie="+cart.getCookie()+" userId="+cart.getUserId());
						}
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * 检查或删除单品赠品。如果单品有赠品的没有加到购物车，则自动加上，<br/>
	 * 反之如果单品赠品已经不存在，则删除购物车下单品赠品。
	 * @param request
	 * @param response
	 * @return 删除过的Cart
	 */
	private static List<Cart> checkOrDeleteProductGift(HttpServletRequest request,HttpServletResponse response){
		//购物车所有数据
		ArrayList<Cart> carts = getCartItems(request,response);
		
		if(carts==null||carts.size()==0)return null;
		
		List<Cart> rlist = new ArrayList<Cart>();
		
		//判断单品赠品是否加入购物车，如果没有，自动加入购物车！！！！！！！
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			if(cart.getType().longValue()>=1&&cart.getType().longValue()!=12
					&&cart.getType().longValue()!=19){
				//正常商品检查其赠品有没有加入到购物车，type=1表示正常商品，10表示不参加E券的商品，其他都是优惠商品
				GiftProduct gp = GiftHelper.getGiftProduct(cart.getProductId());
				
				if(gp!=null){//单品赠品存在
					boolean existsGift = false ;//记录单品赠品是否在购物车里
					//该商品存在单品赠品，检查购物车里有没有这个赠品，没有的话自动加上。单品赠品都是加成一个子节点
					ArrayList<Cart> childCarts = getCartItemsViaParentId(cart.getId());
					if(childCarts!=null&&childCarts.size()>0){
						
						for(int j=0;j<childCarts.size();j++){
							Cart c123 = childCarts.get(j);
							if(c123.getType().longValue()==12){//12是单品赠品类型
								//已经存在这个赠品
								existsGift = true ;
								break ;
							}
						}
					}
					
					//赠品对应的商品
					Product p123 = (Product)Tools.getManager(Product.class).get(gp.getGiftgds_gdsid());
					
					if(!existsGift&&Tools.floatValue(gp.getGiftgds_price())==0&&p123.getGdsmst_validflag()!=null&&p123.getGdsmst_validflag().longValue()==1){//如果0元单品赠品没有加上，则自动加上
						Cart c = new Cart();
						
						c.setAmount(cart.getAmount());//单品赠品买X送X
						c.setCreateDate(new java.util.Date());
						c.setHasChild(new Long(0));						
						c.setOldPrice(Tools.getFloat(p123.getGdsmst_memberprice(),2));//赠品价					
						c.setMoney(Tools.getFloat(c.getAmount()*gp.getGiftgds_price(),2));//支付价就是赠品价
						c.setPrice(Tools.getFloat(gp.getGiftgds_price(),2));//赠品单价
						c.setProductId(p123.getId());
						c.setTitle("【赠品】"+Tools.clearHTML(p123.getGdsmst_gdsname()));
						c.setVipPrice(Tools.getFloat(gp.getGiftgds_price(),2));
						c.setType(new Long(12));//单品赠品类型
						c.setCookie(cart.getCookie());//取上级cookie
						c.setUserId(cart.getUserId());//取上级userId
						
						c.setParentId(cart.getId());
						c.setHasFather(new Long(1));//有父级
						c.setIp(request.getRemoteHost());
						
						//sku
						ArrayList<Sku> slist=SkuHelper.getSkuListViaProductId(p123.getId());
						if(slist!=null&&slist.size()>0&&slist.get(0)!=null)
						{
							c.setSkuId(slist.get(0).getId());
						}
						Tools.getManager(Cart.class).create(c);//创建单品赠品
						
						Tools.getManager(Cart.class).clearListCache(cart);
						cart.setHasChild(new Long(1));
						Tools.getManager(Cart.class).update(cart, true);
						
						
					}
				}else{//如果该单品没有赠品，则删除下面的赠品
					ArrayList<Cart> childCarts = getCartItemsViaParentId(cart.getId());
					if(childCarts!=null&&childCarts.size()>0){
						for(int j=0;j<childCarts.size();j++){
							Cart c23 = childCarts.get(j);
							if(c23.getType().longValue()==12){//是单品赠品，则删除，因为原商品没有单品赠品了
								if(Tools.getManager(Cart.class).delete(c23)){
									rlist.add(c23);//加到返回结果中
									System.out.println("自动删除购物车，不存在的单品赠品，cookie="+c23.getCookie()+" userId="+c23.getUserId());
								}
								Tools.getManager(Cart.class).clearListCache(cart);
								cart.setHasChild(new Long(0));
								Tools.getManager(Cart.class).update(cart, true);
							}
						}
					}
				}//end else
			}
		}//end for
		
		return rlist ;
	}
	
	/**
	 * 检查cart赠品是不是合法，不合法则自动删除，逻辑太复杂，可能有bug
	 * @param request
	 * @param response
	 * @param cart
	 * @return 删除掉的Cart
	 */
	private static List<Cart> checkOrDeleteGift(HttpServletRequest request,HttpServletResponse response){
		boolean isbj=false;
		if(UserHelper.isPtVip(request, response)){//删除非白金用户的生日礼物
			isbj=true;
		}
		if(!isbj){
		ArrayList<Cart> cartList19 = getCartItems(request,response);
		if(cartList19!=null&&cartList19.size()>0){
			for(Cart c19:cartList19){
                if(c19.getType().longValue()==19){
					Tools.getManager(Cart.class).delete(c19);
				}
	     }
		}
		}
		
		ArrayList<Cart> giftList = getCartGifts(request,response);
		if(giftList==null||giftList.size()==0)return null;
		
		List<Cart> rlist = new ArrayList<Cart>();
		
		//第一个条件：比较赠品是否应该存在于购物车中！
		ArrayList<GiftHelper.GiftGoods> giList = GiftHelper.getCartAvaiableGiftProducts(request,response);
		
		if(giList!=null&&giList.size()>0){
			for(int i=0;i<giftList.size();i++){
				Cart c_1 = giftList.get(i);
				boolean valid = false ;
				//循环比较所有赠品是不是和avaiable的赠品相符合，不符合则删除
				for(int j=0;j<giList.size();j++){
					GiftHelper.GiftGoods gg_1 = giList.get(j);
					Product gi_1 = ProductHelper.getById(gg_1.getProductId());
					if(gi_1 != null && c_1.getProductId()!=null&&c_1.getProductId().equals(gi_1.getId())){
						valid = true ;
						break ;
					}
				}
				
				if(!valid){
					//说明该赠品不应该存在于这个购物车里，可能是用户级别不满足等等条件，删除之
					if(Tools.getManager(Cart.class).delete(c_1)){
						rlist.add(c_1);
						System.out.println("自动删除购物车，赠品不应该存在，cookie="+c_1.getCookie()+" userId="+c_1.getUserId());
					}
				}
			}
		}else{//删除所有独立赠品
			for(int i=0;i<giftList.size();i++){
				Cart c_1 = giftList.get(i);
				if(Tools.getManager(Cart.class).delete(c_1)){
					rlist.add(c_1);
					System.out.println("自动删除购物车，删除所有独立赠品，cookie="+c_1.getCookie()+" userId="+c_1.getUserId());
				}
			}
		}
		
		giftList = getCartGifts(request,response); //重新获取一次购物车赠品
		
		//第二个条件：然后判断排他性，先判断“单选”的赠品组是否选择了多个！！！！！！				
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		
		if(gifts!=null&&gifts.size()>0){
			for(int j=0;j<gifts.size();j++){
				Gift gift = gifts.get(j);
			
				//比较单选下面的赠品是否选择了多个
				if(gift.getGiftrckmst_selecttype()!=null&&gift.getGiftrckmst_selecttype().longValue()==0){
					//分类赠品明细
					ArrayList<GiftItem> itemList = GiftHelper.getGiftItems(gift.getId());
					if(itemList==null||itemList.size()==0)continue;

					//和购物车里的赠品进行循环比较
					int count = 0 ;
					if(giftList!=null&&giftList.size()>0){
						for(int a=0;a<giftList.size();a++){
							Cart cc = giftList.get(a);
							if(itemList!=null&&itemList.size()>0){
								for(int b=0;b<itemList.size();b++){
									GiftItem gi = itemList.get(b);
									
									if(cc.getProductId()!=null&&cc.getProductId().equals(gi.getGiftrckdtl_gdsid())){//存在
										count++;
									}
									
									if(count>=2){
										//单选赠品组下面的赠品选择了多个，删除
										if(Tools.getManager(Cart.class).delete(cc)){
											rlist.add(cc);
											System.out.println("自动删除购物车，单选赠品组下面的赠品选择了多个，cookie="+cc.getCookie()+" userId="+cc.getUserId());
										}
										count = 1 ;
										break;
									}
								}//end for b
							}
						}//end for a
					}
					
					giftList = getCartGifts(request,response); //重新获取一次购物车赠品
				}
			}//end for j
		}
		
		giftList = getCartGifts(request,response); //重新获取一次购物车赠品
		
		//第三个条件：判断多品赠品，如果是“单选”的，看看有没有多个赠品在里面
		ArrayList<GiftGroup>  ggroupList = GiftHelper.getAllGiftGroups();
		
		if(ggroupList!=null&&ggroupList.size()>0){
			for(int i=0;i<ggroupList.size();i++){
				
				GiftGroup gg = ggroupList.get(i);
				if(gg.getGiftgrpmst_selecttype()!=null&&gg.getGiftgrpmst_selecttype().longValue()==1)continue ;//多选组，忽略
				
				ArrayList<GiftGroupItem> ggiList = GiftHelper.getGiftGroupItem(gg.getId());
				
				//循环明细，对照购物车赠品判断
				if(giftList!=null&&giftList.size()>0){
					int count = 0 ;
					for(int j=0;j<giftList.size();j++){
						Cart cart = giftList.get(j);
						if(ggiList!=null&&ggiList.size()>0){
							for(int k=0;k<ggiList.size();k++){
								GiftGroupItem ggi = ggiList.get(k);
								
								if(cart.getProductId()!=null&&cart.getProductId().equals(ggi.getGiftgrpdtl_gdsid())){
									count++;
								}
								
								//多品赠品单选组下面的赠品选择了多个，删除
								if(count>=2){ 
									if(Tools.getManager(Cart.class).delete(cart)){
										rlist.add(cart);
										System.out.println("自动删除购物车，多品赠品单选组下面的赠品选择了多个，cookie="+cart.getCookie()+" userId="+cart.getUserId());
									}
									count=1;
									break;
								}
							}//end for k
						}
					}//end for j
					
					giftList = getCartGifts(request,response); //重新获取一次购物车赠品
				}
			}//end for i
		}
		
		giftList = getCartGifts(request,response); //重新获取一次购物车赠品
		
		
		//第四个条件：除单品外，所有其他赠品只能选一个！！！
		
		ArrayList<Cart> cartList = getCartItems(request,response);
		if(cartList!=null&&cartList.size()>0){
			for(Cart c7:cartList){
				if(c7.getType().longValue()==0&&c7.getAmount().longValue()>1){//普通赠品
					c7.setAmount(new Long(1));
					c7.setMoney(new Float(c7.getPrice().floatValue()));
					Tools.getManager(Cart.class).update(c7, false);
				}
				
			}
		}
		
		giftList = getCartGifts(request,response); //重新获取一次购物车赠品
		
		//第五个条件：比较分类赠品金额限制
		ArrayList<GiftItem> allGiftItems = GiftHelper.getAvaiableGiftItems(null, null);
		
		if(giftList!=null&&giftList.size()>0){
			for(int i=0;i<giftList.size();i++){//循环所有购物车里的赠品
				Cart cc = giftList.get(i);
				if(allGiftItems!=null&&allGiftItems.size()>0){
					for(int j=0;j<allGiftItems.size();j++){
						GiftItem g2 = allGiftItems.get(j);
						
						if(cc.getProductId()!=null&&cc.getProductId().equals(g2.getGiftrckdtl_gdsid())){
							//金额不满足也删除
							if(g2.getGiftrckdtl_limitmoney()!=null&&g2.getGiftrckdtl_limitmoney().floatValue()>CartHelper.getTotalPayMoney(request, response)){
								if(Tools.getManager(Cart.class).delete(cc)){
									rlist.add(cc);
									System.out.println("自动删除购物车，金额不满足，cookie="+cc.getCookie()+" userId="+cc.getUserId());
								}
							}
						}
					}
				}
			}
		}
		
		giftList = getCartGifts(request,response); //重新获取一次购物车赠品
		
		//第六个条件：比较多品赠品金额限制
		ArrayList<GiftGroup> giftGroupList = GiftHelper.getAllGiftGroups();
		if(giftList!=null&&giftList.size()>0){
			for(int i=0;i<giftList.size();i++){
				Cart cc = giftList.get(i);
				if(giftGroupList!=null&&giftGroupList.size()>0){
					for(int j=0;j<giftGroupList.size();j++){
						GiftGroup gg = giftGroupList.get(j);
						ArrayList<GiftGroupItem> ggItems = GiftHelper.getGiftGroupItem(gg.getId());
						
						if(ggItems!=null&&ggItems.size()>0){
							for(int k=0;k<ggItems.size();k++){
								GiftGroupItem ggi = ggItems.get(k);
								
								//该赠品属于多品赠品
								if(cc.getProductId()!=null&&cc.getProductId().equals(ggi.getGiftgrpdtl_gdsid())){
									//不满足金额
									if(ggi.getGiftgrpdtl_limitmoney()!=null&&ggi.getGiftgrpdtl_limitmoney().floatValue()>CartHelper.getTotalPayMoney(request, response)){
										if(Tools.getManager(Cart.class).delete(cc)){
											rlist.add(cc);
											System.out.println("自动删除购物车，多品赠品不满足金额，cookie="+cc.getCookie()+" userId="+cc.getUserId());
										}
									}
								}
							}//end for k
						}
					}//end for j
				}
			}//end for i
		}
		
		giftList = getCartGifts(request,response); //重新获取一次赠品列表
		
		return rlist ;
	}
	
	/**
	 * 得到购物车里所有赠品，这里指独立赠品，单品赠品不算，单品赠品已经单独处理了。
	 * @param request
	 * @param response
	 * @return
	 */
	private static ArrayList<Cart> getCartGifts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//获取购物车里所有cart记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()==0){//独立赠品，不算单品赠品
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * 得到购物车里所有正常商品（包括组合商品），赠品、虚拟品、其他优惠的商品都不算。
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartNormalProducts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()>0){//独立商品，组合的也算
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * 能获取赠品的商品列表
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartGiftNormalProducts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()==1||c.getType().longValue()==10||c.getType().longValue()==6||c.getType().longValue()==9||c.getType().longValue()==7||c.getType().longValue()==11||c.getType().longValue()==13){//只要不是赠品都可以用来
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * 检查并更新购物车价格！！！
	 * @param request
	 * @param response
	 */
	public static void updateCartPrice(HttpServletRequest request,HttpServletResponse response){
		//购物车所有数据
		ArrayList<Cart> carts = getCartItems(request,response);
		
		if(carts==null||carts.size()==0)return ;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
		Date ndate=new Date();
		Date edate=null;
		Date sdate=null;
		try {
			edate=sdf.parse("2014-04-23 10:00");
			sdate=sdf.parse("2014-04-15 09:30");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String xycarts="";
		if(ndate.getTime()<edate.getTime()&&ndate.getTime()>sdate.getTime()){
			xycarts=getXjYznum(request,response,carts);
			xycarts=","+xycarts+",";
		}
		
		
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			long ctype=cart.getType().longValue();
	          String gdsid=cart.getProductId();
			if(ctype!=21&&ndate.getTime()<edate.getTime()&&ndate.getTime()>sdate.getTime()&&!Tools.isNull(xycarts)&&xycarts.indexOf(","+cart.getId()+",")>=0){
                float mprice=cart.getPrice().floatValue();
				if(ctype!=20){
				  Product p=ProductHelper.getById(gdsid);
				  mprice=p.getGdsmst_memberprice().floatValue();
                }
				cart.setTitle("【2件8折】"+cart.getTitle());
            	cart.setMoney(Tools.getFloat(mprice*cart.getAmount().longValue()*0.8f,2));
				cart.setPrice(Tools.getFloat(mprice*0.8f,2));
            	cart.setType(new Long(21));
            	Tools.getManager(Cart.class).update(cart, false);
			}
			if(ctype==21&&(ndate.getTime()>edate.getTime()||Tools.isNull(xycarts)||xycarts.indexOf(","+cart.getId()+",")==-1)){
				String ctitle=cart.getTitle();
				ctitle=ctitle.replace("【2件8折】", "");
				Product p=ProductHelper.getById(gdsid);
				cart.setTitle(ctitle);
            	cart.setMoney(Tools.getFloat(cart.getMoney().floatValue()*1.25f,2));
				cart.setPrice(Tools.getFloat(cart.getPrice().floatValue()*1.25f,2));
				if(ctitle.startsWith("【秒杀】")||ctitle.startsWith("【闪购】")){
					cart.setType(new Long(20));
				}else if(p!=null&&p.getGdsmst_specialflag()!=null&&p.getGdsmst_specialflag().longValue()==1){
					cart.setType(new Long(10));
				}else{
            	cart.setType(new Long(1));
				}
            	Tools.getManager(Cart.class).update(cart, false);
			}
			//如果是白金会员，修改价格
			updateCartPrice(request,response,cart);
		}//end for
	}
	
	private static  String  getXjYznum(HttpServletRequest request,HttpServletResponse response,ArrayList<Cart> carts){
		if (carts==null||carts.size()==0)return "";
		String ppcode="9225,9226,9227,9228,9229,9230,9231,9232,9233";
		long xynum=0;
		String xygdsstr="";
		boolean actflag=false;
		for (Cart c:carts){
			String gdsid=c.getProductId();
			if(c.getType().longValue()!=1&&c.getType().longValue()!=10&&c.getType().longValue()!=20&&c.getType().longValue()!=21)continue;
			
		if(!Tools.isNull(ppcode)){
		    ppcode=ppcode.replace("，", ",");		
		     String[] arrppcode=ppcode.split(",");
		     for(int j=0;j<arrppcode.length;j++){
		    	 actflag=	PromotionProductHelper.getPProductByCodeGdsidExist(arrppcode[j],gdsid);
		    	 if(actflag){
		    		 xynum+=c.getAmount().longValue();
		    		 if(Tools.isNull(xygdsstr)) xygdsstr=c.getId();
		    		 else xygdsstr+=","+c.getId();
		    		 break;
		    	 }
		     }
		   
		}
		}
		if(xynum<2)xygdsstr="";
		return xygdsstr;
   }
	
	/**
	 * 获取白金独享列表
	 * 
	 */
	private static ArrayList<PromotionProduct> getbjdxlist(String gdsid)
	{
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code", new Long("8322")));
		clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
		clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
		clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
		List<Order> olist = new ArrayList<Order>();
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((PromotionProduct)be);
		}
		return rlist ;
	}
	
	
	/**
	 * 获取活动商品列表
	 * 
	 */
	private static ArrayList<PromotionProduct> gethdgoodslist(String gdsid)
	{
		ArrayList<PromotionProduct> rlist = new ArrayList<PromotionProduct>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("spgdsrcm_code", new Long("8409")));
		clist.add(Restrictions.eq("spgdsrcm_gdsid", gdsid));
		//clist.add(Restrictions.ge("spgdsrcm_enddate", new Date()));
		//clist.add(Restrictions.le("spgdsrcm_begindate", new Date()));
		List<Order> olist = new ArrayList<Order>();
		List<BaseEntity> list = Tools.getManager(PromotionProduct.class).getList(clist, olist, 0, 1);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((PromotionProduct)be);
			PromotionProduct pp123=(PromotionProduct)be;
			pp123.getSpgdsrcm_gdsid();
		}
		return rlist ;
	}
	/**
	 * 获取正常商品的活动总额<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getbjhdProductMoney(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		//把支付价加起来
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()==1){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					ArrayList<PromotionProduct> bjproduct=gethdgoodslist(cart.getProductId());
					
					if(product!=null&&bjproduct!=null&&bjproduct.size()>0){//让用券
						total+=cart.getOldPrice()*cart.getAmount();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	
	/**
	 * 修改单个cart的价格
	 * @param request
	 * @param response
	 * @param cart
	 */
	public static void updateCartPrice(HttpServletRequest request,HttpServletResponse response,Cart cart){
		float bjhdnum=getbjhdProductMoney(request, response);
		//System.out.println(bjhdnum+"-----------------------------bjgjl---------------------------------");
	/*if(cart.getType().longValue()==20){
		String productId = cart.getProductId();
		Product product = (Product)Tools.getManager(Product.class).get(productId);
		boolean ismiaoshao=getmsflag(product);
		if(!ismiaoshao){
			//如果购物车里的价格不是会员价，修改之
			
			cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2));
			cart.setIp(request.getRemoteHost());
			cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue(),2));
			cart.setType(new Long(1));
			Tools.getManager(Cart.class).update(cart, false);
		}
		
	}*/
		
		
		
		if(UserHelper.isPtVip(request, response)){
			float zk=0.98f;
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//是否是白金独享的商品
				ArrayList<PromotionProduct> bjdxlist=getbjdxlist(productId);
				if(bjdxlist!=null&&bjdxlist.size()>0)
				{
					PromotionProduct bjdxpp=bjdxlist.get(0);
                    if(bjdxpp.getSpgdsrcm_tjprice()!=null)
                    {
                    	cart.setTitle("[白金独享商品]"+cart.getTitle());
                    	cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*bjdxpp.getSpgdsrcm_tjprice().floatValue(),2));
						cart.setIp(request.getRemoteHost());
						cart.setPrice(bjdxpp.getSpgdsrcm_tjprice().floatValue());
                    	cart.setType(new Long(17));
                    	Tools.getManager(Cart.class).update(cart, false);
                    }
				}
				else
				{				
					if(updateCartExpPrice1(request,response,cart))return ;//修改独享价格，如果成功就不修改白金价
					//设置折扣价格
					if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009")))
					{
						zk=0.95f;
					}			
					
					else
					{
						zk=0.98f;
					}
					//if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
						//白金会员价格要打95折,白金价格=会员价*0.95
						//cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
						//cart.setIp(request.getRemoteHost());
						//cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
						//Tools.getManager(Cart.class).update(cart, false);
					//}
					if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*zk,2)){
						//如果要是参加活动的商品则不打折 为推荐位的商品
						ArrayList<PromotionProduct> hdgoodslist=null;
						if(bjhdnum>=200){
						hdgoodslist=gethdgoodslist(productId);
						}
						if(hdgoodslist!=null&&hdgoodslist.size()>0)
						{
							//白金会员价格要打95折,白金价格=会员价*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()),2));
							cart.setIp(request.getRemoteHost());
							cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2));
							Tools.getManager(Cart.class).update(cart, false);
						
						}
						else
						{
							//白金会员价格要打95折,白金价格=会员价*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()*zk),2));
							cart.setIp(request.getRemoteHost());
							cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2));
							Tools.getManager(Cart.class).update(cart, false);
						}
						
						
					}
				}
			}else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//组合商品也可以打折
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//设置折扣价格
				if(cart.getType()!=null&&cart.getType().longValue()==16)
				{
					zk=0.95f;
				}else{
					zk=0.98f;
				}
			
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*zk,2)){
					//白金会员价格要打95折,白金价格=会员价*0.95
					//System.out.print("cbvcbvnbnb"+Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2));
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*zk),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//计算套餐总价
				//if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
					//白金会员价格要打95折,白金价格=会员价*0.95
					//cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2));
					//cart.setIp(request.getRemoteHost());
					//Tools.getManager(Cart.class).update(cart, false);
				//}
				
				if(cart.getType().longValue()==-1){
					if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
						//白金会员价格要打95折,白金价格=会员价*0.95
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT),2));
						cart.setIp(request.getRemoteHost());
						Tools.getManager(Cart.class).update(cart, false);
					}
					}
					else
					{
						if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*0.95f,2)){
							//白金会员价格要打95折,白金价格=会员价*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*0.95f),2));
							cart.setIp(request.getRemoteHost());
							Tools.getManager(Cart.class).update(cart, false);
						}
					}
			}else {//其他如组合特卖、赠品、X选Y
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
		}else if(UserHelper.isVip(request, response)){//如果是VIP会员
			float zk=0.99f;			
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				
				if(updateCartExpPrice(request,cart))return ;//修改独享价格，如果成功就不修改白金价
				//设置折扣价格
				if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009")))
				{
					zk=0.98f;
				}			
				
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*zk,2)){
					//VIP会员
					//如果要是参加活动的商品则不打折 为推荐位的商品
					ArrayList<PromotionProduct> hdgoodslist=null;
					if(bjhdnum>=200){
					hdgoodslist=gethdgoodslist(productId);
					}
					if(hdgoodslist!=null&&hdgoodslist.size()>0)
					{
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()),2));
						cart.setIp(request.getRemoteHost());
						cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2));
						Tools.getManager(Cart.class).update(cart, false);
			        }
					else
					{
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()*zk),2));
						cart.setIp(request.getRemoteHost());
						cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2));
						Tools.getManager(Cart.class).update(cart, false);
					}
				}
			}else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//组合商品也可以打折
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//设置折扣价格
				if(cart.getType()!=null&&cart.getType().longValue()==16)
				{
					zk=0.98f;
				}else{
					zk=0.99f;
				}
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*zk,2)){
					//白金会员价格要打95折,白金价格=会员价*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*zk),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
				
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//计算套餐总价
				if(cart.getType().longValue()==-1){
					if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
						//白金会员价格要打95折,白金价格=会员价*0.95
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
						cart.setIp(request.getRemoteHost());
						Tools.getManager(Cart.class).update(cart, false);
					}
			   }
			   else
			   {
						if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*0.95f,2)){
							//白金会员价格要打95折,白金价格=会员价*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*0.95f),2));
							cart.setIp(request.getRemoteHost());
							Tools.getManager(Cart.class).update(cart, false);
						}
			   }
								
			}else {//其他如组合特卖、赠品、X选Y
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
		}else{//普通会员或者未登录状态
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//正常商品重新计算会员价格
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				if(updateCartExpPrice(request,cart))return ;//修改独享价格，如果成功就不修改会员价
				
		
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2)){
					//如果购物车里的价格不是会员价，修改之
					
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue(),2));
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
			
			
			/*else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//组合商品也可以打折
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					//白金会员价格要打95折,白金价格=会员价*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
				
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//计算套餐总价
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					//白金会员价格要打95折,白金价格=会员价*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}else {//其他如组合特卖、赠品、X选Y*/
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			//}
		}
	}
	/**
	 * 修改购物车独享价，如果用了独享价，白金价和VIP价就不生效了
	 * @param request
	 * @param cart
	 * @return 修改成功返回true，就不再修改白金价了，没有修改返回false
	 */
	private static boolean updateCartExpPrice(HttpServletRequest request,Cart cart){
		//独享价cookie判断
		Cookie exPriceCookie = Tools.getClientCookie(request, "rcmdusr_rcmid");
		String expriceCookieValue = null ;
		if(exPriceCookie!=null){
			expriceCookieValue = exPriceCookie.getValue();
		}else{
			return false ;
		}
		
		if(Tools.isNull(expriceCookieValue)||!StringUtils.isDigits(expriceCookieValue))return false ;
		
		ProductExpPrice pp = (ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(expriceCookieValue));
		
		if(pp==null||!ProductExpPriceHelper.valid(pp))return false ;//验证未通过，可能是过期了
		
		String productId = cart.getProductId();
		
		//加入查询条件
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rcmdgds_rcmid", new Long(expriceCookieValue)));
		clist.add(Restrictions.eq("rcmdgds_gdsid", productId));
		
		ProductExpPriceItem ppi = null ;
		List<BaseEntity> ppiList = Tools.getManager(ProductExpPriceItem.class).getList(clist, null, 0, 1);
		
		if(ppiList==null||ppiList.size()==0)return false ;
		
		ppi = (ProductExpPriceItem)ppiList.get(0);
		//总算到了修改特价的地方了，修改成独享价格
		if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2)||ppi.getRcmdgds_memberprice().floatValue()==0f){
			cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2));
			cart.setIp(request.getRemoteHost());
			cart.setPrice(Tools.getFloat(ppi.getRcmdgds_memberprice().floatValue(), 2));
			if(!cart.getTitle().startsWith("【优惠特价】"))cart.setTitle("【优惠特价】"+cart.getTitle());
			Tools.getManager(Cart.class).update(cart, false);

		}
		
		if(cart.getType().longValue()!=9){
			cart.setType(new Long(9));
			Tools.getManager(Cart.class).update(cart, false);
		}
		return true ;
	}

	/**
	 * 修改购物车独享价，如果用了独享价，白金价和VIP价就不生效了
	 * @param request
	 * @param cart
	 * @return 修改成功返回true，就不再修改白金价了，没有修改返回false
	 */
	private static boolean updateCartExpPrice1(HttpServletRequest request,HttpServletResponse response,Cart cart){
		
		//独享价cookie判断
		Cookie exPriceCookie = Tools.getClientCookie(request, "rcmdusr_rcmid");
		String expriceCookieValue = null ;
		if(exPriceCookie!=null){
			expriceCookieValue = exPriceCookie.getValue();
		}else{
			return false ;
		}
		
		if(Tools.isNull(expriceCookieValue)||!StringUtils.isDigits(expriceCookieValue))return false ;
		
		ProductExpPrice pp = (ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(expriceCookieValue));
		
		if(pp==null||!ProductExpPriceHelper.valid(pp))return false ;//验证未通过，可能是过期了
		
		String productId = cart.getProductId();
		
		//加入查询条件
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rcmdgds_rcmid", new Long(expriceCookieValue)));
		clist.add(Restrictions.eq("rcmdgds_gdsid", productId));
		
		ProductExpPriceItem ppi = null ;
		List<BaseEntity> ppiList = Tools.getManager(ProductExpPriceItem.class).getList(clist, null, 0, 1);
		
		if(ppiList==null||ppiList.size()==0)return false ;
		
		ppi = (ProductExpPriceItem)ppiList.get(0);
		
		//总算到了修改特价的地方了，修改成独享价格
		if(UserHelper.isPtVip(request, response))
		{
			Product product=ProductHelper.getById(productId);
			if(product!=null)
			{
				int bjprice=(int)(product.getGdsmst_memberprice().floatValue());
				if(product.getGdsmst_rackcode()!=null&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009")))
				{
					bjprice=(int)(product.getGdsmst_memberprice().floatValue()*0.95);
				}else
				{
					bjprice=(int)(product.getGdsmst_memberprice().floatValue()*0.98);
				}
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2)&&ppi.getRcmdgds_memberprice().floatValue()<bjprice){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2));
					cart.setIp(request.getRemoteHost());
					cart.setPrice(Tools.getFloat(ppi.getRcmdgds_memberprice().floatValue(), 2));
					if(!cart.getTitle().startsWith("【优惠特价】"))cart.setTitle("【优惠特价】"+cart.getTitle());
					Tools.getManager(Cart.class).update(cart, false);
					if(cart.getType().longValue()!=9){
						cart.setType(new Long(9));
						Tools.getManager(Cart.class).update(cart, false);
					}
				}
				else
				{
					return false;
				}
			}
		}
		else
		{
			if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2)){
				cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2));
				cart.setIp(request.getRemoteHost());
				cart.setPrice(Tools.getFloat(ppi.getRcmdgds_memberprice().floatValue(), 2));
				if(!cart.getTitle().startsWith("【优惠特价】"))cart.setTitle("【优惠特价】"+cart.getTitle());
				Tools.getManager(Cart.class).update(cart, false);
			}
			if(cart.getType().longValue()!=9){
				cart.setType(new Long(9));
				Tools.getManager(Cart.class).update(cart, false);
			}
		}
		
		
		return true ;
	}
	
	/**
	 * 购物车中是否有平安用户的赠品
	 * @param request
	 * @param response
	 * @return true 表示有，false表示没有
	 */
	public static boolean existPingAnGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("平安万里通")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//如果购物车里某个赠品的商品id=平安万里通定义的赠品的商品id，则表示存在了
						if(cart.getProductId()!=null&&cart.getProductId().equals(giList.get(j).getGiftrckdtl_gdsid())){
							return true ;
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有139邮箱用户的赠品
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean exist139MailGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("139邮箱")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//如果购物车里某个赠品的商品id=139邮箱通定义的赠品的商品id，则表示存在了
						if(cart.getProductId()!=null&&cart.getProductId().equals(giList.get(j).getGiftrckdtl_gdsid())){
							return true ;
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有白金VIP用户的赠品
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean existPtVipGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("白金VIP")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//如果购物车里某个赠品的商品id=白金VIP通定义的赠品的商品id，则表示存在了
						if(cart.getProductId()!=null&&cart.getProductId().equals(giList.get(j).getGiftrckdtl_gdsid())){
							return true ;
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有全场赠品
	 * @param request
	 * @param response
	 * @param gift
	 * @return
	 */
	public static boolean existTotalGift(HttpServletRequest request,HttpServletResponse response,Gift gift) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
		if(carts==null||carts.size()==0)return false ;
		
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//购物车里的赠品
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift gift123 = gifts.get(j);
				//000表示全场
				if("000".equals(gift123.getGiftrckmst_rackcode())&&gift123.getId().equals(gift.getId())){
					ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift123.getId());
					if(giList!=null&&giList.size()>0){
						for(int k=0;k<giList.size();k++){
							GiftItem gi = giList.get(k);
							if(gi.getGiftrckdtl_gdsid().equals(p.getId())){
								return true ;
							}
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有分类赠品
	 * @param request
	 * @param response
	 * @param gift Gift
	 * @return
	 */
	public static boolean existDirectoryGift(HttpServletRequest request,HttpServletResponse response, Gift gift) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||gift==null)return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
		if(carts==null||carts.size()==0)return false ;
		
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//购物车里的赠品
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift g = gifts.get(j);
				//分类对上了
				if(gift.getGiftrckmst_rackcode()!=null&&gift.getGiftrckmst_rackcode().equals(g.getGiftrckmst_rackcode())){
					ArrayList<GiftItem> giList = GiftHelper.getGiftItems(g.getId());
					if(giList!=null&&giList.size()>0){
						for(int k=0;k<giList.size();k++){
							GiftItem gi = giList.get(k);
							if(gi.getGiftrckdtl_gdsid().equals(p.getId())){
								return true ;
							}
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有品牌赠品
	 * @param request
	 * @param response
	 * @param brandName 品牌名
	 * @return
	 */
	public static boolean existBrandGift(HttpServletRequest request,HttpServletResponse response, String brandName) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||Tools.isNull(brandName))return false ;
		
		brandName = brandName.trim();
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
		if(carts==null||carts.size()==0)return false ;
		
		//循环判断购物车里的增品
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//购物车里的赠品
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift gift = gifts.get(j);
				//品牌对上了
				if(gift.getGiftrckmst_brandname()!=null&&brandName.trim().equals(gift.getGiftrckmst_brandname().trim())){
					ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
					if(giList!=null&&giList.size()>0){
						for(int k=0;k<giList.size();k++){
							GiftItem gi = giList.get(k);
							if(gi.getGiftrckdtl_gdsid().equals(p.getId())){
								return true ;
							}
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 购物车中是否有多品赠品，即推荐位赠品
	 * @param request
	 * @param response
	 * @param promotion 推荐位号
	 * @return
	 */
	public static boolean existPromotionGift(HttpServletRequest request,HttpServletResponse response, String promotion) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||Tools.isNull(promotion))return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//获取购物车里独立赠品
		if(carts==null||carts.size()==0)return false ;
		
		//循环判断购物车里的增品
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//购物车里的赠品
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			ArrayList<GiftGroup> ggList = GiftHelper.getAllGiftGroups();//所有定义的多品赠品
			if(ggList==null||ggList.size()==0)return false ;
			for(int j=0;j<ggList.size();j++){
				GiftGroup gg = ggList.get(j);
				if(gg.getGiftgrpmst_title()!=null&&gg.getGiftgrpmst_title().indexOf(","+promotion+",")>-1){
					//循环对比所有多品赠品的明细，和购物车里的赠品id就行比较
					ArrayList<GiftGroupItem> ggitemList = GiftHelper.getGiftGroupItem(gg.getId());
					if(ggitemList!=null&&ggitemList.size()>0){
						for(int k=0;k<ggitemList.size();k++){
							GiftGroupItem ggi = ggitemList.get(k);
							if(ggi.getGiftgrpdtl_gdsid()!=null&&ggi.getGiftgrpdtl_gdsid().equals(p.getId())){
								return true ;
							}
						}
					}
				}
			}
		}
		return false;
	}
	
	/**
	 * 获得购物车物品的类别
	 * @param type - type
	 * @return String
	 */
	public static String getProductType(long typeLong){
		int type = (int)typeLong;
		if(type == 1) return "";
		if(type == 6) return "团购商品";
		if(type == 0) return "赠品";
		switch(type){
			case 6:
				return "品牌减免商品";
			case 2:
				return "积分换购商品";
			case 8:
				return "组合特价商品";
			case 3:
			case 4:
			case 5:
				return "促销商品";
			case 9:
				return "独享价商品";
			default:
				return "";
		}
	}
	
	/**
	 * 是否有团购商品
	 * @param request
	 * @param response
	 * @return True or False
	 */
	public static boolean hasGroupProduct(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> list = getCartItems(request,response);
		if(list == null || list.isEmpty()) return false;
		boolean b = false;
		for(Cart cart : list){
			if(Tools.longValue(cart.getType()) == 6){
				b = true;
				break;
			}
		}
		return b;
	}
	
	/**
	 * 是否有团购兑换商品
	 * @param request
	 * @param response
	 * @return True or False
	 */
	public static boolean hasGroupDHProduct(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> list = getCartItems(request,response);
		if(list == null || list.isEmpty()) return false;
		boolean b = false;
		for(Cart cart : list){
			if(Tools.longValue(cart.getType()) == 11){
				b = true;
				break;
			}
		}
		return b;
	}
	
	/**
	 * 购物车中是否有网易兑换商品
	 * @param request
	 * @param response
	 * @return True or False
	 */
	public static boolean hasWangyiProduct(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> list = getCartItems(request,response);
		if(list == null || list.isEmpty()) return false;
		boolean b = false;
		for(Cart cart : list){
			if(Tools.longValue(cart.getType()) == 13&&cart.getTuanCode().startsWith("mqwyjf1204nw")){
				b = true;
				break;
			}
		}
		return b;
	}
	
	public static boolean existsShopCodeP(HttpServletRequest request,HttpServletResponse response,String shopcode){
		
		if(Tools.isNull(shopcode))shopcode="00000000";
		if("11111111".equals(shopcode))return true ;//000表示全场可用
		
		ArrayList<Cart> carts = CartHelper.getCartNormalProducts(request, response);
		if(carts==null||carts.size()==0)return false;
		
		for(Cart c:carts){
			if(c.getType().longValue()>=0){
				if(c.getShopcode().equals(shopcode))return true;
			}
		}
		return false ;
	}
	/**
	 * 购物车是否存在某个分类的商品，判断层级关系
	 * @param rackcode
	 * @return
	 */
	public static boolean existsDirectory(HttpServletRequest request,HttpServletResponse response,String rackcode){
		if(Tools.isNull(rackcode))return false ;
		
		rackcode = rackcode.trim();
		
		if("000".equals(rackcode))return true ;//000表示全场可用
		
		ArrayList<Cart> carts = CartHelper.getCartNormalProducts(request, response);
		if(carts==null||carts.size()==0)return false;
		
		for(Cart c:carts){
			if(c.getType().longValue()>=0){
				Product p = ProductHelper.getById(c.getProductId());
				if(p==null)continue;
				if(p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith(rackcode)
						||(rackcode.equals("017")&& 
								(p.getGdsmst_rackcode().startsWith("02")||p.getGdsmst_rackcode().startsWith("03")||p.getGdsmst_rackcode().startsWith("015009"))
								)))return true;
			}
		}
		
		return false ;
	}
	
	/**
	 * 检查购物车，如果购物车中的物品有错误，则自动删除。
	 * @param request
	 * @param response
	 * @return List<Cart> 被删除的Cart的集合
	 */
	/*public static List<String> checkCartError(HttpServletRequest request,HttpServletResponse response){
		List<Cart> list = CartHelper.getCartItems(request,response);
		if(list == null || list.isEmpty()) return null;
		
		List<String> delete_list = new ArrayList<String>();
		
		for(Cart cart : list){
			Product product = ProductHelper.getById(cart.getProductId());
			//脱销或无货
			if(!ProductHelper.isShow(product)){
				CartHelper.deleteCart(request,response,cart.getId());
				delete_list.add(cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId()));
			}else{
				//有sku但是没有选择
				if(ProductHelper.hasSku(product) && (Tools.isNull(cart.getSkuId()) || "0".equals(cart.getSkuId()))){
					CartHelper.deleteCart(request,response,cart.getId());
					delete_list.add(cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId()));
				}
			}
		}
		return delete_list;
	}*/
	/***
	 * 闪购根据最大数据控制是否秒杀价
	 * @param gdsid
	 * @return
	 */
	public static boolean getsgbuy(String gdsid){
		ArrayList<SgGdsDtl> list = new ArrayList<SgGdsDtl>();

		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("sggdsdtl_gdsid", gdsid));
		clist.add(Restrictions.eq("sggdsdtl_status", new Long(1)));
		//clist.add(Restrictions.gt("sggdsdtl_maxnum", "sggdsdtl_realbuynum"));
		List<BaseEntity> b_list = Tools.getManager(SgGdsDtl.class).getList(clist, null, 0, 1);
		if(b_list!=null&&b_list.size()>0){
			SgGdsDtl sg=(SgGdsDtl)b_list.get(0);
			if(sg.getSggdsdtl_maxnum().longValue()>sg.getSggdsdtl_realbuynum().longValue()
					&&sg.getSggdsdtl_vallnum().longValue()-sg.getSggdsdtl_vbuynum().longValue()-sg.getSggdsdtl_vusrnum().longValue()>0){
			return true ;
			}else{
				return false;
			}
		}
		return true ;
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
		 if(ismiaoshao){

		 	ismiaoshao=getsgbuy(p.getId());
		 }
		 return ismiaoshao;
		}
	/**
	 * 判断一件物品是否存在于购物车中。
	 * @param product - 物品对象
	 * @param skuId - skuId，如果这件物品没有sku，则传入null.
	 * @param request - HttpServletRequest
	 * @param response - HttpServletResponse
	 * @return True or False
	 */
	public static boolean hasInCart(Product product , String skuId , HttpServletRequest request,HttpServletResponse response){
		if(product == null) return false;
		List<Cart> list = CartHelper.getCartItems(request,response);
		if(list == null || list.isEmpty()) return false;
		
		String id = product.getId();
		
		for(Cart cart : list){
			Product goods = ProductHelper.getById(cart.getProductId());
			if(goods == null) continue;
			if(id.equals(goods.getId()) && (skuId == null || skuId.equals(cart.getSkuId()))){
				return true;
			}
		}
		return false;
	}
	
}
