package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.ProductExpPrice;
import com.d1.bean.ProductExpPriceItem;
import com.d1.util.Tools;

/**
 * 商品独享价辅助工具，判断商品独享价是否过期等
 * @author kk
 *
 */
public class ProductExpPriceHelper {
	
	/**
	 * 验证ProductExpPrice是否有效，现在只判断有效期。需要从表rcmdusr中判断有效期！！！
	 * @param pp
	 * @return
	 */
	public static boolean valid(ProductExpPrice pp){
		
		if(pp==null||pp.getRcmdusr_enddate()==null||pp.getRcmdusr_startdate()==null)return false;
		
		//判断是否过期
		if(System.currentTimeMillis()>=pp.getRcmdusr_startdate().getTime()&&
				System.currentTimeMillis()<=pp.getRcmdusr_enddate().getTime()){
			return true ;
		}else{
			return false ;
		}
	}
	
	/**
	 * 获得一条独享价明细
	 * @param productId - 商品ID
	 * @param dxid - 不知道。
	 * @return ProductExpPriceItem
	 */
	public static ProductExpPriceItem getExpPrice(String productId , String dxid){
		if(Tools.isNull(productId) || !Tools.isMath(dxid)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("rcmdgds_gdsid", productId));
		listRes.add(Restrictions.eq("rcmdgds_rcmid", new Long(dxid)));
		
		List list = Tools.getManager(ProductExpPriceItem.class).getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		return (ProductExpPriceItem)list.get(0);
	}
	
}
