package com.d1.sqlserverio;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.hibernate.criterion.Projections;

import com.d1.Const;
import com.d1.dbcache.core.BaseEntity;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.util.Tools;

/**
 * 数据导入导出工具
 * @author kk
 *
 */
public class SqlServerUtil {
	/**
	 * 把表里的数据读取出来，写入zip文件
	 */
	@SuppressWarnings("unchecked")
	public static void exportData(Class<?> beanClass)throws Exception{
		List<String> list = null;//所有id列表
		//把所有数据读到内存中去，并写入zip文件
		org.hibernate.Session s = null ;
		try{
			s = MyHibernateUtil.currentSession("/hibernate.cfg.xml");
			list = (List<String>)s.createCriteria(beanClass)
					.setProjection(Projections.property("id")).list();
			
			System.out.println(list.size()+"<<<pp");
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			MyHibernateUtil.closeSession("/hibernate.cfg.xml");
		}
		
		if(list!=null&&list.size()>0){
			int threadcount = 10 ;//10个线程同时读数据
			int totalLength = list.size();
			
			int pagesize = (int)(totalLength/threadcount);
			if(totalLength%threadcount>0)threadcount++;
			
			System.out.println("读取到"+beanClass.getName()+"个数="+list.size());
			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File("d://"+beanClass.getName()+".zip")));
			
			for(int i=0;i<threadcount;i++){
				List<String> idlist = new ArrayList<String>();
				
				for(int j=i*pagesize;j<i*pagesize+pagesize&&j<list.size();j++){
					idlist.add(list.get(j));
				}
				
				
				
				//多线程读取商品数据
				ReadDataThread rpt = new ReadDataThread(idlist,i,beanClass,zos);
				rpt.run();
				
				zos.flush();
				
			}
			zos.close();
		}
	}
	
	/**
	 * 通过zip文件导入数据
	 * @param beanClass
	 */
	 public static void inputData(Class<?> beanClass) throws Exception{
	        //File file; 
	        ZipInputStream  zipIn ;
	        ZipEntry        zipEntry;
	        String unZipfileName = "d:/"+beanClass.getName()+".zip";

	        try{ 
	            zipIn = new ZipInputStream (new BufferedInputStream(new FileInputStream(unZipfileName))); 

	            while((zipEntry = zipIn.getNextEntry()) != null){ 
	         
	                
	                if(zipEntry.isDirectory()){ 
	                    //file.mkdirs(); 
	                } 
	                else{ 
	                	
	                	
	                    ByteArrayOutputStream bos=new ByteArrayOutputStream();
	                	
	                    byte[] buff = new byte[512]; 
	                    int readed = -1; 
	                    while((readed = zipIn.read(buff)) > 0) {
	                    	bos.write(buff, 0, readed); 
	                    }
	                    bos.close(); 
	                    
	                    ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());
	                    
	                    ObjectInputStream ois = new ObjectInputStream(bis);
	                    
	                   
	                    BaseEntity be = (BaseEntity)ois.readObject();
	                    //此处创建对象
	                    System.out.println("创建"+be);
	                    
	                    Tools.getManager(be.getClass()).create(be);
	                } 
	                zipIn.closeEntry();     
	            } 
	        }catch(IOException ioe){ 
	            ioe.printStackTrace(); 
	        } 
	    } 
	 
	 private static HashMap<String,Class<?>> readBean() throws Exception {
		 HashMap<String,Class<?>> map = new HashMap<String,Class<?>>();
		 
		 File beanPath = new File(Const.PROJECT_PATH+"src/com/d1/bean");
		 String[] fs = beanPath.list();
		 
		 for(int i=0;i<fs.length;i++){
			 
			 if(fs[i].endsWith(".java")){ 
				 System.out.print(fs[i]);
				 File beanFile = new File(Const.PROJECT_PATH+"src/com/d1/bean/"+fs[i]);
				 System.out.println(beanFile.exists()+"<<存在?");
				 
				 BufferedReader br = new BufferedReader(new FileReader(beanFile));
				 String line = null ;
				 
				 while((line=br.readLine())!=null){
					 line = line.trim().replaceAll("\\s", "").toLowerCase();
					 //System.out.println(line);
					 if(line.indexOf("@table(name=\"")>-1){
						 //System.out.println("Table find "+line.indexOf("@Table(name=\""));
						 line = line.substring(line.indexOf("\"")+1);
						 //System.out.println(line+"<<<<<<");
						 String tableName = line.substring(0,line.indexOf("\""));
						 //System.out.println(tableName+"<<<<<<t");
						 Class<?> c = Class.forName("com.d1.bean."+fs[i].substring(0,fs[i].indexOf(".")));
						 System.out.println(tableName+"="+c.getName());
						 map.put(tableName, c);
						 break;
					 }
				 }
				 br.close();
			 }
		 }
		 
		 return map;
		
	 }
	 public static void readDataGo()throws Exception{
		 BufferedReader br = new BufferedReader(new FileReader(new File(Const.PROJECT_PATH+"conf/tables.txt")));
		 String line = null ;
		 HashMap<String,Class<?>> map = readBean();
		 while((line=br.readLine())!=null){
			 System.out.println("开始读取"+map.get(line));
			 try{
				 exportData(map.get(line));
			 }catch(Exception ex){
				 ex.printStackTrace();
			 }
		 }
	 }
	 
/*	 private static void inputDataGo()throws Exception{
		 HashMap<String,Class<?>> map = readBean();
		 Iterator<String> it = map.keySet().iterator();
		 while(it.hasNext()){
			 String tname = it.next();
			 Class<?> c = map.get(tname);
			 System.out.println("导入数据"+c.getName());
			 inputData(c);
		 }
	 }
	 */
	 public static void main(String[] args)throws Exception{
		//readDataGo();
		 //inputData(City.class);
		 //exportData(Product.class);
		 
	 }
}
