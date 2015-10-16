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
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return UserAddress
	 */
	public static UserAddress getById(String id) {
		if(Tools.isNull(id)) return null;
		return (UserAddress)manager.get(id);
	}
	
	/**
	 * ����userid��ȡ��ַ�б�
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
	 * ����û��ĵ�ַ����
	 * @param userId - �û�ID
	 * @return int
	 */
	public static int getUserAddressLength(String userId){
		if(!Tools.isMath(userId)) return 0;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("mbrcst_mbrid", new Long(userId)));
		
		return manager.getLength(clist);
	}
	
	/**
	 * �û��û��ĵ�ַ������ID
	 * @param userId - �û�ID
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
	 * �õ����˵ĵ�ַ��rthird==0��ʾ�Ǳ��˵ĵ�ַ
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
	 * �ж�һ����ַ�Ƿ�֧�ֻ����������cityshipfee���жϣ�
	 * @param userAddressId UserAddress id
	 * @return
	 */
	public static boolean supportPayAfterReceived(String userAddressId){
		UserAddress ua = (UserAddress)Tools.getManager(UserAddress.class).get(userAddressId);
		if(ua==null)return false ;
		
		Long cityId = ua.getMbrcst_cityid();
		CityShipFee csf = (CityShipFee)Tools.getManager(CityShipFee.class).findByProperty("cityid", cityId);
		
		if(csf==null)return false;
		
		//Ifcanhf�ֶ�ֵΪ1��ʾ֧�ֻ�������
		if(csf.getIfcanhf()!=null&&csf.getIfcanhf().longValue()==1)return true ;
		
		return false ;
	}
	
	/**
	 * �ж�һ���û��Ƿ�����ͬ�������͵�ַ
	 * @param userId - �û���ID
	 * @param addressId - ��ַ��ID�����������ӵ�ַ����Ϊ0
	 * @param name - ����
	 * @param address - ��ַ
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
