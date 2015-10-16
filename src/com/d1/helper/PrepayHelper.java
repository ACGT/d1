package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Prepay;
import com.d1.bean.User;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 预付款操作工具
 *
 */
public class PrepayHelper {
	
	/**
	 * 根据userId获取剩余预存款
	 * @param userId
	 * @return
	 */
	public static float getPrepayBalance(String userId){
		if(Tools.isNull(userId))return 0f;
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("prepay_mbrid", new Long(userId)));
		clist.add(Restrictions.eq("prepay_status", new Long(0)));
		
		List<BaseEntity> list = Tools.getManager(Prepay.class).getList(clist,null,0,1000);
		if(list==null||list.size()==0)return 0f;
		float res = 0f ;
		
		for(BaseEntity be:list){
			Prepay p = (Prepay)be;
			if(p.getPrepay_value()!=null)res+=p.getPrepay_value().floatValue();
		}
		return Tools.getFloat(res, 2);
	}
	
	/**
	 * 获取预存款能减免的金额，用于最后算总价，这里包含运费！先用券，然后用预存款！
	 * @param request
	 * @param response
	 * @param ticket_id 使用的优惠券id，即用户选择的优惠券
	 * @param ticket_type 使用券的类型，0表示减免券，1表示折扣券，2表示品牌减免，其他情况表示没有使用优惠券。当ticket_type=2时，就不会管ticket_id了
	 * @param address_id 用户选择的地址
	 * @param payid 用户选择的支付方式
	 * @return
	 */
	public static float getMaxPrepaySaveMoney(HttpServletRequest request,HttpServletResponse response,
			String ticket_id,String ticket_type,String address_id,String payid){
		User loginUser = UserHelper.getLoginUser(request, response);
		if(loginUser==null)return 0f;
		
		//最多能从E券省下多少钱
		float max_save_money_from_ticket = TicketHelper.getMaxTicketSaveMoney(request, response, ticket_id+"", ticket_type+"", address_id+"", payid+"");
		max_save_money_from_ticket=Tools.getFloat(max_save_money_from_ticket, 0);
		float shipfee = OrderHelper.getExpressFee(request, response, address_id, payid,max_save_money_from_ticket);//运费	
		float gdsmoney = CartHelper.getTotalPayMoney(request, response);//商品总价

		if(gdsmoney+shipfee<max_save_money_from_ticket){
			max_save_money_from_ticket=gdsmoney+shipfee;
		}
		
		//最多能从预存款省下多少钱=商品总价+运费-E券省下的钱
		float max_save_money_from_prepay = gdsmoney + shipfee - max_save_money_from_ticket;
		
		if(getPrepayBalance(loginUser.getId())<max_save_money_from_prepay){
			max_save_money_from_prepay = getPrepayBalance(loginUser.getId()) ;
		}
		
		return Tools.getFloat(max_save_money_from_prepay,2) ;
	}
	
}
