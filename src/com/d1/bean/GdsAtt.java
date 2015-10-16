package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;



/**
 * ÉÌÆ·³ßÂë±íÍ¼
 * @author gjl
 *
 */
@Entity
@Table(name="gdsatt")
public class GdsAtt extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdsatt_id") 
	private String id;//done
	private String gdsatt_gdsid;
	private String gdsatt_type;
	private String gdsatt_name;
	private String gdsatt_style;
	private String gdsatt_content;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsatt_gdsid() {
		return gdsatt_gdsid;
	}
	public void setGdsatt_gdsid(String gdsatt_gdsid) {
		this.gdsatt_gdsid = gdsatt_gdsid;
	}
	public String getGdsatt_type() {
		return gdsatt_type;
	}
	public void setGdsatt_type(String gdsatt_type) {
		this.gdsatt_type = gdsatt_type;
	}
	public String getGdsatt_name() {
		return gdsatt_name;
	}
	public void setGdsatt_name(String gdsatt_name) {
		this.gdsatt_name = gdsatt_name;
	}
	public String getGdsatt_style() {
		return gdsatt_style;
	}
	public void setGdsatt_style(String gdsatt_style) {
		this.gdsatt_style = gdsatt_style;
	}
	public String getGdsatt_content() {
		return gdsatt_content;
	}
	public void setGdsatt_content(String gdsatt_content) {
		this.gdsatt_content = gdsatt_content;
	}



}
