package com.d1.helper;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.ProductGroup;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * �Ź�������
 * @author kk
 *
 */
public class ProductGroupHelper {
	
	/**
	 * �õ����������Ź���Ʒ�б�
	 * @return
	 */
	public static ArrayList<ProductGroup> getTodayOtherProductGroups(){
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
		
		clist.add(Restrictions.lt("tgrpmst_starttime", new Date()));
		clist.add(Restrictions.ge("tgrpmst_endtime", new Date()));
		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_priority"));
		olist.add(Order.desc("id"));
		List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductGroup)be);
		}
		return rlist ;
	}
	/**
	 * �õ������Ź���Ʒ�б�
	 * @return
	 */
	public static ArrayList<ProductGroup> getTodayProductGroups(){
		//long today = Tools.getYesterdayTime(0)-1;//�����賿��ʱ��-1����
		//long tomorrow = today + Tools.DAY_MILLIS;//�����賿��ʱ��
		
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
		clist.add(Restrictions.eq("tgrpmst_priority", new Long(5)));
		
		//clist.add(Restrictions.gt("tgrpmst_starttime", new Date(today)));
		//clist.add(Restrictions.lt("tgrpmst_endtime", new Date(tomorrow)));
		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_priority"));
		olist.add(Order.desc("id"));
		List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			ProductGroup pg = (ProductGroup)be;
			long currentTime = System.currentTimeMillis();
			if(Tools.dateValue(pg.getTgrpmst_starttime()) < currentTime && Tools.dateValue(pg.getTgrpmst_endtime()) > currentTime){
				rlist.add(pg);
			}
		}
		return rlist ;
	}
	/**
	 *����id�Ź���Ʒ�б�
	 * @return
	 */
	public static ArrayList<ProductGroup> getProductGroupsById(String id){
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ne("tgrpmst_state", new Long(0)));
		clist.add(Restrictions.lt("tgrpmst_starttime", new Date()));
		clist.add(Restrictions.ge("tgrpmst_endtime", new Date()));
		clist.add(Restrictions.eq("id", id));

		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_priority"));
		olist.add(Order.desc("id"));
		List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductGroup)be);
		}
		return rlist ;
	}
	/**
	 *��id������Ź���Ʒ�б�
	 * @return
	 */
	public static ArrayList<ProductGroup> getOtherProductGroupsExcId(String id){
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
		clist.add(Restrictions.ne("id", id));

		
		//�������������������빺�ﳵʱ������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_priority"));

		List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, 0, 100);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductGroup)be);
		}
		return rlist ;
	}
	/**
	 *��ʷ�Ź���Ʒ�б�--��ҳ
	 * @return
	 */
	public static ArrayList<ProductGroup> getBeforeTodayProductGroups(int PageIndex,int pageSize){
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tgrpmst_state", new Long(2)));
		clist.add(Restrictions.le("tgrpmst_endtime", new Date()));

		
		//������������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_addtime"));

		List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, olist, (PageIndex-1)*pageSize, pageSize);
		
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((ProductGroup)be);
		}
		return rlist ;
	}
	/**
	 *����۸� ҳ����ʾ
	 * @return
	 */
	public static String getRoundPrice(float price){
		String strprice=price+"";
		String[] strlist=strprice.split("\\.");
		if(strlist.length>0){
		DecimalFormat df = new DecimalFormat("0.00");
		String str1=df.format(Double.parseDouble(strlist[0]) );
		String str2=df.format(Double.parseDouble(strprice) );
		if(str1.equals(str2)){

			return strlist[0];
		}
		}
		return strprice;
	}
	/**
	 *�����ʷ�Ź���Ʒ����
	 * @return
	 */
	public static int getPageCount(){
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.eq("tgrpmst_state", new Long(2)));
		clist.add(Restrictions.le("tgrpmst_endtime", new Date()));

		//������������
		List<Order> olist = new ArrayList<Order>();
		olist.add(Order.desc("tgrpmst_addtime"));

		int pageCount = Tools.getManager(ProductGroup.class).getLength(clist);
		return pageCount ;
	}
	
	/**
	 * �����Ƽ��Ų�ѯ�Ź���Ʒ
	 * @return
	 */
	public static ArrayList<ProductGroup> getProductGroupsByCode(ArrayList<String> gdsidlist,int num){
		long today = Tools.getYesterdayTime(0)-1;//�����賿��ʱ��-1����
		long tomorrow = today + Tools.DAY_MILLIS;//�����賿��ʱ��
		
		ArrayList<ProductGroup> rlist = new ArrayList<ProductGroup>();
		if(gdsidlist==null || gdsidlist.size()==0){
			return null;
		}
		else{
			for(int i=0;i<gdsidlist.size();i++){
				if(rlist.size()<=num){
					List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
					clist.add(Restrictions.eq("tgrpmst_gdsid", gdsidlist.get(i)));
					clist.add(Restrictions.eq("tgrpmst_state", new Long(1)));
					
					clist.add(Restrictions.lt("tgrpmst_starttime", new Date(today)));
					clist.add(Restrictions.gt("tgrpmst_endtime", new Date(tomorrow)));
				
					//�������������������빺�ﳵʱ������
				
					List<BaseEntity> list = Tools.getManager(ProductGroup.class).getList(clist, null, 0, 100);
					
					if(list!=null&&list.size()>0){
						for(BaseEntity be:list){
							ProductGroup pg = (ProductGroup)be;
							long currentTime = System.currentTimeMillis();
							if(Tools.dateValue(pg.getTgrpmst_starttime()) < currentTime && Tools.dateValue(pg.getTgrpmst_endtime()) > currentTime){
								rlist.add(pg);
							}
						}
					}
				}
			}
		}
		return rlist ;
	}
}
