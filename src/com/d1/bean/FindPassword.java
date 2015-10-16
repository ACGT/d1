package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="selfFindPwd")
public class FindPassword extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="self_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String self_mbruid;
	private String self_md5key;
	private Date self_createtime;
	private Date self_validendtime;
	private Long self_sucflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSelf_mbruid() {
		return self_mbruid;
	}
	public void setSelf_mbruid(String self_mbruid) {
		this.self_mbruid = self_mbruid;
	}
	public String getSelf_md5key() {
		return self_md5key;
	}
	public void setSelf_md5key(String self_md5key) {
		this.self_md5key = self_md5key;
	}
	public Date getSelf_createtime() {
		return self_createtime;
	}
	public void setSelf_createtime(Date self_createtime) {
		this.self_createtime = self_createtime;
	}
	public Date getSelf_validendtime() {
		return self_validendtime;
	}
	public void setSelf_validendtime(Date self_validendtime) {
		this.self_validendtime = self_validendtime;
	}
	public Long getSelf_sucflag() {
		return self_sucflag;
	}
	public void setSelf_sucflag(Long self_sucflag) {
		this.self_sucflag = self_sucflag;
	}
}
