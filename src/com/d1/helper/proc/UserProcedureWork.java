package com.d1.helper.proc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.hibernate.jdbc.Work;



public class UserProcedureWork implements Work{
	private ArrayList<ProcedureParam> list ;
	private String procedureName;
	public UserProcedureWork(String procedureName,ArrayList<ProcedureParam> list){
		this.procedureName = procedureName;
		this.list = list ;
	}
	
	public void execute(Connection connection)throws SQLException{
		//调用存储过程把订单修改成“确认收款”状态，注意参数，有个参数是输出参数
		String pname = "{call "+this.procedureName+" (";
		for(int i=0;i<list.size();i++){
			pname+="?,";
		}
		pname = pname.substring(0,pname.length()-1);
		pname+=")}";
		
		CallableStatement stmt=connection.prepareCall(pname);
		for(int i=1;i<=list.size();i++){
			ProcedureParam pp=this.list.get(i-1);
			if(pp.isOutParameter()){
				stmt.registerOutParameter(i, pp.getType());
			}else{
				stmt.setString(i, pp.getValue());
			}
		}
		//stmt.setString(1, this.orderId);
		//stmt.registerOutParameter(2, Type.INT);
		stmt.executeUpdate();
	}
}
