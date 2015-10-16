package com.d1.helper;

import com.d1.bean.ProductRelated;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * xxx������
 * @author chengang
 * @createTime 2011-11-18 15:59:36
 *
 */
public class ProductRelatedHelper {
	
	public static final BaseManager manager = Tools.getManager(ProductRelated.class);
	
	/**
	 * ����ID��ö���
	 * @param id - ID
	 * @return ProductRelated
	 */
	public static ProductRelated getById(String id){
		if(Tools.isNull(id)) return null;
		return (ProductRelated)manager.get(id);
	}

}
