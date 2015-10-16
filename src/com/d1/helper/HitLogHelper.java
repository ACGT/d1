package com.d1.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

import com.d1.bean.HitLog;
import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

public class HitLogHelper {
public static ArrayList<HitLog> getLog(String start,String end,String from,String topage){
		
		ArrayList<HitLog> rlist = new ArrayList<HitLog>();
		ArrayList<HitLog> list2 = new ArrayList<HitLog>();
		List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
		clist.add(Restrictions.ge("logdate", start));
		clist.add(Restrictions.le("logdate", end));
		if(!Tools.isNull(from) && !"-1".equals(from)){
			clist.add(Restrictions.like("first_referer_url", from));
		}
		if(!Tools.isNull(topage) && !"-1".equals(topage)){
			clist.add(Restrictions.like("request_uri", topage+"%"));
		}
		List<BaseEntity> list = Tools.getManager(HitLog.class).getList(clist, null, 0, getLogLength(start,end,from,topage));
		if(clist==null||clist.size()==0)return null;
		for(BaseEntity be:list){
			rlist.add((HitLog)be);
		}
		//System.out.print(rlist.size());
		for(HitLog hl:rlist){
			if(topage.equals("product")){
				if(hl.getRequest_uri().indexOf("productsort")<0){
					list2.add(hl);
				}
			}
		}
		if(list2==null||list2.size()==0)return null;
		return list2 ;
	}

public static int getLogLength(String start,String end,String from,String topage){
	List<SimpleExpression> clist = new ArrayList<SimpleExpression>();
	clist.add(Restrictions.ge("logdate", start));
	clist.add(Restrictions.le("logdate", end));
	if(!Tools.isNull(from) && !"-1".equals(from)){
		clist.add(Restrictions.like("first_referer_url", from));
	}
	if(!Tools.isNull(topage) && !"-1".equals(topage)){
		clist.add(Restrictions.like("request_uri", "%"+topage+"%"));
	}
	return Tools.getManager(HitLog.class).getLength(clist);
	
}
public static ArrayList<HitLog> getLog(String start,String end,String from,String keyword,String topage ){
	ArrayList<HitLog> list=getLog(start,end, from, topage);
	ArrayList<HitLog> rlist = new ArrayList<HitLog>();
	ArrayList<HitLog> rlist2 = new ArrayList<HitLog>();
	if(list==null || list.size()==0) return null;
	if(!Tools.isNull(keyword) && !"-1".equals(keyword)){
		for(HitLog hl:list){
			String url=hl.getFirst_referer_url();
			url=url.substring(url.indexOf("?"),url.length());
			String[] strlist1=url.split("&");
			for(int i=0;i<strlist1.length;i++){
				String[] strlist2=strlist1[i].split("=");
				for(int j=0;j<strlist2.length;j++){
					if(strlist2[j].equals("keyword") || strlist2[j].equals("kd") || strlist2[j].equals("query")){
						String[] keywords=keyword.split(",");
						int count=0;
						for(int k=0;k<keywords.length;k++){
							if(strlist2[j+1].indexOf(keywords[k])>0){
								count++;
							}
						}
						if(!keyword.equals("0") && count>0){//°üº¬¹Ø¼ü×Ö
							rlist.add(hl);
						}else if(keyword.equals("0") && count==0){
							rlist2.add(hl);
						}
					}
					
				}
			}
		}
		if(!keyword.equals("0")){
			if(rlist==null || rlist.size()==0) return null;
			return rlist;
		}else{
			if(rlist2==null || rlist2.size()==0) return null;
			return rlist2;
		}
	}else{
		return list;
	}
	
}
}