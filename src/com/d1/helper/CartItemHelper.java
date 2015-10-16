package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CartItem;
import com.d1.bean.OrderBase;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * cart item �����࣬����δ����Ķ���ռ�˶��ٿ��
 * @author kk
 *
 */
public class CartItemHelper {
	/**
	 * �õ�һ����Ʒ�ڶ����е�ռ�õĿ�棬������״̬Ϊ0����ռ�ã��������0��ʾ��ռ���ˣ��Ѿ��޸Ŀ��򶩵��Ѿ�ȡ����
	 * @param gdsid ��Ʒid
	 * @param skuid sku id
	 * @return
	 */
	public static int getProductOccupyStock(String gdsid,String skuid){
		if(Tools.isNull(gdsid))return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("productId", gdsid));
		if(!Tools.isNull(skuid)){
			listRes.add(Restrictions.eq("skuId", skuid));
		}
		
		List<BaseEntity> list = Tools.getManager(CartItem.class).getList(listRes, null, 0, 1000);
		if(list==null||list.size()==0)return 0;
		
		int total = 0 ;
		for(BaseEntity be:list){
			CartItem ci = (CartItem)be;
			String orderId = ci.getOrderId();
			OrderBase ob = OrderHelper.getById(orderId);//����
			if(ob.getOdrmst_orderstatus()!=null&&ob.getOdrmst_orderstatus().longValue()==0){//ֻ��0��״̬����ռ���
				if(ci.getCreateDate().getTime()+3600000l>=System.currentTimeMillis()){//δ����1Сʱ�Ĳ���ռ���
					total+=ci.getAmount().intValue();
				}
			}
		}
		
		return total;
	}
	
	/**
	 * ɾ��һ��Сʱ��ǰ�ļ�¼��ÿ����ִ��һ�μ���
	 */
	public static void deleteRecordBeforeOneHour(){
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.lt("createDate", new Date(System.currentTimeMillis()-3600000l)));
		
		List<BaseEntity> list = Tools.getManager(CartItem.class).getList(listRes, null, 0, 1000);
		if(list==null||list.size()==0)return;
		
		for(BaseEntity be:list){
			Tools.getManager(CartItem.class).delete(be);
		}
	}
}
