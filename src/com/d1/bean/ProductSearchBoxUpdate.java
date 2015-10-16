package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="gdsbox_update")
public class ProductSearchBoxUpdate extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsbox_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private String gdsmst_gdsid;
	private Long gdsmst_action;
	private Date gdsbox_createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsmst_gdsid() {
		return gdsmst_gdsid;
	}
	public void setGdsmst_gdsid(String gdsmst_gdsid) {
		this.gdsmst_gdsid = gdsmst_gdsid;
	}
	public Long getGdsmst_action() {
		return gdsmst_action;
	}
	public void setGdsmst_action(Long gdsmst_action) {
		this.gdsmst_action = gdsmst_action;
	}
	public Date getGdsbox_createtime() {
		return gdsbox_createtime;
	}
	public void setGdsbox_createtime(Date gdsbox_createtime) {
		this.gdsbox_createtime = gdsbox_createtime;
	}
}
