package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;

import com.d1.bean.ProductSale;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * �����Ṥ����
 * @author zpp
 *
 */
public class ProductSaleHelper {
	
	/**
	 * ��������Ʒ��ȫȡ������һ������200��
	 * @return
	 */
	public static ArrayList<ProductSale> getAllProductSales(){
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("salesmst_seq"));
		olist.add(Order.desc("id"));
		List<BaseEntity> list = Tools.getManager(ProductSale.class).getList(null, olist, 0, 1000);
		
		ArrayList<ProductSale> rlist = new ArrayList<ProductSale>();
		if(list!=null){
			for(BaseEntity b:list){
				rlist.add((ProductSale)b);
			}
		}
		
		return rlist ;
	}
	/**
	 * ������Ʒ�б�
	 *
	 */
	public static ArrayList<ProductSale> getTodayProductSaleList(){
		ArrayList<ProductSale> rlist = new ArrayList<ProductSale>();
		
		ArrayList<ProductSale> list = getAllProductSales();
		if(list!=null){
			for(ProductSale ps:list){
				if(ps.getSalesmst_validflag()!=null&&ps.getSalesmst_validflag().longValue()==1
					&&ps.getSalesmst_starttime()!=null&&ps.getSalesmst_endtime()!=null){
						if(ps.getSalesmst_starttime().getTime()<System.currentTimeMillis()&&
								ps.getSalesmst_endtime().getTime()>System.currentTimeMillis()){
							rlist.add(ps);
					}
				}
			}
		}
		
		/*
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("salesmst_validflag", new Long(1)));
		
		clist.add(Restrictions.lt("salesmst_starttime", new Date()));
		clist.add(Restrictions.ge("salesmst_endtime", new Date()));
		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("salesmst_seq"));
		olist.add(Order.desc("id"));
		List<BaseEntity> list = Tools.getManager(ProductSale.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductSale)be);
		}
		*/
		
		return rlist ;
	}
	
	/**
	 * ����id��ѯ������Ʒ��Ϣ
	 *
	 */
	public static ArrayList<ProductSale> getProductInfoById(String id){
		ArrayList<ProductSale> rlist = new ArrayList<ProductSale>();
		
		ArrayList<ProductSale> list = getAllProductSales();
		if(list!=null){
			for(ProductSale ps:list){
				if(ps.getSalesmst_validflag()!=null&&ps.getSalesmst_validflag().longValue()==1
					&&ps.getSalesmst_starttime()!=null&&ps.getSalesmst_endtime()!=null){
						if(ps.getSalesmst_starttime().getTime()<System.currentTimeMillis()&&
								ps.getSalesmst_endtime().getTime()>System.currentTimeMillis()){
							if(ps.getId().equals(id))rlist.add(ps);
					}
				}
			}
		}
		
		/*
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("salesmst_validflag", new Long(1)));
		clist.add(Restrictions.eq("id", id));
		clist.add(Restrictions.lt("salesmst_starttime", new Date()));
		clist.add(Restrictions.ge("salesmst_endtime", new Date()));
		
		List<BaseEntity> list = Tools.getManager(ProductSale.class).getList(clist, null, 0, 100);
		
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductSale)be);
		}
		*/
		return rlist ;
	}
}
