package com.d1.bean.id;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.d1.Const;
import com.d1.dbcache.core.MyHibernateUtil;

/**
 * id���������ο��洢����sp_getseqidд��
 * @author kk 
 */
public class SequenceIdGenerator {//implements IdentifierGenerator{
	
	private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;
	
	/**
	 * id���ɣ�����������һ��hibernate�����ļ�������������ӣ���ú�ԭ�����г�ͻ������<br/>
	 * ������ϸsysseq_id=5������odrmst_id��sysseq_id=4������odrmst_odrid������һ��������<br/>
	 * �û���id��Ӧsyseq_id=3��<br/>
	 */
	public synchronized static String  generate(String sysseq_id)
			throws HibernateException {
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx = session.beginTransaction() ;
			//���������ݿⱾ�����������commit��rollback��ͻ��ͷ�
			SQLQuery query = session.createSQLQuery("select sysseq_seq,sysseq_applydate from sysseq(XLOCK,PAGLOCK) where sysseq_id="+sysseq_id);
			
			@SuppressWarnings("rawtypes")
			List list = query.list();
			Object[] objs = (Object[])list.get(0);//�϶�������һ��
			Integer seq = (Integer)objs[0];//���ݱ���ȡ�������к�
			
			seq = new Integer(seq.intValue()+1);//+1
			
			//�޸ĵ�ǰseqֵ
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
