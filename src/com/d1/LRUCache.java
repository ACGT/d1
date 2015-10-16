package com.d1;

import java.util.LinkedHashMap;

/**
 * LRUMap的简单实现，继承LinkedHashMap，重写removeEldestEntry方法即可实现定长LRU算法。<br/>
 * 使用Map cache=Collections.synchronizedMap(new MyLRUCache(10000));即可实现线程安全<br/>
 * @author kk
 */
public class LRUCache<K, V> extends LinkedHashMap<K, V>    
{    
    /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -5291299322319277503L;
	
	/**
	 * 最大容量
	 */
	private final int maxCapacity;
	
	/**
	 * 默认的加载因子
	 */
    private static final float DEFAULT_LOAD_FACTOR = 0.75f;    
   
    public LRUCache(int maxCapacity)    
    {    
        super(maxCapacity, DEFAULT_LOAD_FACTOR, true);    
        this.maxCapacity = maxCapacity;    
    }    
   
    @Override   
    protected boolean removeEldestEntry(java.util.Map.Entry<K, V> eldest)    
    {    
        return size() > maxCapacity;    
    }   
}    
