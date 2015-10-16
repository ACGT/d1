package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.TicketFlag;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class TicketFlagHelper {
	/**
	 * 判断券是否是不返利券、新会员券或限制会员使用张数券
	 * @param card_no
	 * @param validflag
	 * @return
	 */
	public static boolean existsTicketFlag(String card_no,Long validflag){
		if(Tools.isNull(card_no))return false;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("tktflag_validflag", validflag));
		
		List<BaseEntity> list = Tools.getManager(TicketFlag.class).getList(listRes, null, 0, 2000);
		
		if(list==null||list.size()==0)return false;
		
		for(BaseEntity be:list){
			TicketFlag tf = (TicketFlag)be;
			if(card_no.startsWith(tf.getTktflag_cardnot()))return true;
		}
		return false ;
	}
}
