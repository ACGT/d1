package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 用于发短信
 * @author gjl
 *
 */
@Entity
@Table(name="smssnddtl")
public class SmsSndDtl extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String phone;
	private String mbrid;
	private String smstxt;
	private Long ifsend=new Long(0);
	private String temp1;
	private Date senddate ;
	private Date createdate=new Date();
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMbrid() {
		return mbrid;
	}
	public void setMbrid(String mbrid) {
		this.mbrid = mbrid;
	}
	public String getSmstxt() {
		return smstxt;
	}
	public void setSmstxt(String smstxt) {
		this.smstxt = smstxt;
	}
	public Long getIfsend() {
		return ifsend;
	}
	public void setIfsend(Long ifsend) {
		this.ifsend = ifsend;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public Date getSenddate() {
		return senddate;
	}
	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
}
