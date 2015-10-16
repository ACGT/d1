package com.d1.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Directory;
import com.d1.bean.ProductStandard;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;
import com.d1.util.Tools;

/**
 * 商品规格辅助类
 * @author chengang
 * @creatTime 2011-10-29 12:41:20
 *
 */
public class ProductStandardHelper {
	
	public static final BaseManager manager = Tools.getManager(ProductStandard.class);
	
	/**
	 * 通过ID找到对象
	 * @param id
	 * @return ProductStandard
	 */
	public static ProductStandard getById(String id) {
		if(Tools.isNull(id)) return null;
		return (ProductStandard)manager.get(id);
	}
	/**
	 * 获取所有规格
	 */
	public static ArrayList<ProductStandard> getAllStandard(){
		ArrayList<ProductStandard> list2=new ArrayList<ProductStandard>(); 
		 List<BaseEntity> list=	Tools.getManager(ProductStandard.class).getList(null, null, 0, 200);
	 if(list==null || list.size()==0) return null;
		for(BaseEntity be:list){	 
			list2.add((ProductStandard)be);
		}
	 return list2;
	}
	
	/**
	 * 根据商品分类获得商品的规格
	 * @param rackcode - 商品的分类
	 * @return List<ProductStandardHelper.Standard>
	 */
	public static List<ProductStandardHelper.Standard> getGGByRackcode(String rackcode){
		if(Tools.isNull(rackcode)) return null;
		List<SimpleExpression> listRes = new ArrayList<SimpleExpression>();
		//listRes.add(Restrictions.like("id", rackcode+"%"));
		listRes.add(Restrictions.eq("id", rackcode));
		List list = Tools.getManager(Directory.class).getList(listRes, null, 0, 1000);
		
		if(list == null || list.isEmpty()) return null;
		
		int size = list.size();
		
		Map<String,Standard> standMap = new HashMap<String,Standard>();
		
		for(int i=0;i<size;i++){
			Directory dir = (Directory)list.get(i);
			ProductStandard ps = getById(dir.getRakmst_stdid());
			if(ps == null) continue;
			String atrname1 = ps.getStdmst_atrname1();
			if(!Tools.isNull(atrname1) && standMap.get(atrname1) == null){
				Standard s = getStandard(ps.getStdmst_showflag1(),atrname1,ps.getStdmst_atrdtl1(),1);
				if(s != null) standMap.put(atrname1, s);
			}
			String atrname2 = ps.getStdmst_atrname2();
			if(!Tools.isNull(atrname2) && standMap.get(atrname2) == null){
				Standard s = getStandard(ps.getStdmst_showflag2(),atrname2,ps.getStdmst_atrdtl2(),2);
				if(s != null) standMap.put(atrname2, s);
			}
			String atrname3 = ps.getStdmst_atrname3();
			if(!Tools.isNull(atrname3) && standMap.get(atrname3) == null){
				Standard s = getStandard(ps.getStdmst_showflag3(),atrname3,ps.getStdmst_atrdtl3(),3);
				if(s != null) standMap.put(atrname3, s);
			}
			String atrname4 = ps.getStdmst_atrname4();
			if(!Tools.isNull(atrname4) && standMap.get(atrname4) == null){
				Standard s = getStandard(ps.getStdmst_showflag4(),atrname4,ps.getStdmst_atrdtl4(),4);
				if(s != null) standMap.put(atrname4, s);
			}
			String atrname5 = ps.getStdmst_atrname5();
			if(!Tools.isNull(atrname5) && standMap.get(atrname5) == null){
				Standard s = getStandard(ps.getStdmst_showflag5(),atrname5,ps.getStdmst_atrdtl5(),5);
				if(s != null) standMap.put(atrname5, s);
			}
			String atrname6 = ps.getStdmst_atrname6();
			if(!Tools.isNull(atrname6) && standMap.get(atrname6) == null){
				Standard s = getStandard(ps.getStdmst_showflag6(),atrname6,ps.getStdmst_atrdtl6(),6);
				if(s != null) standMap.put(atrname6, s);
			}
			String atrname7 = ps.getStdmst_atrname7();
			if(!Tools.isNull(atrname7) && standMap.get(atrname7) == null){
				Standard s = getStandard(ps.getStdmst_showflag7(),atrname7,ps.getStdmst_atrdtl7(),7);
				if(s != null) standMap.put(atrname7, s);
			}
			String atrname8 = ps.getStdmst_atrname8();
			if(!Tools.isNull(atrname8) && standMap.get(atrname8) == null){
				Standard s = getStandard(ps.getStdmst_showflag8(),atrname8,ps.getStdmst_atrdtl8(),8);
				if(s != null) standMap.put(atrname8, s);
			}
			String atrname9 = ps.getStdmst_atrname9();
			if(!Tools.isNull(atrname9) && standMap.get(atrname9) == null){
				Standard s = getStandard(ps.getStdmst_showflag9(),atrname9,ps.getStdmst_atrdtl9(),9);
				if(s != null) standMap.put(atrname9, s);
			}
			String atrname10 = ps.getStdmst_atrname10();
			if(!Tools.isNull(atrname10) && standMap.get(atrname10) == null){
				Standard s = getStandard(ps.getStdmst_showflag10(),atrname10,ps.getStdmst_atrdtl10(),10);
				if(s != null) standMap.put(atrname10, s);
			}
			String atrname11 = ps.getStdmst_atrname11();
			if(!Tools.isNull(atrname11) && standMap.get(atrname11) == null){
				Standard s = getStandard(ps.getStdmst_showflag11(),atrname11,ps.getStdmst_atrdtl11(),11);
				if(s != null) standMap.put(atrname11, s);
			}
			String atrname12 = ps.getStdmst_atrname12();
			if(!Tools.isNull(atrname12) && standMap.get(atrname12) == null){
				Standard s = getStandard(ps.getStdmst_showflag12(),atrname12,ps.getStdmst_atrdtl12(),12);
				if(s != null) standMap.put(atrname12, s);
			}
		}
		
		List<Standard> standList = null;
		if(standMap != null && !standMap.isEmpty()){
			standList = new ArrayList<Standard>();
			Iterator<String> it = standMap.keySet().iterator();
			while(it.hasNext()){
				standList.add(standMap.get(it.next()));
			}
		}
		
		return standList;
	}
	
	/**
	 * 创建规格。
	 * @param showFlag - 
	 * @param atrname -
	 * @param atrdtl - 
	 * @param c - 
	 * @return Standard
	 */
	private static Standard getStandard(long showFlag,String atrname , String atrdtl , int c){
		Standard s = null;
		if(showFlag == 2){
			s = new Standard();
			s.setAtrFlag(c);
			s.setAtrname(atrname);
			s.setAtrdtl(atrdtl);
		}
		return s;
	}
	
	/**
	 * 商品的规格
	 * @author chengang
	 *
	 */
	public static class Standard{
		private long atrFlag;
		private String atrname;
		private String atrdtl;
		
		public Standard(){}
		
		public long getAtrFlag() {
			return atrFlag;
		}
		public void setAtrFlag(long atrFlag) {
			this.atrFlag = atrFlag;
		}
		public String getAtrname() {
			return atrname;
		}
		public void setAtrname(String atrname) {
			this.atrname = atrname;
		}
		public String getAtrdtl() {
			return atrdtl;
		}
		public void setAtrdtl(String atrdtl) {
			this.atrdtl = atrdtl;
		}
	}

}
