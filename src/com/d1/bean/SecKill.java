package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 秒杀表
 * @author kk
 *
 */
@Entity
@Table(name="mstjgds")
public class SecKill extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mstjgds_id")
	private String id;
	
	private String mstjgds_gdsid;
	private Date mstjgds_starttime;
	private Date mstjgds_endtime;
	
	/**
	 * 1=正在秒杀的商品
	 */
	private Long mstjgds_state;
	private Float mstjgds_tjprice;
	private String mstjgds_picstr;
	private String mstjgds_picstr2;
	private Date mstjgds_createtime;
	private Long mstjgds_maxcount;
	private Long mstjgds_count;
	private Long mstjgds_sort;
	private String  mstjgds_picurl;
	private String  mstjgds_downtime;

	private String  mstjgds_memo;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMstjgds_gdsid() {
		return mstjgds_gdsid;
	}
	public void setMstjgds_gdsid(String mstjgds_gdsid) {
		this.mstjgds_gdsid = mstjgds_gdsid;
	}
	public Date getMstjgds_starttime() {
		return mstjgds_starttime;
	}
	public void setMstjgds_starttime(Date mstjgds_starttime) {
		this.mstjgds_starttime = mstjgds_starttime;
	}
	public Date getMstjgds_endtime() {
		return mstjgds_endtime;
	}
	public void setMstjgds_endtime(Date mstjgds_endtime) {
		this.mstjgds_endtime = mstjgds_endtime;
	}
	public Long getMstjgds_state() {
		return mstjgds_state;
	}
	public void setMstjgds_state(Long mstjgds_state) {
		this.mstjgds_state = mstjgds_state;
	}
	public Float getMstjgds_tjprice() {
		return mstjgds_tjprice;
	}
	public void setMstjgds_tjprice(Float mstjgds_tjprice) {
		this.mstjgds_tjprice = mstjgds_tjprice;
	}
	public String getMstjgds_picstr() {
		return mstjgds_picstr;
	}
	public void setMstjgds_picstr(String mstjgds_picstr) {
		this.mstjgds_picstr = mstjgds_picstr;
	}
	public String getMstjgds_picstr2() {
		return mstjgds_picstr2;
	}
	public void setMstjgds_picstr2(String mstjgds_picstr2) {
		this.mstjgds_picstr2 = mstjgds_picstr2;
	}
	public Date getMstjgds_createtime() {
		return mstjgds_createtime;
	}
	public void setMstjgds_createtime(Date mstjgds_createtime) {
		this.mstjgds_createtime = mstjgds_createtime;
	}
	public Long getMstjgds_maxcount() {
		return mstjgds_maxcount;
	}
	public void setMstjgds_maxcount(Long mstjgds_maxcount) {
		this.mstjgds_maxcount = mstjgds_maxcount;
	}
	public Long getMstjgds_count() {
		return mstjgds_count;
	}
	public void setMstjgds_count(Long mstjgds_count) {
		this.mstjgds_count = mstjgds_count;
	}
	public Long getMstjgds_sort() {
		return mstjgds_sort;
	}
	public void setMstjgds_sort(Long mstjgds_sort) {
		this.mstjgds_sort = mstjgds_sort;
	}
	public String getMstjgds_picurl() {
		return mstjgds_picurl;
	}
	public void setMstjgds_picurl(String mstjgds_picurl) {
		this.mstjgds_picurl = mstjgds_picurl;
	}
	public String getMstjgds_memo() {
		return mstjgds_memo;
	}
	public void setMstjgds_memo(String mstjgds_memo) {
		this.mstjgds_memo = mstjgds_memo;
	}
	public String getMstjgds_downtime() {
		return mstjgds_downtime;
	}
	public void setMstjgds_downtime(String mstjgds_downtime) {
		this.mstjgds_downtime = mstjgds_downtime;
	}
}
