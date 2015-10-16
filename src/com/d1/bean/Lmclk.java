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
 * 联盟点击日志表，前台只有写操作
 * @author kk
 */
@Entity
@Table(name="lmclk")
public class Lmclk extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="lmclk_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;
	private String lmclk_uid;
	private String lmclk_linkurl;
	private Date lmclk_createdate;
	private String lmclk_from;
	private String lmclk_ip;
	private String lmclk_subad;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLmclk_uid() {
		return lmclk_uid;
	}
	public void setLmclk_uid(String lmclk_uid) {
		this.lmclk_uid = lmclk_uid;
	}
	public String getLmclk_linkurl() {
		return lmclk_linkurl;
	}
	public void setLmclk_linkurl(String lmclk_linkurl) {
		this.lmclk_linkurl = lmclk_linkurl;
	}
	public Date getLmclk_createdate() {
		return lmclk_createdate;
	}
	public void setLmclk_createdate(Date lmclk_createdate) {
		this.lmclk_createdate = lmclk_createdate;
	}
	public String getLmclk_from() {
		return lmclk_from;
	}
	public void setLmclk_from(String lmclk_from) {
		this.lmclk_from = lmclk_from;
	}
	public String getLmclk_ip() {
		return lmclk_ip;
	}
	public void setLmclk_ip(String lmclk_ip) {
		this.lmclk_ip = lmclk_ip;
	}
	public String getLmclk_subad() {
		return lmclk_subad;
	}
	public void setLmclk_subad(String lmclk_subad) {
		this.lmclk_subad = lmclk_subad;
	}
	
}
