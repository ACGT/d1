package com.d1.helper;

import com.d1.bean.Resource;
import com.d1.util.Tools;

/**
 * 得到source文件版本
 * @author kk
 */
public class ResourceHelper {
	/**
	 * 获得资源文件的版本号，当数据库更新时自动更新
	 * @param resource 文件路径
	 * @return
	 */
	public static String getResourceVersion(String resource){
		if(Tools.isNull(resource))return "";
		Resource r = (Resource)Tools.getManager(Resource.class).get(resource);
		if(r==null)return resource;
		return resource+"?"+r.getCurrentVersion();
	}
}
