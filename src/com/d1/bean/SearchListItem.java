package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 搜索条件明细
 * @author kk
 *
 */
@Entity
@Table(name="searchdtl")
public class SearchListItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="searchdtl_id")
	private String id;//done
	
	/**
	 * productprice对应商品价格，productbrand对应商品品牌，Productother1-8对应商品gdsmst_stdvalue1-8
	 */
	private String searchdtl_searchlist_gdsmst;
	private String searchdtl_rackcode;
	private String searchdtl_searchlist_name;
	private String searchdtl_value;
	private String searchdtl_searchlist_atrdtl_unit;
	private Float searchdtl_count;
	private String searchdtl_type;
	private Long searchdtl_seq;
	private String searchdtl_stdmst_unit;
	private Long searchdtl_showflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSearchdtl_searchlist_gdsmst() {
		return searchdtl_searchlist_gdsmst;
	}
	public void setSearchdtl_searchlist_gdsmst(String searchdtl_searchlist_gdsmst) {
		this.searchdtl_searchlist_gdsmst = searchdtl_searchlist_gdsmst;
	}
	public String getSearchdtl_rackcode() {
		return searchdtl_rackcode;
	}
	public void setSearchdtl_rackcode(String searchdtl_rackcode) {
		this.searchdtl_rackcode = searchdtl_rackcode;
	}
	public String getSearchdtl_searchlist_name() {
		return searchdtl_searchlist_name;
	}
	public void setSearchdtl_searchlist_name(String searchdtl_searchlist_name) {
		this.searchdtl_searchlist_name = searchdtl_searchlist_name;
	}
	public String getSearchdtl_value() {
		return searchdtl_value;
	}
	public void setSearchdtl_value(String searchdtl_value) {
		this.searchdtl_value = searchdtl_value;
	}
	public String getSearchdtl_searchlist_atrdtl_unit() {
		return searchdtl_searchlist_atrdtl_unit;
	}
	public void setSearchdtl_searchlist_atrdtl_unit(
			String searchdtl_searchlist_atrdtl_unit) {
		this.searchdtl_searchlist_atrdtl_unit = searchdtl_searchlist_atrdtl_unit;
	}
	public Float getSearchdtl_count() {
		return searchdtl_count;
	}
	public void setSearchdtl_count(Float searchdtl_count) {
		this.searchdtl_count = searchdtl_count;
	}
	public String getSearchdtl_type() {
		return searchdtl_type;
	}
	public void setSearchdtl_type(String searchdtl_type) {
		this.searchdtl_type = searchdtl_type;
	}
	public Long getSearchdtl_seq() {
		return searchdtl_seq;
	}
	public void setSearchdtl_seq(Long searchdtl_seq) {
		this.searchdtl_seq = searchdtl_seq;
	}
	public String getSearchdtl_stdmst_unit() {
		return searchdtl_stdmst_unit;
	}
	public void setSearchdtl_stdmst_unit(String searchdtl_stdmst_unit) {
		this.searchdtl_stdmst_unit = searchdtl_stdmst_unit;
	}
	public Long getSearchdtl_showflag() {
		return searchdtl_showflag;
	}
	public void setSearchdtl_showflag(Long searchdtl_showflag) {
		this.searchdtl_showflag = searchdtl_showflag;
	}
	
}
