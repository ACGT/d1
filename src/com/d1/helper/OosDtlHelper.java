package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.OosDtl;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 缺货通知表
 * @author chengang
 * @crateTime 2011-11-30 17:43:57
 *
 */
public class OosDtlHelper {
	
	public static BaseManager manager = Tools.getManager(OosDtl.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return OosDtl
	 */
	public static OosDtl getById(String id){
		if(Tools.isNull(id)) return null;
		return (OosDtl)manager.get(id);
	}
	
	/**
	 * 查看某个邮件是否申请了到货通知。
	 * @param productId - 物品ID
	 * @param email - Emial
	 * @param status - 装填，0未发送状态，1已发送
	 * @return OosDtl
	 */
	public static OosDtl getByGdsEmail(String productId , String email , long status){
		if(Tools.isNull(productId) || Tools.isEmail(email)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("oosdtl_gdsid", productId));
		listRes.add(Restrictions.eq("oosdtl_email", email));
		listRes.add(Restrictions.eq("oosdtl_status", new Long(status)));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (OosDtl)list.get(0);
	}
	
	/**
	 * 创建一个申请到货通知
	 * @param productId - 物品ID
	 * @param email - Email
	 * @return OosDtl
	 */
	public static OosDtl createOosDtl(String productId , String email){
		if(Tools.isNull(productId) || !Tools.isEmail(email)) return null;
		
		OosDtl oo = getByGdsEmail(productId , email , 0);
		
		if(oo != null) return oo;
		
		oo = new OosDtl();
		oo.setOosdtl_createdate(new Date());
		oo.setOosdtl_email(email);
		oo.setOosdtl_gdsid(productId);
		oo.setOosdtl_status(new Long(0));
		
		return (OosDtl)manager.create(oo);
	}

}
