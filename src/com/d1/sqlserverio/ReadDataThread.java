package com.d1.sqlserverio;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import com.d1.dbcache.core.BaseEntity;
import com.d1.util.Tools;

/**
 * 多线程读取数据，写入文件
 * @author kk
 *
 */
public class ReadDataThread {//extends Thread{
	private List<String> idlist = null; 
	
	private int id ;
	
	private static Class<?> beanClass ;
	
	private ZipOutputStream zos ;
	
	public ReadDataThread(List<String> idlist,int id,Class<?> bc,ZipOutputStream zos){
		this.idlist = idlist ;
		this.id = id ;
		beanClass = bc ;
		this.zos = zos ;
	}
	
	public void run() {
		System.out.println("线程"+id+"开始读"+beanClass.getName()+"数据...");
		if(idlist!=null&&idlist.size()>0){
			for(String s:idlist){
				BaseEntity b = Tools.getManager(beanClass).get(s);
				try{
					writeObject(b);
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		System.out.println("线程"+id+"读"+beanClass.getName()+"数据...完成");
	}
	
	/**
	 * 把对象二进制写入zip文件
	 * @param b
	 * @throws Exception
	 */
	private void writeObject(BaseEntity b) throws Exception{	
		
		ZipEntry ze = new ZipEntry(b.getId());
		byte[] bs = objectToBytes(b);
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//将ZipEntry加到zos中，再写入实际的文件内容
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		
		zos.closeEntry();
		zos.flush();
		//zos.close();//关闭
	}
	
	/**
	 * 对象转换成字节
	 * @param b
	 * @return
	 * @throws IOException
	 */
	private byte[] objectToBytes(BaseEntity b) throws IOException {
	    ByteArrayOutputStream out = new ByteArrayOutputStream();
	    ObjectOutputStream ot = new ObjectOutputStream(out);
	    ot.writeObject(b);
	    ot.flush();
	    ot.close();
	    return out.toByteArray();
	}

}
