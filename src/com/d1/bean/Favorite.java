package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品收藏表
 * @author kk
 *
 */
@Entity
@Table(name="gdswil")
public class Favorite extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdswil_id") 
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private Long gdswil_mbrid;
	private String gdswil_shopcode;
	private String gdswil_gdsid;
	private String gdswil_gdsname;
	private Long gdswil_count;
	private Date gdswil_applytime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdswil_mbrid() {
		return gdswil_mbrid;
	}
	public void setGdswil_mbrid(Long gdswil_mbrid) {
		this.gdswil_mbrid = gdswil_mbrid;
	}
	public String getGdswil_shopcode() {
		return gdswil_shopcode;
	}
	public void setGdswil_shopcode(String gdswil_shopcode) {
		this.gdswil_shopcode = gdswil_shopcode;
	}
	public String getGdswil_gdsid() {
		return gdswil_gdsid;
	}
	public void setGdswil_gdsid(String gdswil_gdsid) {
		this.gdswil_gdsid = gdswil_gdsid;
	}
	public String getGdswil_gdsname() {
		return gdswil_gdsname;
	}
	public void setGdswil_gdsname(String gdswil_gdsname) {
		this.gdswil_gdsname = gdswil_gdsname;
	}
	public Long getGdswil_count() {
		return gdswil_count;
	}
	public void setGdswil_count(Long gdswil_count) {
		this.gdswil_count = gdswil_count;
	}
	public Date getGdswil_applytime() {
		return gdswil_applytime;
	}
	public void setGdswil_applytime(Date gdswil_applytime) {
		this.gdswil_applytime = gdswil_applytime;
	}
	
}
