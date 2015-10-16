package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * xÔªÑ¡Y¼þ
 * @author kk
 *
 */
@Entity
@Table(name="gdsmstxsy")
public class ProductXsY extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="gdsmstxsy_id")
	private String id;//done
	
	private Float gdsmstxsy_finalprice;
	private Long gdsmstxsy_maxcount;
	private Long gdsmstxsy_allmoney;
	private Long gdsmstxsy_validflag;
	private Date gdsmstxsy_startdate;
	private Date gdsmstxsy_enddate;
	private String gdsmstxsy_title;
	private String gdsmstxsy_content;
	private Long gdsmstxsy_sex;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Float getGdsmstxsy_finalprice() {
		return gdsmstxsy_finalprice;
	}
	public void setGdsmstxsy_finalprice(Float gdsmstxsy_finalprice) {
		this.gdsmstxsy_finalprice = gdsmstxsy_finalprice;
	}
	public Long getGdsmstxsy_maxcount() {
		return gdsmstxsy_maxcount;
	}
	public void setGdsmstxsy_maxcount(Long gdsmstxsy_maxcount) {
		this.gdsmstxsy_maxcount = gdsmstxsy_maxcount;
	}
	public Long getGdsmstxsy_allmoney() {
		return gdsmstxsy_allmoney;
	}
	public void setGdsmstxsy_allmoney(Long gdsmstxsy_allmoney) {
		this.gdsmstxsy_allmoney = gdsmstxsy_allmoney;
	}
	public Long getGdsmstxsy_validflag() {
		return gdsmstxsy_validflag;
	}
	public void setGdsmstxsy_validflag(Long gdsmstxsy_validflag) {
		this.gdsmstxsy_validflag = gdsmstxsy_validflag;
	}
	public Date getGdsmstxsy_startdate() {
		return gdsmstxsy_startdate;
	}
	public void setGdsmstxsy_startdate(Date gdsmstxsy_startdate) {
		this.gdsmstxsy_startdate = gdsmstxsy_startdate;
	}
	public Date getGdsmstxsy_enddate() {
		return gdsmstxsy_enddate;
	}
	public void setGdsmstxsy_enddate(Date gdsmstxsy_enddate) {
		this.gdsmstxsy_enddate = gdsmstxsy_enddate;
	}
	public String getGdsmstxsy_title() {
		return gdsmstxsy_title;
	}
	public void setGdsmstxsy_title(String gdsmstxsy_title) {
		this.gdsmstxsy_title = gdsmstxsy_title;
	}
	public String getGdsmstxsy_content() {
		return gdsmstxsy_content;
	}
	public void setGdsmstxsy_content(String gdsmstxsy_content) {
		this.gdsmstxsy_content = gdsmstxsy_content;
	}
	public Long getGdsmstxsy_sex() {
		return gdsmstxsy_sex;
	}
	public void setGdsmstxsy_sex(Long gdsmstxsy_sex) {
		this.gdsmstxsy_sex = gdsmstxsy_sex;
	}
}
