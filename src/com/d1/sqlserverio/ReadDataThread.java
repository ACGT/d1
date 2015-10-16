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
 * ���̶߳�ȡ���ݣ�д���ļ�
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
		System.out.println("�߳�"+id+"��ʼ��"+beanClass.getName()+"����...");
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
		System.out.println("�߳�"+id+"��"+beanClass.getName()+"����...���");
	}
	
	/**
	 * �Ѷ��������д��zip�ļ�
	 * @param b
	 * @throws Exception
	 */
	private void writeObject(BaseEntity b) throws Exception{	
		
		ZipEntry ze = new ZipEntry(b.getId());
		byte[] bs = objectToBytes(b);
		ze.setSize(bs.length);
		ze.setTime(System.currentTimeMillis());
		//��ZipEntry�ӵ�zos�У���д��ʵ�ʵ��ļ�����
		zos.putNextEntry(ze);
		zos.write(bs,0,bs.length);
		
		zos.closeEntry();
		zos.flush();
		//zos.close();//�ر�
	}
	
	/**
	 * ����ת�����ֽ�
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
