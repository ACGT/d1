package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.ProductExpPrice;
import com.d1.bean.ProductExpPriceItem;
import com.d1.util.Tools;

/**
 * ��Ʒ����۸������ߣ��ж���Ʒ������Ƿ���ڵ�
 * @author kk
 *
 */
public class ProductExpPriceHelper {
	
	/**
	 * ��֤ProductExpPrice�Ƿ���Ч������ֻ�ж���Ч�ڡ���Ҫ�ӱ�rcmdusr���ж���Ч�ڣ�����
	 * @param pp
	 * @return
	 */
	public static boolean valid(ProductExpPrice pp){
		
		if(pp==null||pp.getRcmdusr_enddate()==null||pp.getRcmdusr_startdate()==null)return false;
		
		//�ж��Ƿ����
		if(System.currentTimeMillis()>=pp.getRcmdusr_startdate().getTime()&&
				System.currentTimeMillis()<=pp.getRcmdusr_enddate().getTime()){
			return true ;
		}else{
			return false ;
		}
	}
	
	/**
	 * ���һ���������ϸ
	 * @param productId - ��ƷID
	 * @param dxid - ��֪����
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
