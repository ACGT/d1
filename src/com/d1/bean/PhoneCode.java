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
 * ÊÖ»ú×¢²áÂë±í
 * @author 
 *
 */
@Entity
@Table(name="phonecode")
public class PhoneCode extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="phonecode_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String phonecode_tele;
	private String phonecode_code;
	private Long phonecode_status;
	private Date phonecode_updatetime;
	private Long phonecode_flag;
	private Date phonecode_updatetimeg;
	private Long phonecode_flagg;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPhonecode_tele() {
		return phonecode_tele;
	}
	public void setPhonecode_tele(String phonecode_tele) {
		this.phonecode_tele = phonecode_tele;
	}
	public String getPhonecode_code() {
		return phonecode_code;
	}
	public void setPhonecode_code(String phonecode_code) {
		this.phonecode_code = phonecode_code;
	}
	public Long getPhonecode_status() {
		return phonecode_status;
	}
	public void setPhonecode_status(Long phonecode_status) {
		this.phonecode_status = phonecode_status;
	}
	public Long getPhonecode_flag() {
		return phonecode_flag;
	}
	public void setPhonecode_flag(Long phonecode_flag) {
		this.phonecode_flag = phonecode_flag;
	}
	public Date getPhonecode_updatetime() {
		return phonecode_updatetime;
	}
	public void setPhonecode_updatetime(Date phonecode_updatetime) {
		this.phonecode_updatetime = phonecode_updatetime;
	}
	public Long getPhonecode_flagg() {
		return phonecode_flagg;
	}
	public void setPhonecode_flagg(Long phonecode_flagg) {
		this.phonecode_flagg = phonecode_flagg;
	}
	public Date getPhonecode_updatetimeg() {
		return phonecode_updatetimeg;
	}
	public void setPhonecode_updatetimeg(Date phonecode_updatetimeg) {
		this.phonecode_updatetimeg = phonecode_updatetimeg;
	}
	
}
