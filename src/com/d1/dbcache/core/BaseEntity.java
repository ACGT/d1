package com.d1.dbcache.core;

/** 
 * BaseEntity是数据库基本的Entity，所有实体bean都要继承这个类！<br/>
 * 若要增加一个表，写一个Bean继承BaseEntity，并注意事项如下：<br/>
 * 1：实现类必须实现序列化，这样对象才可以存入memcached中；<br/>
 * 2：实现类必须有id这个域，且必须是@Id，并和数据库的主键或唯一标识字段对应；<br/>
 * 3：除id外，其他字段名和bean的field名必须保持完全一致（触发器会用到这些字段名）；<br/>
 * @author kk
 */
abstract public class BaseEntity implements java.lang.Cloneable , java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * getid方法
	 */
	abstract public String getId() ;
	
	/**
	 * setid方法
	 * @param id
	 */
	abstract public void setId(String id) ;
	
	/**
	 * 克隆一个对象，用于保存对象的副本，在事务中会用到
	 */
	public Object clone() {
       try{
    	   return super.clone();
       }catch(CloneNotSupportedException ce){
    	   return null;
       }
    }
	
	/**
	 * 覆盖toString方法，人性化打印id
	 */
	public String toString(){
		return this.getClass().getName()+":id="+this.getId();
	}
}
