package com.d1.helper;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.d1.Const;
import com.d1.dbcache.core.MyHibernateUtil;

public class JsHelper {
	private static final String HIBERNATE_FILE = Const.HIBERNATE_CON_FILE;
	public	static List getJsOdrShop(String shipdate_s, String shipdate_e, String shpmst_shopcode, String jsmst_sumprice){
			Session session = null ;
			Transaction tx = null ;
			try{
				session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
				 
				String sql = "select distinct shpmst_shopcode,shpmst_shopname,sum(sumprice) as sumprice,shpmst_sendtype from ("
							+ " select distinct shpmst_shopcode,shpmst_shopname,shpmst_shopname,sum(Odrmst_ordermoney+Odrmst_giftfee-Odrmst_tktvalue-odrmst_shipfee*2) as sumprice,shpmst_sendtype from odrmst a, shpmst b where a.odrmst_sndshopcode = b.shpmst_shopcode and shpmst_sendtype = 2" + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e+"'")) + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype,shpmst_shopname"
							+ " union select distinct shpmst_shopcode,shpmst_shopname,shpmst_shopname,sum(Odrmst_ordermoney+Odrmst_giftfee-Odrmst_tktvalue-odrmst_shipfee*2) as sumprice,shpmst_sendtype from odrmst_recent a, shpmst b where a.odrmst_sndshopcode = b.shpmst_shopcode and shpmst_sendtype = 2 " + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e)+"'") + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype,shpmst_shopname"
							+ " union select distinct shpmst_shopcode,shpmst_shopname,sum(-odrshopth_money) as sumprice,shpmst_sendtype from odrmst_recent a, shpmst b, odrshopth c where a.odrmst_sndshopcode = b.shpmst_shopcode and a.odrmst_odrid = c.odrshopth_odrid and shpmst_sendtype = 2 and odrshopth_thtype = 1 " + (shipdate_s.equals("")?"":(" and odrshopth_cldate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrshopth_cldate>'"+shipdate_e+"'")) + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype,shpmst_shopname) a" 
							+ " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype having sum(a.sumprice)>"+(jsmst_sumprice.equals("")?"0":jsmst_sumprice)+( shpmst_shopcode.equals("")?"":" and shpmst_shopcode = '"+shpmst_shopcode+"'");
				//System.out.println(sql);
				SQLQuery query = session.createSQLQuery(sql);
				
				return query.list();
			}catch(HibernateException ex){
				throw ex ; 
			}finally{
				MyHibernateUtil.closeSession(HIBERNATE_FILE);
			}
			
		}
	
	public	static void createJsOdrShop(String fmtDate, String shipdate_s, String shipdate_e, String shpmst_shopcode, String jsmst_sumprice,String user){
		Session session = null ;
		Transaction tx = null ;
		try{
			session = MyHibernateUtil.currentSession(HIBERNATE_FILE) ;
			tx=session.beginTransaction();
			String sql = "";
			
            String jscode=fmtDate+"-"+shpmst_shopcode;
			//删除以前的临时数据
			sql = "delete jsdtl where jsdtl_jsmstcode in (select jsmst_code from jsmst where jsmst_status = 0 and jsmst_createuser='"+user+"')";
			session.createSQLQuery(sql).executeUpdate();
			
			sql = "delete jsmst where jsmst_status = 0 and jsmst_createuser='"+user+"'";
			session.createSQLQuery(sql).executeUpdate();
			//加入jsmst
			sql = "insert jsmst(jsmst_period, jsmst_code, jsmst_shpcode,jsmst_shpname,jsmst_sumprice,jsmst_status,jsmst_createuser) " 
						+ "select distinct jsmst_period,'"+ fmtDate+"-'+shpmst_shopcode as jsmst_code,shpmst_shopcode,shpmst_shopname,sum(sumprice) as sumprice,0 as jsmst_status,'"+user+"' from ("
						+ " select distinct '"+shipdate_e+"至"+shipdate_s+"' as jsmst_period,shpmst_shopcode,shpmst_shopname,sum(Odrmst_ordermoney-Odrmst_giftfee+odrmst_shipfee-Odrmst_tktvalue-odrmst_ordermoney*shpmst_incomevalue) as sumprice,shpmst_sendtype from odrmst a, shpmst b where a.odrmst_sndshopcode = b.shpmst_shopcode and shpmst_sendtype = 2" + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e+"'")) + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype"
						+ " union select distinct '"+shipdate_e+"至"+shipdate_s+"' as jsmst_period, shpmst_shopcode,shpmst_shopname,sum(Odrmst_ordermoney-Odrmst_giftfee+odrmst_shipfee-Odrmst_tktvalue-odrmst_ordermoney*shpmst_incomevalue) as sumprice,shpmst_sendtype from odrmst_recent a, shpmst b where a.odrmst_sndshopcode = b.shpmst_shopcode and shpmst_sendtype = 2 " + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e)+"'") + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype"
						+ " union select distinct '"+shipdate_e+"至"+shipdate_s+"' as jsmst_period, shpmst_shopcode,shpmst_shopname,sum(-odrshopth_money+odrshopth_money*shpmst_incomevalue) as sumprice,shpmst_sendtype from odrmst_recent a, shpmst b, odrshopth c where a.odrmst_sndshopcode = b.shpmst_shopcode and a.odrmst_odrid = c.odrshopth_odrid and shpmst_sendtype = 2 and odrshopth_thtype = 1 " + (shipdate_s.equals("")?"":(" and odrshopth_cldate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrshopth_cldate>'"+shipdate_e+"'")) + " group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype" 
						+ " union select distinct '"+shipdate_e+"至"+shipdate_s+"' as jsmst_period,shpmst_shopcode,shpmst_shopname,sum(Odrmst_ordermoney-Odrmst_giftfee+odrmst_shipfee-Odrmst_tktvalue-odrmst_ordermoney*shpmst_incomevalue) as sumprice,shpmst_sendtype from odrmst a, shpmst b where a.odrmst_sndshopcode = b.shpmst_shopcode and shpmst_sendtype = 2 " + (shipdate_s.equals("")?"":(" and odrmst_giftdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_giftdate>'"+shipdate_e+"'"))+" group by shpmst_shopcode, shpmst_shopname, shpmst_sendtype) a" 
						+ " where '"+ fmtDate+"-'+shpmst_shopcode not in(select jsmst_code from jsmst) group by shpmst_shopcode,shpmst_shopname,shpmst_sendtype,jsmst_period having sum(a.sumprice)>"+(jsmst_sumprice.equals("")?"0":jsmst_sumprice)+( shpmst_shopcode.equals("")?"":" and shpmst_shopcode = '"+shpmst_shopcode+"'");
			System.out.println(sql);
			session.createSQLQuery(sql).executeUpdate();
			
			sql = "insert jsdtl(jsdtl_jsmstcode,jsdtl_odrid,jsdtl_gdsprice,jsdtl_jmprice,jsdtl_gwjprice,jsdtl_giftfee,jsdtl_lmcommision,jsdtl_createdate, jsdtl_shipfee, jsdtl_gwjshare, jsdtl_flag,jsdtl_odrname,jsdtl_shipdate)"
					+" select distinct jsmst_code,odrmst_odrid,odrmst_ordermoney,isnull(odrmst_d1actmoney,0) as odrmst_d1actmoney,odrmst_tktvalue-isnull(odrmst_d1actmoney,0),0,(odrmst_ordermoney-odrmst_shipfee)*shpmst_incomevalue,getdate(),odrmst_shipfee,1,1,odrmst_rname,odrmst_shipdate from odrmst a, jsmst b, shpmst d where shpmst_shopcode = odrmst_sndshopcode and odrmst_sndshopcode = jsmst_shpcode   and jsmst_code = '"+jscode+"' " + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e+"'"))+" and odrmst_odrid not in (select jsdtl_odrid from jsdtl)";
			session.createSQLQuery(sql).executeUpdate();
			
			sql = "insert jsdtl(jsdtl_jsmstcode,jsdtl_odrid,jsdtl_gdsprice,jsdtl_jmprice,jsdtl_gwjprice,jsdtl_giftfee,jsdtl_lmcommision,jsdtl_createdate, jsdtl_shipfee, jsdtl_gwjshare, jsdtl_flag,jsdtl_odrname,jsdtl_shipdate)"
					+" select distinct jsmst_code,odrmst_odrid,odrmst_ordermoney,isnull(odrmst_d1actmoney,0) as odrmst_d1actmoney,odrmst_tktvalue-isnull(odrmst_d1actmoney,0),0,(odrmst_ordermoney-odrmst_shipfee)*shpmst_incomevalue,getdate(),odrmst_shipfee,1,1,odrmst_rname,odrmst_shipdate from odrmst_recent a, jsmst b, shpmst d where shpmst_shopcode = odrmst_sndshopcode and odrmst_sndshopcode = jsmst_shpcode and  jsmst_code = '"+jscode+"' " + (shipdate_s.equals("")?"":(" and odrmst_shipdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_shipdate>'"+shipdate_e+"'"))+" and odrmst_odrid not in (select jsdtl_odrid from jsdtl)";
			session.createSQLQuery(sql).executeUpdate();
			//退货
			sql = "insert jsdtl(jsdtl_jsmstcode,jsdtl_odrid,jsdtl_gdsprice,jsdtl_jmprice,jsdtl_gwjprice,jsdtl_giftfee,jsdtl_lmcommision,jsdtl_createdate, jsdtl_shipfee, jsdtl_gwjshare, jsdtl_flag,jsdtl_odrname,jsdtl_shipdate)"
					+" select jsmst_code, odrshopth_odrid, -sum(odrshopth_money),0,0,0,-sum(odrshopth_money*shpmst_incomevalue),getdate(),0,1,2,max(odrshopth_rname),max(odrshopth_shipdate) from odrshopth a, jsmst b, shpmst c where shpmst_shopcode = jsmst_shpcode and jsmst_shpcode = odrshopth_shopcode and  jsmst_code = '"+jscode+"' " + (shipdate_s.equals("")?"":(" and odrshopth_cldate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrshopth_cldate>'"+shipdate_e+"'"))+" and odrshopth_odrid not in (select jsdtl_odrid from jsdtl where jsdtl_flag=2) and   exists(select top 1 1  from jsdtl where jsdtl_odrid=odrshopth_odrid and jsdtl_flag<>2) group by jsmst_code, odrshopth_odrid";
			//System.out.println(sql);
			session.createSQLQuery(sql).executeUpdate();
			//送的运费
			sql = "insert jsdtl(jsdtl_jsmstcode,jsdtl_odrid,jsdtl_gdsprice,jsdtl_jmprice,jsdtl_gwjprice,jsdtl_giftfee,jsdtl_lmcommision,jsdtl_createdate, jsdtl_shipfee, jsdtl_gwjshare, jsdtl_flag,jsdtl_odrname,jsdtl_shipdate)"
				+" select distinct jsmst_code,odrmst_odrid,0,0,0,-odrmst_giftfee,0,getdate(),0,1,3,odrmst_rname,odrmst_shipdate from odrmst a, jsmst b, shpmst d where shpmst_shopcode = odrmst_sndshopcode and odrmst_sndshopcode = jsmst_shpcode  and  jsmst_code = '"+jscode+"' and odrmst_odrid not in (select jsdtl_odrid from jsdtl) " + (shipdate_s.equals("")?"":(" and odrmst_giftdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_giftdate>'"+shipdate_e+"'") );
			session.createSQLQuery(sql).executeUpdate();
			//送的运费
			sql = "insert jsdtl(jsdtl_jsmstcode,jsdtl_odrid,jsdtl_gdsprice,jsdtl_jmprice,jsdtl_gwjprice,jsdtl_giftfee,jsdtl_lmcommision,jsdtl_createdate, jsdtl_shipfee, jsdtl_gwjshare,jsdtl_flag,jsdtl_odrname,jsdtl_shipdate)"
					+" select distinct jsmst_code,odrmst_odrid,0,0,0,-odrmst_giftfee,0,getdate(),0,1,3,odrmst_rname,odrmst_shipdate from odrmst_recent a, jsmst b, shpmst d where shpmst_shopcode = odrmst_sndshopcode and odrmst_sndshopcode = jsmst_shpcode and  jsmst_code = '"+jscode+"' and odrmst_odrid not in (select jsdtl_odrid from jsdtl) " + (shipdate_s.equals("")?"":(" and odrmst_giftdate<'"+shipdate_s+"'")) + (shipdate_e.equals("")?"":(" and odrmst_giftdate>'"+shipdate_e+"'"));
				session.createSQLQuery(sql).executeUpdate();
			//聚会订单 0.3
			sql = "update jsdtl set jsdtl_lmcommision = case when odrmst_validdate>cast('2014-8-1' as datetime) then (jsdtl_gdsprice-jsdtl_shipfee)*0.3 else (jsdtl_gdsprice-jsdtl_shipfee)*0.2  end from odrmst, jsmst where odrmst_odrid = jsdtl_odrid and jsmst_code = jsdtl_jsmstcode and  jsmst_code = '"+jscode+"'  and odrmst_mbrid = 2316985 and jsmst_status = 0";
			session.createSQLQuery(sql).executeUpdate();
			//聚会订单recent 0.3
			sql = "update jsdtl set jsdtl_lmcommision = case when odrmst_validdate>cast('2014-8-1' as datetime) then (jsdtl_gdsprice-jsdtl_shipfee)*0.3 else (jsdtl_gdsprice-jsdtl_shipfee)*0.2  end from odrmst_recent, jsmst where odrmst_odrid = jsdtl_odrid and jsmst_code = jsdtl_jsmstcode and  jsmst_code = '"+jscode+"'  and odrmst_mbrid = 2316985 and jsmst_status = 0";
			session.createSQLQuery(sql).executeUpdate();
			
			//139
			sql = "update jsdtl set jsdtl_lmcommision =(jsdtl_gdsprice-jsdtl_shipfee)*0.2  from odrmst, jsmst where odrmst_odrid = jsdtl_odrid and jsmst_code = jsdtl_jsmstcode and  jsmst_code = '"+jscode+"'  and exists(select top 1 1 from odrdtl where odrdtl_odrid=odrmst_odrid and odrdtl_shipstatus>1 and odrdtl_tuancardno like 'mq139%' ) and jsmst_status = 0";
			session.createSQLQuery(sql).executeUpdate();
			//139recent 0.2
			sql = "update jsdtl set jsdtl_lmcommision =(jsdtl_gdsprice-jsdtl_shipfee)*0.2  from odrmst_recent, jsmst where odrmst_odrid = jsdtl_odrid and jsmst_code = jsdtl_jsmstcode and  jsmst_code = '"+jscode+"'  and exists(select top 1 1 from odrdtl_recent where odrdtl_odrid=odrmst_odrid and odrdtl_shipstatus>1 and odrdtl_tuancardno like 'mq139%' ) and jsmst_status = 0";
			session.createSQLQuery(sql).executeUpdate();

			sql = "update jsmst set jsmst_sumprice = sumprice from ("
					+ " select jsmst_code,sum((jsdtl_gdsprice-jsdtl_shipfee)-jsdtl_gwjprice+jsdtl_shipfee-jsdtl_jmprice+jsdtl_giftfee-jsdtl_lmcommision) as sumprice" 
					+ " from jsdtl b, jsmst c where jsdtl_jsmstcode = jsmst_code and jsmst_status=0 group by jsmst_code"
					+ " ) a join jsmst e on a.jsmst_code = e.jsmst_code where  e.jsmst_code = '"+jscode+"' ";
			session.createSQLQuery(sql).executeUpdate();
			tx.commit();
			}catch(Exception ex){
				tx.rollback();
				ex.printStackTrace(); 
		}finally{
			MyHibernateUtil.closeSession(HIBERNATE_FILE);
		}
		
	}
}
