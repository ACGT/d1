package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="helpmst_code0909")
public class HelpCode extends BaseEntity implements java.io.Serializable {
	
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="helpcode_code")
	private String id;//done
	private String helpcode_name;
	private Long helpcode_typeid;
	private Long helpcode_hitcount;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHelpcode_name() {
		return helpcode_name;
	}
	public void setHelpcode_name(String helpcode_name) {
		this.helpcode_name = helpcode_name;
	}
	public Long getHelpcode_typeid() {
		return helpcode_typeid;
	}
	public void setHelpcode_typeid(Long helpcode_typeid) {
		this.helpcode_typeid = helpcode_typeid;
	}
	public Long getHelpcode_hitcount() {
		return helpcode_hitcount;
	}
	public void setHelpcode_hitcount(Long helpcode_hitcount) {
		this.helpcode_hitcount = helpcode_hitcount;
	}
	
	
}
