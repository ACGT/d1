package com.d1.dbcache.core;

import com.danga.MemCached.MemCachedClient;
import com.danga.MemCached.SockIOPool;

/**
 * memcached在分布式session和分布式缓存中非常有用。<br/>
 * @author kk
 */
public class MyMemcachedUtil {
	/**
	 * 初始化memcached server的相关数据
	 */
	private static SockIOPool pool = null;
	
	/**
	 * memcached client
	 */
	private static MemCachedClient memCacheClient = null ;
	
	/**
	 * 从配置文件中读取memcached server列表，并初始化
	 */
	static {
		String[] serverlist = MyConfig.getMemcachedServers();
		
		if(serverlist==null||serverlist.length==0){
			System.out.println("出错了！没有配置memcached server！！！");
		}
	    //String[] serverlist     = { "cache0.server.com:11211", "cache1.server.com:11211" };
		//Integer[] weights       = { new Integer(5), new Integer(2) };   
	    int initialConnections  = 30;
	    int minSpareConnections = 20;
	    int maxSpareConnections = 150;   
	    long maxIdleTime        = 1000 * 60 * 30;       // 30 minutes
	    long maxBusyTime        = 1000 * 60 * 5;        // 5 minutes
	    long maintThreadSleep   = 1000 * 5;                     // 5 seconds
	    int  socketTimeOut      = 1000 * 3;                 // 3 seconds to block on reads
	    //int     socketConnectTO     = 1000 * 3;                 // 3 seconds to block on initial connections.  If 0, then will use blocking connect (default)
	    //boolean failover        = false;                        // turn off auto-failover in event of server down       
	    boolean nagleAlg        = false;                        // turn off Nagle's algorithm on all sockets in pool    
	    //boolean aliveCheck      = false;                        // disable health check of socket on checkout
	    pool = SockIOPool.getInstance("mycache");
	    pool.setServers( serverlist );
	    //pool.setWeights( weights );     
	    pool.setInitConn( initialConnections );
	    
	    //某一台server出故障时自动转到下一个
	    pool.setFailover(true);
	    //server恢复后又回来
	    pool.setFailback(true);

	    pool.setMinConn( minSpareConnections );
	    pool.setMaxConn( maxSpareConnections );
	    pool.setMaxIdle( maxIdleTime );
	    pool.setMaxBusyTime( maxBusyTime );
	    pool.setMaintSleep( maintThreadSleep );
	    pool.setSocketTO( socketTimeOut );
	    pool.setNagle( nagleAlg ); 
	    
	    //多个server的一致性hash算法配置
	    pool.setHashingAlg( SockIOPool.CONSISTENT_HASH );
	    pool.setAliveCheck( true );
	    pool.initialize();
	      
	    memCacheClient = new MemCachedClient("mycache");
	}
	
	/**
	 * 得到一个memcached client
	 * @return
	 */
	public static MemCachedClient getMemCachedClient(){
		return memCacheClient;
	}

}
