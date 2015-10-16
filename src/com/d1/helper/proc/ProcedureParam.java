package com.d1.helper.proc;

public class ProcedureParam {
	private String name ;
	private String value ;
	
	private boolean isOutParameter;
	private int type;
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isOutParameter() {
		return isOutParameter;
	}
	public void setOutParameter(boolean isOutParameter) {
		this.isOutParameter = isOutParameter;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}
