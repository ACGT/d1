package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.bean.YhNews;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * �Ż����Ÿ�����
 * @author chengang
 * @version chengang
 * @createTime 2011��12��8��10:53:03
 *
 */
public class YhNewsHelper {
	
public static BaseManager manager = Tools.getManager(YhNews.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return YhNews
	 */
	public static YhNews getById(String id){
		if(Tools.isNull(id)) return null;
		return (YhNews)manager.get(id);
	}
	
	/**
	 * �����Ʒ����ҳ���Ż���Ϣ
	 * @param product - ��ƷID
	 * @param count - ��ȡ�ĳ���
	 * @return List<YhNews>
	 */
	public static List<YhNews> getYhNewsList(Product product , int count){
		if(product == null || count <= 0) return null;
		
		String rackCode = Tools.trim(product.getGdsmst_rackcode());
		String brand = Tools.trim(product.getGdsmst_brand());
		String provide = Tools.trim(product.getGdsmst_provide());
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.ge("yhnews_endtime", new Date()));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.asc("yhnews_seq"));
		
		ArrayList<PromotionProduct> promotionList = PromotionProductHelper.getPromotionProductById(product.getId());
		String[] promotionCode = null;
		if(promotionList != null && !promotionList.isEmpty()){
			int size = promotionList.size();
			promotionCode = new String[size];
			for(int i=0;i<size;i++){
				PromotionProduct pp = promotionList.get(i);
				promotionCode[i] = String.valueOf(pp.getSpgdsrcm_code());
			}
		}
		
		List list = manager.getList(listRes, listOrder, 0, 1000);
		
		if(list == null || list.isEmpty()) return null;
		
		int rackCodeLen = rackCode.length();
		
		List<YhNews> infoList = new ArrayList<YhNews>();
		
		int size = list.size();

		for(int i=0;i<size;i++){
			YhNews yn = (YhNews)list.get(i);
			String gdsId = yn.getYhnews_giftgdsid();
			if(!Tools.isNull(gdsId)){
				boolean b = true;//��ƷID�Ƿ�ȫ���¼��˻�û����ˡ�
				String[] ids = gdsId.split(",");
				if(ids != null && ids.length>0){
					for(int j=0;j<ids.length;j++){
						Product p = ProductHelper.getById(ids[j]);
						if(ProductHelper.isShow(p)){
							b = false;
							break;
						}
					}
				}
				//ȫ���¼ܣ���������Ϣ��ǰ̨��ʾ������
				if(b) continue;
			}
			boolean isAdd1 = false;
			boolean isAdd2 = false;
			boolean isAdd3 = false;
			boolean isAdd4 = false;
			String yhrackcodeid = yn.getYhnews_rackcode();//����
			if (!Tools.isNull(yhrackcodeid))yhrackcodeid=yhrackcodeid.trim();
			if (!Tools.isNull(rackCode))rackCode=rackCode.trim();
			if("000".equals(yhrackcodeid) || Tools.isNull(yhrackcodeid)){
				//infoList.add(yn);
				isAdd1 = true;
			}
			if(!isAdd1 && rackCode.startsWith(yhrackcodeid)){
				//infoList.add(yn);
				isAdd1 = true;
			}
			/*if(!isAdd){
				for(int j=3;j<=rackCodeLen;j++){
					if (j != rackCodeLen){
						if(yhrackcodeid.startsWith(rackCode.substring(0,j))){
							infoList.add(yn);
							isAdd = true;
							break;
						}
					}else{
						if(yhrackcodeid.equals(rackCode)){
							infoList.add(yn);
							isAdd = true;
							break;
						}
					}
				}
			}*/
			if (yn.getYhnews_reccode().longValue()==0){
				isAdd2 = true;
			}
			if(!isAdd2 && promotionCode != null && promotionCode.length>0){
				String code = String.valueOf(yn.getYhnews_reccode());//�Ƽ�λ
				for(int j=0;j<promotionCode.length;j++){
					if(code.equals(promotionCode[j])){
						//infoList.add(yn);
						isAdd2 = true;
						break;
					}
				}
			}
			
			 String yhbrand=yn.getYhnews_brand();
			 if (!Tools.isNull(brand))brand=brand.trim();
			 if (!Tools.isNull(yhbrand))yhbrand=yhbrand.trim();
				if(Tools.isNull(yhbrand) || brand.equals(yhbrand)){
					//infoList.add(yn);
					isAdd3 = true;
				}
	          String yhprovide=yn.getYhnews_provide();
	          if (!Tools.isNull(yhprovide))yhprovide=yhprovide.trim();
	          if (!Tools.isNull(provide))provide=provide.trim();
				if(Tools.isNull(yhprovide) || provide.equals(yhprovide)){
					//infoList.add(yn);
					isAdd4 = true;
				}

			if (isAdd1 && isAdd2 && isAdd3 && isAdd4){
				infoList.add(yn);
			}
			if(infoList.size()>=count) break;
		}
		
		
		return infoList;
	}

}