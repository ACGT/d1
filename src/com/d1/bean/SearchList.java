package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 搜索条件和分类对应关系表
 * @author kk
 *
 */
@Entity
@Table(name="searchlist")
public class SearchList extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="searchlist_id")
	private String id;//done
	
	private String searchlist_rackcode;
	private String searchlist_name;
	private Long searchlist_showflag;
	private Long searchlist_seq;
	private Date searchlist_createdate;
	private Date searchlist_updatedate;
	private String searchlist_gdsmst;
	private Long searchlist_type;
	private String searchlist_context;
	private String searchlist_iflist;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSearchlist_rackcode() {
		return searchlist_rackcode;
	}
	public void setSearchlist_rackcode(String searchlist_rackcode) {
		this.searchlist_rackcode = searchlist_rackcode;
	}
	public String getSearchlist_name() {
		return searchlist_name;
	}
	public void setSearchlist_name(String searchlist_name) {
		this.searchlist_name = searchlist_name;
	}
	public Long getSearchlist_showflag() {
		return searchlist_showflag;
	}
	public void setSearchlist_showflag(Long searchlist_showflag) {
		this.searchlist_showflag = searchlist_showflag;
	}
	public Long getSearchlist_seq() {
		return searchlist_seq;
	}
	public void setSearchlist_seq(Long searchlist_seq) {
		this.searchlist_seq = searchlist_seq;
	}
	public Date getSearchlist_createdate() {
		return searchlist_createdate;
	}
	public void setSearchlist_createdate(Date searchlist_createdate) {
		this.searchlist_createdate = searchlist_createdate;
	}
	public Date getSearchlist_updatedate() {
		return searchlist_updatedate;
	}
	public void setSearchlist_updatedate(Date searchlist_updatedate) {
		this.searchlist_updatedate = searchlist_updatedate;
	}
	public String getSearchlist_gdsmst() {
		return searchlist_gdsmst;
	}
	public void setSearchlist_gdsmst(String searchlist_gdsmst) {
		this.searchlist_gdsmst = searchlist_gdsmst;
	}
	public Long getSearchlist_type() {
		return searchlist_type;
	}
	public void setSearchlist_type(Long searchlist_type) {
		this.searchlist_type = searchlist_type;
	}
	public String getSearchlist_context() {
		return searchlist_context;
	}
	public void setSearchlist_context(String searchlist_context) {
		this.searchlist_context = searchlist_context;
	}
	public String getSearchlist_iflist() {
		return searchlist_iflist;
	}
	public void setSearchlist_iflist(String searchlist_iflist) {
		this.searchlist_iflist = searchlist_iflist;
	}

}
