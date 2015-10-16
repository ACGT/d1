package com.d1.bean.trigger;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.Field;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.d1.Const;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.helper.ResourceHelper;
import com.d1.util.Tools;

/**
 * 创建触发器代码，记录数据更改情况，用于清除缓存
 * @author kk
 */
public class CreateTrigger {
	
	/**
	 * main执行方法，生成sql并执行
	 * @param args
	 * @throws Exception
	 */
    public static void main(String[] args) throws Exception{
    	createTriggerSql();
    	//System.out.println(com.d1.helper.ResourceHelper.getResourceVersion("/res/xy/df.css"));
    	//System.out.println(ResourceHelper.getResourceVersion("/res/css/jquery.flexbox.css"));
    }
    
    /**
     * 触发器模板，用于创建表变化情况的触发器
     */
    private static String TRIGGER_TEMPLATE = "";
    
    /**
     * 触发器模板文件
     */
    private static final String TRIGGER_TEMPLATE_FILE=Const.PROJECT_PATH+"conf/access_trigger.txt";
    
    static{
    	try{
    		BufferedReader br = new BufferedReader(new FileReader(new File(TRIGGER_TEMPLATE_FILE)));
    		String line = null ;
    		StringBuffer sb = new StringBuffer();
    		while((line=br.readLine())!=null){
    			sb.append(line).append(System.getProperty("line.separator"));
    		}
    		br.close();
    		TRIGGER_TEMPLATE = sb.toString();
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    }
    
    /**
     * 执行sql,删除或创建触发器
     * @param sql
     */
    private static boolean executeUpdate(String sql) {
    	Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(Const.HIBERNATE_CON_FILE) ;
			tx = session.beginTransaction() ;
			session.createSQLQuery(sql).executeUpdate();
			tx.commit();
			return true ;
		}catch(Exception ex){
			if(tx!=null)tx.rollback();
			if(!sql.startsWith("drop")){
				System.out.println(sql);
			}
			
			ex.printStackTrace();
			
			return false ;
		}finally{
			MyHibernateUtil.closeSession(Const.HIBERNATE_CON_FILE);
		}
    }
    /**
     * 创建触发器的方法，直接读java文件，根据表名、class名、id名生成对应的触发器语句！
     */
    private static void createTriggerSql() throws Exception {
    	File beanDir = new File(Const.PROJECT_PATH+"src/com/d1/bean");
    	String[] beans = beanDir.list();
    	for(int i=0;i<beans.length;i++){
    		String bname = beans[i];
    		if(bname.endsWith(".java")){
    			//System.out.println(bname);
    			Class<?> c = Class.forName("com.d1.bean."+bname.substring(0,bname.indexOf(".java")));
    			Field[] f = c.getDeclaredFields();
    			String id_name="id";
    			for(int j=0;j<f.length;j++){
    				if(f[j].isAnnotationPresent(Id.class)&&f[j].isAnnotationPresent(Column.class)){
    					Column c135 = f[j].getAnnotation(Column.class);
    					id_name = c135.name();
    					break ;
    				}
    			}
    			//System.out.println(c.getName());
    			Table t = c.getAnnotation(Table.class);
    			String tableName = "",tname="";
	    		if(t!=null&&!t.name().equals("lmclk")
	    				&&!t.name().equals("f_order_taobao")
	    				&&!t.name().equals("f_order_tenpay")
	    				&&!t.name().equals("odrshp")
	    				&&!t.name().equals("gdswil")
	    				&&!t.name().equals("mbrlog")
	    				&&!t.name().equals("odrshp_cache")
	    				&&!t.name().equals("odrshp")
	    				&&!t.name().equals("scrchgawd")
	    				&&!t.name().equals("f_cart_item")
	    				&&!t.name().equals("qqloginmbr")
	    				&&!t.name().equals("f_cart")){
	    			tableName = t.catalog()+"."+t.name();
	    			tname = t.name();
	
	    			if(tableName.startsWith("."))tableName=tableName.substring(1);
	    			
	    			/*try{
		    			List<BaseEntity> list = Tools.getManager(c).getList(null, null, 0, 1);
		    			if(list!=null&&list.size()>0){
		    				Tools.getManager(c).update(list.get(0), false);
		    			}
	    			}catch(Exception ex){
	    				ex.printStackTrace();
	    			}*/
	    			
	    			if(t.name().equals("weekact")){
		    			String triggerName = "acs_trg_"+tname;//触发器名
		    			String dropTriggerSql = "drop trigger "+triggerName;//drop触发器的sql
		
		    			boolean drop = executeUpdate(dropTriggerSql);//先drop掉对应触发器
		    			
		    			System.out.println("drop触发器"+triggerName+" "+drop);
		    			
		    			String createTriggerSql = TRIGGER_TEMPLATE ;
		    			createTriggerSql = createTriggerSql.replaceAll("<table_name>", tname);
		    			createTriggerSql = createTriggerSql.replaceAll("<full_table_name>", tableName);
		    			createTriggerSql = createTriggerSql.replaceAll("<class_name>", c.getName());
		    			createTriggerSql = createTriggerSql.replaceAll("<table_id_name>", id_name);
		    			
		    			//System.out.println(c.getName());
		    			String[] hashFields = Tools.getManager(c).getHashFields();
		    			String before_value = "d."+id_name;
		    			String after_value = "i."+id_name;
		    			String insert_value = "i."+id_name;
		    			String delete_value = "d."+id_name ;
		    			
		    			if(hashFields!=null&&hashFields.length>0){
		    				before_value = "";
		    				after_value = "";
		    				insert_value = "";
		    				delete_value = "";
		    				for(int x=0;x<hashFields.length;x++){
		    					before_value += "'"+hashFields[x]+"='+cast(isnull(d."+hashFields[x]+",'') as varchar)"+"+'!@#'+";
		    					after_value += "'"+hashFields[x]+"='+cast(isnull(i."+hashFields[x]+",'') as varchar)"+"+'!@#'+";
		    					insert_value += "'"+hashFields[x]+"='+cast(isnull(i."+hashFields[x]+",'') as varchar)"+"+'!@#'+";
		    					delete_value += "'"+hashFields[x]+"='+cast(isnull(d."+hashFields[x]+",'') as varchar)"+"+'!@#'+";
		    				}
		    				
		    				if(before_value.endsWith("+"))before_value=before_value.substring(0,before_value.length()-1);
		    				if(after_value.endsWith("+"))after_value=after_value.substring(0,after_value.length()-1);
		    				if(insert_value.endsWith("+"))insert_value=insert_value.substring(0,insert_value.length()-1);
		    				if(delete_value.endsWith("+"))delete_value=delete_value.substring(0,delete_value.length()-1);
		    				
		    			}
		    			
		    			//System.out.println(delete_value);
		    			
		    			createTriggerSql = createTriggerSql.replaceAll("<before_value>", before_value);
		    			createTriggerSql = createTriggerSql.replaceAll("<insert_value>", insert_value);
		    			createTriggerSql = createTriggerSql.replaceAll("<delete_value>", delete_value);
		    			createTriggerSql = createTriggerSql.replaceAll("<after_value>", after_value);
		    			
		    			
		    			createTriggerSql = "create trigger "+triggerName+System.getProperty("line.separator")+createTriggerSql;
		    			
		    			System.out.println(createTriggerSql);
		    			boolean create = executeUpdate(createTriggerSql);
		    			System.out.println("create触发器"+triggerName+" "+create);
	    			}//end if
	    		}
    		}
    	}
    }
}
