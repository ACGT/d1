package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="counterdtl")
public class CounterItem extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="counterdtl_id")
	private String id;//done
	private Long counterdtl_mstid;
	private Long counterdtl_pos;
	private Long counterdtl_type;
	private String counterdtl_title;
	private String counterdtl_code;
	private String counterdtl_imgurl;
	private Long counterdtl_status;
	private Long counterdtl_seq;
	private String counterdtl_imglink;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getCounterdtl_mstid() {
		return counterdtl_mstid;
	}
	public void setCounterdtl_mstid(Long counterdtl_mstid) {
		this.counterdtl_mstid = counterdtl_mstid;
	}
	public Long getCounterdtl_pos() {
		return counterdtl_pos;
	}
	public void setCounterdtl_pos(Long counterdtl_pos) {
		this.counterdtl_pos = counterdtl_pos;
	}
	public Long getCounterdtl_type() {
		return counterdtl_type;
	}
	public void setCounterdtl_type(Long counterdtl_type) {
		this.counterdtl_type = counterdtl_type;
	}
	public String getCounterdtl_title() {
		return counterdtl_title;
	}
	public void setCounterdtl_title(String counterdtl_title) {
		this.counterdtl_title = counterdtl_title;
	}
	public String getCounterdtl_code() {
		return counterdtl_code;
	}
	public void setCounterdtl_code(String counterdtl_code) {
		this.counterdtl_code = counterdtl_code;
	}
	public String getCounterdtl_imgurl() {
		return counterdtl_imgurl;
	}
	public void setCounterdtl_imgurl(String counterdtl_imgurl) {
		this.counterdtl_imgurl = counterdtl_imgurl;
	}
	public Long getCounterdtl_status() {
		return counterdtl_status;
	}
	public void setCounterdtl_status(Long counterdtl_status) {
		this.counterdtl_status = counterdtl_status;
	}
	public Long getCounterdtl_seq() {
		return counterdtl_seq;
	}
	public void setCounterdtl_seq(Long counterdtl_seq) {
		this.counterdtl_seq = counterdtl_seq;
	}
	public String getCounterdtl_imglink() {
		return counterdtl_imglink;
	}
	public void setCounterdtl_imglink(String counterdtl_imglink) {
		this.counterdtl_imglink = counterdtl_imglink;
	}
}
