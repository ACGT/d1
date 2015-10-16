package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.TicketInfo;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 优惠信息辅助类
 * @author chengang
 * @createTime 2011-10-31 21:47:18
 *
 */
public class TicketInfoHelper {
	
	public static BaseManager manager = Tools.getManager(TicketInfo.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return TicketInfo
	 */
	public static TicketInfo getById(String id){
		if(Tools.isNull(id)) return null;
		return (TicketInfo)manager.get(id);
	}
	
	/**
	 * 根据商品分类获取最新优惠的内容
	 * @param rackcode - 商品的类别
	 * @param brandName - 商品品牌
	 * @param count - 取的内容数量
	 * @return List<TicketInfo>
	 * @deprecated 此方法已经作废
	 * @see YhNewsHelper
	 */
	public static List<TicketInfo> getYHListByRackcode(String rackcode , String brandName , int count){
		List<TicketInfo> infoList = null;

		boolean bransIsNull = Tools.isNull(brandName);
		if(!Tools.isNull(rackcode)){
			List<Order> listOrder = new ArrayList<Order>();
			listOrder.add(Order.asc("seq"));
			
			List list = manager.getList(null, listOrder, 0, 100);
			
			if(list == null || list.isEmpty()) return null;
			
			infoList = new ArrayList<TicketInfo>();
			
			int rackCodeLen = rackcode.length();
			
			int size = list.size();
			for(int i=0;i<size;i++){
				TicketInfo info = (TicketInfo)list.get(i);
				String yhrackcodeid = info.getYhrackcodeid();
				boolean isAdd = false;
				if(yhrackcodeid != null){
					for(int j=3;j<=rackCodeLen;j++){
						if (j != rackcode.length()){
							if(yhrackcodeid.startsWith(rackcode.substring(0,j))){
								infoList.add(info);
								isAdd = true;
								break;
							}
						}else{
							if(yhrackcodeid.equals(rackcode)){
								infoList.add(info);
								isAdd = true;
								break;
							}
						}
					}
				}
				if(!bransIsNull && !isAdd){
					if(brandName.equals(info.getYhbrandname())){
						infoList.add(info);
					}
				}
				if(infoList.size()>=count) break;
			}
		}else{
			if(!bransIsNull){
				List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
				listRes.add(Restrictions.eq("yhbrandname", brandName));
				
				List<Order> listOrder = new ArrayList<Order>();
				listOrder.add(Order.asc("seq"));
				
				List list = manager.getList(listRes, listOrder, 0, 100);
				
				if(list != null && !list.isEmpty()){
					infoList = new ArrayList<TicketInfo>();
					
					int size = list.size();
					for(int i=0;i<size;i++){
						TicketInfo info = (TicketInfo)list.get(i);
						infoList.add(info);
					}
				}
			}
		}
		return infoList;
	}

}
