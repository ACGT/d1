package com.d1;

import java.util.LinkedHashMap;

/**
 * LRUMap�ļ�ʵ�֣��̳�LinkedHashMap����дremoveEldestEntry��������ʵ�ֶ���LRU�㷨��<br/>
 * ʹ��Map cache=Collections.synchronizedMap(new MyLRUCache(10000));����ʵ���̰߳�ȫ<br/>
 * @author kk
 */
public class LRUCache<K, V> extends LinkedHashMap<K, V>    
{    
    /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -5291299322319277503L;
	
	/**
	 * �������
	 */
	private final int maxCapacity;
	
	/**
	 * Ĭ�ϵļ�������
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
