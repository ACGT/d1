package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * x¼þÔùY¼þ
 * @author kk
 *
 */
@Entity
@Table(name="gdsmstxzy")
public class ProductXzY extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="gdsmstxzy_id")
	private String id;//done
	private Long gdsmstxzy_gdscount;
	private Long gdsmstxzy_zcount;
	private Long gdsmstxzy_validflag;
	private Date gdsmstxzy_startdate;
	private Date gdsmstxzy_enddate;
	private String gdsmstxzy_title;
	private String gdsmstxzy_content;
	private Long gdsmstxzy_sex;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdsmstxzy_gdscount() {
		return gdsmstxzy_gdscount;
	}
	public void setGdsmstxzy_gdscount(Long gdsmstxzy_gdscount) {
		this.gdsmstxzy_gdscount = gdsmstxzy_gdscount;
	}
	public Long getGdsmstxzy_zcount() {
		return gdsmstxzy_zcount;
	}
	public void setGdsmstxzy_zcount(Long gdsmstxzy_zcount) {
		this.gdsmstxzy_zcount = gdsmstxzy_zcount;
	}
	public Long getGdsmstxzy_validflag() {
		return gdsmstxzy_validflag;
	}
	public void setGdsmstxzy_validflag(Long gdsmstxzy_validflag) {
		this.gdsmstxzy_validflag = gdsmstxzy_validflag;
	}
	public Date getGdsmstxzy_startdate() {
		return gdsmstxzy_startdate;
	}
	public void setGdsmstxzy_startdate(Date gdsmstxzy_startdate) {
		this.gdsmstxzy_startdate = gdsmstxzy_startdate;
	}
	public Date getGdsmstxzy_enddate() {
		return gdsmstxzy_enddate;
	}
	public void setGdsmstxzy_enddate(Date gdsmstxzy_enddate) {
		this.gdsmstxzy_enddate = gdsmstxzy_enddate;
	}
	public String getGdsmstxzy_title() {
		return gdsmstxzy_title;
	}
	public void setGdsmstxzy_title(String gdsmstxzy_title) {
		this.gdsmstxzy_title = gdsmstxzy_title;
	}
	public String getGdsmstxzy_content() {
		return gdsmstxzy_content;
	}
	public void setGdsmstxzy_content(String gdsmstxzy_content) {
		this.gdsmstxzy_content = gdsmstxzy_content;
	}
	public Long getGdsmstxzy_sex() {
		return gdsmstxzy_sex;
	}
	public void setGdsmstxzy_sex(Long gdsmstxzy_sex) {
		this.gdsmstxzy_sex = gdsmstxzy_sex;
	}
	
	
}
