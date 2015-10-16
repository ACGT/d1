package com.d1.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.Hitindex;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class HitindexHelper {
//��ȡȫ����ҳ����������
public	static ArrayList<Hitindex> gethitindexList(){
		
		ArrayList<Hitindex> rlist = new ArrayList<Hitindex>();
		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		List<BaseEntity> list = Tools.getManager(Hitindex.class).getList(clist, null, 0, 100);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Hitindex)be);
		}
		return rlist ;
	}

//��ȡĳ��ʱ�����ҳ����������
//��ȡȫ����ҳ����������
public	static ArrayList<Hitindex> gethitindexListBydate(Date start,Date ends){
		
		ArrayList<Hitindex> rlist = new ArrayList<Hitindex>();		
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ge("hitindex_createdate",start));
		clist.add(Restrictions.le("hitindex_createdate",ends));
		List<BaseEntity> list = Tools.getManager(Hitindex.class).getList(clist, null, 0, 100);
		if(list==null||list.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((Hitindex)be);
		}
		return rlist ;
	}




}
