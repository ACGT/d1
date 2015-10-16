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
 * 搭配明细表
 * @author wdx
 */
@Entity
@Table(name="gdscolldetail")
public class Gdscolldetail extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdscolldetail_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	
	/**
	 * 搭配主表id
	 */
	private Long gdscolldetail_gdscrollid;
	private String gdscolldetail_gdsid;
	private String gdscolldetail_title;
	private String gdscolldetail_url;
	private String gdscolldetail_otherimg;
	private Long gdscolldetail_sort;
	private Long gdscolldetail_flag;
	private Date gdscolldetail_createdate;
	private Long gdscolldetail_gdsflag;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdscolldetail_gdscrollid() {
		return gdscolldetail_gdscrollid;
	}
	public void setGdscolldetail_gdscrollid(Long gdscolldetail_gdscrollid) {
		this.gdscolldetail_gdscrollid = gdscolldetail_gdscrollid;
	}
	public String getGdscolldetail_gdsid() {
		return gdscolldetail_gdsid;
	}
	public void setGdscolldetail_gdsid(String gdscolldetail_gdsid) {
		this.gdscolldetail_gdsid = gdscolldetail_gdsid;
	}
	public String getGdscolldetail_title() {
		return gdscolldetail_title;
	}
	public void setGdscolldetail_title(String gdscolldetail_title) {
		this.gdscolldetail_title = gdscolldetail_title;
	}
	public String getGdscolldetail_url() {
		return gdscolldetail_url;
	}
	public void setGdscolldetail_url(String gdscolldetail_url) {
		this.gdscolldetail_url = gdscolldetail_url;
	}
	public String getGdscolldetail_otherimg() {
		return gdscolldetail_otherimg;
	}
	public void setGdscolldetail_otherimg(String gdscolldetail_otherimg) {
		this.gdscolldetail_otherimg = gdscolldetail_otherimg;
	}
	public Long getGdscolldetail_sort() {
		return gdscolldetail_sort;
	}
	public void setGdscolldetail_sort(Long gdscolldetail_sort) {
		this.gdscolldetail_sort = gdscolldetail_sort;
	}
	public Long getGdscolldetail_flag() {
		return gdscolldetail_flag;
	}
	public void setGdscolldetail_flag(Long gdscolldetail_flag) {
		this.gdscolldetail_flag = gdscolldetail_flag;
	}
	public Date getGdscolldetail_createdate() {
		return gdscolldetail_createdate;
	}
	public void setGdscolldetail_createdate(Date gdscolldetail_createdate) {
		this.gdscolldetail_createdate = gdscolldetail_createdate;
	}
	public Long getGdscolldetail_gdsflag() {
		return gdscolldetail_gdsflag;
	}
	public void setGdscolldetail_gdsflag(Long gdscolldetail_gdsflag) {
		this.gdscolldetail_gdsflag = gdscolldetail_gdsflag;
	}
	
	
	
}
