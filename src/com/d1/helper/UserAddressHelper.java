package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.CityShipFee;
import com.d1.bean.UserAddress;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

public class UserAddressHelper {
	
	public static final BaseManager manager = Tools.getManager(UserAddress.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return UserAddress
	 */
	public static UserAddress getById(String id) {
		if(Tools.isNull(id)) return null;
		return (UserAddress)manager.get(id);
	}
	
	/**
	 * 根据userid获取地址列表
	 * @param userId
	 * @return
	 */
	public static ArrayList<UserAddress> getUserAddressList(String userId){
		
		if(userId==null||!StringUtils.isDigits(userId))return null;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
		
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("createdate"));
		
		List<BaseEntity> list = Tools.getManager(UserAddress.class).getList(clist, olist, 0, 100);
		if(list==null||list.size()==0)return null ;
		
		ArrayList<UserAddress> rlist = new ArrayList<UserAddress>();
		for(BaseEntity be:list){
			rlist.add((UserAddress)be);
		}
		return rlist ;
	}
	
	/**
	 * 获得用户的地址长度
	 * @param userId - 用户ID
	 * @return int
	 */
	public static int getUserAddressLength(String userId){
		if(!Tools.isMath(userId)) return 0;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
		
		return manager.getLength(clist);
	}
	
	/**
	 * 用户用户的地址的最大的ID
	 * @param userId - 用户ID
	 * @return long
	 */
	public static long getUserMaxId(String userId){
		long max = 0;
		List<UserAddress> list = getUserAddressList(userId);
		if(list != null && !list.isEmpty()){
			for(UserAddress add : list){
				long id = Tools.longValue(add.getMbrcst_id());
				if(id > max){
					max = id;
				}
			}
		}
		return max+1;
	}
	
	/**
	 * 得到本人的地址，rthird==0表示是本人的地址
	 * @param userId
	 * @return
	 */
	public static UserAddress getOwnUserAddress(String userId){
		ArrayList<UserAddress> list = getUserAddressList(userId);
		if(list==null||list.size()==0)return null;
		for(UserAddress ua:list){
			if(ua.getMbrcst_rthird()!=null&&ua.getMbrcst_rthird()==0){
				return ua ;
			}
		}
		return null ;
	}
	
	/**
	 * 判断一个地址是否支持货到付款，根据cityshipfee表判断！
	 * @param userAddressId UserAddress id
	 * @return
	 */
	public static boolean supportPayAfterReceived(String userAddressId){
		UserAddress ua = (UserAddress)Tools.getManager(UserAddress.class).get(userAddressId);
		if(ua==null)return false ;
		
		Long cityId = ua.getMbrcst_cityid();
		CityShipFee csf = (CityShipFee)Tools.getManager(CityShipFee.class).findByProperty("cityid", cityId);
		
		if(csf==null)return false;
		
		//Ifcanhf字段值为1表示支持货到付款
		if(csf.getIfcanhf()!=null&&csf.getIfcanhf().longValue()==1)return true ;
		
		return false ;
	}
	
	/**
	 * 判断一个用户是否有相同的姓名和地址
	 * @param userId - 用户的ID
	 * @param addressId - 地址的ID，如果是新添加地址，则为0
	 * @param name - 姓名
	 * @param address - 地址
	 * @return True or False
	 */
	public static boolean isSameAddress(String userId , String addressId , String name , String address){
		if(name == null || address == null) return false;
		
		ArrayList<UserAddress> list = getUserAddressList(userId);
		if(list == null || list.isEmpty()) return false;
		
		for(UserAddress ua : list){
			if(!ua.getId().equals(addressId)){
				if(name.equals(ua.getMbrcst_name()) && address.equals(ua.getMbrcst_raddress())){
					return true;
				}
			}
		}
		
		return false;
	}
	
}
