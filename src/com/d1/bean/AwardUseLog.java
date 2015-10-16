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
 * »ý·Ö¶Ò»»¼ÇÂ¼
 * @author kk
 *
 */
@Entity
@Table(name="scrchgawd")
public class AwardUseLog extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="scrchgawd_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long scrchgawd_mbrid;
	private String scrchgawd_uid;
	private String scrchgawd_name;
	private Long scrchgawd_awardid;
	private Date scrchgawd_applytime;
	private Long scrchgawd_status;
	private Date scrchgawd_updtime;
	private String scrchgawd_mbrmst_name;
	private String scrchgawd_mbrmst_haddr;
	private String scrchgawd_mbrmst_postcode;
	private String scrchgawd_mbrmst_usephone;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getScrchgawd_mbrid() {
		return scrchgawd_mbrid;
	}
	public void setScrchgawd_mbrid(Long scrchgawd_mbrid) {
		this.scrchgawd_mbrid = scrchgawd_mbrid;
	}
	public String getScrchgawd_uid() {
		return scrchgawd_uid;
	}
	public void setScrchgawd_uid(String scrchgawd_uid) {
		this.scrchgawd_uid = scrchgawd_uid;
	}
	public String getScrchgawd_name() {
		return scrchgawd_name;
	}
	public void setScrchgawd_name(String scrchgawd_name) {
		this.scrchgawd_name = scrchgawd_name;
	}
	public Long getScrchgawd_awardid() {
		return scrchgawd_awardid;
	}
	public void setScrchgawd_awardid(Long scrchgawd_awardid) {
		this.scrchgawd_awardid = scrchgawd_awardid;
	}
	public Date getScrchgawd_applytime() {
		return scrchgawd_applytime;
	}
	public void setScrchgawd_applytime(Date scrchgawd_applytime) {
		this.scrchgawd_applytime = scrchgawd_applytime;
	}
	public Long getScrchgawd_status() {
		return scrchgawd_status;
	}
	public void setScrchgawd_status(Long scrchgawd_status) {
		this.scrchgawd_status = scrchgawd_status;
	}
	public Date getScrchgawd_updtime() {
		return scrchgawd_updtime;
	}
	public void setScrchgawd_updtime(Date scrchgawd_updtime) {
		this.scrchgawd_updtime = scrchgawd_updtime;
	}
	public String getScrchgawd_mbrmst_name() {
		return scrchgawd_mbrmst_name;
	}
	public void setScrchgawd_mbrmst_name(String scrchgawd_mbrmst_name) {
		this.scrchgawd_mbrmst_name = scrchgawd_mbrmst_name;
	}
	public String getScrchgawd_mbrmst_haddr() {
		return scrchgawd_mbrmst_haddr;
	}
	public void setScrchgawd_mbrmst_haddr(String scrchgawd_mbrmst_haddr) {
		this.scrchgawd_mbrmst_haddr = scrchgawd_mbrmst_haddr;
	}
	public String getScrchgawd_mbrmst_postcode() {
		return scrchgawd_mbrmst_postcode;
	}
	public void setScrchgawd_mbrmst_postcode(String scrchgawd_mbrmst_postcode) {
		this.scrchgawd_mbrmst_postcode = scrchgawd_mbrmst_postcode;
	}
	public String getScrchgawd_mbrmst_usephone() {
		return scrchgawd_mbrmst_usephone;
	}
	public void setScrchgawd_mbrmst_usephone(String scrchgawd_mbrmst_usephone) {
		this.scrchgawd_mbrmst_usephone = scrchgawd_mbrmst_usephone;
	}
}
