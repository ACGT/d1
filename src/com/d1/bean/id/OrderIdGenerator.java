package com.d1.bean.id;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.d1.Const;
import com.d1.dbcache.core.MyHibernateUtil;
import com.d1.util.Tools;

/**
 * ����id���������ο��洢����sp_getseqд�ģ��ⲿ����ֱ�ӵ�sp_getseq����洢���̻������<br/>
 * ����������һ��hibernate�����ļ����Ƿ�ֹ��������ͬһ��session���رգ�����<br/>
 * @author kk 
 */
public class OrderIdGenerator{// implements IdentifierGenerator{
	
	private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;

	/**
	 * id���ɣ�����������һ��hibernate�����ļ�������������ӣ���ú�ԭ�����г�ͻ������
	 */
	//public Serializable generate(SessionImplementor arg0, Object arg1)
	/*public synchronized static String generate()
			throws HibernateException {
		
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx = session.beginTransaction() ;
			
			//���������ݿⱾ�����
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id=2");
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//�϶�������һ��
			Integer seq = (Integer)objs[0];//���ݱ���ȡ�������к�
			java.util.Date cdate = (java.util.Date)objs[1];//����
			java.util.Date today = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			
			//�������ڲ���ȣ���ʾ����ͬһ���ˣ����������ں����к�
			if(!sdf.format(today).equals(sdf.format(cdate))){
				session.createSQLQuery("update sysseq set sysseq_seq=1,sysseq_applydate=getdate() where sysseq_id=2")
					.executeUpdate();
				
				seq = new Integer(1) ;
			}
			
			Random r = new Random();
			seq = new Integer(seq.intValue()+r.nextInt(19)+1);//��һ�������
			
			//�޸ĵ�ǰseqֵ
			session.createSQLQuery("update sysseq set sysseq_seq="+seq.intValue()+" where sysseq_id=2")
				.executeUpdate();
			
			String date = sdf.format(today);//yyMMdd����
			DecimalFormat df = new DecimalFormat("000000");
			String seqStr = df.format(seq.intValue());//����6λ
			
			tx.commit();
			
			return date+seqStr ;//yyMMdd+6λ����һ��12λ������
		}catch(HibernateException ex){
			if(tx!=null)tx.rollback();
			throw ex ; 
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
	}*/
	public synchronized static String generate()
			throws HibernateException {
		
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx = session.beginTransaction() ;
			
			//���������ݿⱾ�����
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id=7");
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//�϶�������һ��
			Integer seq = (Integer)objs[0];//���ݱ���ȡ�������к�
			java.util.Date cdate = (java.util.Date)objs[1];//����
			java.util.Date today = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			
			seq = new Integer(seq.intValue()+1);
			
			//�޸ĵ�ǰseqֵ
			session.createSQLQuery("update sysseq set sysseq_seq="+seq.intValue()+" where sysseq_id=7")
				.executeUpdate();
			SimpleDateFormat   df=new   SimpleDateFormat("yyyy");  
			SimpleDateFormat   df2=new   SimpleDateFormat("MM");  
	        int odryy= Tools.parseInt(df.format(today).substring(2));
			int odrMM=Tools.parseInt(df2.format(today));
			String seqf1=(seq+"").substring(0, 2);
			String seqf2=(seq+"").substring(2, 5);
			String seqf3=(seq+"").substring(5,6);
			String seqf4=(seq+"").substring(6);
			Random r = new Random();
			String rom = r.nextInt(99)+"";//��һ�������
			String rom2 = r.nextInt(9)+"";//��һ�������
			
			if (rom.length()==1){
				rom="0"+rom;
			}
			
			//System.out.println((odryy*12+odrMM)+Tools.parseInt(seqf1));
			String odridstr=((odryy*12+odrMM)+Tools.parseInt(seqf1))+seqf2+"0"+seqf3+rom+seqf4+rom2;
			
			tx.commit();
			
			return odridstr ;//yyMMdd+6λ����һ��12λ������
		}catch(HibernateException ex){
			if(tx!=null)tx.rollback();
			throw ex ; 
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
	}
	
}
