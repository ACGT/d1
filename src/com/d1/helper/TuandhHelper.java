package com.d1.helper;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Tuandh;
import com.d1.bean.WeiboUser;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;


public class TuandhHelper {
     public static BaseManager manager = Tools.getManager(Tuandh.class);
     
     /**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return Tuandh
	 */
	public static Tuandh getById(String id){
		if(Tools.isNull(id)) return null;
		return (Tuandh)manager.get(id);
	}
	
	public static Tuandh getTuandhByCardno(String cardno)
	{
	   if(Tools.isNull(cardno)||cardno.length()<=0)
	   {
		   return null;
	   }
	   else
	   {
		    List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
			listRes.add(Restrictions.eq("tuandh_cardno", cardno));
			
			List list = manager.getList(listRes, null, 0, 1);
			
			if(list == null || list.isEmpty()) return null;
			
			return (Tuandh)list.get(0);
	   }
	}
 
}