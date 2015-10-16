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
 * Ԥ�����������
 *
 */
public class PrepayHelper {
	
	/**
	 * ����userId��ȡʣ��Ԥ���
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
	 * ��ȡԤ����ܼ���Ľ�����������ܼۣ���������˷ѣ�����ȯ��Ȼ����Ԥ��
	 * @param request
	 * @param response
	 * @param ticket_id ʹ�õ��Ż�ȯid�����û�ѡ����Ż�ȯ
	 * @param ticket_type ʹ��ȯ�����ͣ�0��ʾ����ȯ��1��ʾ�ۿ�ȯ��2��ʾƷ�Ƽ��⣬���������ʾû��ʹ���Ż�ȯ����ticket_type=2ʱ���Ͳ����ticket_id��
	 * @param address_id �û�ѡ��ĵ�ַ
	 * @param payid �û�ѡ���֧����ʽ
	 * @return
	 */
	public static float getMaxPrepaySaveMoney(HttpServletRequest request,HttpServletResponse response,
			String ticket_id,String ticket_type,String address_id,String payid){
		User loginUser = UserHelper.getLoginUser(request, response);
		if(loginUser==null)return 0f;
		
		//����ܴ�Eȯʡ�¶���Ǯ
		float max_save_money_from_ticket = TicketHelper.getMaxTicketSaveMoney(request, response, ticket_id+"", ticket_type+"", address_id+"", payid+"");
		max_save_money_from_ticket=Tools.getFloat(max_save_money_from_ticket, 0);
		float shipfee = OrderHelper.getExpressFee(request, response, address_id, payid,max_save_money_from_ticket);//�˷�	
		float gdsmoney = CartHelper.getTotalPayMoney(request, response);//��Ʒ�ܼ�

		if(gdsmoney+shipfee<max_save_money_from_ticket){
			max_save_money_from_ticket=gdsmoney+shipfee;
		}
		
		//����ܴ�Ԥ���ʡ�¶���Ǯ=��Ʒ�ܼ�+�˷�-Eȯʡ�µ�Ǯ
		float max_save_money_from_prepay = gdsmoney + shipfee - max_save_money_from_ticket;
		
		if(getPrepayBalance(loginUser.getId())<max_save_money_from_prepay){
			max_save_money_from_prepay = getPrepayBalance(loginUser.getId()) ;
		}
		
		return Tools.getFloat(max_save_money_from_prepay,2) ;
	}
	
}
