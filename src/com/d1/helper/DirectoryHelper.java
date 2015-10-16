package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Directory;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * ��Ʒ���������
 * @author chengang
 * @createTime 2011-10-24 22:47:48
 *
 */
public class DirectoryHelper {
	
	public static final BaseManager manager = Tools.getManager(Directory.class);
	
	/**
	 * ͨ��ID�ҵ�����
	 * @param id
	 * @return Directory
	 */
	public static Directory getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Directory)manager.get(id);
	}

	/**
	 * ͨ����һ����Ʒ�����ҵ�����
	 * @param parentrackcode
	 * @return Directory
	 */
	public static ArrayList<Directory> getByParentrackcode(String parentrackcode) {
		ArrayList<Directory> list=new ArrayList<Directory>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rakmst_parentrackcode", parentrackcode));
		clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
		clist.add(Restrictions.gt("rakmst_gdscount", new Long(0)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("rakmst_gdscount"));
		List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Directory)be);
			}
		}
		return list;
	}
	//��ø�Ŀ¼
	public static ArrayList<Directory> getParentrackcode() {
		ArrayList<Directory> list=new ArrayList<Directory>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rakmst_typeid", new Long(1)));
		clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
		List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, null, 0, 100);
		if(clist==null||clist.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Directory)be);
			}
		}
		return list;
	}
	/**
	 * ͨ����һ����Ʒ�����ҵ�����
	 * @param parentrackcode
	 * @return Directory
	 */
	public static ArrayList<Directory> getByParentcode(String parentrackcode) {
		ArrayList<Directory> list=new ArrayList<Directory>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rakmst_parentrackcode", parentrackcode));
		clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("rakmst_seq"));
		List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Directory)be);
			}
		}
		return list;
	}
	
	/**
	 * ͨ����һ����Ʒ�����ҵ�����(�Ϸ�)
	 * @param parentrackcode
	 * @return Directory
	 */
	public static ArrayList<Directory> getByParentcodeNorth(String parentrackcode) {
		ArrayList<Directory> list=new ArrayList<Directory>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("rakmst_parentrackcode", parentrackcode));
		clist.add(Restrictions.eq("rakmst_showflag", new Long(1)));
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.asc("rakmst_sounthseq"));
		List<BaseEntity> b_list = Tools.getManager(Directory.class).getList(clist, olist, 0, 100);
		if(clist==null||clist.size()==0)return null;
		if(b_list!=null){
			for(BaseEntity be:b_list){
				list.add((Directory)be);
			}
		}
		return list;
	}
	
	
}
