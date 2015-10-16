package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="helpmst0909")
public class HelpContent extends BaseEntity implements java.io.Serializable {
	
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="helpmst_id")
	private String id;//done
	private String hlepmst_title;
	private String helpmst_text;
	private Date helpmst_createdate;
	private String helpmst_code;
	private String helpmst_url;
	private String helpmst_keyword;
	private Long helpmst_hitcount;
	private Long helpmst_seq;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHlepmst_title() {
		return hlepmst_title;
	}
	public void setHlepmst_title(String hlepmst_title) {
		this.hlepmst_title = hlepmst_title;
	}
	public String getHelpmst_text() {
		return helpmst_text;
	}
	public void setHelpmst_text(String helpmst_text) {
		this.helpmst_text = helpmst_text;
	}
	public Date getHelpmst_createdate() {
		return helpmst_createdate;
	}
	public void setHelpmst_createdate(Date helpmst_createdate) {
		this.helpmst_createdate = helpmst_createdate;
	}
	public String getHelpmst_code() {
		return helpmst_code;
	}
	public void setHelpmst_code(String helpmst_code) {
		this.helpmst_code = helpmst_code;
	}
	public String getHelpmst_url() {
		return helpmst_url;
	}
	public void setHelpmst_url(String helpmst_url) {
		this.helpmst_url = helpmst_url;
	}
	public String getHelpmst_keyword() {
		return helpmst_keyword;
	}
	public void setHelpmst_keyword(String helpmst_keyword) {
		this.helpmst_keyword = helpmst_keyword;
	}
	public Long getHelpmst_hitcount() {
		return helpmst_hitcount;
	}
	public void setHelpmst_hitcount(Long helpmst_hitcount) {
		this.helpmst_hitcount = helpmst_hitcount;
	}
	public Long getHelpmst_seq() {
		return helpmst_seq;
	}
	public void setHelpmst_seq(Long helpmst_seq) {
		this.helpmst_seq = helpmst_seq;
	}
}
