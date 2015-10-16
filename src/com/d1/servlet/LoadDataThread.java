package com.d1.servlet;

import java.io.File;

import javax.persistence.Table;

import com.d1.Const;
import com.d1.util.Tools;


/**
 * �ѳ�������load���ڴ���
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
	    			
	    			//������Tableע�����Entity
	    			Table t = c.getAnnotation(Table.class);
	    			
		    		if(t!=null&&!t.name().equals("lmclk")
		    				&&!t.name().equals("f_order_taobao")
		    				&&!t.name().equals("gdsmst")//ǰ����ع���
		    				&&!t.name().equals("skumst")//ǰ����ع���
		    				&&!t.name().equals("gdssale")//ǰ����ع���
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
		    			//�ܼ�¼��С��10000������ȫ�����ص�����
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
		System.out.println("��load�����ݶ�load��ϣ�������������������ʱ"+(end-start)+"���룡����");
		
	}

}
