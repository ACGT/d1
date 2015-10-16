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
 * ��Ʒ���ù����࣬�����ǲ���Gift��
 * @author kk
 *
 */
public class GiftHelper {
	
	public static final BaseManager manager = Tools.getManager(GiftProduct.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return GiftProduct
	 */
	public static GiftProduct getById(String id){
		if(Tools.isNull(id)) return null;
		return (GiftProduct)manager.get(id);
	}
	
	/**
	 * giftgds_gdsid �鿴����
	 * @param productId - ��ƷID
	 * @return GiftProduct
	 */
	public static GiftProduct getGiftProductByGId(String productId){
		if(Tools.isNull(productId)) return null;
		return (GiftProduct)manager.findByProperty("giftgds_gdsid", productId);
	}
	
	/**
	 * �õ���Ʒ��Ʒ��Ӧ�Ķ�Ӧ��ϵ��¼�����ڻ�ȡ��Ʒ��Ʒ�ļ۸���Ϣ��
	 * @param productId ��Ʒid
	 * @return GiftProduct 
	 */
	public static GiftProduct getGiftProduct(String productId){
		if(Tools.isNull(productId)) return null;
		//�ȴӵ�Ʒ�����л�ȡ��¼
		GiftProduct gp = (GiftProduct)manager.findByProperty("giftgds_mastergdsid", productId);
		return gp ;
	}
	
	/**
	 * ��õ�Ʒ��Ʒ����Ʒ��Ϣ
	 * @param productId - ��ƷID
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
	 * ��ȡ��Ч��Ʒ��ϸ
	 * @param rackcode �����ţ�000��ʾȫ����null��ȡȫ��
	 * @param brandName Ʒ�ƣ����Ϊnull����ȡȫ��
	 * @return ���з���������GiftItem
	 */
	public static ArrayList<GiftItem> getAvaiableGiftItems(String rackcode,String brandName){
		//�����ѯ����
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		
		if(rackcode!=null)clist.add(Restrictions.eq("giftrckmst_rackcode", rackcode));
		if(brandName!=null)clist.add(Restrictions.eq("giftrckmst_brandname", brandName));
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//ֻȡ��Ч��
		
		ArrayList<GiftItem> resList = new ArrayList<GiftItem>();
		
		//����Ʒ�����ȡ�б�
		List<BaseEntity> list = Tools.getManager(Gift.class).getList(clist, null, 0, 1000);
		
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Gift gift = (Gift)list.get(i);
				
				//������Ʒ���ȡ��Ʒ��ϸ��һ����Ʒ�����ж����Ʒ��Ʒ
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
	 * ��ȡ���ж������Ʒ��¼��ֻȡ��Ч�ġ���ʾȫ����Ȼ���Ƿ���
	 * @return
	 */
	public static ArrayList<Gift> getAllValidGifts(){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//��Ч��
		
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
	 * ����gift id�õ���Ӧ����ϸ
	 * @param giftId giftId����������
	 * @return
	 */
	public static ArrayList<GiftItem> getGiftItems(String giftId){
		if(!StringUtils.isDigits(giftId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_mstid", new Long(giftId)));//������Long
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
	 * ������Ʒ����Ʒid��ȡ����Ʒ��Ӧ�����з���
	 * @param productId
	 * @return
	 */
	public static ArrayList<String> getGiftDirectory(String productId){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckdtl_gdsid", productId));
		//��ȡ����Ʒ�Ķ�����Ʒ��ϸ���ٸ���mstid��ȡ��Ӧ�����з���
		List<BaseEntity> resList = Tools.getManager(GiftItem.class).getList(clist,null,0,1000);
		ArrayList<String> list = new ArrayList<String>();
		
		if(resList!=null&&resList.size()>0){
			for(int i=0;i<resList.size();i++){
				GiftItem gi = (GiftItem)resList.get(i);
				//������ϸȡGift������
				Gift gift = (Gift)Tools.getManager(Gift.class).get(gi.getGiftrckdtl_mstid()+"");
				if(gift!=null){
					//�������
					list.add(gift.getGiftrckmst_rackcode());
				}
			}
		}
		
		return list ;
		
	}
	
	/**
	 * ��ȡһ�����ﳵ���ܿ�������Ʒ���޳�һЩ�ų��е���Ʒ��һ����˵�����ü��ľ��ǿ��Լ��빺�ﳵ��<br/>
	 * ����׽�VIP����Ʒ��������ڹ��ﳵ�У���ô����ȡ�׽�VIP����Ʒ�б��ˡ�
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<GiftGoods> getCartVisiableGiftProducts(HttpServletRequest request,HttpServletResponse response){
		return getCartGiftProducts(request,response,true);
	}
	
	/**
	 * ȡ�ù��ﳵ����Ʒ������Ʒ�б������ǹ��ﳵ�Ƿ���������Ʒ
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<GiftGoods> getCartAvaiableGiftProducts(HttpServletRequest request,HttpServletResponse response){
		return getCartGiftProducts(request,response,false);
	}
	
	
	/**
	 * �õ����ﳵ��֧���ۣ��������˷ѣ�
	 * @param request
	 * @param response
	 * @return ������λС��
	 */
	public static float getTotalPayMoneys(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = CartHelper.getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
				if(cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=18&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14)total+=cart.getMoney();
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	
	/**
	 * ��ȡ�ù��ﳵ��������Ʒ��Ӧ����Ʒ��ϸ��Ҳ���Ǹù��ﳵ����Դ�����Щ��Ʒ������<br/>
	 * ��Ʒ��Ʒ�Ѿ����������������Ĳ�������Ʒ��Ʒ��������������
	 * @param request
	 * @param response
	 * @param flag true��ʾȡ���ﳵ���пɼ���Ʒ������ĳ��������Ʒ�Ѿ�������ȡ�÷���������Ʒ����false��ʾȡ���й��ﳵ��Ʒ�ܿ�������Ʒ�����ܹ��ﳵ�е���Ʒ��
	 * @return
	 */
	private static ArrayList<GiftGoods> getCartGiftProducts(HttpServletRequest request,HttpServletResponse response,boolean flag){
		ArrayList<Cart> normalCartList = CartHelper.getCartNormalProducts(request,response);
		
		//��Ҫ���صĽ��
		ArrayList<GiftGoods> resGiftItemList = new ArrayList<GiftGoods>();
		
		ArrayList<Gift> giftList = getAllValidGifts();
		
		/*//�����ƽ������ͨ���û������϶�Ӧ����Ʒ
		if(UserHelper.isPingAnUser(request,response)){
			if(!flag||(flag&&!CartHelper.existPingAnGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//��Ʒ������������ƽ������ͨ������Ʒ������
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().indexOf("ƽ������ͨ")>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		
		//�����139������û������϶�Ӧ����Ʒ
		if(UserHelper.is139MailUser(request, response)){
			if(!flag||(flag&&!CartHelper.exist139MailGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//��Ʒ������������139���䡱����Ʒ������
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().indexOf("139����")>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		
		//����ǰ׽�VIP�û������϶�Ӧ��Ʒ
	/*	if(UserHelper.isPtVip(request, response)){
			if(!flag||(flag&&!CartHelper.existPtVipGift(request,response))){
				for(int i=0;i<giftList.size();i++){
					Gift g_2 = giftList.get(i);
					//��Ʒ�������������׽�VIP������Ʒ������
					if(g_2.getGiftrckmst_title()!=null&&g_2.getGiftrckmst_title().toLowerCase().indexOf("�׽�VIP".toLowerCase())>-1){
						ArrayList<GiftItem> giftItemList = getGiftItems(g_2.getId());
						if(giftItemList!=null&&giftItemList.size()>0){
							for(int k=0;k<giftItemList.size();k++){
								GiftItem gi_1 = giftItemList.get(k);
								
								//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		
	//���Ϲ��ﳵ����Ʒ��Ӧ��ȫ����Ʒ---��������ȫ����ȫ���̻����̻��Լ���ȫ��
		
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//���ﳵ����������Ʒ
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//000�����ʾȫ��
					if(!flag||(!CartHelper.existTotalGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+""))){
						if("000".equals(gift_1.getGiftrckmst_rackcode())){
							ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
								float shopmoney= shopmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gift_1.getGiftrckmst_shopcode());
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
									
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
	
		//���Ϲ��ﳵ����Ʒ��Ӧ�ķ�����Ʒ---�������֡�ȫ���̻����̻��Լ�����
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//���ﳵ����������Ʒ
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//������������������
					
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
									//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		
		//����Ʒ����Ʒ
		ArrayList<Brand> brandList = CartHelper.getCartBrands(request,response);
		
		for(int i=0;brandList!=null&&i<brandList.size();i++){
			Brand brand = brandList.get(i);
			
			//����Ʒ����Ʒ������������������������
			if(!flag||(flag&&!CartHelper.existBrandGift(request,response,brand.getBrand_name()))){
				
				ArrayList<GiftItem> brandGiftItemList = getAvaiableGiftItems(null,brand.getBrand_name());
				
				if(brandGiftItemList!=null&&brandGiftItemList.size()>0){
					float shopmoney=0f;
					for(int k=0;k<brandGiftItemList.size();k++){
						GiftItem gi_1 = brandGiftItemList.get(k);
						Gift gift = (Gift)Tools.getManager(Gift.class).get(String.valueOf(gi_1.getGiftrckdtl_mstid()));
						if(gift != null){
						//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		
		/*//����Ķ�Ʒ��Ʒ����
		ArrayList<GiftGroup> ggList = getAllGiftGroups();
		//���϶�Ʒ��Ʒ�����Ƽ�λ��Ʒ
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product==null)continue;
			
			PromotionProduct pp = getPromotionProductViaProductId(product.getId());
			
			if(pp==null)continue;
			String promotion = pp.getSpgdsrcm_code()+"";//��Ӧ���Ƽ�λ
			
			if(ggList==null||ggList.size()==0)break ;
			
			for(int j=0;j<ggList.size();j++){
				GiftGroup gg = ggList.get(j);
				
				if(!flag||(flag&&!CartHelper.existPromotionGift(request,response,gg.getGiftgrpmst_sprckcodeStr()))){				
					//����������Ƽ�λ�Ķ���
					if(gg.getGiftgrpmst_sprckcodeStr()!=null&&gg.getGiftgrpmst_sprckcodeStr().indexOf(","+promotion+",")>-1){
						//ȡ��ϸ����
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
		
		//key������Ʒ��id����ֹ�ظ�����
		HashMap<String,Integer> giftItemMap = new HashMap<String,Integer>();
		//ȥ�ظ�����Ʒ��ϸ��һ������������ظ���
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
			if(v.intValue()>1){//�ظ��ˣ�ɾ��֮
				
				resGiftItemList.remove(i) ;
				i--;
			}
		}
	
		Collections.sort(resGiftItemList , new GiftComparator());
		//System.out.println("���ﳵ�����Ʒ����"+resGiftItemList.size());
		return resGiftItemList ;
	}
	public static ArrayList<Gift> getAllValidGifts(int type){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("giftrckmst_validflag", new Long(0)));//��Ч��
		if(type==0){
		clist.add(Restrictions.eq("giftrckmst_rackcode", "000"));//��Ч��
		}else if(type==1){
			clist.add(Restrictions.ne("giftrckmst_rackcode", "000"));//��Ч��
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
	 * @param type   0ȫ����1���ࡢ2Ʒ��
	 * @return
	 */
		public static ArrayList<Gift> getCartGift(HttpServletRequest request,HttpServletResponse response,int type){
			ArrayList<Cart> normalCartList = CartHelper.getCartNormalProducts(request,response);
			ArrayList<Gift> gList=new ArrayList<Gift>();
		ArrayList<Gift> giftList =null;
		if(type!=2)	giftList=getAllValidGifts(type);
		
		
	//���Ϲ��ﳵ����Ʒ��Ӧ��ȫ����Ʒ---��������ȫ����ȫ���̻����̻��Լ���ȫ��
		if(type==0){
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//���ﳵ����������Ʒ
			
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//000�����ʾȫ��
					if((!CartHelper.existTotalGift(request,response,gift_1)||"1".equals(gift_1.getGiftrckmst_selecttype()+""))){
						if("000".equals(gift_1.getGiftrckmst_rackcode())){
							ArrayList<GiftItem> giftItemList = getGiftItems(gift_1.getId());
							if(giftItemList!=null&&giftItemList.size()>0){
							//	float shopmoney=CartShopCodeHelper.getTotalPayMoneys(request,response,gift_1.getGiftrckmst_shopcode());
								for(int k=0;k<giftItemList.size();k++){
									GiftItem gi_1 = giftItemList.get(k);
									//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
									
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
		//���Ϲ��ﳵ����Ʒ��Ӧ�ķ�����Ʒ---�������֡�ȫ���̻����̻��Լ�����
		for(int i=0;i<normalCartList.size();i++){
			Cart cart = normalCartList.get(i);//���ﳵ����������Ʒ
			Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(product!=null){
				for(int j=0;j<giftList.size();j++){
					Gift gift_1 = giftList.get(j);
					//������������������
					
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
									//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
		//����Ʒ����Ʒ
		ArrayList<Brand> brandList = CartHelper.getCartBrands(request,response);
		
		for(int i=0;brandList!=null&&i<brandList.size();i++){
			Brand brand = brandList.get(i);
			
			//����Ʒ����Ʒ������������������������
			if((!CartHelper.existBrandGift(request,response,brand.getBrand_name()))){
				
				ArrayList<GiftItem> brandGiftItemList = getAvaiableGiftItems(null,brand.getBrand_name());
				
				if(brandGiftItemList!=null&&brandGiftItemList.size()>0){
					float shopmoney=0f;
					for(int k=0;k<brandGiftItemList.size();k++){
						GiftItem gi_1 = brandGiftItemList.get(k);
						Gift gift = (Gift)Tools.getManager(Gift.class).get(String.valueOf(gi_1.getGiftrckdtl_mstid()));
						if(gift != null){
						//���������ż��롣����ط�����Ҫ�ж��û�������ʱ���ж�
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
                	  shoptxt="<a href=\"http://www.d1.com.cn/shopbrand.jsp?sc="+shopcode+"\" target=\"_blank\">�ڡ�"+ sm.getShpmst_shopname()+"������</a><br>";
                	  }
                  }*/
				 int smoneh= (int)Tools.getFloat(fltGiftRckDtl_Limitmoney-cartallmoney,0) ;
				if("000".equals(strGiftrckmst_rackcode)){//ȫ��
					if(smoneh<=0){
						strValue = "���Ѿ��ﵽ����Ҫ��";
					/*if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "ȫ�����ѿ���ѻ��";
						}else{
							strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
						}
					}else{//������1314Ԫ������ѻ��     ������999Ԫ��1Ԫ�ɻ���
						if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "ȫ�����Ѽ�" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}else{
							if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
								strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
							}else{
								strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫֱ��" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "Ԫ";
							}
						}
					}*/
				 }else{
					 if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						  strValue = "������"+smoneh+"Ԫ������ѻ�ô���Ʒ";
						}else{
							strValue = "������"+smoneh+"Ԫ+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ���ɻ���";
						}
				 }
				}else if("001".equals(strGiftrckmst_rackcode)){//��װ��Ʒ
					if(smoneh<=0){
						strValue = "���Ѿ��ﵽ����Ҫ��";
					/*if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "��װ��Ʒ���ѿ���ѻ��";
						}else{
							strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
						}
					}else{
						if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "��װ��Ʒ���Ѽ�" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}else{
							if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
								strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
							}else{
								strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫֱ��" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "Ԫ";
							}
						}
					}*/
				   }else{
					   if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
							  strValue = "������"+smoneh+"Ԫ������ѻ�ô���Ʒ";
							}else{
								strValue = "������"+smoneh+"Ԫ+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ���ɻ���";
							}
				   }
				}
				else{
					//System.out.println("Ʒ����ʾ��Ϣ");
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
						strValue = "���Ѿ��ﵽ����Ҫ��";
					/*if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "����ѻ��";
						}else{
							strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
						}
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
							strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}else{
							strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}
					}*/
					}else{
						 if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
							  strValue = "������"+smoneh+"Ԫ������ѻ�ô���Ʒ";
							}else{
								strValue = "������"+smoneh+"Ԫ+" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ���ɻ���";
							}
					}
				}
			}
			return strValue;
		}
		
	
	/**
	 * �õ����ж�Ʒ��Ʒ�Ķ���
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
	 * ����gift group id��ȡ�������ϸ�����Ի�ȡ���ж���Ķ�Ʒ��Ʒ
	 * @param giftGroupId GiftGroup id��null��ʾ��ȡȫ��
	 * @return
	 */
	public static ArrayList<GiftGroupItem> getGiftGroupItem(String giftGroupId){
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		if(giftGroupId!=null)clist.add(Restrictions.eq("giftgrpdtl_mstid", new Long(giftGroupId)));//������Long
		
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
	 * ������Ʒid��ȡ����Ӧ�Ķ�Ʒ�Ƽ�λ��Ӧ��ϵ��¼
	 * @param productId
	 * @return
	 */
	public static PromotionProduct getPromotionProductViaProductId(String productId){
		return (PromotionProduct)Tools.getManager(PromotionProduct.class).findByProperty("spgdsrcm_gdsid", productId);
	}
	
	/**
	 * ��Ʒ��Ʒ������Ʒ��
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
				strValue = "����ר����Ʒ";
			}else{
				strValue = "ר����Ʒ����" + Tools.getFormatMoney(fltLimitMoney) + "Ԫ";
			}
			if (Tools.floatCompare(fltAddMoney, 0) == 1){
				strValue = strValue + "��" + Tools.getFormatMoney(fltAddMoney) + "Ԫ���";
				goods.setIsfree(false);
			}else{
				strValue = strValue + "����ѻ��";
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
	 * ��ͨ��Ʒ������Ʒ��
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
				shpname="���̡�"+shpmst.getShpmst_shopname()+"��";
			}
			
			String strValue = "";

			goods = new GiftGoods();
			
			goods.setRackcode(strGiftrckmst_rackcode);
			
			if("000".equals(strGiftrckmst_rackcode)){//ȫ��
				if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "ȫ�����ѿ���ѻ��";
					}else{
						strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
					}
					goods.setIsfree(true);
				}else{
					if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "ȫ�����Ѽ�" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
							strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}else{
							strValue = "ȫ��������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫֱ��" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "Ԫ";
						}
					}
					goods.setIsfree(false);
				}
			}if("001".equals(strGiftrckmst_rackcode)){//��װ��Ʒ
				if(Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 0){
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "��װ��Ʒ���ѿ���ѻ��";
					}else{
						strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
					}
					goods.setIsfree(true);
				}else{
					if(Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "��װ��Ʒ���Ѽ�" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
					}else{
						if (Tools.floatCompare(fltGiftRckDtl_Addmoney, 0) == 1){
							strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
						}else{
							strValue = "��װ��Ʒ������" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫֱ��" + Tools.getFormatMoney(-fltGiftRckDtl_Addmoney) + "Ԫ";
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
						strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "����ѻ��";
					}else{
						strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ����ѻ��";
					}
					goods.setIsfree(true);
				}else{
					if (Tools.floatCompare(fltGiftRckDtl_Limitmoney, 0) == 0){
						strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
					}else{
						strValue = "��" + strGiftrckmst_brandname + strRakmst_rackname + "��" + Tools.getFormatMoney(fltGiftRckDtl_Limitmoney) + "Ԫ��" + Tools.getFormatMoney(fltGiftRckDtl_Addmoney) + "Ԫ�ɻ���";
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
	 * ��Ʒ��Ʒ��
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
		 * ���࣬�����ȫ����Ʒ����Ϊ000
		 */
		private String rackcode ;

		/**
		 * ��ƷID
		 */
		private String productId;
		
		/**
		 * ��ƷItem��ID
		 */
		private String giftItemId;
		/**
		 * ��Ʒ�����ID
		 */
		private long giftMstId;
		
		/**
		 * �Ƿ��������Ʒ
		 */
		private boolean isfree;
		
		/**
		 * ��Ʒ����
		 */
		private String name;
		
		/**
		 * ��Ʒ˵��
		 */
		private String value;
		
		/**
		 * �ּ�
		 */
		private float price;
		
		/**
		 * �г��ۼ�
		 */
		private float salePrice;
		
		/**
		 * 0��ͨ��Ʒ��1��Ʒ��Ʒ
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
	 * ������Ʒ���Ȱ���ѵ�����ǰ�棬Ȼ������
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
