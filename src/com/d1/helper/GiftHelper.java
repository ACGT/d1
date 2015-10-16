package com.d1.helper;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Brand;
import com.d1.bean.Cart;
import com.d1.bean.Directory;
import com.d1.bean.Gift;
import com.d1.bean.GiftGroup;
import com.d1.bean.GiftGroupItem;
import com.d1.bean.GiftItem;
import com.d1.bean.GiftProduct;
import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.bean.ShpMst;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * 赠品常用工具类，不光是操作Gift表
 * @author kk
 *
 */
public class GiftHelper {
	
	public static final BaseManager manager = Tools.getManager(GiftProduct.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return GiftProduct
	 */
	public static GiftProduct getById(String id){
		if(Tools.isNull(id)) return null;
		return (GiftProduct)manager.get(id);
	}
	
	/**
	 * giftgds_gdsid 查看对象
	 * @param productId - 商品ID
	 * @return GiftProduct
	 */
	public static GiftProduct getGiftProductByGId(String productId){
		if(Tools.isNull(productId)) return null;
		return (GiftProduct)manager.findByProperty("giftgds_gdsid", productId);
	}
	
	/**
	 * 得到单品赠品对应的对应关系记录，便于获取单品赠品的价格信息！
	 * @param productId 商品id
	 * @return GiftProduct 
	 */
	public static GiftProduct getGiftProduct(String productId){
		if(Tools.isNull(productId)) return null;
		//先从单品增表中获取记录
		GiftProduct gp = (GiftProduct)manager.findByProperty("giftgds_mastergdsid", productId);
		return gp ;
	}
	
	/**
	 * 获得单品赠品的物品信息
	 * @param productId - 商品ID
	 * @return Product
	 */
	public static Product getGiftProductByProductId(String productId){
		GiftProduct gp = getGiftProduct(productId);
		if(gp != null){
			return ProductHelper.getById(gp.getGiftgds_gdsid());
		}
		return null;
	}
	
	/**
	 * 获取有效赠品明细
	 * @param rackcode 分类编号，000表示全场，null则取全部
	 * @param brandName 品牌，如果为null，则取全部
	 * @return 所有符合条件的GiftItem
	 */
	public static ArrayList<GiftItem> getAvaiableGiftItems(String rackcode,String brandName){
		//加入查询条件
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		
		if(rackcode!=null)clist.add(Restrictions.eq("giftrckmst_rackcode", rackcode));
		if(brandName!=null)clist.add(Restrictions.eq("giftrckmst_brandname", brandName));
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//只取有效的
		
		ArrayList<GiftItem> resList = new ArrayList<GiftItem>();
		
		//从赠品主表读取列表
		List<BaseEntity> list = Tools.getManager(Gift.class).getList(clist, null, 0, 1000);
		
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Gift gift = (Gift)list.get(i);
				
				//根据赠品表读取赠品明细表，一个赠品可能有多个赠品商品
				List<GiftItem> giList = getGiftItems(gift.getId());
				if(giList!=null&&giList.size()>0){
					for(int j=0;j<giList.size();j++){
						GiftItem gi = (GiftItem)giList.get(j);
						if(gi!=null)resList.add(gi);
					}
				}
			}
		}
		
