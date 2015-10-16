package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
@Entity
@Table(name="makemail")
public class MakEmail extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="makemail_id")
	private String id;//done
	private Long makemail_mbrid;
	private Long makemail_sex;
	private String makemail_std1;
	private String makemail_std2;
	private String makemail_std3;
	private String makemail_std4;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMakemail_mbrid() {
		return makemail_mbrid;
	}
	public void setMakemail_mbrid(Long makemail_mbrid) {
		this.makemail_mbrid = makemail_mbrid;
	}
	public Long getMakemail_sex() {
		return makemail_sex;
	}
	public void setMakemail_sex(Long makemail_sex) {
		this.makemail_sex = makemail_sex;
	}
	public String getMakemail_std1() {
		return makemail_std1;
	}
	public void setMakemail_std1(String makemail_std1) {
		this.makemail_std1 = makemail_std1;
	}
	public String getMakemail_std2() {
		return makemail_std2;
	}
	public void setMakemail_std2(String makemail_std2) {
		this.makemail_std2 = makemail_std2;
	}
	public String getMakemail_std3() {
		return makemail_std3;
	}
	public void setMakemail_std3(String makemail_std3) {
		this.makemail_std3 = makemail_std3;
	}
	public String getMakemail_std4() {
		return makemail_std4;
	}
	public void setMakemail_std4(String makemail_std4) {
		this.makemail_std4 = makemail_std4;
	}
	
}
