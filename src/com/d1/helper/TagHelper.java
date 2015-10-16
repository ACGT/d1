package com.d1.helper;

import com.d1.bean.Tag;
import com.d1.util.Tools;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.BaseManager;

public class TagHelper { 

		//���������λ��ת������ 
		
		static final int GB_SP_DEFF = 160; 
		//��Ź���һ�����ֲ�ͬ��������ʼ��λ�� 
		
		static final int[] secPosvalueList = { 
		   1601, 1637, 1833, 2078, 2274, 2302, 2433, 2594, 2787, 
		   3106, 3212, 3472, 3635, 3722, 3730, 3858, 4027, 4086, 
		   4390, 4558, 4684, 4925, 5249, 5600 
		  }; 
		//��Ź���һ�����ֲ�ͬ��������ʼ��λ���Ӧ���� 
		static final char[] firstLetter = { 
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 
		'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 
		    't', 'w', 'x', 'y', 'z'}; 
		//��ȡһ���ַ�����ƴ���� 
	public static String getFirstLetter(String oriStr) { 
		String str = oriStr.toLowerCase(); 
		StringBuffer buffer = new StringBuffer(); 
		char ch; 
		char[] temp; 
		for (int i = 0; i < str.length(); i++) { //���δ���str��ÿ���ַ� 
		ch = str.charAt(i); 
		temp = new char[] {ch}; 
		byte[] uniCode = new String(temp).getBytes(); 
		if (uniCode[0] < 128 && uniCode[0] > 0) { // �Ǻ��� 
		  buffer.append(temp); 
		  } else { 
		  buffer.append(convert(uniCode)); 
		  } 
		  } 
		  return buffer.toString(); 
	} 
	  /** ��ȡһ�����ֵ�ƴ������ĸ�� 
	  ��     * GB�������ֽڷֱ��ȥ160��ת����10��������ϾͿ��Եõ���λ�� 
	  ����* ���纺�֡��㡱��GB����0xC4/0xE3���ֱ��ȥ0xA0��160������0x24/0x43 
	  ����* 0x24ת��10���ƾ���36��0x43��67����ô������λ�����3667���ڶ��ձ��ж���Ϊ��n�� 
	  ����*/ 
	static char convert(byte[] bytes) { 
	  
		  char result = '-'; 
		  
		  int secPosValue = 0; 
		  
		  int i; 
		  
		  for( i =0; i < bytes.length; i++) { 
		   
		   bytes[i] -= GB_SP_DEFF; 
		  } 
		  
		  secPosValue = bytes[0] * 100 + bytes[1]; 
		  
		  for ( i = 0; i<23; i++) { 
		   
		   if(secPosValue >= secPosvalueList[i] && secPosValue <secPosvalueList[i+1]) { 
		    
		    result = firstLetter[i]; 
		    
		    break; 
		   } 
		  } 
		  return result; 
	} 
	
	//��ȡ����Tag�б�
	public static ArrayList<Tag> getTags()
	{
		ArrayList<Tag> list=new ArrayList<Tag>();
		List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
		List<Order> olist=new ArrayList<Order>();
		olist.add(Order.desc("tag_counts"));
		List<BaseEntity> blist=Tools.getManager(Tag.class).getList(rlist, olist, 0, 10000);
		if(blist!=null&&blist.size()>0)
		{
			for(BaseEntity be:blist)
			{
				if(be!=null)
				{
					list.add((Tag)be);
				}
			}
		}
		
		return list;
	}
	
	
	//��ȡ����������Tag�б�
		public static ArrayList<Tag> getTags(String name,String id)
		{
			ArrayList<Tag> list=new ArrayList<Tag>();
			List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
			if(name!=null&&name.length()>0){
				rlist.add(Restrictions.like("tag_key", '%'+name+'%'));
			}
			if(id!=null&&id.length()>0&&Tools.isNumber(id)){
				rlist.add(Restrictions.eq("id", id));
			}
			List<Order> olist=new ArrayList<Order>();
			olist.add(Order.desc("tag_counts"));
			List<BaseEntity> blist=Tools.getManager(Tag.class).getList(rlist, olist, 0, 10000);
			if(blist!=null&&blist.size()>0)
			{
				for(BaseEntity be:blist)
				{
					if(be!=null)
					{
						list.add((Tag)be);
					}
				}
			}
			
			return list;
		}
		
	
	
	
	
	
	//��ȡ����Tag�б�
		public static ArrayList<Tag> getTagsByCount(String letters,int count)
		{
			ArrayList<Tag> list=new ArrayList<Tag>();
			List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
			if(letters!=null&&letters.length()>0)
			{
			    rlist.add(Restrictions.eq("tag_letters", letters.toUpperCase()));
			}
			List<BaseEntity> blist=Tools.getManager(Tag.class).getList(rlist, null, 0, count);
			if(blist!=null&&blist.size()>0)
			{
				for(BaseEntity be:blist)
				{
					if(be!=null)
					{
						list.add((Tag)be);
					}
				}
			}
			
			return list;
		}
	//���ݱ�ǩ����  ��ȡ��ǩ
		public static Tag getTagsByKey(String key)
		{
			ArrayList<Tag> list=new ArrayList<Tag>();
			List<SimpleExpression> rlist=new ArrayList<SimpleExpression>();
			if(key!=null&&key.length()>0)
			{
			    rlist.add(Restrictions.eq("tag_key", key));
			}
			List<BaseEntity> blist=Tools.getManager(Tag.class).getList(rlist, null, 0, 10);
			if(blist!=null&&blist.size()>0)
			{
				for(BaseEntity be:blist)
				{
					if(be!=null)
					{
						list.add((Tag)be);
					}
				}
			}
			if(list!=null&&list.size()>0){
			return list.get(0);
			}else{
				return null;
			}
		}


}
