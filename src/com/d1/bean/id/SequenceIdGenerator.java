package com.d1.bean.id;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.d1.Const;
import com.d1.dbcache.core.MyHibernateUtil;

/**
 * id生成器，参考存储过程sp_getseqid写的
 * @author kk 
 */
public class SequenceIdGenerator {//implements IdentifierGenerator{
	
	private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;
	
	/**
	 * id生成，这里用另外一个hibernate配置文件，用另外的连接，免得和原事务有冲突！！！<br/>
	 * 订单明细sysseq_id=5；订单odrmst_id的sysseq_id=4；订单odrmst_odrid用另外一个生成器<br/>
	 * 用户的id对应syseq_id=3。<br/>
	 */
	public synchronized static String  generate(String sysseq_id)
			throws HibernateException {
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx = session.beginTransaction() ;
			//这里有数据库本身的锁，事务commit或rollback后就会释放
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id="+sysseq_id);
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//肯定存在这一行
			Integer seq = (Integer)objs[0];//数据表里取到的序列号
			
			seq = new Integer(seq.intValue()+1);//+1
			
			//修改当前seq值
			session.createSQLQuery("update sysseq set sysseq_seq="+seq.intValue()+" where sysseq_id="+sysseq_id)
				.executeUpdate();
			
			tx.commit();
			
			return seq+"";
		}catch(HibernateException ex){
			if(tx!=null)tx.rollback();
			throw ex ; 
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
	}//end synchronized
}
