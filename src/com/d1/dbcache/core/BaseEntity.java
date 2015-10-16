package com.d1.dbcache.core;

/** 
 * BaseEntity�����ݿ������Entity������ʵ��bean��Ҫ�̳�����࣡<br/>
 * ��Ҫ����һ����дһ��Bean�̳�BaseEntity����ע���������£�<br/>
 * 1��ʵ�������ʵ�����л�����������ſ��Դ���memcached�У�<br/>
 * 2��ʵ���������id������ұ�����@Id���������ݿ��������Ψһ��ʶ�ֶζ�Ӧ��<br/>
 * 3����id�⣬�����ֶ�����bean��field�����뱣����ȫһ�£����������õ���Щ�ֶ�������<br/>
 * @author kk
 */
abstract public class BaseEntity implements java.lang.Cloneable , java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * getid����
	 */
	abstract public String getId() ;
	
	/**
	 * setid����
	 * @param id
	 */
	abstract public void setId(String id) ;
	
	/**
	 * ��¡һ���������ڱ������ĸ������������л��õ�
	 */
	public Object clone() {
       try{
    	   return super.clone();
       }catch(CloneNotSupportedException ce){
    	   return null;
       }
    }
	
	/**
	 * ����toString���������Ի���ӡid
	 */
	public String toString(){
		return this.getClass().getName()+":id="+this.getId();
	}
}
