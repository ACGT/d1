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
 * cart item 工具类，计算未处理的订单占了多少库存
 * @author kk
 *
 */
public class CartItemHelper {
	/**
	 * 得到一个商品在订单中的占用的库存，若订单状态为0才算占用，如果不是0表示不占用了（已经修改库存或订单已经取消）
	 * @param gdsid 商品id
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
			OrderBase ob = OrderHelper.getById(orderId);//订单
			if(ob.getOdrmst_orderstatus()!=null&&ob.getOdrmst_orderstatus().longValue()==0){//只有0的状态才算占库存
				if(ci.getCreateDate().getTime()+3600000l>=System.currentTimeMillis()){//未超过1小时的才算占库存
					total+=ci.getAmount().intValue();
				}
			}
		}
		
		return total;
	}
	
	/**
	 * 删除一个小时以前的记录，每分钟执行一次即可
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
