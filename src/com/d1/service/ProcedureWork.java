package com.d1.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import org.hibernate.jdbc.Work;


/**
 * 实现了Work接口，调用存储过程，这里不需要提交，因为放在事务方法里面使用。<br/>
 * 因为session.connection()已经deprecated掉了，所以这么调用存储过程！！！<br/>
 * @author kk
 */
public class ProcedureWork implements Work{
	private String orderId ;
	public ProcedureWork(String orderId){
		this.orderId = orderId ;
	}
	
	public void execute(Connection connection)throws SQLException{
		//调用存储过程把订单修改成“确认收款”状态，注意参数，有个参数是输出参数
		//CallableStatement stmt=connection.prepareCall("{call sp_validodrNew2010(?,?)}");
		CallableStatement stmt=connection.prepareCall("{call sp_validodrnew2013(?,?)}");
		stmt.setString(1, this.orderId);
		stmt.registerOutParameter(2, Types.INTEGER);
		stmt.executeUpdate();
	}
}