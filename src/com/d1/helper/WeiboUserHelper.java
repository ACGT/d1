package com.d1.helper;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.WeiboUser;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 微博登录的记录
 * @author chengang
 * @createTime 2011年11月13日10:52:14
 *
 */
public class WeiboUserHelper {
	
	public static BaseManager manager = Tools.getManager(WeiboUser.class);
	
	/**
	 * 根据ID获得对象
	 * @param id - ID
	 * @return WeiboUser
	 */
	public static WeiboUser getById(String id){
		if(Tools.isNull(id)) return null;
		return (WeiboUser)manager.get(id);
	}
	
	/**
	 * 根据微博ID和类型获得对象
	 * @param name - 微博ID
	 * @param flag - 微博名称 - sinawb or sohuwb or ...
	 * @return WeiboUser
	 */
	public static WeiboUser getByName(String name , String flag){
		if(Tools.isNull(name) || Tools.isNull(flag)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("weibombr_name", name));
		listRes.add(Restrictions.eq("weibombr_flag", flag));
		
		List list = manager.getList(listRes, null, 0, 1);
		
		if(list == null || list.isEmpty()) return null;
		
		return (WeiboUser)list.get(0);
	}
	
	/**
	 * 数据库中是否存在此微博的信息记录
	 * @param name - 微博ID
	 * @param flag - 微博名称 - sinawb or sohuwb or ...
	 * @return True or False
	 */
	public static boolean isExist(String name , String flag){
		return getByName(name , flag) != null?true:false;
	}
	
	/**
	 * 微博生成的一个随机Code
	 * @param codeCount - 随机数长度
	 * @return String
	 */
	public static String createRandomCode(int codeCount){
	    String allChar = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,X,Y,Z";
	    //里面的字符你可以自己加啦
	    String[] allCharArray = allChar.split(",");
	    String randomCode = "";
	    int temp = -1;
	    Random random = new Random();
	    for (int i = 0; i < codeCount; i++)
	    {
	        if (temp != -1)
	        {
	            random = new Random(i * temp * (int)System.currentTimeMillis());
	        }
	        int t = random.nextInt(35);
	        if (temp == t)
	        {
	            return createRandomCode(codeCount);
	        }
	        temp = t;
	        randomCode += allCharArray[temp];
	    }
	    return randomCode;
	}

}
