package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Gdscoll_Order;
import com.d1.bean.Cart;
import com.d1.bean.Product;
import com.d1.bean.PromotionProduct;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 搭配3.0订单对应帮助类
 * 
 * @author Administrator
 *
 */
public class Gdscoll_OrderHelper {
	/***
	 * 根据订单号获取数据
	 * 
	 * @param odrid
	 * @return
	 */
    public static ArrayList<Gdscoll_Order> getGdscoll_OrderByOrdid(String odrid){
    	if(odrid==null||odrid.length()<=0) return null;
        ArrayList<Gdscoll_Order> rlist = new ArrayList<Gdscoll_Order>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("go_odrid", odrid));
		List<BaseEntity> list = Tools.getManager(Gdscoll_Order.class).getList(clist, null, 0, 100);
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Gdscoll_Order)be);
		}
		return rlist ;
    	
    }
	
	
}
