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
 * 商品分类表辅助类
 * @author chengang
 * @createTime 2011-10-24 22:47:48
 *
 */
public class DirectoryHelper {
	
	public static final BaseManager manager = Tools.getManager(Directory.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return Directory
	 */
	public static Directory getById(String id) {
		if(Tools.isNull(id)) return null;
		return (Directory)manager.get(id);
	}

	/**
	 * 通过上一级商品分类找到对象
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
	//获得根目录
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
	 * 通过上一级商品分类找到对象
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
	 * 通过上一级商品分类找到对象(南方)
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
