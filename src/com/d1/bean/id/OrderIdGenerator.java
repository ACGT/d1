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
 * 订单id生成器，参考存储过程sp_getseq写的，外部连接直接调sp_getseq这个存储过程会堵塞。<br/>
 * 这里用另外一个hibernate配置文件，是防止在事务中同一个session被关闭！！！<br/>
 * @author kk 
 */
public class OrderIdGenerator{// implements IdentifierGenerator{
	
	private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;

	/**
	 * id生成，这里用另外一个hibernate配置文件，用另外的连接，免得和原事务有冲突！！！
	 */
	//public Serializable generate(SessionImplementor arg0, Object arg1)
	/*public synchronized static String generate()
			throws HibernateException {
		
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx = session.beginTransaction() ;
			
			//这里有数据库本身的锁
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id=2");
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//肯定存在这一行
			Integer seq = (Integer)objs[0];//数据表里取到的序列号
			java.util.Date cdate = (java.util.Date)objs[1];//日期
			java.util.Date today = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			
			//两个日期不相等，表示不是同一天了，则重置日期和序列号
			if(!sdf.format(today).equals(sdf.format(cdate))){
				session.createSQLQuery("update sysseq set sysseq_seq=1,sysseq_applydate=getdate() where sysseq_id=2")
					.executeUpdate();
				
				seq = new Integer(1) ;
			}
			
			Random r = new Random();
			seq = new Integer(seq.intValue()+r.nextInt(19)+1);//加一个随机数
			
			//修改当前seq值
			session.createSQLQuery("update sysseq set sysseq_seq="+seq.intValue()+" where sysseq_id=2")
				.executeUpdate();
			
			String date = sdf.format(today);//yyMMdd日期
			DecimalFormat df = new DecimalFormat("000000");
			String seqStr = df.format(seq.intValue());//补齐6位
			
			tx.commit();
			
			return date+seqStr ;//yyMMdd+6位数，一共12位订单号
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
			
			//这里有数据库本身的锁
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id=7");
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//肯定存在这一行
			Integer seq = (Integer)objs[0];//数据表里取到的序列号
			java.util.Date cdate = (java.util.Date)objs[1];//日期
			java.util.Date today = new java.util.Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
			
			seq = new Integer(seq.intValue()+1);
			
			//修改当前seq值
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
			String rom = r.nextInt(99)+"";//加一个随机数
			String rom2 = r.nextInt(9)+"";//加一个随机数
			
			if (rom.length()==1){
				rom="0"+rom;
			}
			
			//System.out.println((odryy*12+odrMM)+Tools.parseInt(seqf1));
			String odridstr=((odryy*12+odrMM)+Tools.parseInt(seqf1))+seqf2+"0"+seqf3+rom+seqf4+rom2;
			
			tx.commit();
			
			return odridstr ;//yyMMdd+6位数，一共12位订单号
		}catch(HibernateException ex){
			if(tx!=null)tx.rollback();
			throw ex ; 
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
	}
	
}
