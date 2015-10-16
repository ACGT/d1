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
 * ���ﳵ����������
 * @author kk
 */
public class CartHelper {
	
	public static BaseManager manager = Tools.getManager(Cart.class);
	
	/**
	 * ����ID��ù��ﳵ  OK
	 * @param id - ID
	 * @return Cart
	 */
	public static Cart getById(String id){
		if(Tools.isNull(id)) return null;
		return (Cart)manager.get(id);
	}
	
	/**
	 * �õ����ﳵ���ֻ�����Ʒ���ܻ���
	 * @param request
	 * @param response
	 * @return
	 */
	public static long getTotalProductPoint(HttpServletRequest request,HttpServletResponse response){
		return getCartTotalPoint(request,response);
	}
	
	/**
	 * �õ����ﳵ����Ʒ�Ѿ�����������
	 * @param productId ��Ʒid
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
	 * �õ����ﳵ��֧���ۣ��������˷ѣ�
	 * @param request
	 * @param response
	 * @return ������λС��
	 */
	public static float getTotalPayMoney(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
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
	 * �õ�һ��������Ʒ��֧���ۣ����ڻ�ȡ��Ʒ�ж�
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getTotalRackcodePayMoney(HttpServletRequest request,HttpServletResponse response,String rackcode,String shopcode){
		if(rackcode!=null)rackcode = rackcode.trim();
		
		if(Tools.isNull(rackcode))return getTotalPayMoney(request,response);
		
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
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
	 * �õ����ﳵһ�������µ��ܽ��ж�Ŀ¼startsWith���ɣ�000��ʾȫ�������ڻ�ȡ����ȯ����жϣ�������ȯ�Ĳ���������
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

		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�������ֻ������֧������Ʒ
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				
				//type>0��ʾʵ����Ʒ��type<0���ײ����������⹺��ȯ���������ܼ�
				if(cart.getType().longValue()>=0){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if( p!=null&&(p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))&&p.getGdsmst_rackcode()!=null&&(p.getGdsmst_rackcode().startsWith(rackcode)
							||(rackcode.equals("017")&& 
							(p.getGdsmst_rackcode().startsWith("02")||p.getGdsmst_rackcode().startsWith("03")||p.getGdsmst_rackcode().startsWith("015009"))
							))){
						if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//����ȯ
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
	 * �õ����ﳵ����Ʒ������������Ʒ���������Ŀ���ǿⷿҪ�������ܼ�����
	 * @param request
	 * @param response
	 * @return
	 */
	public static int getTotalProductCount(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//������������
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
	 * �ж�һ����Ʒ�Ƿ��ڹ��ﳵ��
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
		//System.out.println("�鿴��Ʒ��ID��"+productId+"----"+allList.size()+"---"+giftmstid);
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
	 * ��ȡ���ﳵ���Ʒ�Ƽ����б�����м�¼��˵���ù��ﳵ��Ʒ���Żݡ��Żݶ��ٲο�BrandPromotion�Ķ���<br/>
	 * ֧��ʱ������ж��Ʒ�Ƽ��⣬��ϲ���һ�������Ż�ȯ���������ݿ⣩��������<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<BrandPromotion> getCartBrandPromotion(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Brand> brandList = getCartBrands(request,response);
		if(brandList==null||brandList.size()==0)return null;
		
		ArrayList<BrandPromotion> resList = new ArrayList<BrandPromotion>();//����Ʒ�Ƽ��ⶨ��
		
		//����Ʒ�Ƽ��������
		for(int i=0;i<brandList.size();i++){
			Brand b = brandList.get(i);
			BrandPromotion bp = BrandHelper.getBrandPromotionViaBrandId(b.getBrand_code());
			
			if(bp==null)continue;
			
			//����Ʒ�Ƽ������������Ч��û�й��ڡ�����������
			//if(bp.getBrdtktmst_validflag()!=null&&(bp.getBrdtktmst_validflag().longValue()==1)){
				if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()&&
						System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()&&
						bp.getBrdtktmst_gdsvalue()!=null){
					//�����ܽ��
					if(b.getBrand_name()!=null&&CartHelper.getCartBrandPayMoney2(request, response, b.getBrand_name().trim(),"00000000")>=bp.getBrdtktmst_gdsvalue().floatValue()){
						resList.add(bp);
					}
				}
			//}
		}
		return resList ;
	}
	
	/**
	 * ��ȡ���ﳵ���Ʒ�Ƽ����б�����м�¼��˵���ù��ﳵ��Ʒ���Żݡ��Żݶ��ٲο�BrandPromotion�Ķ���<br/>
	 * ֧��ʱ������ж��Ʒ�Ƽ��⣬��ϲ���һ�������Ż�ȯ���������ݿ⣩��������<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<BrandPromotion> getCartBrandPromotion2(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Brand> brandList = getCartBrands(request,response);
		if(brandList==null||brandList.size()==0)return null;
		
		ArrayList<BrandPromotion> resList = new ArrayList<BrandPromotion>();//����Ʒ�Ƽ��ⶨ��
		
		//����Ʒ�Ƽ��������
		for(int i=0;i<brandList.size();i++){
			Brand b = brandList.get(i);
			BrandPromotion bp = BrandHelper.getBrandPromotionViaBrandId(b.getBrand_code());
			
			if(bp==null)continue;
			
			//����Ʒ�Ƽ������������Ч��û�й��ڡ�����������
			//if(bp.getBrdtktmst_validflag()!=null&&(bp.getBrdtktmst_validflag().longValue()==1)){
				if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()&&
						System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()&&
						bp.getBrdtktmst_gdsvalue()!=null){
					//�����ܽ��
					if(b.getBrand_name()!=null&&CartHelper.getCartBrandPayMoney2(request, response, b.getBrand_name().trim(),"00000000")>=bp.getBrdtktmst_gdsvalue().floatValue()){
						resList.add(bp);
					}
				}
			//}
		}
		return resList ;
	}
	
	/**
	 * ��ȡ���ﳵ��ĳ��Ʒ����Ʒ����֧���ۣ����ڼ�����Ʒ���������μ�Eȯ����ƷҲ��
	 * @param request
	 * @param response
	 * @param brandName brand name
	 * @return
	 */
	public static float getCartBrandPayMoney(HttpServletRequest request,HttpServletResponse response,String brandName,String shopcode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(brandName!=null)brandName=brandName.trim();
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if((cart.getShopcode().equals(shopcode)||shopcode.equals("11111111"))&&cart.getType().longValue()>=0&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13&&cart.getType().longValue()!=14&&cart.getType().longValue()!=18){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(p==null)continue ;
					
					//�����������Ʒ������Ż���Ʒ������Ʒ�Ǹ�Ʒ���µģ����Ǯ������
					if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().trim().equals(brandName)&&cart.getType().longValue()!=2){
						total+=cart.getMoney();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	/**
	 * �õ�Ʒ�ƿ�����ȯ�Ľ����μ�Eȯ�Ĳ��㣬���ڼ���Ʒ�Ƽ���
	 * @param request
	 * @param response
	 * @param brandName
	 * @return
	 */
	public static float getCartBrandPayMoney2(HttpServletRequest request,HttpServletResponse response,String brandName,String shopcode){
		if(Tools.isNull(shopcode))shopcode="00000000";
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(brandName!=null)brandName=brandName.trim();
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(p==null)continue ;
					
					//�����������Ʒ������Ż���Ʒ������Ʒ�Ǹ�Ʒ���µģ����Ǯ������
					if(p.getGdsmst_brandname()!=null&&p.getGdsmst_brandname().trim().equals(brandName)
							&&(p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))){
						if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//����ȯ
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
	
	
	/**�̻�����
	 * ��ȡ���ﳵ��ĳ����Ʒ�������ܽ����ڼ����̻����������
	 * @param request
	 * @param response
	 * @param shopcode shopcode name
	 * @return
	 */
	public static float getCartShopActPayMoney(HttpServletRequest request,HttpServletResponse response,D1ActTb act){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		//��֧���ۼ�����
		
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
					ppcode=ppcode.replace("��", ",");
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
	 * �����̻�����������ѯ
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
	 * ���������������̻����
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
				ppcode=ppcode.replace("��", ",");
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
	 * �̻�����  ---ȡ�����̻���Żݽ��
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
		        //��ȡ���ﳵ�����м�¼
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
				itemactmemo="����Ʒ�μ���"+act.getD1acttb_snum3()+"��"+itemactmoney;
			}else if(act.getD1acttb_snum2().floatValue()>0f&&shopactcartmoney>=act.getD1acttb_snum2().floatValue()){
				cutmoney+=act.getD1acttb_enum2().floatValue() ;
				itemactmoney=act.getD1acttb_enum2().floatValue();
				itemactmemo="����Ʒ�μ���"+act.getD1acttb_snum2()+"��"+itemactmoney;
			}else if(act.getD1acttb_snum1().floatValue()>0f&&shopactcartmoney>=act.getD1acttb_snum1().floatValue()){
				cutmoney+=act.getD1acttb_enum1().floatValue() ;
				itemactmoney=act.getD1acttb_enum1().floatValue();
				itemactmemo="����Ʒ�μ���"+act.getD1acttb_snum1()+"��"+itemactmoney;
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
					//System.out.println(cutmoney +"-------------111------------��Ʒ�Żݽ��"+new Long(Tools.parseLong(cutmoney+"")));
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
	 * �̻������ ���ﳵ�ܵ��Żݽ�� 
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
	 * �̻������ �����̻��ź��̻��������
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
	 * �Ƽ�λȯ
	 * @param request
	 * @param response
	 * @param sprckcode
	 * @return
	 */
	public static float getCartSprckcodePayMoney(HttpServletRequest request,HttpServletResponse response,String sprckcode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(sprckcode!=null)sprckcode=sprckcode.trim();
		//��֧���ۼ�����
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
	 * ��ȡ�Ƽ�λȯ�Ĺ��ﳵ��Ʒ
	 * @param request
	 * @param response
	 * @param sprckcode
	 * @return
	 */
	public static String getCartSprckcodegdslist(HttpServletRequest request,HttpServletResponse response,String sprckcode){
		String retglist="";
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		if(sprckcode!=null)sprckcode=sprckcode.trim();
		//��֧���ۼ�����
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
	 * id�ǹ��ﳵ���е�Ʒ�ƣ�Ʒ����
	 * @param request
	 * @param response
	 * @return �ǿյ�Map
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
	 * �õ����ﳵ��������Ʒ��Ʒ�ƣ��Ѿ�ȥ�أ������ڼ���Ʒ�Ƽ���
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Brand> getCartBrands(HttpServletRequest request,HttpServletResponse response){
		//������Ʒ�б�
		ArrayList<Cart> carts = CartHelper.getCartNormalProducts(request, response) ;
		if(carts==null||carts.size()==0)return null;
		
		HashMap<String,String> bmap = new HashMap<String,String>();
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			//000000��ʾû��Ʒ��
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
	 * �õ����ﳵƷ�Ƽ���Ӧ�ü�����Ǯ�����ܼ��˷ѣ�����
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getBrandCutMoney(HttpServletRequest request,HttpServletResponse response){
		/*ArrayList<BrandPromotion> bplist = getCartBrandPromotion(request,response);
		if(bplist!=null&&bplist.size()>0){//�������Ʒ�Ƽ��⣬�ϲ�����һ��Ʒ�Ƽ���ȯ
			float moneycut = 0f;
			for(BrandPromotion bp:bplist){
				if(bp.getBrdtktmst_value()!=null)moneycut+=bp.getBrdtktmst_value().floatValue();
			}
			float res = Tools.getFloat(moneycut, 2);
			
			//�ж�һ�£��Է���һ
			if(res>CartHelper.getNormalProductMoney(request, response)){
				res = CartHelper.getNormalProductMoney(request, response) ;
			}
			
			return Tools.getFloat(res,2) ;//������λС��
		}else{
			return 0f ;
		}*/
		float res =0f;
		res=getBrandCutLists(request,response);
		if (res>0){
			 res = Tools.getFloat(res, 2);
			//�ж�һ�£��Է���һ
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
	 * �������п��Դ�����Ʒ���ܼۣ������ж��Ƿ�����Eȯ�ʹ���������������ȯ����Ʒ����<br/>Ʒ�Ƽ���
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoneypp(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null && !Tools.isNull(product.getGdsmst_rackcode())&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9&&cart.getType().longValue()!=13){//����ȯ
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
			if(brand!=null&&brand.trim().length()>0&&p.getGdsmst_shopcode()!=null&&p.getGdsmst_shopcode().equals(brand.trim())){//�������
				if(Tools.longValue(p.getGdsmst_specialflag()) != 1&&!p.getGdsmst_rackcode().startsWith("014")){//����ȯ
					total+=cart.getMoney();
				}
			}
			
		}
		return total;
	}
	/**
	 * �õ����ﳵ������������Ʒ�����������Ʒ������Ʒ������Ʒ�������Żݵ���Ʒ�����㡣///Ʒ�Ƽ����õ���
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartNormalProductspp(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()>0&&c.getType().longValue()!=2&&c.getType().longValue()!=9&&c.getType().longValue()!=13&&c.getType().longValue()!=10){//������Ʒ����ϵ�Ҳ��
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
	 * �������п��Դ�����Ʒ���ܼۣ������ж��Ƿ�����Eȯ�ʹ���������������ȯ����Ʒ����<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getNormalProductMoney(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())
							&&cart.getType().longValue()!=2&&cart.getType().longValue()!=9){//����ȯ
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
	 * ��ȡ�̻��Ŀ����Ż�ȯ����Ʒ
	 * @param request
	 * @param response
	 * @param shopcode
	 * @return
	 */
	public static float getShopNormalProductMoney(HttpServletRequest request,HttpServletResponse response,String shopcode){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()>=0){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					if(product!=null&&!Tools.isNull(product.getGdsmst_shopcode())&&(product.getGdsmst_shopcode().equals(shopcode)||shopcode.equals("11111111"))
							&&Tools.longValue(product.getGdsmst_specialflag()) != 1&&Tools.isNull(cart.getTuanCode())&&cart.getType().longValue()!=2){//����ȯ
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
	 * �õ���¼�û�id�µĹ��ﳵ��ֻ��userid
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getLoginUserCartItems(HttpServletRequest request,HttpServletResponse response){
		//��ȡ��¼״̬��userid�����ǵ�¼״̬����null
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
	 * ��ȡ���ﳵ�����м�¼��ֻ��cookie
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
	 * ����cookie��ֵ��ȡ���ﳵ��������Ϣ
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaCookie(String cookieValue){
		return getCartItems("cookie",cookieValue,true);
	}
	
	/**
	 * ����userId��ֵ��ȡ���ﳵ��������Ϣ
	 * @param cookieValue
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaUserId(String userId){
		return getCartItems("userId",userId,true);
	}
	
	/**
	 * ��ȡ���ﳵ��һ����Ʒ�����getCartItemsViaParentId������ʵ�ֱ������ﳵ�㼶��ϵ��Ҳ��ֱ����getCartItem������ȡ���й��ﳵ��Ʒ��
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
	 * ���ݸ���cart id��ȡcart�б�
	 * @param parentId cart��Ӧ��ParentId
	 * @return
	 */
	public static ArrayList<Cart> getCartItemsViaParentId(String parentId){
		return getCartItems("parentId",parentId,false);
	}
	
	/**
	 * ����Ʒ��2����Ʒ�������һ��list��
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
	 * ������ﳵ��ɾ�����ﳵ������ж���
	 * @param request
	 * @param response
	 */
	public static void clearAllCarts(HttpServletRequest request,HttpServletResponse response){
		clearAllCookieCarts(request,response);
		
		clearAllLoginUserCarts(request,response);
	}
	
	/**
	 * ���cookie�µĹ��ﳵ������Ŀ
	 */
	public static void clearAllCookieCarts(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		String cookie = getCartCookieValue(request, response);
		
		
		if(!Tools.isNull(cookie)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("cookie", cookie));
			
			//��ȡ�б�
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//���ɾ��
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//ɾ��cart
					Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * �����¼id�µĹ��ﳵ������Ŀ
	 * @param request
	 * @param response
	 */
	public static void clearAllLoginUserCarts(HttpServletRequest request,HttpServletResponse response){
		String userId = getCartUserId(request, response);
		
		if(!Tools.isNull(userId)){
			List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
			clist.add(Restrictions.eq("userId", userId));
			
			//��ȡ�б�
			List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, null, 0, 1000);
			
			//���ɾ��
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					Cart c = (Cart)list.get(i);
					//ɾ��cart
					Tools.getManager(Cart.class).delete(c);
				}
			}
		}
	}
	
	/**
	 * �����ֶ������ֶ�ֵ��ȡcart�б����ݲ㼶��ϵ��ȡ��
	 * @param fieldName
	 * @param fieldValue
	 * @param getChild true��ʾ��childһ��ӽ�����false��ʾ����child
	 * @return
	 */
	private static ArrayList<Cart> getCartItems(String fieldName,String fieldValue,boolean getChild){
		//�����ѯ����
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq(fieldName, fieldValue));
		
		//��ȡ�����ģ�Ȼ��ȡ�Ӽ�cart
		if(getChild)clist.add(Restrictions.eq("hasFather", new Long(0)));
		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("createDate"));
		
		//��ȡ�б�
		List<BaseEntity> list = Tools.getManager(Cart.class).getList(clist, olist, 0, 1000);
		
		//ǿ��ת��
		ArrayList<Cart> resList = new ArrayList<Cart>();
		if(list!=null&&list.size()>0){
			for(int i=0;i<list.size();i++){
				Cart cart = (Cart)list.get(i);
				resList.add(cart);
				if(getChild){
					if(cart.getHasChild().longValue()==1){//�������cart��Ҳ���뵽�б���
						ArrayList<Cart> childList = getCartItemsViaParentId(cart.getId());
						if(childList!=null&&childList.size()>0){
							//ȫ�����뵽�����
							for(int j=0;j<childList.size();j++)resList.add(childList.get(j));
						}
					}
				}//end if(getChild)
			}
		}
		
		return resList ;
	}
	
	/**
	 * ��һ����Ʒ�Ƿ��ڹ��ﳵ���ˣ�����ڵĻ��޸���������
	 * @param request
	 * @param response
	 * @param productId ����Ϊnull
	 * @param skuId ����Ϊnull
	 * @param type type������Ϊnull
	 * @return cart ��Ϊnull��ʾ����
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
	 * �ѵ�����Ʒ���빺�ﳵ���˴��޸�cookie��userIdȻ�󴴽����ݿ⣬����������jsp�����á�
	 * @param request 
	 * @param response
	 * @param cart Cart���󣬷����ݿ����û������cookie��userId�����������ݶ����ú��ˡ�
	 * @return -1=���ﳵ����100����¼�ˣ�-2=��������1=����ɹ�
	 */
	public static int addCart(HttpServletRequest request,HttpServletResponse response,Cart cart) {
		//���ͬһ���û��Ĺ��ﳵ��¼�Ѿ���100�����򲻼��룬���ⱻ����
		ArrayList<Cart> cartList = CartHelper.getCartItems(request, response);
		if(cartList!=null&&cartList.size()>100)return -1;
		
		if(cart==null)return -2;
		cart.setIp(request.getRemoteHost());//set the ip
		
		if(cart.getType().longValue()==1){
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			//����ǲ�����ȯ����Ʒ���Զ��޸�type
			if(p!=null&&p.getGdsmst_specialflag()!=null&&p.getGdsmst_specialflag().longValue()==1){
				cart.setType(new Long(10));
			}
			
			//�������ɱ��Ʒ������һ��tuanCode�������tuanCode=SecKill��ʾΪ��ɱ��Ʒ
			SecKill sk_34434 = (SecKill)Tools.getManager(SecKill.class).findByProperty("mstjgds_gdsid", cart.getProductId());
			if(sk_34434!=null&&sk_34434.getMstjgds_state()!=null&&sk_34434.getMstjgds_state().longValue()==1){
				cart.setTuanCode("SecKill");//�����tuanCode����������tuanCode������һ��
			}
		}
		
		Cart pcart = getCartViaProductId(request,response,cart.getProductId(),cart.getSkuId(),cart.getType().longValue()) ;
		
		//������ﳵ�����������Ʒ�򴴽�������Ѿ��������޸���������
		if(pcart==null){
			//����Ƿǵ�¼״̬
			cart.setCookie(getCartCookieValue(request,response));
			cart.setUserId(getCartUserId(request,response));
			//����ʱ��
			cart.setCreateDate(new Date());
			cart.setIp(request.getRemoteHost());
			
			//����cart�����ݿ�
			Tools.getManager(Cart.class).create(cart);
		}else{
			pcart.setAmount(new Long(pcart.getAmount().longValue()+cart.getAmount().longValue()));
			pcart.setMoney(Tools.getFloat(new Float(pcart.getMoney().floatValue()+cart.getMoney().floatValue()),2));
			
			//�޸��������ɣ�money�ں������޸�
			Tools.getManager(Cart.class).update(pcart, false);
		}
		
		
		
		CartHelper.updateCartPrice(request, response, cart);
		
		//���¼��㹺�ﳵ����Item�������۸���Ʒ������������������
		updateAllCartItems(request,response);
		
		return 1;
	} 
	
	/**
	 * ��ȡ���ﳵ�����л��ֶһ���Ҫ�Ļ��֣������жϻ��ֹ�����֧��
	 * @param request
	 * @param response
	 * @return
	 */
	public static long getCartTotalPoint(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> list = getCartItems(request, response);
		if(list==null|list.size()==0)return 0;
		long total = 0;
		for(Cart c:list){
			if(c.getType().longValue()==2||c.getType().longValue()==-5){//���ֻ�����Ʒ�Ͷһ�ȯ��Ҫ�Ļ���
				total+=c.getPoint().longValue();
			}
		}
		return total ;
	}
	
	/**
	 * �õ����ι��ﳵ��cookieֵ�����û�У�����cookie
	 * @param request
	 * @param response
	 * @return
	 */
	public static String getCartCookieValue(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();

		Cookie cartCookie = Tools.getClientCookie(request,Const.CART_COOKIE_NAME);
		if(cartCookie==null){
			//��һ����sessionId��¼cookie
			if(session.getAttribute("CART_COOKIE_ATTRIBUTE_VALUE")==null){
				Cookie userCartCookie = new Cookie(Const.CART_COOKIE_NAME, MD5.toMD5(session.getId()+"#"+new Random().nextInt(1000000)));
				userCartCookie.setPath("/");
				userCartCookie.setDomain("d1.com.cn");
				userCartCookie.setMaxAge(60*60*24*30);//30����Ч��
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
	 * �õ����ι��ﳵ��userId
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
	 * �������Ʒ���빺�ﳵ
	 * @param request
	 * @param response
	 * @param packageId ��Ʒ���id�������ײ͵�id
	 * @param pmap key=��Ʒid��value=skuid�����sku�Ļ�
	 * @return -1=��Ʒ��ϲ����ڣ�-2��Ʒ��ϵ���ϸΪ�գ�-3=�������Ʒid�����ײ������Ʒ��-4=�ײ��Ѿ��ӹ�һ���ˣ�-5=���ﳵ����100����¼��
	 */
	public static int addPackageProductToCart(HttpServletRequest request,HttpServletResponse response,String packageId,HashMap<String,String> pmap) {
		ProductPackage pp = (ProductPackage)Tools.getManager(ProductPackage.class).get(packageId);
		if(pp==null)return -1;
		
		List<BaseEntity> list = ProductPackageItemHelper.getGdsmstByGdspid(packageId);
		if(list==null||list.size()==0)return -2;
		
		Iterator<String> it = pmap.keySet().iterator();
		while(it.hasNext()){
			String ppid = it.next();//��Ʒid
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
		
		Cart cartAdded = null ;//���ײ��Ƿ�ӹ����ﳵ
		if(cartList!=null){
			for(Cart c23:cartList){
				if(c23.getType().longValue()==-1&&pp.getId().equals(c23.getProductId())){
					cartAdded = c23 ;
					break;
				}
			}
		}
		if(cartAdded==null){//��һ�μ����ײ�
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
			pcart.setPrice(new Float(0));//������޸�Price��
			pcart.setTitle("����Ϲ���"+Tools.clearHTML(pp.getGdspkt_title()));
			pcart.setType(new Long(-1));//-1��ʾ������Ʒ
			pcart.setVipPrice(new Float(0));
			pcart.setUserId(getCartUserId(request,response));
			pcart.setProductId(pp.getId());//��������ײ͵�id
			
			Tools.getManager(Cart.class).create(pcart);
			
			Iterator<String> it2 = pmap.keySet().iterator();
			
			float total_money_pcart = 0,old_total_money_pcart=0;//�����ײ͵��ۣ�ԭ��
			
			while(it2.hasNext()){
				String ppid = it2.next();//��Ʒid
				
				ProductPackageItem ppi123 = null ;
				for(BaseEntity be:list){
					ProductPackageItem ppi = (ProductPackageItem)be;
					if(ppi.getGdspktdtl_gdsid().equals(ppid)){
						ppi123 = ppi ;
						break ;
					}
				}
	
				//�����ײ�����
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
				ccart.setMoney(Tools.getFloat(mprice-ppi123.getGdspktdtl_savemoney().floatValue(),2));//�ײ͵ļ۸�
				ccart.setOldPrice(Tools.getFloat(mprice, 2));
				ccart.setPoint(new Long(0));
				ccart.setSkuId(pmap.get(ppid));
				ccart.setPrice(Tools.getFloat(mprice-ppi123.getGdspktdtl_savemoney().floatValue(),2));
				ccart.setTitle("����Ϲ���"+Tools.clearHTML(pc.getGdsmst_gdsname()));
				ccart.setProductId(pc.getId());
				ccart.setType(new Long(8));//8��ʾ�����Ʒ
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
			
			Tools.getManager(Cart.class).update(pcart, false);//�޸��ײ͵���
		}else{//��μ���ͬһ���ײͣ�������
			return -4 ;
		}
		
		updateAllCartItems(request,response);
		
		return 1;
	}
	
	/**
	 * �õ��Ź���Ʒ�����������������Ź���Ʒ����
	 * @param request
	 * @param response
	 * @param productId ��Ʒid
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
	 * ���Ź���Ʒ���빺�ﳵ
	 * @param request
	 * @param response
	 * @param pgid ProductGroup��id��ע�⣬������Ʒid
	 * @param skuId sku idһ��Ϊnull�������Ż�ױƷ��ʱ��
	 * @param amount ����
	 * @return -1��Ӧ��ProductGroupΪ�գ�-2=��ƷΪ�գ�-3=�����Ź����������ˣ�1=�ɹ���-4=���ݿ����ʧ�ܣ�-5=���ﳵ����100����¼��
	 * 			-6 �Ź���δ��ʼ��-7�Ź�������-8��������
	 */
	public static int addTuanProductToCart(HttpServletRequest request,HttpServletResponse response,String pgid,String skuId,int amount){
		ProductGroup pg = (ProductGroup)Tools.getManager(ProductGroup.class).get(pgid);
		if(pg==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(pg.getTgrpmst_gdsid());
		if(product==null)return -2;
		
		if(amount <= 0) return -8;
		
		//������Ʒ�Ź�������
		if(amount+getTuanProductCount(request,response,product.getId())>pg.getTgrpmst_maxcount().intValue())return -3;
		
		long currentTime = System.currentTimeMillis();
		if(currentTime < Tools.dateValue(pg.getTgrpmst_starttime())) return -6;
		if(currentTime > Tools.dateValue(pg.getTgrpmst_endtime())) return -7;
		
		Cart cartAdded = null ; //�Ƿ�ӹ���
		
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
			c.setTitle("���Ź���Ʒ��"+Tools.clearHTML(product.getGdsmst_gdsname()));
			c.setType(new Long(6));
			c.setUserId(getCartUserId(request,response));
			c.setAwardId(pg.getId());//award id ������ProductGroup��id
			c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
			Tools.getManager(Cart.class).create(c);
			
			updateAllCartItems(request,response);
			if(c.getId()!=null){
				return 1;
			}else{
				return -4;
			}
		}else{//�޸���������
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
	 * ���Ź���Ʒ���빺�ﳵ(2012-3-16)
	 * @param request
	 * @param response
	 * @param pgid PromotionProduct��id��ע�⣬������Ʒid
	 * @param skuId sku idһ��Ϊnull�������Ż�ױƷ��ʱ��
	 * @param amount ����
	 * @return -1��Ӧ��PromotionProductΪ�գ�-2=��ƷΪ�գ�-3=�����Ź����������ˣ�1=�ɹ���-4=���ݿ����ʧ�ܣ�-5=���ﳵ����100����¼��
	 * 			-6 �Ź���δ��ʼ��-7�Ź�������-8��������
	 */
	public static int addTuanProductToCartNew(HttpServletRequest request,HttpServletResponse response,String pgid,String skuId,int amount){
		PromotionProduct pg = (PromotionProduct)Tools.getManager(PromotionProduct.class).get(pgid);
		if(pg==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(pg.getSpgdsrcm_gdsid());
		if(product==null)return -2;
		
		if(amount <= 0) return -8;
		
		//������Ʒ�Ź�������
		if(product.getGdsmst_buylimit()!=null&&product.getGdsmst_buylimit().longValue()!=0)
		{
		    if(amount+getTuanProductCount(request,response,product.getId())>product.getGdsmst_buylimit().longValue())return -3;
		}
		long currentTime = System.currentTimeMillis();
		if(currentTime < Tools.dateValue(pg.getSpgdsrcm_begindate())) return -6;
		if(currentTime > Tools.dateValue(pg.getSpgdsrcm_enddate())) return -7;
		
		Cart cartAdded = null ; //�Ƿ�ӹ���
		
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
			c.setTitle("���Ź���Ʒ��"+Tools.clearHTML(product.getGdsmst_gdsname()));
			c.setType(new Long(6));
			c.setUserId(getCartUserId(request,response));
			c.setAwardId(pg.getId());//award id ������ProductGroup��id
			c.setVipPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
			Tools.getManager(Cart.class).create(c);
			
			updateAllCartItems(request,response);
			if(c.getId()!=null){
				return 1;
			}else{
				return -4;
			}
		}else{//�޸���������
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
	 * ����Ʒ���빺�ﳵ
	 * @param request
	 * @param response
	 * @param gf ��ز���
	 * @param skuid sku id
	 * @return -1=��������-2=��ƷΪ�գ�-3=���ݿⴴ������-5=�Ѿ��ӹ�һ����
	 */
	public static int addGiftProductToCart(HttpServletRequest request,HttpServletResponse response,GiftHelper.GiftGoods gf,String skuId){
		if(gf==null)return -1;
		
		Product product = (Product)Tools.getManager(Product.class).get(gf.getProductId());
		if(product==null)return -2;
		
		Cart cartAdded = null ; //�Ƿ�ӹ���
		
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
	     
		//�ڶ���������Ȼ���ж������ԣ����жϡ���ѡ������Ʒ���Ƿ�ѡ���˶��������������				
				ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
				
				if(gifts!=null&&gifts.size()>0){
					for(int j=0;j<gifts.size();j++){
						Gift gift = gifts.get(j);
					
						//�Ƚϵ�ѡ�������Ʒ�Ƿ�ѡ���˶��
						if(gift.getGiftrckmst_selecttype()!=null&&gift.getGiftrckmst_selecttype().longValue()==0){
							//������Ʒ��ϸ
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
													&&c.getProductId().equals(gi.getGiftrckdtl_gdsid())){//����
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
			c.setTitle("����Ʒ��"+Tools.clearHTML(gf.getName()));
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
		}else{//�޸���������
			return -5;
		}
	}
	
	/**
	 * XԪѡY�����빺�ﳵ
	 * @param request
	 * @param response
	 * @param code �Ƽ�λ�ţ�Ҳ����ProductXsY��id
	 * @param pmap key=��Ʒid��value=skuId����еĻ�
	 * @return -1=ProductXsY�����ڣ�-2=��������-3=û���Ƽ�λ��Ʒ��-4=��Ʒ������xԪѡY������Ʒ��-5=�Ѿ��ӹ���(�ӹ���ֻ���޸�����)��-6=�������ԣ�����ѡX����-7=���ﳵ����100����Ʒ��
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
			boolean flag = false ;//�Ƿ�Ϸ�
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
		
		Cart cartAdded = null ;//�Ƿ��Ѿ�ѡ����
		ArrayList<Cart> cartList = getCartItems(request, response);
		
		if(cartList!=null&&cartList.size()>100)return -7;
		
		if(cartList!=null){
			for(Cart c123:cartList){
				//����ProductId����XsY���Ƽ�λid
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
			pcart.setPrice(new Float(0));//������޸�price
			pcart.setTitle("������ػݡ�"+Tools.clearHTML(pxy.getGdsmstxsy_title()));
			pcart.setType(new Long(-2));//-2��ʾXԪѡY�����ڵ�
			pcart.setVipPrice(new Float(0));
			pcart.setUserId(getCartUserId(request,response));
			pcart.setProductId(code);//�������XsY���Ƽ�λid
			
			Tools.getManager(Cart.class).create(pcart);
			
			Iterator<String> it2 = pmap.keySet().iterator();
			
			float total_money_pcart = Tools.getFloat(pxy.getGdsmstxsy_allmoney().floatValue(),2);//����XsY�ײ͵���
			float total_old_money = 0f ;
			
			while(it2.hasNext()){
				String ppid = it2.next();//��Ʒid
				
				//�����ײ�����
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
				ccart.setType(new Long(4));//4��ʾXsY�����Ʒ
				ccart.setVipPrice(Tools.getFloat(Const.PT_VIP_DISCOUNT*pc.getGdsmst_memberprice().floatValue(), 2));
				ccart.setUserId(getCartUserId(request,response));
				ccart.setParentId(pcart.getId());
				Tools.getManager(Cart.class).create(ccart);
				
				total_old_money+=pc.getGdsmst_memberprice().floatValue();
			}
			
			pcart.setPrice(Tools.getFloat(new Float(total_money_pcart),2));
			pcart.setOldPrice(Tools.getFloat(new Float(total_old_money),2));
			pcart.setMoney(Tools.getFloat(total_money_pcart*pcart.getAmount().longValue(), 2));
			Tools.getManager(Cart.class).update(pcart, false);//�޸��ײ͵���
		}else{
			return -5;
		}
		
		updateAllCartItems(request,response);
		return 1;
	}
	

	/**
	 * �ѻ�����Ʒ���빺�ﳵ����Χ����Ҫ�ж��û��Ƿ��½�������Ƿ��㹻������
	 * @param request
	 * @param response
	 * @param gdsid ��Ʒid
	 * @param skuId ��Ʒ��skuid������еĻ�
	 * @param awardId Award��id
	 * @return -1=��ƷΪ�գ�-2=award��¼Ϊ�գ�-3=���ǵ�½�û���-4=�û����ֲ�����1=����ɹ���-5=���ݿⴴ��ʧ�ܣ�-6=���ﳵ����100����¼��
	 */
	public static int addJifenProductToCart(HttpServletRequest request,HttpServletResponse response,String gdsid,String skuId,String awardId) {
		if(!"00000000".equals(gdsid)){//000000��ʾ�һ�ȯ
			Product product =  (Product)Tools.getManager(Product.class).get(gdsid);
			if(product==null)return -1;
			
			//���ֻ�����Ӧ��ϵ
			Award award = (Award)Tools.getManager(Award.class).get(awardId);
			if(award==null||award.getAward_value()==null)return -2 ;
			
			User loginUser = UserHelper.getLoginUser(request, response);
			if(loginUser==null)return -3 ;
			
			float ppoint = award.getAward_value().floatValue();//�һ���Ʒ�Ļ���ֵ
			long upoint = UsrPointHelper.getUseScore(loginUser.getId());//�û����ܻ���
			
			if(ppoint+getCartTotalPoint(request,response)>upoint)return -4 ;
			
			Cart c_added = null ;//��Ʒ�Ƿ��������ﳵ
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
				c.setTitle("�����ֻ�����"+Tools.clearHTML(product.getGdsmst_gdsname()));
				c.setParentId("0");
				c.setProductId(product.getId());
				c.setAmount(new Long(1));
				c.setCreateDate(new Date());
				c.setCookie(getCartCookieValue(request,response));
				c.setHasChild(new Long(0));
				c.setHasFather(new Long(0));
				c.setIp(request.getRemoteHost());
				c.setMoney(Tools.getFloat(award.getAward_price(),2));//�Ӷ���Ǯ
				c.setPrice(Tools.getFloat(award.getAward_price(),2));//����Ҫ����Ǯ
				c.setOldPrice(product.getGdsmst_memberprice());
				c.setPoint(award.getAward_value());
				c.setShopcode(product.getGdsmst_shopcode());
				c.setSkuId(skuId);
				c.setType(new Long(2));//���ֻ���
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
			}else{//�޸���������
				c_added.setAmount(new Long(c_added.getAmount().longValue()+1));
				c_added.setMoney(Tools.getFloat(c_added.getAmount().longValue()*award.getAward_price(),2));
				c_added.setUserId(loginUser.getId());
				c_added.setPoint(new Long(c_added.getAmount().longValue()*award.getAward_value().longValue()));
				boolean ret = Tools.getManager(Cart.class).update(c_added, false);
				
				updateAllCartItems(request,response);
				
				if(ret)return 1;
				else return -5;
			}
		}else{//�һ�ȯ
			//���ֻ�����Ӧ��ϵ
			Award award = (Award)Tools.getManager(Award.class).get(awardId);
			if(award==null||award.getAward_value()==null)return -2 ;
			
			User loginUser = UserHelper.getLoginUser(request, response);
			if(loginUser==null)return -3 ;
			
			
			float ppoint = award.getAward_value().floatValue();//�һ���Ʒ�Ļ���ֵ
			float upoint = UserScoreHelper.getRealScore(loginUser.getId());//�û����ܻ���
			
			if(ppoint+getCartTotalPoint(request,response)>upoint)return -4 ;
			
			Cart c_added = null ;//��Ʒ�Ƿ��������ﳵ
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
			
			if(c_added==null){//û�жһ����򴴽�
				Cart c = new Cart();
				c.setTitle("�����ֻ�����"+Tools.clearHTML(award.getAward_gdsname()));
				c.setParentId("0");
				c.setProductId(award.getId());//ע�⣬����������award id
				c.setAmount(new Long(1));
				c.setCreateDate(new Date());
				c.setCookie(getCartCookieValue(request,response));
				c.setHasChild(new Long(0));
				c.setHasFather(new Long(0));
				c.setIp(request.getRemoteHost());
				c.setMoney(Tools.getFloat(award.getAward_price(),2));//�Ӷ���Ǯ
				c.setPrice(Tools.getFloat(award.getAward_price(),2));//����Ҫ����Ǯ
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
	 * ��һ����Ʒ�ӹ��ﳵ��ɾ��
	 * @param request
	 * @param response
	 * @param productId
	 */
	public static ArrayList<Cart> deleteCart(HttpServletRequest request,HttpServletResponse response,String cartId){
		//�����ݿ�ɾ��
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		
		if(cart==null)return null;
		
		ArrayList<Cart> list1 = new ArrayList<Cart>();
		
		String cookie_v = CartHelper.getCartCookieValue(request, response);
		String userId_v = CartHelper.getCartUserId(request, response);
		
		if((cookie_v!=null&&cookie_v.equals(cart.getCookie()))||(userId_v!=null&&userId_v.equals(cart.getUserId()))){
			
			if(cart.getHasChild().longValue()==1){
				//��ȡ��cart�б�
				ArrayList<Cart> childCart = getCartItemsViaParentId(cart.getId());
				//ɾ�ӽڵ�
				if(childCart!=null&&childCart.size()>0){
					for(int i=0;i<childCart.size();i++){
						Cart cc = childCart.get(i);
						if(Tools.getManager(Cart.class).delete(cc)){
							list1.add(cc);
						}
					}
				}
			}
			//ɾ���ڵ㣬���ڵ�ɾ������ʾ��ʾ��Ϣ�����Բ��ü��뵽list1��
			if(Tools.getManager(Cart.class).delete(cart)){
				//list1.add(cart);
			}
			
		}else{
			System.err.println("deleteCart:ɾ��ʧ�ܣ�Ȩ�޲�����cart id="+cart.getId()+"����Դip="+request.getRemoteHost());
		}
		
		//���¼��㹺�ﳵ����Item�������۸���Ʒ������������������
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
	 * �޸Ĺ��ﳵ��ĳ����Ʒ���������޸����������޸ĳ�0�����޸ĳ�0����deleteCart����������
	 * @param request
	 * @param response
	 * @param cartId ���ﳵid
	 * @param amount �޸ĵ�Ŀ������ 
	 */
	public static List<Cart> updateCartAmount(HttpServletRequest request,HttpServletResponse response,String cartId,int amount) {
		//�����ݿ�ɾ��
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		if(cart==null){
			return null ;
		}else{
			//��ȡ��cart�б�
			ArrayList<Cart> childCart = getCartItemsViaParentId(cart.getId());
			//�޸������ӽڵ�������֧�����ں����޸�
			if(childCart!=null&&!childCart.isEmpty()){
				for(Cart c : childCart){
					c.setAmount(new Long(amount));
					c.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(c, false);
				}
			}
			//�޸Ĺ��ﳵ
			cart.setAmount(new Long(amount));
			cart.setIp(request.getRemoteHost());
			Tools.getManager(Cart.class).update(cart,false);
		}
				
		//���¼��㹺�ﳵ����Item�������۸���Ʒ������������������
		return updateAllCartItems(request,response);		
	}
	
	/**
	 * �޸Ĺ��ﳵ��ĳ����Ʒ��skuid
	 * @param request
	 * @param response
	 * @param cartId ���ﳵid
	 * @param skuid �޸ĵ�Ŀ������ 
	 */
	public static boolean updateCartSkuId(HttpServletRequest request,HttpServletResponse response,String cartId,String skuid) {
		//�����ݿ�ɾ��
		Cart cart = (Cart)Tools.getManager(Cart.class).get(cartId);
		if(cart==null){
			return false ;
		}else{
			
			//�޸Ĺ��ﳵ
			cart.setSkuId(skuid);
			cart.setIp(request.getRemoteHost());
			return Tools.getManager(Cart.class).update(cart,false);
		}
	
	}
	
	
	
	/**
	 * ���¹��ﳵ��������Ϣ�����ﳵֻҪ�б䶯��Ҫ������һ�顣�߼��ǳ����ӣ�ע�⣡
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return ɾ����Cart
	 */
	public static List<Cart> updateAllCartItems(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		synchronized(session){
			//�����¹��ﳵ�۸񣬲�ͬ��Ա����۸�ͬ
			updateCartPrice(request,response);
			
			//�����¹��ﳵ��Ʒ���Ѳ�������������Ʒɾ�����ѷ��������ĵ�Ʒ��Ʒ�Զ����빺�ﳵ
			return updateCartGift(request,response);
		}
	}
	
	/**
	 * ��鲢���¹��ﳵ��Ʒ�Բ���
	 * @param request
	 * @param response
	 * @return ����ɾ������Cart
	 */
	private static List<Cart> updateCartGift(HttpServletRequest request,HttpServletResponse response){
		List<Cart> list = new ArrayList<Cart>();
		
		
		//����ɾ����Ʒ��Ʒ
		List<Cart> list1 = checkOrDeleteProductGift(request,response);

		//���������Ʒ�Ƿ���Ч�������Ч�Զ�ɾ��������
		List<Cart> list2 = checkOrDeleteGift(request,response);
		
		//�Զ�ɾ���¼ܵ���Ʒ
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
	 * ɾ���¼ܵ���Ʒ
	 * @param request
	 * @param response
	 * @return
	 */
	private static List<Cart> checkOrDeleteValidProduct(HttpServletRequest request,HttpServletResponse response){
		//���ﳵ��������
		ArrayList<Cart> carts = getCartItems(request,response);
		if(carts==null||carts.size()==0)return null;
		
		List<Cart> rlist = new ArrayList<Cart>();
		
		for(Cart cart:carts){
			if(cart.getType().longValue()>=0){//���������Ʒ
				Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
				
				//��Ʒ�¼��ˣ�ɾ����Ʒ�����к��Ӻ����и���
				if(product!=null&&product.getGdsmst_validflag()!=null&&product.getGdsmst_validflag().longValue()!=1&&product.getGdsmst_validflag().longValue()!=4){
					if(cart.getHasChild().longValue()==1){//����к���
						ArrayList<Cart> childCarts = CartHelper.getCartItemsViaParentId(cart.getId());
						if(childCarts!=null&&childCarts.size()>0){
							for(Cart cc90:childCarts){
								if(Tools.getManager(Cart.class).delete(cc90)){
									rlist.add(cc90);
									System.out.println("�Զ�ɾ�����ﳵ��������Ʒ�Ѿ��¼ܣ�cookie="+cc90.getCookie()+" userId="+cc90.getUserId());
								}
							}
						}
						
						Tools.getManager(Cart.class).delete(cart);
						rlist.add(cart);
						System.out.println("�Զ�ɾ�����ﳵ����Ʒ�Ѿ��¼ܣ�cookie="+cart.getCookie()+" userId="+cart.getUserId());
						
					}else if(cart.getHasFather().longValue()==1){//�������Cart
						ArrayList<Cart> childCarts = CartHelper.getCartItemsViaParentId(cart.getParentId());
						if(childCarts!=null&&childCarts.size()>0){
							for(Cart cc90:childCarts){
								if(Tools.getManager(Cart.class).delete(cc90)){
									rlist.add(cc90);
									System.out.println("�Զ�ɾ�����ﳵ������Ʒ�Ѿ��¼ܣ�cookie="+cc90.getCookie()+" userId="+cc90.getUserId());
								}
							}
						}
						
						Cart pcart = (Cart)Tools.getManager(Cart.class).get(cart.getParentId());
						if(pcart!=null&&pcart.getType().longValue()<0){
							if(Tools.getManager(Cart.class).delete(pcart)){
								rlist.add(pcart);
								System.out.println("�Զ�ɾ�����ﳵ����Ʒ������Ʒ�Ѿ��¼ܣ�cookie="+pcart.getCookie()+" userId="+pcart.getUserId());
							}
						}
					}else{
						if(Tools.getManager(Cart.class).delete(cart)){
							rlist.add(cart);
							System.out.println("�Զ�ɾ�����ﳵ����Ʒ�Ѿ��¼ܣ�cookie="+cart.getCookie()+" userId="+cart.getUserId());
						}
					}
				}
			}
		}
		return rlist ;
	}
	
	/**
	 * ����ɾ����Ʒ��Ʒ�������Ʒ����Ʒ��û�мӵ����ﳵ�����Զ����ϣ�<br/>
	 * ��֮�����Ʒ��Ʒ�Ѿ������ڣ���ɾ�����ﳵ�µ�Ʒ��Ʒ��
	 * @param request
	 * @param response
	 * @return ɾ������Cart
	 */
	private static List<Cart> checkOrDeleteProductGift(HttpServletRequest request,HttpServletResponse response){
		//���ﳵ��������
		ArrayList<Cart> carts = getCartItems(request,response);
		
		if(carts==null||carts.size()==0)return null;
		
		List<Cart> rlist = new ArrayList<Cart>();
		
		//�жϵ�Ʒ��Ʒ�Ƿ���빺�ﳵ�����û�У��Զ����빺�ﳵ��������������
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);
			if(cart.getType().longValue()>=1&&cart.getType().longValue()!=12
					&&cart.getType().longValue()!=19){
				//������Ʒ�������Ʒ��û�м��뵽���ﳵ��type=1��ʾ������Ʒ��10��ʾ���μ�Eȯ����Ʒ�����������Ż���Ʒ
				GiftProduct gp = GiftHelper.getGiftProduct(cart.getProductId());
				
				if(gp!=null){//��Ʒ��Ʒ����
					boolean existsGift = false ;//��¼��Ʒ��Ʒ�Ƿ��ڹ��ﳵ��
					//����Ʒ���ڵ�Ʒ��Ʒ����鹺�ﳵ����û�������Ʒ��û�еĻ��Զ����ϡ���Ʒ��Ʒ���Ǽӳ�һ���ӽڵ�
					ArrayList<Cart> childCarts = getCartItemsViaParentId(cart.getId());
					if(childCarts!=null&&childCarts.size()>0){
						
						for(int j=0;j<childCarts.size();j++){
							Cart c123 = childCarts.get(j);
							if(c123.getType().longValue()==12){//12�ǵ�Ʒ��Ʒ����
								//�Ѿ����������Ʒ
								existsGift = true ;
								break ;
							}
						}
					}
					
					//��Ʒ��Ӧ����Ʒ
					Product p123 = (Product)Tools.getManager(Product.class).get(gp.getGiftgds_gdsid());
					
					if(!existsGift&&Tools.floatValue(gp.getGiftgds_price())==0&&p123.getGdsmst_validflag()!=null&&p123.getGdsmst_validflag().longValue()==1){//���0Ԫ��Ʒ��Ʒû�м��ϣ����Զ�����
						Cart c = new Cart();
						
						c.setAmount(cart.getAmount());//��Ʒ��Ʒ��X��X
						c.setCreateDate(new java.util.Date());
						c.setHasChild(new Long(0));						
						c.setOldPrice(Tools.getFloat(p123.getGdsmst_memberprice(),2));//��Ʒ��					
						c.setMoney(Tools.getFloat(c.getAmount()*gp.getGiftgds_price(),2));//֧���۾�����Ʒ��
						c.setPrice(Tools.getFloat(gp.getGiftgds_price(),2));//��Ʒ����
						c.setProductId(p123.getId());
						c.setTitle("����Ʒ��"+Tools.clearHTML(p123.getGdsmst_gdsname()));
						c.setVipPrice(Tools.getFloat(gp.getGiftgds_price(),2));
						c.setType(new Long(12));//��Ʒ��Ʒ����
						c.setCookie(cart.getCookie());//ȡ�ϼ�cookie
						c.setUserId(cart.getUserId());//ȡ�ϼ�userId
						
						c.setParentId(cart.getId());
						c.setHasFather(new Long(1));//�и���
						c.setIp(request.getRemoteHost());
						
						//sku
						ArrayList<Sku> slist=SkuHelper.getSkuListViaProductId(p123.getId());
						if(slist!=null&&slist.size()>0&&slist.get(0)!=null)
						{
							c.setSkuId(slist.get(0).getId());
						}
						Tools.getManager(Cart.class).create(c);//������Ʒ��Ʒ
						
						Tools.getManager(Cart.class).clearListCache(cart);
						cart.setHasChild(new Long(1));
						Tools.getManager(Cart.class).update(cart, true);
						
						
					}
				}else{//����õ�Ʒû����Ʒ����ɾ���������Ʒ
					ArrayList<Cart> childCarts = getCartItemsViaParentId(cart.getId());
					if(childCarts!=null&&childCarts.size()>0){
						for(int j=0;j<childCarts.size();j++){
							Cart c23 = childCarts.get(j);
							if(c23.getType().longValue()==12){//�ǵ�Ʒ��Ʒ����ɾ������Ϊԭ��Ʒû�е�Ʒ��Ʒ��
								if(Tools.getManager(Cart.class).delete(c23)){
									rlist.add(c23);//�ӵ����ؽ����
									System.out.println("�Զ�ɾ�����ﳵ�������ڵĵ�Ʒ��Ʒ��cookie="+c23.getCookie()+" userId="+c23.getUserId());
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
	 * ���cart��Ʒ�ǲ��ǺϷ������Ϸ����Զ�ɾ�����߼�̫���ӣ�������bug
	 * @param request
	 * @param response
	 * @param cart
	 * @return ɾ������Cart
	 */
	private static List<Cart> checkOrDeleteGift(HttpServletRequest request,HttpServletResponse response){
		boolean isbj=false;
		if(UserHelper.isPtVip(request, response)){//ɾ���ǰ׽��û�����������
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
		
		//��һ���������Ƚ���Ʒ�Ƿ�Ӧ�ô����ڹ��ﳵ�У�
		ArrayList<GiftHelper.GiftGoods> giList = GiftHelper.getCartAvaiableGiftProducts(request,response);
		
		if(giList!=null&&giList.size()>0){
			for(int i=0;i<giftList.size();i++){
				Cart c_1 = giftList.get(i);
				boolean valid = false ;
				//ѭ���Ƚ�������Ʒ�ǲ��Ǻ�avaiable����Ʒ����ϣ���������ɾ��
				for(int j=0;j<giList.size();j++){
					GiftHelper.GiftGoods gg_1 = giList.get(j);
					Product gi_1 = ProductHelper.getById(gg_1.getProductId());
					if(gi_1 != null && c_1.getProductId()!=null&&c_1.getProductId().equals(gi_1.getId())){
						valid = true ;
						break ;
					}
				}
				
				if(!valid){
					//˵������Ʒ��Ӧ�ô�����������ﳵ��������û���������ȵ�������ɾ��֮
					if(Tools.getManager(Cart.class).delete(c_1)){
						rlist.add(c_1);
						System.out.println("�Զ�ɾ�����ﳵ����Ʒ��Ӧ�ô��ڣ�cookie="+c_1.getCookie()+" userId="+c_1.getUserId());
					}
				}
			}
		}else{//ɾ�����ж�����Ʒ
			for(int i=0;i<giftList.size();i++){
				Cart c_1 = giftList.get(i);
				if(Tools.getManager(Cart.class).delete(c_1)){
					rlist.add(c_1);
					System.out.println("�Զ�ɾ�����ﳵ��ɾ�����ж�����Ʒ��cookie="+c_1.getCookie()+" userId="+c_1.getUserId());
				}
			}
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
		
		//�ڶ���������Ȼ���ж������ԣ����жϡ���ѡ������Ʒ���Ƿ�ѡ���˶��������������				
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		
		if(gifts!=null&&gifts.size()>0){
			for(int j=0;j<gifts.size();j++){
				Gift gift = gifts.get(j);
			
				//�Ƚϵ�ѡ�������Ʒ�Ƿ�ѡ���˶��
				if(gift.getGiftrckmst_selecttype()!=null&&gift.getGiftrckmst_selecttype().longValue()==0){
					//������Ʒ��ϸ
					ArrayList<GiftItem> itemList = GiftHelper.getGiftItems(gift.getId());
					if(itemList==null||itemList.size()==0)continue;

					//�͹��ﳵ�����Ʒ����ѭ���Ƚ�
					int count = 0 ;
					if(giftList!=null&&giftList.size()>0){
						for(int a=0;a<giftList.size();a++){
							Cart cc = giftList.get(a);
							if(itemList!=null&&itemList.size()>0){
								for(int b=0;b<itemList.size();b++){
									GiftItem gi = itemList.get(b);
									
									if(cc.getProductId()!=null&&cc.getProductId().equals(gi.getGiftrckdtl_gdsid())){//����
										count++;
									}
									
									if(count>=2){
										//��ѡ��Ʒ���������Ʒѡ���˶����ɾ��
										if(Tools.getManager(Cart.class).delete(cc)){
											rlist.add(cc);
											System.out.println("�Զ�ɾ�����ﳵ����ѡ��Ʒ���������Ʒѡ���˶����cookie="+cc.getCookie()+" userId="+cc.getUserId());
										}
										count = 1 ;
										break;
									}
								}//end for b
							}
						}//end for a
					}
					
					giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
				}
			}//end for j
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
		
		//�������������ж϶�Ʒ��Ʒ������ǡ���ѡ���ģ�������û�ж����Ʒ������
		ArrayList<GiftGroup>  ggroupList = GiftHelper.getAllGiftGroups();
		
		if(ggroupList!=null&&ggroupList.size()>0){
			for(int i=0;i<ggroupList.size();i++){
				
				GiftGroup gg = ggroupList.get(i);
				if(gg.getGiftgrpmst_selecttype()!=null&&gg.getGiftgrpmst_selecttype().longValue()==1)continue ;//��ѡ�飬����
				
				ArrayList<GiftGroupItem> ggiList = GiftHelper.getGiftGroupItem(gg.getId());
				
				//ѭ����ϸ�����չ��ﳵ��Ʒ�ж�
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
								
								//��Ʒ��Ʒ��ѡ���������Ʒѡ���˶����ɾ��
								if(count>=2){ 
									if(Tools.getManager(Cart.class).delete(cart)){
										rlist.add(cart);
										System.out.println("�Զ�ɾ�����ﳵ����Ʒ��Ʒ��ѡ���������Ʒѡ���˶����cookie="+cart.getCookie()+" userId="+cart.getUserId());
									}
									count=1;
									break;
								}
							}//end for k
						}
					}//end for j
					
					giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
				}
			}//end for i
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
		
		
		//���ĸ�����������Ʒ�⣬����������Ʒֻ��ѡһ��������
		
		ArrayList<Cart> cartList = getCartItems(request,response);
		if(cartList!=null&&cartList.size()>0){
			for(Cart c7:cartList){
				if(c7.getType().longValue()==0&&c7.getAmount().longValue()>1){//��ͨ��Ʒ
					c7.setAmount(new Long(1));
					c7.setMoney(new Float(c7.getPrice().floatValue()));
					Tools.getManager(Cart.class).update(c7, false);
				}
				
			}
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
		
		//������������ȽϷ�����Ʒ�������
		ArrayList<GiftItem> allGiftItems = GiftHelper.getAvaiableGiftItems(null, null);
		
		if(giftList!=null&&giftList.size()>0){
			for(int i=0;i<giftList.size();i++){//ѭ�����й��ﳵ�����Ʒ
				Cart cc = giftList.get(i);
				if(allGiftItems!=null&&allGiftItems.size()>0){
					for(int j=0;j<allGiftItems.size();j++){
						GiftItem g2 = allGiftItems.get(j);
						
						if(cc.getProductId()!=null&&cc.getProductId().equals(g2.getGiftrckdtl_gdsid())){
							//������Ҳɾ��
							if(g2.getGiftrckdtl_limitmoney()!=null&&g2.getGiftrckdtl_limitmoney().floatValue()>CartHelper.getTotalPayMoney(request, response)){
								if(Tools.getManager(Cart.class).delete(cc)){
									rlist.add(cc);
									System.out.println("�Զ�ɾ�����ﳵ�������㣬cookie="+cc.getCookie()+" userId="+cc.getUserId());
								}
							}
						}
					}
				}
			}
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ�ι��ﳵ��Ʒ
		
		//�������������Ƚ϶�Ʒ��Ʒ�������
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
								
								//����Ʒ���ڶ�Ʒ��Ʒ
								if(cc.getProductId()!=null&&cc.getProductId().equals(ggi.getGiftgrpdtl_gdsid())){
									//��������
									if(ggi.getGiftgrpdtl_limitmoney()!=null&&ggi.getGiftgrpdtl_limitmoney().floatValue()>CartHelper.getTotalPayMoney(request, response)){
										if(Tools.getManager(Cart.class).delete(cc)){
											rlist.add(cc);
											System.out.println("�Զ�ɾ�����ﳵ����Ʒ��Ʒ�������cookie="+cc.getCookie()+" userId="+cc.getUserId());
										}
									}
								}
							}//end for k
						}
					}//end for j
				}
			}//end for i
		}
		
		giftList = getCartGifts(request,response); //���»�ȡһ����Ʒ�б�
		
		return rlist ;
	}
	
	/**
	 * �õ����ﳵ��������Ʒ������ָ������Ʒ����Ʒ��Ʒ���㣬��Ʒ��Ʒ�Ѿ����������ˡ�
	 * @param request
	 * @param response
	 * @return
	 */
	private static ArrayList<Cart> getCartGifts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//��ȡ���ﳵ������cart��¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()==0){//������Ʒ�����㵥Ʒ��Ʒ
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * �õ����ﳵ������������Ʒ�����������Ʒ������Ʒ������Ʒ�������Żݵ���Ʒ�����㡣
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartNormalProducts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()>0){//������Ʒ����ϵ�Ҳ��
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * �ܻ�ȡ��Ʒ����Ʒ�б�
	 * @param request
	 * @param response
	 * @return
	 */
	public static ArrayList<Cart> getCartGiftNormalProducts(HttpServletRequest request,HttpServletResponse response){
		ArrayList<Cart> resList = new ArrayList<Cart>();
		
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		
		if(cartList!=null&&cartList.size()>0){
			for(int i=0;i<cartList.size();i++){
				Cart c = cartList.get(i);
				if(c.getType().longValue()==1||c.getType().longValue()==10||c.getType().longValue()==6||c.getType().longValue()==9||c.getType().longValue()==7||c.getType().longValue()==11||c.getType().longValue()==13){//ֻҪ������Ʒ����������
					resList.add(c);
				}
			}
		}
		return resList ;
	}
	
	/**
	 * ��鲢���¹��ﳵ�۸񣡣���
	 * @param request
	 * @param response
	 */
	public static void updateCartPrice(HttpServletRequest request,HttpServletResponse response){
		//���ﳵ��������
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
				cart.setTitle("��2��8�ۡ�"+cart.getTitle());
            	cart.setMoney(Tools.getFloat(mprice*cart.getAmount().longValue()*0.8f,2));
				cart.setPrice(Tools.getFloat(mprice*0.8f,2));
            	cart.setType(new Long(21));
            	Tools.getManager(Cart.class).update(cart, false);
			}
			if(ctype==21&&(ndate.getTime()>edate.getTime()||Tools.isNull(xycarts)||xycarts.indexOf(","+cart.getId()+",")==-1)){
				String ctitle=cart.getTitle();
				ctitle=ctitle.replace("��2��8�ۡ�", "");
				Product p=ProductHelper.getById(gdsid);
				cart.setTitle(ctitle);
            	cart.setMoney(Tools.getFloat(cart.getMoney().floatValue()*1.25f,2));
				cart.setPrice(Tools.getFloat(cart.getPrice().floatValue()*1.25f,2));
				if(ctitle.startsWith("����ɱ��")||ctitle.startsWith("��������")){
					cart.setType(new Long(20));
				}else if(p!=null&&p.getGdsmst_specialflag()!=null&&p.getGdsmst_specialflag().longValue()==1){
					cart.setType(new Long(10));
				}else{
            	cart.setType(new Long(1));
				}
            	Tools.getManager(Cart.class).update(cart, false);
			}
			//����ǰ׽��Ա���޸ļ۸�
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
		    ppcode=ppcode.replace("��", ",");		
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
	 * ��ȡ�׽�����б�
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
	 * ��ȡ���Ʒ�б�
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
	 * ��ȡ������Ʒ�Ļ�ܶ�<br/>
	 * @param request
	 * @param response
	 * @return
	 */
	public static float getbjhdProductMoney(HttpServletRequest request,HttpServletResponse response){
		//��ȡ���ﳵ�����м�¼
		ArrayList<Cart> cartList = getCartItems(request,response) ;
		//��֧���ۼ�����
		if(cartList==null||cartList.size()==0){
			return 0f;
		}else{
			float total = 0f;
			for(int i=0;i<cartList.size();i++){
				Cart cart = cartList.get(i);
				if(cart.getType().longValue()==1){
					Product product = (Product)Tools.getManager(Product.class).get(cart.getProductId());
					ArrayList<PromotionProduct> bjproduct=gethdgoodslist(cart.getProductId());
					
					if(product!=null&&bjproduct!=null&&bjproduct.size()>0){//����ȯ
						total+=cart.getOldPrice()*cart.getAmount();
					}
				}
			}
			
			return Tools.getFloat(total,2);
		}
	}
	
	
	
	/**
	 * �޸ĵ���cart�ļ۸�
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
			//������ﳵ��ļ۸��ǻ�Ա�ۣ��޸�֮
			
			cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2));
			cart.setIp(request.getRemoteHost());
			cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue(),2));
			cart.setType(new Long(1));
			Tools.getManager(Cart.class).update(cart, false);
		}
		
	}*/
		
		
		
		if(UserHelper.isPtVip(request, response)){
			float zk=0.98f;
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//������Ʒ���¼����Ա�۸�
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//�Ƿ��ǰ׽�������Ʒ
				ArrayList<PromotionProduct> bjdxlist=getbjdxlist(productId);
				if(bjdxlist!=null&&bjdxlist.size()>0)
				{
					PromotionProduct bjdxpp=bjdxlist.get(0);
                    if(bjdxpp.getSpgdsrcm_tjprice()!=null)
                    {
                    	cart.setTitle("[�׽������Ʒ]"+cart.getTitle());
                    	cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*bjdxpp.getSpgdsrcm_tjprice().floatValue(),2));
						cart.setIp(request.getRemoteHost());
						cart.setPrice(bjdxpp.getSpgdsrcm_tjprice().floatValue());
                    	cart.setType(new Long(17));
                    	Tools.getManager(Cart.class).update(cart, false);
                    }
				}
				else
				{				
					if(updateCartExpPrice1(request,response,cart))return ;//�޸Ķ���۸�����ɹ��Ͳ��޸İ׽��
					//�����ۿۼ۸�
					if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009")))
					{
						zk=0.95f;
					}			
					
					else
					{
						zk=0.98f;
					}
					//if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
						//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
						//cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
						//cart.setIp(request.getRemoteHost());
						//cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue()*Const.PT_VIP_DISCOUNT,2));
						//Tools.getManager(Cart.class).update(cart, false);
					//}
					if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*zk,2)){
						//���Ҫ�ǲμӻ����Ʒ�򲻴��� Ϊ�Ƽ�λ����Ʒ
						ArrayList<PromotionProduct> hdgoodslist=null;
						if(bjhdnum>=200){
						hdgoodslist=gethdgoodslist(productId);
						}
						if(hdgoodslist!=null&&hdgoodslist.size()>0)
						{
							//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()),2));
							cart.setIp(request.getRemoteHost());
							cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()),2));
							Tools.getManager(Cart.class).update(cart, false);
						
						}
						else
						{
							//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(product.getGdsmst_memberprice().floatValue()*zk),2));
							cart.setIp(request.getRemoteHost());
							cart.setPrice(Tools.getFloat((int)(product.getGdsmst_memberprice().floatValue()*zk),2));
							Tools.getManager(Cart.class).update(cart, false);
						}
						
						
					}
				}
			}else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//�����ƷҲ���Դ���
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//�����ۿۼ۸�
				if(cart.getType()!=null&&cart.getType().longValue()==16)
				{
					zk=0.95f;
				}else{
					zk=0.98f;
				}
			
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*zk,2)){
					//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
					//System.out.print("cbvcbvnbnb"+Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2));
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*zk),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//�����ײ��ܼ�
				//if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
					//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
					//cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2));
					//cart.setIp(request.getRemoteHost());
					//Tools.getManager(Cart.class).update(cart, false);
				//}
				
				if(cart.getType().longValue()==-1){
					if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT,2)){
						//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*Const.PT_VIP_DISCOUNT),2));
						cart.setIp(request.getRemoteHost());
						Tools.getManager(Cart.class).update(cart, false);
					}
					}
					else
					{
						if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*0.95f,2)){
							//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*0.95f),2));
							cart.setIp(request.getRemoteHost());
							Tools.getManager(Cart.class).update(cart, false);
						}
					}
			}else {//�����������������Ʒ��XѡY
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
		}else if(UserHelper.isVip(request, response)){//�����VIP��Ա
			float zk=0.99f;			
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//������Ʒ���¼����Ա�۸�
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				
				if(updateCartExpPrice(request,cart))return ;//�޸Ķ���۸�����ɹ��Ͳ��޸İ׽��
				//�����ۿۼ۸�
				if(product.getGdsmst_rackcode()!=null&&product.getGdsmst_rackcode().length()>0&&(product.getGdsmst_rackcode().startsWith("02")||product.getGdsmst_rackcode().startsWith("03")||product.getGdsmst_rackcode().startsWith("015009")))
				{
					zk=0.98f;
				}			
				
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue()*zk,2)){
					//VIP��Ա
					//���Ҫ�ǲμӻ����Ʒ�򲻴��� Ϊ�Ƽ�λ����Ʒ
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
			}else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//�����ƷҲ���Դ���
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				//�����ۿۼ۸�
				if(cart.getType()!=null&&cart.getType().longValue()==16)
				{
					zk=0.98f;
				}else{
					zk=0.99f;
				}
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*zk,2)){
					//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*zk),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
				
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//�����ײ��ܼ�
				if(cart.getType().longValue()==-1){
					if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
						//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
						cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
						cart.setIp(request.getRemoteHost());
						Tools.getManager(Cart.class).update(cart, false);
					}
			   }
			   else
			   {
						if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue()*0.95f,2)){
							//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
							cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*(int)(cart.getPrice().floatValue()*0.95f),2));
							cart.setIp(request.getRemoteHost());
							Tools.getManager(Cart.class).update(cart, false);
						}
			   }
								
			}else {//�����������������Ʒ��XѡY
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
		}else{//��ͨ��Ա����δ��¼״̬
			if(cart.getType().longValue()==1||cart.getType().longValue()==10){//������Ʒ���¼����Ա�۸�
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				if(updateCartExpPrice(request,cart))return ;//�޸Ķ���۸�����ɹ��Ͳ��޸Ļ�Ա��
				
		
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2)){
					//������ﳵ��ļ۸��ǻ�Ա�ۣ��޸�֮
					
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*product.getGdsmst_memberprice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					cart.setPrice(Tools.getFloat(product.getGdsmst_memberprice().floatValue(),2));
					Tools.getManager(Cart.class).update(cart, false);
				}
			}
			
			
			/*else if(cart.getType().longValue()==8||cart.getType().longValue()==16){//�����ƷҲ���Դ���
				String productId = cart.getProductId();
				Product product = (Product)Tools.getManager(Product.class).get(productId);
				
				if(product!=null&&cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
				
			}else if(cart.getType().longValue()==-1||cart.getType().longValue()==-6){//�����ײ��ܼ�
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					//�׽��Ա�۸�Ҫ��95��,�׽�۸�=��Ա��*0.95
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			}else {//�����������������Ʒ��XѡY*/
				if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2)){
					cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*cart.getPrice().floatValue(),2));
					cart.setIp(request.getRemoteHost());
					Tools.getManager(Cart.class).update(cart, false);
				}
			//}
		}
	}
	/**
	 * �޸Ĺ��ﳵ����ۣ�������˶���ۣ��׽�ۺ�VIP�۾Ͳ���Ч��
	 * @param request
	 * @param cart
	 * @return �޸ĳɹ�����true���Ͳ����޸İ׽���ˣ�û���޸ķ���false
	 */
	private static boolean updateCartExpPrice(HttpServletRequest request,Cart cart){
		//�����cookie�ж�
		Cookie exPriceCookie = Tools.getClientCookie(request, "rcmdusr_rcmid");
		String expriceCookieValue = null ;
		if(exPriceCookie!=null){
			expriceCookieValue = exPriceCookie.getValue();
		}else{
			return false ;
		}
		
		if(Tools.isNull(expriceCookieValue)||!StringUtils.isDigits(expriceCookieValue))return false ;
		
		ProductExpPrice pp = (ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(expriceCookieValue));
		
		if(pp==null||!ProductExpPriceHelper.valid(pp))return false ;//��֤δͨ���������ǹ�����
		
		String productId = cart.getProductId();
		
		//�����ѯ����
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rcmdgds_rcmid", new Long(expriceCookieValue)));
		clist.add(Restrictions.eq("rcmdgds_gdsid", productId));
		
		ProductExpPriceItem ppi = null ;
		List<BaseEntity> ppiList = Tools.getManager(ProductExpPriceItem.class).getList(clist, null, 0, 1);
		
		if(ppiList==null||ppiList.size()==0)return false ;
		
		ppi = (ProductExpPriceItem)ppiList.get(0);
		//���㵽���޸��ؼ۵ĵط��ˣ��޸ĳɶ���۸�
		if(cart.getMoney().floatValue()!=Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2)||ppi.getRcmdgds_memberprice().floatValue()==0f){
			cart.setMoney(Tools.getFloat(cart.getAmount().longValue()*ppi.getRcmdgds_memberprice().floatValue(), 2));
			cart.setIp(request.getRemoteHost());
			cart.setPrice(Tools.getFloat(ppi.getRcmdgds_memberprice().floatValue(), 2));
			if(!cart.getTitle().startsWith("���Ż��ؼۡ�"))cart.setTitle("���Ż��ؼۡ�"+cart.getTitle());
			Tools.getManager(Cart.class).update(cart, false);

		}
		
		if(cart.getType().longValue()!=9){
			cart.setType(new Long(9));
			Tools.getManager(Cart.class).update(cart, false);
		}
		return true ;
	}

	/**
	 * �޸Ĺ��ﳵ����ۣ�������˶���ۣ��׽�ۺ�VIP�۾Ͳ���Ч��
	 * @param request
	 * @param cart
	 * @return �޸ĳɹ�����true���Ͳ����޸İ׽���ˣ�û���޸ķ���false
	 */
	private static boolean updateCartExpPrice1(HttpServletRequest request,HttpServletResponse response,Cart cart){
		
		//�����cookie�ж�
		Cookie exPriceCookie = Tools.getClientCookie(request, "rcmdusr_rcmid");
		String expriceCookieValue = null ;
		if(exPriceCookie!=null){
			expriceCookieValue = exPriceCookie.getValue();
		}else{
			return false ;
		}
		
		if(Tools.isNull(expriceCookieValue)||!StringUtils.isDigits(expriceCookieValue))return false ;
		
		ProductExpPrice pp = (ProductExpPrice)Tools.getManager(ProductExpPrice.class).findByProperty("rcmdusr_rcmid", new Long(expriceCookieValue));
		
		if(pp==null||!ProductExpPriceHelper.valid(pp))return false ;//��֤δͨ���������ǹ�����
		
		String productId = cart.getProductId();
		
		//�����ѯ����
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rcmdgds_rcmid", new Long(expriceCookieValue)));
		clist.add(Restrictions.eq("rcmdgds_gdsid", productId));
		
		ProductExpPriceItem ppi = null ;
		List<BaseEntity> ppiList = Tools.getManager(ProductExpPriceItem.class).getList(clist, null, 0, 1);
		
		if(ppiList==null||ppiList.size()==0)return false ;
		
		ppi = (ProductExpPriceItem)ppiList.get(0);
		
		//���㵽���޸��ؼ۵ĵط��ˣ��޸ĳɶ���۸�
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
					if(!cart.getTitle().startsWith("���Ż��ؼۡ�"))cart.setTitle("���Ż��ؼۡ�"+cart.getTitle());
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
				if(!cart.getTitle().startsWith("���Ż��ؼۡ�"))cart.setTitle("���Ż��ؼۡ�"+cart.getTitle());
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
	 * ���ﳵ���Ƿ���ƽ���û�����Ʒ
	 * @param request
	 * @param response
	 * @return true ��ʾ�У�false��ʾû��
	 */
	public static boolean existPingAnGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("ƽ������ͨ")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//������ﳵ��ĳ����Ʒ����Ʒid=ƽ������ͨ�������Ʒ����Ʒid�����ʾ������
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
	 * ���ﳵ���Ƿ���139�����û�����Ʒ
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean exist139MailGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("139����")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//������ﳵ��ĳ����Ʒ����Ʒid=139����ͨ�������Ʒ����Ʒid�����ʾ������
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
	 * ���ﳵ���Ƿ��а׽�VIP�û�����Ʒ
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean existPtVipGift(HttpServletRequest request,HttpServletResponse response) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		for(int i=0;i<gifts.size();i++){
			Gift gift = gifts.get(i);
			if(gift.getGiftrckmst_title()!=null&&gift.getGiftrckmst_title().indexOf("�׽�VIP")>-1){
				ArrayList<GiftItem> giList = GiftHelper.getGiftItems(gift.getId());
				if(giList==null||giList.size()==0)return false ;
				for(int j=0;j<giList.size();j++){
					ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
					if(carts==null||carts.size()==0)return false ;
					for(int k=0;k<carts.size();k++){
						Cart cart = carts.get(k);
						//������ﳵ��ĳ����Ʒ����Ʒid=�׽�VIPͨ�������Ʒ����Ʒid�����ʾ������
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
	 * ���ﳵ���Ƿ���ȫ����Ʒ
	 * @param request
	 * @param response
	 * @param gift
	 * @return
	 */
	public static boolean existTotalGift(HttpServletRequest request,HttpServletResponse response,Gift gift) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0)return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
		if(carts==null||carts.size()==0)return false ;
		
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//���ﳵ�����Ʒ
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift gift123 = gifts.get(j);
				//000��ʾȫ��
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
	 * ���ﳵ���Ƿ��з�����Ʒ
	 * @param request
	 * @param response
	 * @param gift Gift
	 * @return
	 */
	public static boolean existDirectoryGift(HttpServletRequest request,HttpServletResponse response, Gift gift) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||gift==null)return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
		if(carts==null||carts.size()==0)return false ;
		
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//���ﳵ�����Ʒ
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift g = gifts.get(j);
				//���������
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
	 * ���ﳵ���Ƿ���Ʒ����Ʒ
	 * @param request
	 * @param response
	 * @param brandName Ʒ����
	 * @return
	 */
	public static boolean existBrandGift(HttpServletRequest request,HttpServletResponse response, String brandName) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||Tools.isNull(brandName))return false ;
		
		brandName = brandName.trim();
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
		if(carts==null||carts.size()==0)return false ;
		
		//ѭ���жϹ��ﳵ�����Ʒ
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//���ﳵ�����Ʒ
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			for(int j=0;j<gifts.size();j++){
				Gift gift = gifts.get(j);
				//Ʒ�ƶ�����
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
	 * ���ﳵ���Ƿ��ж�Ʒ��Ʒ�����Ƽ�λ��Ʒ
	 * @param request
	 * @param response
	 * @param promotion �Ƽ�λ��
	 * @return
	 */
	public static boolean existPromotionGift(HttpServletRequest request,HttpServletResponse response, String promotion) {
		ArrayList<Gift> gifts = GiftHelper.getAllValidGifts();
		if(gifts==null||gifts.size()==0||Tools.isNull(promotion))return false ;
		
		ArrayList<Cart> carts = CartHelper.getCartGifts(request, response);//��ȡ���ﳵ�������Ʒ
		if(carts==null||carts.size()==0)return false ;
		
		//ѭ���жϹ��ﳵ�����Ʒ
		for(int i=0;i<carts.size();i++){
			Cart cart = carts.get(i);//���ﳵ�����Ʒ
			Product p = (Product)Tools.getManager(Product.class).get(cart.getProductId());
			if(p==null)continue;
			
			ArrayList<GiftGroup> ggList = GiftHelper.getAllGiftGroups();//���ж���Ķ�Ʒ��Ʒ
			if(ggList==null||ggList.size()==0)return false ;
			for(int j=0;j<ggList.size();j++){
				GiftGroup gg = ggList.get(j);
				if(gg.getGiftgrpmst_title()!=null&&gg.getGiftgrpmst_title().indexOf(","+promotion+",")>-1){
					//ѭ���Ա����ж�Ʒ��Ʒ����ϸ���͹��ﳵ�����Ʒid���бȽ�
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
	 * ��ù��ﳵ��Ʒ�����
	 * @param type - type
	 * @return String
	 */
	public static String getProductType(long typeLong){
		int type = (int)typeLong;
		if(type == 1) return "";
		if(type == 6) return "�Ź���Ʒ";
		if(type == 0) return "��Ʒ";
		switch(type){
			case 6:
				return "Ʒ�Ƽ�����Ʒ";
			case 2:
				return "���ֻ�����Ʒ";
			case 8:
				return "����ؼ���Ʒ";
			case 3:
			case 4:
			case 5:
				return "������Ʒ";
			case 9:
				return "�������Ʒ";
			default:
				return "";
		}
	}
	
	/**
	 * �Ƿ����Ź���Ʒ
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
	 * �Ƿ����Ź��һ���Ʒ
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
	 * ���ﳵ���Ƿ������׶һ���Ʒ
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
		if("11111111".equals(shopcode))return true ;//000��ʾȫ������
		
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
	 * ���ﳵ�Ƿ����ĳ���������Ʒ���жϲ㼶��ϵ
	 * @param rackcode
	 * @return
	 */
	public static boolean existsDirectory(HttpServletRequest request,HttpServletResponse response,String rackcode){
		if(Tools.isNull(rackcode))return false ;
		
		rackcode = rackcode.trim();
		
		if("000".equals(rackcode))return true ;//000��ʾȫ������
		
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
	 * ��鹺�ﳵ��������ﳵ�е���Ʒ�д������Զ�ɾ����
	 * @param request
	 * @param response
	 * @return List<Cart> ��ɾ����Cart�ļ���
	 */
	/*public static List<String> checkCartError(HttpServletRequest request,HttpServletResponse response){
		List<Cart> list = CartHelper.getCartItems(request,response);
		if(list == null || list.isEmpty()) return null;
		
		List<String> delete_list = new ArrayList<String>();
		
		for(Cart cart : list){
			Product product = ProductHelper.getById(cart.getProductId());
			//�������޻�
			if(!ProductHelper.isShow(product)){
				CartHelper.deleteCart(request,response,cart.getId());
				delete_list.add(cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId()));
			}else{
				//��sku����û��ѡ��
				if(ProductHelper.hasSku(product) && (Tools.isNull(cart.getSkuId()) || "0".equals(cart.getSkuId()))){
					CartHelper.deleteCart(request,response,cart.getId());
					delete_list.add(cart.getId()+"_0_"+(Tools.isNull(cart.getSkuId())?"0":cart.getSkuId()));
				}
			}
		}
		return delete_list;
	}*/
	/***
	 * ��������������ݿ����Ƿ���ɱ��
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
	 * �ж�һ����Ʒ�Ƿ�����ڹ��ﳵ�С�
	 * @param product - ��Ʒ����
	 * @param skuId - skuId����������Ʒû��sku������null.
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
