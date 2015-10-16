package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Brand;
import com.d1.bean.BrandPromotion;
import com.d1.bean.BrandPromotionItem;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * Ʒ�Ʋ�������������Ʒ�Ƽ���ķ�����
 * @author kk
 *
 */
public class BrandHelper {
	
	/**
	 * �õ�����Ʒ�ƣ�Լ2000����OK
	 * @return
	 */
	public static ArrayList<Brand> getAllBrands(){
		List<BaseEntity> list = Tools.getManager(Brand.class).getList(null, null, 0, 10000);
		ArrayList<Brand> resList = new ArrayList<Brand>();
		if(list==null||list.size()==0)return null;
		for(int i=0;i<list.size();i++){
			Brand b = (Brand)list.get(i);
			resList.add(b);
		}
		return resList ;
	}
	
	/**
	 * �õ���Ч��Ʒ�Ƽ����¼�����ڵĲ�ȡ��
	 * @return
	 */
	public static ArrayList<BrandPromotion> getAvaiableBrandPromotions(){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brdtktmst_validflag", new Long(1)));
		
		List<BaseEntity> list = Tools.getManager(BrandPromotion.class).getList(clist, null, 0, 1000);
		if(list==null||list.size()==0)return null;
		
		ArrayList<BrandPromotion>  resList = new ArrayList<BrandPromotion>();
		for(int i=0;i<list.size();i++){
			BrandPromotion bp = (BrandPromotion)list.get(i);
			//δ���ڵĲż���
			if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()
					&&System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()){
				resList.add(bp);
			}
		}
		return resList ;
	}
	
	/**
	 * �õ����ݿ������ж����Ʒ�Ƽ��⣬���������м�¼��ǰ̨һ�㲻�����������
	 * @return
	 */
	public static ArrayList<BrandPromotion> getAllBrandPromotions(){
		List<BaseEntity> list = Tools.getManager(BrandPromotion.class).getList(null, null, 0, 1000);
		if(list==null||list.size()==0)return null;
		
		ArrayList<BrandPromotion>  resList = new ArrayList<BrandPromotion>();
		for(int i=0;i<list.size();i++){
			BrandPromotion bp = (BrandPromotion)list.get(i);
			resList.add(bp);
		}
		return resList ;
	}
	
	/**
	 * ���������Ʒ�Ƽ���ȡ��ϸ����
	 * @param brandPromotionId null��ʾ���Դ�������brandPromotionId����������
	 * @param brandId Ʒ��id
	 * @return
	 */
	public static ArrayList<BrandPromotionItem> getBrandPromotionItems(String brandPromotionId,String brandId){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		if(brandPromotionId!=null)clist.add(Restrictions.eq("brdtktdtl_mstid", new Long(brandPromotionId)));
		if(brandId!=null)clist.add(Restrictions.eq("brdtktdtl_brand", brandId));
		clist.add(Restrictions.eq("brdtktdtl_validflag", new Long(1)));
		
		List<BaseEntity> list = Tools.getManager(BrandPromotionItem.class).getList(clist, null, 0, 1000);
		if(list==null||list.size()==0)return null;
		
		ArrayList<BrandPromotionItem> resList = new ArrayList<BrandPromotionItem>();
		for(int i=0;i<list.size();i++){
			BrandPromotionItem bpi = (BrandPromotionItem)list.get(i);
			resList.add(bpi);
		}
		return resList;
	}
	
	/**
	 * ����brandId�ҵ���Ӧ��BrandPromotion���壬�������˶����ֻȡ��һ������Ʒ�Ƽ��⣡��<br/>
	 * ��˵�������ݿ�83����¼����һ�����ظ��ģ�Ŀǰ���ڹ���״̬��
	 * @param brandId Ʒ��id
	 * @return
	 */
	public static BrandPromotion getBrandPromotionViaBrandId(String brandId){
		BrandPromotionItem bpi = (BrandPromotionItem)Tools.getManager(BrandPromotionItem.class).findByProperty("brdtktdtl_brand", brandId);
		if(bpi==null||bpi.getBrdtktdtl_validflag()==null||bpi.getBrdtktdtl_validflag().longValue()!=1)return null;
		return (BrandPromotion)Tools.getManager(BrandPromotion.class).get(bpi.getBrdtktdtl_mstid()+"");
	}
	
	/**
	 * ����Ʒ�����ƻ��Ʒ�ƶ���
	 * @param brand_name - Ʒ������
	 * @return Brand
	 */
	public static Brand getBrandByName(String brand_name){
		if(Tools.isNull(brand_name)) return null;
		return (Brand)Tools.getManager(Brand.class).findByProperty("brand_name", brand_name);
	}
	
	/**
	 * ����Ʒ�Ƶ�code���Ʒ�ƶ���
	 * @param brand_code - Ʒ�Ʊ���
	 * @return Brand
	 */
	public static Brand getBrandByCode(String brand_code){
		if(Tools.isNull(brand_code)) return null;
		return (Brand)Tools.getManager(Brand.class).findByProperty("brand_code", brand_code);
	}
	
	/**
	 * ���ݷ����ȡƷ��
	 * @return
	 */
	public static ArrayList<Brand> getBrandByRackCode(String rackcode){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brand_rackcode", rackcode));	
		List<BaseEntity> list = Tools.getManager(Brand.class).getList(clist, null, 0, 1000);
		if(list==null||list.size()==0)return null;
		
		ArrayList<Brand> resList = new ArrayList<Brand>();
		for(BaseEntity brand:list){
			resList.add((Brand)brand);
		}
		return resList;
	}
	
	/**
	 * ���ݷ����ȡƷ��
	 * @return
	 */
	public static ArrayList<Brand> getBrandInfo(String rackcode,String brandcode){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("brand_rackcode", rackcode));	
		clist.add(Restrictions.eq("brand_code", brandcode));	
		List<BaseEntity> list = Tools.getManager(Brand.class).getList(clist, null, 0, 1);
		if(list==null||list.size()==0)return null;
		
		ArrayList<Brand> resList = new ArrayList<Brand>();
		for(BaseEntity brand:list){
			resList.add((Brand)brand);
		}
		return resList;
	}
}
