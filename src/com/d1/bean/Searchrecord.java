
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
 * ËÑË÷¼ÇÂ¼±í
 * @author wdx
 *
 */
@Entity
@Table(name="searchrecord")
public class Searchrecord extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="searchrecord_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private String searchrecord_keyword;
	private Long searchrecord_count;
	private Date searchrecord_createtime;
	private String searchrecord_mbrname;
	private String searchrecord_ip;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSearchrecord_keyword() {
		return searchrecord_keyword;
	}
	public void setSearchrecord_keyword(String searchrecord_keyword) {
		this.searchrecord_keyword = searchrecord_keyword;
	}
	public Long getSearchrecord_count() {
		return searchrecord_count;
	}
	public void setSearchrecord_count(Long searchrecord_count) {
		this.searchrecord_count = searchrecord_count;
	}
	public Date getSearchrecord_createtime() {
		return searchrecord_createtime;
	}
	public void setSearchrecord_createtime(Date searchrecord_createtime) {
		this.searchrecord_createtime = searchrecord_createtime;
	}
	public String getSearchrecord_mbrname() {
		return searchrecord_mbrname;
	}
	public void setSearchrecord_mbrname(String searchrecord_mbrname) {
		this.searchrecord_mbrname = searchrecord_mbrname;
	}
	public String getSearchrecord_ip() {
		return searchrecord_ip;
	}
	public void setSearchrecord_ip(String searchrecord_ip) {
		this.searchrecord_ip = searchrecord_ip;
	}
	

}