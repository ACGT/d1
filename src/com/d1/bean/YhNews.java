package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ”≈ª›–¬Œ≈
 * @author kk
 *
 */
@Entity
@Table(name="yhnews")
public class YhNews extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="yhnews_id")
	private String id;
	private String yhnews_rackcode;
	private String yhnews_brand;
	private String yhnews_provide;
	private Long yhnews_reccode;
	private String yhnews_giftgdsid;
	private String yhnews_title;
	private String yhnews_link;
	private Long yhnews_seq;
	private Date yhnews_createtime;
	private Date yhnews_endtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getYhnews_rackcode() {
		return yhnews_rackcode;
	}
	public void setYhnews_rackcode(String yhnews_rackcode) {
		this.yhnews_rackcode = yhnews_rackcode;
	}
	public String getYhnews_brand() {
		return yhnews_brand;
	}
	public void setYhnews_brand(String yhnews_brand) {
		this.yhnews_brand = yhnews_brand;
	}
	public String getYhnews_provide() {
		return yhnews_provide;
	}
	public void setYhnews_provide(String yhnews_provide) {
		this.yhnews_provide = yhnews_provide;
	}
	public Long getYhnews_reccode() {
		return yhnews_reccode;
	}
	public void setYhnews_reccode(Long yhnews_reccode) {
		this.yhnews_reccode = yhnews_reccode;
	}
	public String getYhnews_giftgdsid() {
		return yhnews_giftgdsid;
	}
	public void setYhnews_giftgdsid(String yhnews_giftgdsid) {
		this.yhnews_giftgdsid = yhnews_giftgdsid;
	}
	public String getYhnews_title() {
		return yhnews_title;
	}
	public void setYhnews_title(String yhnews_title) {
		this.yhnews_title = yhnews_title;
	}
	public String getYhnews_link() {
		return yhnews_link;
	}
	public void setYhnews_link(String yhnews_link) {
		this.yhnews_link = yhnews_link;
	}
	public Long getYhnews_seq() {
		return yhnews_seq;
	}
	public void setYhnews_seq(Long yhnews_seq) {
		this.yhnews_seq = yhnews_seq;
	}
	public Date getYhnews_createtime() {
		return yhnews_createtime;
	}
	public void setYhnews_createtime(Date yhnews_createtime) {
		this.yhnews_createtime = yhnews_createtime;
	}
	public Date getYhnews_endtime() {
		return yhnews_endtime;
	}
	public void setYhnews_endtime(Date yhnews_endtime) {
		this.yhnews_endtime = yhnews_endtime;
	}
}
