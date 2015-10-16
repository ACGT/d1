package com.d1.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import org.hibernate.jdbc.Work;


/**
 * ʵ����Work�ӿڣ����ô洢���̣����ﲻ��Ҫ�ύ����Ϊ�������񷽷�����ʹ�á�<br/>
 * ��Ϊsession.connection()�Ѿ�deprecated���ˣ�������ô���ô洢���̣�����<br/>
 * @author kk
 */
public class ProcedureWork implements Work{
	private String orderId ;
	public ProcedureWork(String orderId){
		this.orderId = orderId ;
	}
	
	public void execute(Connection connection)throws SQLException{
		//���ô洢���̰Ѷ����޸ĳɡ�ȷ���տ״̬��ע��������и��������������
		//CallableStatement stmt=connection.prepareCall("{call sp_validodrNew2010(?,?)}");
		CallableStatement stmt=connection.prepareCall("{call sp_validodrnew2013(?,?)}");
		stmt.setString(1, this.orderId);
		stmt.registerOutParameter(2, Types.INTEGER);
		stmt.executeUpdate();
	}
}