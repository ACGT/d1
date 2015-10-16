package com.d1.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Comment;
import com.d1.bean.CommentCache;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.StringUtils;
import com.d1.util.Tools;

/**
 * ��Ʒ���۱�����
 * @author chengang
 * @createTime 2011-10-27 22:02:55
 *
 */
public class CommentHelper {
	
	public static final BaseManager manager = Tools.getManager(Comment.class);
	
	public static final BaseManager cacheManager = Tools.getManager(CommentCache.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return Comment
	 */
	public static Comment getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Comment)manager.get(id);
	}
	
	/**
	 * ͨ����ƷID������۵ĳ���
	 * @param productId - ��ƷID
	 * @return int
	 */
	public static int getCommentLength(String productId){
		if(Tools.isNull(productId)) return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
		//listRes.add(Restrictions.eq("gdscom_checkStatue", new Long(1)));
		return manager.getLength(listRes);
	}
	
	/**
	 * ��ö�Ӧ��Ʒ��������Ϣ���������ҳ����ʾ״̬Ϊ1��
	 * @param productId - ��ƷID
	 * @param start - ��ʼ
	 * @param length - ����
	 * @return List<Comment>
	 */
	public static List getCommentList(String productId , int start , int length){
		if(Tools.isNull(productId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
		//listRes.add(Restrictions.eq("gdscom_checkStatue", new Long(1)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdscom_createdate"));
		
		return manager.getList(listRes, listOrder, start, length);
	}
	
	/**
	 * �����߷���������Ϣ���������ҳ����ʾ״̬Ϊ1��
	 * @param productId - ��ƷID
	 * @param start - ��ʼ
	 * @param length - ����
	 * @return List<Comment>
	 */
	public static List getCommentListByLevel(String productId , int start , int length){
		if(Tools.isNull(productId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
		//listRes.add(Restrictions.eq("gdscom_checkStatue", new Long(1)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdscom_level"));
		listOrder.add(Order.desc("gdscom_createdate"));
		
		return manager.getList(listRes, listOrder, start, length);
	}
	
	
	
	
	public static List getCommentList(String productId){
		if(Tools.isNull(productId)) return null;
		
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_status", new Long(1)));
		//listRes.add(Restrictions.eq("gdscom_checkStatue", new Long(1)));
		List<Order> listOrder = new ArrayList<Order>();
		listOrder.add(Order.desc("gdscom_createdate"));
		
		return manager.getList(listRes, listOrder, 0, 1000);
	}
	
	/**
	 * ���ݴ�ֵĵȼ���ó���
	 * @param productId - ��ƷID
	 * @param level - �ȼ�
	 * @return int
	 */
	public static int getCommentLevelCount(String productId , long level){
		if(Tools.isNull(productId)) return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		//listRes.add(Restrictions.ne("gdscom_status", new Long(2)));
		listRes.add(Restrictions.eq("gdscom_level", new Long(level)));
		
		return manager.getLength(listRes);
	}
	
	/**
	 * ���ݴ�ֵĵȼ���û������۵ĳ���
	 * @param productId - ��ƷID
	 * @param level - �ȼ�
	 * @return int
	 */
	public static int getCacheCommentLevelCount(String productId , long level){
		if(Tools.isNull(productId)) return 0;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		listRes.add(Restrictions.eq("gdscom_gdsid", productId));
		listRes.add(Restrictions.eq("gdscom_level", new Long(level)));
		
		return cacheManager.getLength(listRes);
	}
	
	/**
	 * ������۵ȼ���ƽ����
	 * @param productId - ��ƷID
	 * @return double
	 */
	public static double getCommentLevel(String productId){
		if(Tools.isNull(productId)) return 0;
		
		int score_5 = getCommentLevelCount(productId , 5);
		int score_4 = getCommentLevelCount(productId , 4);
		int score_3 = getCommentLevelCount(productId , 3);
		int score_2 = getCommentLevelCount(productId , 2);
		int score_1 = getCommentLevelCount(productId , 1);
		
		score_5 += getCacheCommentLevelCount(productId , 5);
		score_4 += getCacheCommentLevelCount(productId , 4);
		score_3 += getCacheCommentLevelCount(productId , 3);
		score_2 += getCacheCommentLevelCount(productId , 2);
		score_1 += getCacheCommentLevelCount(productId , 1);
		return (score_5 + score_4 * 0.8 + score_3 * 0.6 + score_2 * 0.4 + score_1 * 0.2) / (score_1 + score_2 + score_3 + score_4 + score_5);
	}
	
	/**
	 * ��Ʒ�����Ǽ���ʾ
	 * @param productId - ��ƷID
	 * @return int
	 */
    public static int getLevelView(String productId){
        double score= getCommentLevel(productId);
        int avgscore=0;
        try{
        avgscore=(int)(score * 10);
        }catch(Exception ex)
        {
        	avgscore=0;
        }
        return avgscore;
    }
    
    /**
     *��ȡ�����˵����䣨����ȫ�ԣ� 
     *
     * @param gdscom_uid ��Աid
     * @return �µĻ�Աuid
     */
    public static String GetCommentUid(String gdscom_uid)
    {
    	if(Tools.isNull(gdscom_uid)) return "";
    	String str=gdscom_uid.trim();
    	if(str==null)str="";
    	return "***"+StringUtils.getCnSubstring(str,0,10);
    }

    /**
     * ��ȡ���ҵ����ۡ�
     */
public static List getMyCommentList(Long mbrid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdscom_createdate"));
	return manager.getList(listRes, listOrder, 0, 1000);
}
public static List getMyCacheCommentList(Long mbrid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	List<Order> listOrder = new ArrayList<Order>();
	listOrder.add(Order.desc("gdscom_createdate"));
	return cacheManager.getList(listRes, listOrder, 0, 1000);
}
public static List getMyNewCommentList(Long mbrid,String orderid){
	List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
	listRes.add(Restrictions.eq("gdscom_mbrid", mbrid));
	listRes.add(Restrictions.eq("gdscom_odrid", orderid));
	//listRes.add(Restrictions.eq("sessionid", sessionid));
	return manager.getList(listRes, null, 0, 1000);
}
//������
public static int getinCommentLength(String[] gdsarr){
	if(gdsarr.length==0) return 0;
	int comcount=0;
	for(int j=0;j<gdsarr.length;j++){
		comcount+=getCommentLength(gdsarr[j]);
	}
	return  comcount;
}
//�����б�
public static List getinCommentList2(String[] gdsarr, int count){
	if(gdsarr.length==0) return null;
	ArrayList<Comment> list=new ArrayList<Comment>();
    for(int j=0;j<gdsarr.length;j++){
  	  List<Comment> commentlist = getCommentList(gdsarr[j]);
		for(Comment comment:commentlist){
			list.add(comment);
		}
    }
	if(list==null || list.size()==0){
		return null;
	}
	//����
	Collections.sort(list,new CommentCreateTimeComparator());
	int i=0;
	ArrayList<Comment> list2=new ArrayList<Comment>();
	for(Comment comment:list){
		if(i<count){
			list2.add(comment);
		}
		i++;
	}
	return list2;

}
//�����б�
public static List getinCommentList(String[] gdsarr, int start , int length){
	if(gdsarr.length==0) return null;
	ArrayList<Comment> list=new ArrayList<Comment>();
  for(int j=0;j<gdsarr.length;j++){
	  List<Comment> commentlist = getCommentList(gdsarr[j]);
		for(Comment comment:commentlist){
			list.add(comment);
		}
  }
	if(list==null || list.size()==0){
		return null;
	}
	//����
	Collections.sort(list,new CommentCreateTimeComparator());
	
	ArrayList<Comment> newlist = new ArrayList<Comment>();
	
	for(int i=start;i<start+length&&i<list.size();i++){
		newlist.add(list.get(i));
	}
	return newlist;

}


}
class CommentCreateTimeComparator implements Comparator<Comment>{

	@Override
	public int compare(Comment p0, Comment p1) {
		if(p0.getGdscom_createdate()!=null&&p1.getGdscom_createdate()!=null){
			if(p0.getGdscom_createdate().getTime()>p1.getGdscom_createdate().getTime()){
				return -1 ;
			}else if(p0.getGdscom_createdate().getTime()==p1.getGdscom_createdate().getTime()){
				return 0 ;
			}else{
				return 1 ;
			}
		}
		return 0;
	}

}
