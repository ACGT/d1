package com.d1.helper;

import com.d1.bean.Resource;
import com.d1.util.Tools;

/**
 * �õ�source�ļ��汾
 * @author kk
 */
public class ResourceHelper {
	/**
	 * �����Դ�ļ��İ汾�ţ������ݿ����ʱ�Զ�����
	 * @param resource �ļ�·��
	 * @return
	 */
	public static String getResourceVersion(String resource){
		if(Tools.isNull(resource))return "";
		Resource r = (Resource)Tools.getManager(Resource.class).get(resource);
		if(r==null)return resource;
		return resource+"?"+r.getCurrentVersion();
	}
}