		return resList ;
	}
	
	/**
	 * 获取所有定义的赠品记录，只取有效的。显示全场，然后是分类
	 * @return
	 */
	public static ArrayList<Gift> getAllValidGifts(){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//有效的
		
		List<BaseEntity> resList = Tools.getManager(Gift.class).getList(clist,null,0,1000);
		ArrayList<Gift> list = new ArrayList<Gift>();
		if(resList!=null){
			for(int i=0;i<resList.size();i++){
				list.add((Gift)resList.get(i));
			}
		}
		return list ;
	}
	
	/**
	 * 根据gift id得到对应的明细
	 * @param giftId giftId必须是数字
	 * @return
	 */
	public static ArrayList<GiftItem> getGiftItems(String giftId){
		if(!StringUtils.isDigits(giftId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(giftId)));//这里是Long
		clist.add(Restrictions.eq("giftrckdtl_viewflag", new Long(1)));
		
		//List<Order> olist = new ArrayList<Order>();
		//olist.add(Order.asc("giftrckdtl_limitmoney"));
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).getList(clist,null,0,1000);
		ArrayList<GiftItem> list = new ArrayList<GiftItem>();
		if(resList!=null){
			for(int i=0;i<resList.size();i++){
				list.add((GiftItem)resList.get(i));
			}
		}
		return list ;
	}
	
	/**
	 * 根据赠品的商品id获取该赠品对应的所有分类
	 * @param productId
	 * @return
	 */
	public static ArrayList<String> getGiftDirectory(String productId){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_gdsid", productId));
		//获取该商品的多有赠品明细，再更具mstid获取对应的所有分类
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).getList(clist,null,0,1000);
		ArrayList<String> list = new ArrayList<String>();
		
		if(resList!=null&&resList.size()>0){
			for(int i=0;i<resList.size();i++){
				GiftItem gi = (GiftItem)resList.get(i);
				//根据明细取Gift主数据
				Gift gift = (Gift)Tools.getManager(Gift.class).get(gi.getGiftrckdtl_mstid()+"");
				if(gift!=null){
					//加入分类
					list.add(gift.getGiftrckmst_rackcode());
				}
			}
		}
		
		return list ;
		
	}
	
	/**
	 * 获取一个购物车下能看到的赠品，剔除一些排斥行的赠品，一般来说，看得见的就是可以加入购物车的<br/>
	 * 比如白金VIP的赠品如果出现在购物车中，那么不再取白金VIP的赠品列表了。
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<GiftGoods> getCartVisiableGiftProducts(HttpServletRequest request,HttpServletResponse response){
		return getCartGiftProducts(request,response,true);
	}
	
	/**
	 * 取该购物车下商品所有赠品列表，不考虑购物车是否有其他赠品
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<GiftGoods> getCartAvaiableGiftProducts(HttpServletRequest request,HttpServletResponse response){
		return getCartGiftProducts(request,response,false);
	}
	
	
	/**
	 * 得到购物车总支付价，不包括运费！
	 * @param request
	 * @param response
	 * @return 保留两位小数
	 */
	public static float getTotalPayMoneys(HttpServletRequest request,HttpServletResponse response){
		//获取购物车里所有记录
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//把支付价加起来，只计算能支付的商品
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0表示实际商品，type<0是套餐名或者虚拟购物券，不计算总价
				if(cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=18&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14)total+=cart.getMoney();
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	
	/**
	 * 获取该购物车里所有商品对应的赠品明细，也就是该购物车里可以存在哪些赠品！！！<br/>
	 * 单品赠品已经单独处理，这里计算的不包括单品赠品！！！！！！！
	 * @param request
	 * @param response
	 * @param flag true表示取购物车所有可见赠品（比如某个分类赠品已经存在则不取该分类其他赠品），false表示取所有购物车商品能看到的赠品（不管购物车中的赠品）
	 * @return
	 */
	private static ArrayList<GiftGoods> getCartGiftProducts(HttpServletRequest request,HttpServletResponse response,boolean flag){
		ArrayList<Cart> normalCartList = CartHelper.getCartNormalProducts(request,response);
		
		//需要返回的结果
		ArrayList<GiftGoods> resGiftItemList = new ArrayList<GiftGoods>();
		
		ArrayList<Gift> giftList = getAllValidGifts();
		
		/*//如果是平安万里通的用户，加上对应的赠品
		if(UserHelper.isPingAnUser(request,response)){
			if(!flag||(flag&&!CartHelper.existPingAnGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//赠品主表标题包含“平安万里通”的赠品，加入
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().indexOf("平安万里通")>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
								if(gi_1.getGiftrckdtl_limitmoney()<=CartShopCodeHelper.getTotalPayMoney(request,response,"00000000")){
									GiftGoods gg = create(g_2,gi_1);
									if(gg != null) {
										if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
									}
								}
							}
						}
					}
				}
			}
		}
		
		//如果是139邮箱的用户，加上对应的赠品
		if(UserHelper.is139MailUser(request, response)){
			if(!flag||(flag&&!CartHelper.exist139MailGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//赠品主表标题包含“139邮箱”的赠品，加入
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().indexOf("139邮箱")>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
								if(gi_1.getGiftrckdtl_limitmoney()<=CartShopCodeHelper.getTotalPayMoney(request,response,"00000000")){
									GiftGoods gg = create(g_2,gi_1);
									if(gg != null) {
										if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
									}
								}
							}
						}
					}
				}
			}
		}*/
		
		//如果是白金VIP用户，加上对应赠品
	/*	if(UserHelper.isPtVip(request, response)){
			if(!flag||(flag&&!CartHelper.existPtVipGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//赠品主表标题包含“白金VIP”的赠品，加入
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().toLowerCase().indexOf("白金VIP".toLowerCase())>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
								if(gi_1.getGiftrckdtl_limitmoney()<=CartShopCodeHelper.getTotalPayMoney(request,response,"00000000")){
									GiftGoods gg = create(g_2,gi_1);
									if(gg != null) {
										if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
									}
								}
							}
						}
					}
				}
			}
		}*/
		
	//加上购物车里商品对应的全场赠品---包括两种全场、全部商户、商户自己的全场
		
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//购物车里正常的商品
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//000分类表示全场
					if(!flag||(!CartHelper.existTotalGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+""))){
						if("000".equals(gift_1.getGiftrckmst_rackcode())){
							ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
								float shopmoney= shopmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gift_1.getGiftrckmst_shopcode());
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
									
									if((gi_1.getGiftrckdtl_limitmoney().floatValue()==0&&shopmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney().floatValue()<=shopmoney)){
										GiftGoods gg = create(gift_1,gi_1);
										if(gg != null ) {
											if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
										}
									}
								}
							}
						}
					}
				}
			}
		}
	
		//加上购物车里商品对应的分类赠品---包括两种、全部商户、商户自己分类
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//购物车里正常的商品
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//满足分类条件，则加入
					
					if((!flag||(!CartHelper.existDirectoryGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+"")))&&Tools.isNull(gift_1.getGiftrckmst_brandname())){
						if(product.getGdsmst_rackcode()!=null&&(product.getGdsmst_rackcode().startsWith(gift_1.getGiftrckmst_rackcode())
								||("001".equals(gift_1.getGiftrckmst_rackcode())
								&&(product.getGdsmst_rackcode().startsWith("015009")||product.getGdsmst_rackcode().startsWith("02")
								||product.getGdsmst_rackcode().startsWith("03"))
								)||("002".equals(gift_1.getGiftrckmst_rackcode())
										&&!product.getGdsmst_rackcode().startsWith("014")))){
								ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
								float rckmoney=0f;
								if ("001".equals(gift_1.getGiftrckmst_rackcode())){
									rckmoney=CartHelper.getTotalRackcodePayMoney(request,response,"015009",gift_1.getGiftrckmst_shopcode());
									rckmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"02",gift_1.getGiftrckmst_shopcode());
									rckmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"03",gift_1.getGiftrckmst_shopcode());
								}
								else{
									rckmoney=CartHelper.getTotalRackcodePayMoney(request,response,gift_1.getGiftrckmst_rackcode(),gift_1.getGiftrckmst_shopcode());
								}
								
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
									//System.out.println(gi_1.getGiftrckdtl_limitmoney()+"====="+rckmoney);
									if((gi_1.getGiftrckdtl_limitmoney().floatValue()==0&&rckmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney().floatValue()<=rckmoney)){
										GiftGoods gg = create(gift_1,gi_1);
										if(gg != null) {										
												if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		//加上品牌赠品
		ArrayList<Brand> brandList = CartHelper.getCartBrands(request,response);
		
		for(int i=0;brandList!=null&&i<brandList.size();i++){
			Brand brand = brandList.get(i);
			
			//加上品牌赠品！！！！！！！！！！！！
			if(!flag||(flag&&!CartHelper.existBrandGift(request,response,brand.getBrand_name()))){
				
				ArrayList<GiftItem> brandGiftItemList = getAvaiableGiftItems(null,brand.getBrand_name());
				
				if(brandGiftItemList!=null&&brandGiftItemList.size()>0){
					float shopmoney=0f;
					for(int k=0;k<brandGiftItemList.size();k++){
						GiftItem gi_1 = brandGiftItemList.get(k);
						Gift gift = (Gift)Tools.getManager(Gift.class).get(String.valueOf(gi_1.getGiftrckdtl_mstid()));
						if(gift != null){
						//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
							shopmoney=CartHelper.getCartBrandPayMoney(request,response,brand.getBrand_name(),gift.getGiftrckmst_shopcode());
						 if((gi_1.getGiftrckdtl_limitmoney()==0&&shopmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney()<=shopmoney)){
							
								GiftGoods gg = create(gift,gi_1);
								if(gg != null) {
									if(!flag||!CartHelper.existsGiftProductId(request,response,gg.getProductId()))resGiftItemList.add(gg);
								}
							}
						}
					}
				}
			}
		}
		
		/*//定义的多品赠品主表
		ArrayList<GiftGroup> ggList = getAllGiftGroups();
		//加上多品赠品，即推荐位赠品
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product==null)continue;
			
			PromotionProduct pp = getPromotionProductViaProductId(product.getId());
			
			if(pp==null)continue;
			String promotion = pp.getSpgdsrcm_code()+"";//对应的推荐位
			
			if(ggList==null||ggList.size()==0)break ;
			
			for(int j=0;j<ggList.size();j++){
				GiftGroup gg = ggList.get(j);
				
				if(!flag||(flag&&!CartHelper.existPromotionGift(request,response,gg.getGiftgrpmst_sprckcodeStr()))){				
					//主表有这个推荐位的定义
					if(gg.getGiftgrpmst_sprckcodeStr()!=null&&gg.getGiftgrpmst_sprckcodeStr().indexOf(","+promotion+",")>-1){
						//取明细数据
						ArrayList<GiftGroupItem> ggiList = getGiftGroupItem(gg.getId());
						if(ggiList!=null&&ggiList.size()>0){
							for(int k=0;k<ggiList.size();k++){
								GiftGoods giftGoods = create(gg,ggiList.get(k));
								if(giftGoods != null) {
									if(!flag||!CartHelper.existsGiftProductId(request,response,giftGoods.getProductId()))resGiftItemList.add(giftGoods);
								}
							}
						}
					}
				}
			}
		}*/
		
		//key就是商品的id，防止重复计算
		HashMap<String,Integer> giftItemMap = new HashMap<String,Integer>();
		//去重付的赠品明细，一般情况不会有重复的
		for(int i=0;i<resGiftItemList.size();i++){
			GiftGoods gift_goods = resGiftItemList.get(i);
			String itemId = gift_goods.getProductId();
			if(giftItemMap.containsKey(itemId)){
				Integer i_123 = giftItemMap.get(itemId);
				giftItemMap.put(itemId, new Integer(i_123.intValue()+1));
			}else{
				giftItemMap.put(itemId, new Integer(1));
			}
			
			Integer v = giftItemMap.get(itemId);
			if(v.intValue()>1){//重复了，删除之
				
				resGiftItemList.remove(i) ;
				i--;
			}
		}
	
		Collections.sort(resGiftItemList , new GiftComparator());
		//System.out.println("购物车里的赠品数："+resGiftItemList.size());
		return resGiftItemList ;
	}
	public static ArrayList<Gift> getAllValidGifts(int type){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//有效的
		if(type==0){
		clist.add(Restrictions.eq("giftrckmst_rackcode", "000"));//有效的
		}else if(type==1){
			clist.add(Restrictions.ne("giftrckmst_rackcode", "000"));//有效的
	    }
		
		List<BaseEntity> resList = Tools.getManager(Gift.class).getList(clist,null,0,1000);
		ArrayList<Gift> list = new ArrayList<Gift>();
		if(resList!=null){
			for(int i=0;i<resList.size();i++){
				list.add((Gift)resList.get(i));
			}
		}
		return list ;
	}
	private static boolean Giftlistexists(ArrayList<Gift> gflist,String mid){
		if(Tools.isNull(mid))return true;
		for(int i=0;i<gflist.size();i++){
			if(gflist.get(i).getId().equals(mid)){
				return true;
			}
		}
		return false;
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @param type   0全场、1分类、2品牌
	 * @return
	 */
		public static ArrayList<Gift> getCartGift(HttpServletRequest request,HttpServletResponse response,int type){
			ArrayList<Cart> normalCartList = CartHelper.getCartNormalProducts(request,response);
			ArrayList<Gift> gList=new ArrayList<Gift>();
		ArrayList<Gift> giftList =null;
		if(type!=2)	giftList=getAllValidGifts(type);
		
		
	//加上购物车里商品对应的全场赠品---包括两种全场、全部商户、商户自己的全场
		if(type==0){
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//购物车里正常的商品
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//000分类表示全场
					if((!CartHelper.existTotalGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+""))){
						if("000".equals(gift_1.getGiftrckmst_rackcode())){
							ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
							//	float shopmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gift_1.getGiftrckmst_shopcode());
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
									
									//if((gi_1.getGiftrckdtl_limitmoney().floatValue()==0&&shopmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney().floatValue()<=shopmoney)){

											if(!Giftlistexists(gList,gift_1.getId())&&!CartHelper.existsGiftProductId(request,response,gi_1.getGiftrckdtl_gdsid())){
												gList.add(gift_1);
												break;
											}
										//	}
								}
							}
						}
					}
				}
			}
		}
		}
		if(type==1){
		//加上购物车里商品对应的分类赠品---包括两种、全部商户、商户自己分类
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//购物车里正常的商品
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//满足分类条件，则加入
					
					if(((!CartHelper.existDirectoryGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+"")))&&Tools.isNull(gift_1.getGiftrckmst_brandname())){
						if(product.getGdsmst_rackcode()!=null&&(product.getGdsmst_rackcode().startsWith(gift_1.getGiftrckmst_rackcode())
								||("001".equals(gift_1.getGiftrckmst_rackcode())
								&&(product.getGdsmst_rackcode().startsWith("015009")||product.getGdsmst_rackcode().startsWith("02")
								||product.getGdsmst_rackcode().startsWith("03"))
								)||("002".equals(gift_1.getGiftrckmst_rackcode())
										&&!product.getGdsmst_rackcode().startsWith("014")))){
								ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
								/*float rckmoney=0f;
								if ("001".equals(gift_1.getGiftrckmst_rackcode())){
									rckmoney=CartHelper.getTotalRackcodePayMoney(request,response,"015009",gift_1.getGiftrckmst_shopcode());
									rckmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"02",gift_1.getGiftrckmst_shopcode());
									rckmoney+=CartHelper.getTotalRackcodePayMoney(request,response,"03",gift_1.getGiftrckmst_shopcode());
								}
								else{
									rckmoney=CartHelper.getTotalRackcodePayMoney(request,response,gift_1.getGiftrckmst_rackcode(),gift_1.getGiftrckmst_shopcode());
								}
								*/
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
									//System.out.println(gi_1.getGiftrckdtl_limitmoney()+"====="+rckmoney);
									//if((gi_1.getGiftrckdtl_limitmoney().floatValue()==0&&rckmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney().floatValue()<=rckmoney)){
									if(!Giftlistexists(gList,gift_1.getId())&&!CartHelper.existsGiftProductId(request,response,gi_1.getGiftrckdtl_gdsid())){
										gList.add(gift_1);
										break;
									}
									//}
								}
							}
						}
					}
				}
			}
		}
		}
		if(type==2){
		//加上品牌赠品
		ArrayList<Brand> brandList = CartHelper.getCartBrands(request,response);
		
		for(int i=0;brandList!=null&&i<brandList.size();i++){
			Brand brand = brandList.get(i);
			
			//加上品牌赠品！！！！！！！！！！！！
			if((!CartHelper.existBrandGift(request,response,brand.getBrand_name()))){
				
				ArrayList<GiftItem> brandGiftItemList = getAvaiableGiftItems(null,brand.getBrand_name());
				
				if(brandGiftItemList!=null&&brandGiftItemList.size()>0){
					float shopmoney=0f;
					for(int k=0;k<brandGiftItemList.size();k++){
						GiftItem gi_1 = brandGiftItemList.get(k);
						Gift gift = (Gift)Tools.getManager(Gift.class).get(String.valueOf(gi_1.getGiftrckdtl_mstid()));
						if(gift != null){
						//如果满足金额才加入。这个地方可能要判断用户级别，暂时不判断
							//shopmoney=CartHelper.getCartBrandPayMoney(request,response,brand.getBrand_name(),gift.getGiftrckmst_shopcode());
						// if((gi_1.getGiftrckdtl_limitmoney()==0&&shopmoney>0f)||(gi_1.getGiftrckdtl_limitmoney().floatValue()!=0&&gi_1.getGiftrckdtl_limitmoney()<=shopmoney)){
							if(!Giftlistexists(gList,gift.getId())&&!CartHelper.existsGiftProductId(request,response,gi_1.getGiftrckdtl_gdsid())){
								gList.add(gift);
								break;
							}
						//	}
						}
					}
				}
			}
		}
		}
	
		return gList;
	}

		public static String getcreategiftaddstr(Gift g,GiftItem gitem,Product product,float cartallmoney){
			if(g==null || product == null) return "";
			String strValue = "";
			// String shoptxt="";
			if(product != null && ProductHelper.isShow(product)){
				float fltGiftRckDtl_Limitmoney = Tools.floatValue(gitem.getGiftrckdtl_limitmoney());
				float fltGiftRckDtl_Addmoney = Tools.floatValue(gitem.getGiftrckdtl_addmoney());
				String strGiftrckmst_rackcode = g.getGiftrckmst_rackcode().trim();
                  /*String shopcode=g.getGiftrckmst_shopcode();
				  
                  if(!shopcode.equals("11111111")){
                	  ShpMst sm=(ShpMst)Tools.getManager(ShpMst.class).get(shopcode);
                	  if(sm!=null){
                	  shoptxt="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+shopcode+"\" target=\"_blank\">在“"+ sm.getShpmst_shopname()+"”店铺</a><br>";
                	  }
                  }*/
				 int smoneh= (int)Tools.getFloat(fltGiftRckDtl_Limitmoney-cartallmoney,0) ;
				if("000".equals(strGiftrckmst_rackcode)){//全场
					if(smoneh<=0){
						strValue = "你已经达到换购要求";
					/*if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "全场消费可免费获得";
						}else{
							strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
						}
					}else{//消费满1314元即可免费获得     消费满999元加1元可换购
						if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "全场消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}else{
							if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
								strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
							}else{
								strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
							}
						}
					}*/
				 }else{
					 if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						  strValue = "您还差"+smoneh+"元即可免费获得此商品";
						}else{
							strValue = "您还差"+smoneh+"元+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元即可换购";
						}
				 }
				}else if("001".equals(strGiftrckmst_rackcode)){//服装饰品
					if(smoneh<=0){
						strValue = "你已经达到换购要求";
					/*if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "服装饰品消费可免费获得";
						}else{
							strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
						}
					}else{
						if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "服装饰品消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}else{
							if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
								strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
							}else{
								strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
							}
						}
					}*/
				   }else{
					   if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
							  strValue = "您还差"+smoneh+"元即可免费获得此商品";
							}else{
								strValue = "您还差"+smoneh+"元+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元即可换购";
							}
				   }
				}
				else{
					//System.out.println("品牌提示信息");
					String strGiftrckmst_brandname = g.getGiftrckmst_brandname();
					if(strGiftrckmst_brandname!=null)strGiftrckmst_brandname=strGiftrckmst_brandname.replace("null", "");
					Directory dir = DirectoryHelper.getById(strGiftrckmst_rackcode);
					String strRakmst_rackname = (dir != null ? dir.getRakmst_rackname():"000");
					if(strRakmst_rackname.equals("000")){
						strRakmst_rackname="";
					}
					if(Tools.isNull(strGiftrckmst_brandname)){
						strGiftrckmst_brandname="";
					}
					if(smoneh<=0){
						strValue = "你已经达到换购要求";
					/*if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "可免费获得";
						}else{
							strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
						}
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}else{
							strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}
					}*/
					}else{
						 if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
							  strValue = "您还差"+smoneh+"元即可免费获得此商品";
							}else{
								strValue = "您还差"+smoneh+"元+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元即可换购";
							}
					}
				}
			}
			return strValue;
		}
		
	
	/**
	 * 得到所有多品赠品的定义
	 * @return
	 */
	public static ArrayList<GiftGroup> getAllGiftGroups(){
		List<BaseEntity> list = Tools.getManager(GiftGroup.class).getList(null, null, 0, 1000);
		ArrayList<GiftGroup> resList = new ArrayList<GiftGroup>();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				GiftGroup gg =(GiftGroup)list.get(i);
				resList.add(gg);
			}
		}
		return resList ;
	}
	
	/**
	 * 根据gift group id获取定义的明细，可以获取所有定义的多品赠品
	 * @param giftGroupId GiftGroup id，null表示获取全部
	 * @return
	 */
	public static ArrayList<GiftGroupItem> getGiftGroupItem(String giftGroupId){
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		if(giftGroupId!=null)clist.add(Restrictions.eq("giftgrpdtl_mstid", new Long(giftGroupId)));//这里是Long
		
		List<BaseEntity> resList = Tools.getManager(GiftGroupItem.class).getList(clist,null,0,1000);
		ArrayList<GiftGroupItem> list = new ArrayList<GiftGroupItem>();
		if(resList!=null){
			for(int i=0;i<resList.size();i++){
				list.add((GiftGroupItem)resList.get(i));
			}
		}
		return list ;
	}
	
	/**
	 * 根据商品id获取到对应的多品推荐位对应关系记录
	 * @param productId
	 * @return
	 */
	public static PromotionProduct getPromotionProductViaProductId(String productId){
		return (PromotionProduct)Tools.getManager(PromotionProduct.class).findByProperty("spgdsrcm_gdsid", productId);
	}
	
	/**
	 * 多品赠品创建赠品类
	 * @param gg - GiftGroup
	 * @param ggi - GiftGroupItem
	 * @return GiftGoods
	 */
	private static GiftGoods create(GiftGroup gg , GiftGroupItem ggi){
		if(gg==null || ggi == null) return null;
		Product product = ProductHelper.getById(ggi.getGiftgrpdtl_gdsid());
		GiftGoods goods = null;
		if(product != null && ProductHelper.isShow(product)){
			float fltLimitMoney = Tools.floatValue(ggi.getGiftgrpdtl_limitmoney());
			float fltAddMoney = Tools.floatValue(ggi.getGiftgrpdtl_addmoney());
			
			goods = new GiftGoods();
			String strValue = "";
			if (Tools.floatCompare(fltLimitMoney, 0) == 0){
				strValue = "购买专区商品";
			}else{
				strValue = "专区商品购满" + Tools.getFormatMoney(fltLimitMoney) + "元";
			}
			if (Tools.floatCompare(fltAddMoney, 0) == 1){
				strValue = strValue + "加" + Tools.getFormatMoney(fltAddMoney) + "元获得";
				goods.setIsfree(false);
			}else{
				strValue = strValue + "可免费获得";
				goods.setIsfree(true);
			}
			goods.setValue(strValue);
			goods.setName(Tools.clearHTML(product.getGdsmst_gdsname()));
			goods.setProductId(product.getId());
			goods.setSalePrice(Tools.floatValue(product.getGdsmst_saleprice()));
			goods.setType(1);
			if(fltAddMoney <= 0) fltAddMoney = 0;
			goods.setPrice(fltAddMoney);
			goods.setGiftItemId(ggi.getId());
		}
		return goods;
	}
	
	/**
	 * 普通赠品创建赠品类
	 * @param g - Gift
	 * @param gi - GiftItem
	 * @return GiftGoods
	 */
	private static GiftGoods create(Gift g , GiftItem gi){
		if(g==null || gi == null) return null;
		Product product = ProductHelper.getById(gi.getGiftrckdtl_gdsid());
		GiftGoods goods = null;
		String shpname="";
		if(product != null && ProductHelper.isShow(product)){
			float fltGiftRckDtl_Limitmoney = Tools.floatValue(gi.getGiftrckdtl_limitmoney());
			float fltGiftRckDtl_Addmoney = Tools.floatValue(gi.getGiftrckdtl_addmoney());
			String strGiftrckmst_rackcode = g.getGiftrckmst_rackcode();
			String strgf_shopcode = g.getGiftrckmst_shopcode();
			if(!strgf_shopcode.equals("11111111")){
				ShpMst shpmst=(ShpMst)Tools.getManager(ShpMst.class).get(strgf_shopcode);
				if(shpmst==null)return null;
				shpname="店铺“"+shpmst.getShpmst_shopname()+"”";
			}
			
			String strValue = "";

			goods = new GiftGoods();
			
			goods.setRackcode(strGiftrckmst_rackcode);
			
			if("000".equals(strGiftrckmst_rackcode)){//全场
				if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "全场消费可免费获得";
					}else{
						strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
					}
					goods.setIsfree(true);
				}else{
					if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "全场消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
							strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}else{
							strValue = "全场消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
						}
					}
					goods.setIsfree(false);
				}
			}if("001".equals(strGiftrckmst_rackcode)){//服装饰品
				if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "服装饰品消费可免费获得";
					}else{
						strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
					}
					goods.setIsfree(true);
				}else{
					if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "服装饰品消费加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
							strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
						}else{
							strValue = "服装饰品消费满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元直减" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "元";
						}
					}
					goods.setIsfree(false);
				}
			}
			else{
				String strGiftrckmst_brandname = g.getGiftrckmst_brandname();
				Directory dir = DirectoryHelper.getById(strGiftrckmst_rackcode);
				String strRakmst_rackname = (dir != null ? dir.getRakmst_rackname():"000");
				if(strRakmst_rackname.equals("000")){
					strRakmst_rackname="";
				}
				if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "可免费获得";
					}else{
						strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元可免费获得";
					}
					goods.setIsfree(true);
				}else{
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
					}else{
						strValue = "买" + strGiftrckmst_brandname + strRakmst_rackname + "满" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "元加" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "元可换购";
					}
					goods.setIsfree(false);
				}
			}
			strValue=shpname+strValue;
			goods.setValue(strValue);
			goods.setName(Tools.clearHTML(product.getGdsmst_gdsname()));
			goods.setProductId(product.getId());
			goods.setSalePrice(Tools.floatValue(product.getGdsmst_saleprice()));
			goods.setType(0);
			goods.setGiftItemId(gi.getId());
			goods.setGiftMstId(gi.getGiftrckdtl_mstid());
			if(fltGiftRckDtl_Addmoney < 0) fltGiftRckDtl_Addmoney = 0;
			goods.setPrice(fltGiftRckDtl_Addmoney);
		}
		return goods;
	}
	
	/**
	 * 赠品物品。
	 * @author chengang
	 * @createTime 2011-11-25 13:29:23
	 *
	 */
	public static class GiftGoods implements Serializable{
		
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		
		/**
		 * 分类，如果是全场赠品，则为000
		 */
		private String rackcode ;

		/**
		 * 物品ID
		 */
		private String productId;
		
		/**
		 * 赠品Item的ID
		 */
		private String giftItemId;
		/**
		 * 赠品区域的ID
		 */
		private long giftMstId;
		
		/**
		 * 是否是免费赠品
		 */
		private boolean isfree;
		
		/**
		 * 商品名称
		 */
		private String name;
		
		/**
		 * 商品说明
		 */
		private String value;
		
		/**
		 * 现价
		 */
		private float price;
		
		/**
		 * 市场售价
		 */
		private float salePrice;
		
		/**
		 * 0普通赠品，1多品赠品
		 */
		private long type;

		public String getGiftItemId() {
			return giftItemId;
		}

		public void setGiftItemId(String giftItemId) {
			this.giftItemId = giftItemId;
		}
		
		public long getGiftMstId() {
			return giftMstId;
		}

		public void setGiftMstId(long giftMstId) {
			this.giftMstId = giftMstId;
		}

		public float getPrice() {
			return price;
		}

		public void setPrice(float price) {
			this.price = price;
		}

		public String getProductId() {
			return productId;
		}

		public void setProductId(String productId) {
			this.productId = productId;
		}

		public boolean isIsfree() {
			return isfree;
		}

		public void setIsfree(boolean isfree) {
			this.isfree = isfree;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getValue() {
			return value;
		}

		public String getRackcode() {
			return rackcode;
		}

		public void setRackcode(String rackcode) {
			this.rackcode = rackcode;
		}

		public void setValue(String value) {
			this.value = value;
		}

		public float getSalePrice() {
			return salePrice;
		}

		public void setSalePrice(float salePrice) {
			this.salePrice = salePrice;
		}

		public long getType() {
			return type;
		}

		public void setType(long type) {
			this.type = type;
		}
		
	}
	
	/**
	 * 排序赠品，先把免费的排在前面，然后则是
	 * @author chengang
	 * @createTime 2011-11-18 22:13:23
	 *
	 */
	public static class GiftComparator implements Comparator<GiftGoods> {

		@Override
		public int compare(GiftGoods p0, GiftGoods p1) {
			boolean free0 = p0.isIsfree();
			boolean free1 = p1.isIsfree();
			if(free0 && !free1){
				return -1;
			}else if(free0 == free1){
				return 0 ;
			}else{
				return 1;
			}
		}
		
	}
	
}
