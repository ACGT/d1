package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 2345导航分类对应
 * @author gjl
 *
 */
@Entity
@Table(name="rck2345")
public class Rck2345 extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="rck_id")
	private String id;//done
	private String rck_code ;
	private String rck_name ;
	private String rck_2345name1 ;
	private String rck_2345name2 ;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRck_code() {
		return rck_code;
	}
	public void setRck_code(String rck_code) {
		this.rck_code = rck_code;
	}
	public String getRck_name() {
		return rck_name;
	}
	public void setRck_name(String rck_name) {
		this.rck_name = rck_name;
	}
	public String getRck_2345name1() {
		return rck_2345name1;
	}
	public void setRck_2345name1(String rck_2345name1) {
		this.rck_2345name1 = rck_2345name1;
	}
	public String getRck_2345name2() {
		return rck_2345name2;
	}
	public void setRck_2345name2(String rck_2345name2) {
		this.rck_2345name2 = rck_2345name2;
	}
	

}
