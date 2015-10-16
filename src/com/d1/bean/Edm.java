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
@Table(name="edmmst")
public class Edm extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="edmmst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long edmmst_014;
	private Long edmmst_017001;
	private Long edmmst_015009;
	private Long edmmst_015002;
	private Long edmmst_017002;
	private Long edmmst_0170021;
	private Long edmmst_tg99;
	private String edmmst_email;
	private Date edmmst_adddate;
	private Date edmmst_update;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getEdmmst_014() {
		return edmmst_014;
	}
	public void setEdmmst_014(Long edmmst_014) {
		this.edmmst_014 = edmmst_014;
	}
	public Long getEdmmst_017001() {
		return edmmst_017001;
	}
	public void setEdmmst_017001(Long edmmst_017001) {
		this.edmmst_017001 = edmmst_017001;
	}
	public Long getEdmmst_015009() {
		return edmmst_015009;
	}
	public void setEdmmst_015009(Long edmmst_015009) {
		this.edmmst_015009 = edmmst_015009;
	}
	public Long getEdmmst_015002() {
		return edmmst_015002;
	}
	public void setEdmmst_015002(Long edmmst_015002) {
		this.edmmst_015002 = edmmst_015002;
	}
	public Long getEdmmst_017002() {
		return edmmst_017002;
	}
	public void setEdmmst_017002(Long edmmst_017002) {
		this.edmmst_017002 = edmmst_017002;
	}
	public Long getEdmmst_0170021() {
		return edmmst_0170021;
	}
	public void setEdmmst_0170021(Long edmmst_0170021) {
		this.edmmst_0170021 = edmmst_0170021;
	}
	public Long getEdmmst_tg99() {
		return edmmst_tg99;
	}
	public void setEdmmst_tg99(Long edmmst_tg99) {
		this.edmmst_tg99 = edmmst_tg99;
	}
	public String getEdmmst_email() {
		return edmmst_email;
	}
	public void setEdmmst_email(String edmmst_email) {
		this.edmmst_email = edmmst_email;
	}
	public Date getEdmmst_adddate() {
		return edmmst_adddate;
	}
	public void setEdmmst_adddate(Date edmmst_adddate) {
		this.edmmst_adddate = edmmst_adddate;
	}
	public Date getEdmmst_update() {
		return edmmst_update;
	}
	public void setEdmmst_update(Date edmmst_update) {
		this.edmmst_update = edmmst_update;
	}
}
