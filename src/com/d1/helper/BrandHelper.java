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
 * 品牌操作方法，包括品牌减免的方法！
 * @author kk
 *
 */
public class BrandHelper {
	
	/**
	 * 得到所有品牌，约2000个。OK
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
	 * 得到有效的品牌减免记录，过期的不取。
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
			//未过期的才加入
			if(System.currentTimeMillis()>=bp.getBrdtktmst_startdate().getTime()
					&&System.currentTimeMillis()<=bp.getBrdtktmst_enddate().getTime()){
				resList.add(bp);
			}
		}
		return resList ;
	}
	
	/**
	 * 得到数据库里所有定义的品牌减免，这里是所有记录，前台一般不用这个方法！
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
	 * 根据主表的品牌减免取明细数据
	 * @param brandPromotionId null表示忽略此条件，brandPromotionId必须是数字
	 * @param brandId 品牌id
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
	 * 根据brandId找到对应的BrandPromotion定义，若定义了多个，只取第一个计算品牌减免！！<br/>
	 * （说明：数据库83条记录，有一个是重复的，目前处于过期状态）
	 * @param brandId 品牌id
	 * @return
	 */
	public static BrandPromotion getBrandPromotionViaBrandId(String brandId){
		BrandPromotionItem bpi = (BrandPromotionItem)Tools.getManager(BrandPromotionItem.class).findByProperty("brdtktdtl_brand", brandId);
		if(bpi==null||bpi.getBrdtktdtl_validflag()==null||bpi.getBrdtktdtl_validflag().longValue()!=1)return null;
		return (BrandPromotion)Tools.getManager(BrandPromotion.class).get(bpi.getBrdtktdtl_mstid()+"");
	}
	
	/**
	 * 根据品牌名称获得品牌对象
	 * @param brand_name - 品牌名称
	 * @return Brand
	 */
	public static Brand getBrandByName(String brand_name){
		if(Tools.isNull(brand_name)) return null;
		return (Brand)Tools.getManager(Brand.class).findByProperty("brand_name", brand_name);
	}
	
	/**
	 * 根据品牌的code获得品牌对象
	 * @param brand_code - 品牌编码
	 * @return Brand
	 */
	public static Brand getBrandByCode(String brand_code){
		if(Tools.isNull(brand_code)) return null;
		return (Brand)Tools.getManager(Brand.class).findByProperty("brand_code", brand_code);
	}
	
	/**
	 * 根据分类获取品牌
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
	 * 根据分类获取品牌
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
