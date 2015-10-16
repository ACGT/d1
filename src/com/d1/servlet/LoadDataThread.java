package com.d1.servlet;

import java.io.File;

import javax.persistence.Table;

import com.d1.Const;
import com.d1.util.Tools;


/**
 * 把常用数据load到内存中
 * @author kk
 *
 */
public class LoadDataThread extends Thread{

	public LoadDataThread(){

	}
	
	@Override
	public void run() {
		long start = System.currentTimeMillis();
		
		File beanDir = new File(Const.PROJECT_PATH+"src/com/d1/bean");
    	String[] beans = beanDir.list();
    	for(int i=0;i<beans.length;i++){
    		try{
	    		String bname = beans[i];
	    		if(bname.endsWith(".java")){
	    			Class<?> c = Class.forName("com.d1.bean."+bname.substring(0,bname.indexOf(".java")));
	    			
	    			//定义了Table注解就是Entity
	    			Table t = c.getAnnotation(Table.class);
	    			
		    		if(t!=null&&!t.name().equals("lmclk")
		    				&&!t.name().equals("f_order_taobao")
		    				&&!t.name().equals("gdsmst")//前面加载过了
		    				&&!t.name().equals("skumst")//前面加载过了
		    				&&!t.name().equals("gdssale")//前面加载过了
		    				&&!t.name().equals("f_order_tenpay")
		    				&&!t.name().equals("odrshp")
		    				&&!t.name().equals("gdswil")
		    				&&!t.name().equals("mbrlog")
		    				&&!t.name().equals("odrshp_cache")
		    				&&!t.name().equals("odrshp")
		    				&&!t.name().equals("scrchgawd")
		    				&&!t.name().equals("qqloginmbr")
		    				&&!t.name().equals("f_cart")){
		
		    			int recordCount = Tools.getManager(c).getLength(null);
		    			//总记录数小于10000的数据全部加载到缓存
		    			if(recordCount<=10000){
		    				Tools.getManager(c).loadAllData();
		    			}
		    		}
	    		}
    		}catch(Exception ex){
    			ex.printStackTrace();
    		}
    	}
		
		long end = System.currentTimeMillis();
		System.out.println("该load的数据都load完毕！！！！！！！！！耗时"+(end-start)+"毫秒！！！");
		
	}

}
