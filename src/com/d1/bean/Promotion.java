package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 文字图片推荐位表
 * @author kk
 *
 */
@Entity
@Table(name="splmst")
public class Promotion extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="splmst_id")
	private String id;//done

	private String splmst_rackcode;
	private Long splmst_code;
	private String splmst_subid;
	private String splmst_name;
	private String splmst_url;
	private Long splmst_seqview;
	private Date splmst_createdate;
	private Date splmst_updatedate;
	private String splmst_picstr;
	private String splmst_picstr2;
	private Date splmst_tjendtime;
	private Long splmst_areaid;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSplmst_rackcode() {
		return splmst_rackcode;
	}
	public void setSplmst_rackcode(String splmst_rackcode) {
		this.splmst_rackcode = splmst_rackcode;
	}
	public Long getSplmst_code() {
		return splmst_code;
	}
	public void setSplmst_code(Long splmst_code) {
		this.splmst_code = splmst_code;
	}
	public String getSplmst_subid() {
		return splmst_subid;
	}
	public void setSplmst_subid(String splmst_subid) {
		this.splmst_subid = splmst_subid;
	}
	public String getSplmst_name() {
		return splmst_name;
	}
	public void setSplmst_name(String splmst_name) {
		this.splmst_name = splmst_name;
	}
	public String getSplmst_url() {
		return splmst_url;
	}
	public void setSplmst_url(String splmst_url) {
		this.splmst_url = splmst_url;
	}
	public Long getSplmst_seqview() {
		return splmst_seqview;
	}
	public void setSplmst_seqview(Long splmst_seqview) {
		this.splmst_seqview = splmst_seqview;
	}
	public Date getSplmst_createdate() {
		return splmst_createdate;
	}
	public void setSplmst_createdate(Date splmst_createdate) {
		this.splmst_createdate = splmst_createdate;
	}
	public Date getSplmst_updatedate() {
		return splmst_updatedate;
	}
	public void setSplmst_updatedate(Date splmst_updatedate) {
		this.splmst_updatedate = splmst_updatedate;
	}
	public String getSplmst_picstr() {
		return splmst_picstr;
	}
	public void setSplmst_picstr(String splmst_picstr) {
		this.splmst_picstr = splmst_picstr;
	}
	public String getSplmst_picstr2() {
		return splmst_picstr2;
	}
	public void setSplmst_picstr2(String splmst_picstr2) {
		this.splmst_picstr2 = splmst_picstr2;
	}
	public Date getSplmst_tjendtime() {
		return splmst_tjendtime;
	}
	public void setSplmst_tjendtime(Date splmst_tjendtime) {
		this.splmst_tjendtime = splmst_tjendtime;
	}
	public Long getSplmst_areaid() {
		return splmst_areaid;
	}
	public void setSplmst_areaid(Long splmst_areaid) {
		this.splmst_areaid = splmst_areaid;
	}
	
}
