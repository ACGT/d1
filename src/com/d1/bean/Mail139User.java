package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 139” œ‰”√ªß±Ì
 * @author kk
 *
 */
@Entity
@Table(name="mbr139")
public class Mail139User extends BaseEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	@Column(name="mbr139_id")
	private String id ;//done
	
	private String mbr139_userAccount;
	private Long mbr139_rtype;
	private String mbr139_rurl;
	private Long mbr139_mbrid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbr139_userAccount() {
		return mbr139_userAccount;
	}
	public void setMbr139_userAccount(String mbr139_userAccount) {
		this.mbr139_userAccount = mbr139_userAccount;
	}
	public Long getMbr139_rtype() {
		return mbr139_rtype;
	}
	public void setMbr139_rtype(Long mbr139_rtype) {
		this.mbr139_rtype = mbr139_rtype;
	}
	public String getMbr139_rurl() {
		return mbr139_rurl;
	}
	public void setMbr139_rurl(String mbr139_rurl) {
		this.mbr139_rurl = mbr139_rurl;
	}
	public Long getMbr139_mbrid() {
		return mbr139_mbrid;
	}
	public void setMbr139_mbrid(Long mbr139_mbrid) {
		this.mbr139_mbrid = mbr139_mbrid;
	}


}
