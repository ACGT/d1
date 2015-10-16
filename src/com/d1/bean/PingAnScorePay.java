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
 * 平安积分支付表
 * @author kk
 *
 */
@Entity
@Table(name="pinganodr")
public class PingAnScorePay extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="pinganodr_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String pinganodr_ttnumber;//PK
	private String pinganodr_odrid;
	private String pinganodr_operation;
	private String pinganodr_partner;
	private String pinganodr_memberid;
	private Float pinganodr_amount;
	private Date pinganodr_tttime;
	private Date pinganodr_tuitime;
	private String pinganodr_param;
	private String pinganodr_ctnumber;
	private String pinganodr_method;
	private String pinganodr_stnumber;
	private String pinganodr_errorcode;
	private Long pinganodr_status;
	private Date pinganodr_createdate;
	
	public String getPinganodr_ttnumber() {
		return pinganodr_ttnumber;
	}
	public void setPinganodr_ttnumber(String pinganodr_ttnumber) {
		this.pinganodr_ttnumber = pinganodr_ttnumber;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPinganodr_odrid() {
		return pinganodr_odrid;
	}
	public void setPinganodr_odrid(String pinganodr_odrid) {
		this.pinganodr_odrid = pinganodr_odrid;
	}
	public String getPinganodr_operation() {
		return pinganodr_operation;
	}
	public void setPinganodr_operation(String pinganodr_operation) {
		this.pinganodr_operation = pinganodr_operation;
	}
	public String getPinganodr_partner() {
		return pinganodr_partner;
	}
	public void setPinganodr_partner(String pinganodr_partner) {
		this.pinganodr_partner = pinganodr_partner;
	}
	public String getPinganodr_memberid() {
		return pinganodr_memberid;
	}
	public void setPinganodr_memberid(String pinganodr_memberid) {
		this.pinganodr_memberid = pinganodr_memberid;
	}
	public Float getPinganodr_amount() {
		return pinganodr_amount;
	}
	public void setPinganodr_amount(Float pinganodr_amount) {
		this.pinganodr_amount = pinganodr_amount;
	}
	public Date getPinganodr_tttime() {
		return pinganodr_tttime;
	}
	public void setPinganodr_tttime(Date pinganodr_tttime) {
		this.pinganodr_tttime = pinganodr_tttime;
	}
	public Date getPinganodr_tuitime() {
		return pinganodr_tuitime;
	}
	public void setPinganodr_tuitime(Date pinganodr_tuitime) {
		this.pinganodr_tuitime = pinganodr_tuitime;
	}
	public String getPinganodr_param() {
		return pinganodr_param;
	}
	public void setPinganodr_param(String pinganodr_param) {
		this.pinganodr_param = pinganodr_param;
	}
	public String getPinganodr_ctnumber() {
		return pinganodr_ctnumber;
	}
	public void setPinganodr_ctnumber(String pinganodr_ctnumber) {
		this.pinganodr_ctnumber = pinganodr_ctnumber;
	}
	public String getPinganodr_method() {
		return pinganodr_method;
	}
	public void setPinganodr_method(String pinganodr_method) {
		this.pinganodr_method = pinganodr_method;
	}
	public String getPinganodr_stnumber() {
		return pinganodr_stnumber;
	}
	public void setPinganodr_stnumber(String pinganodr_stnumber) {
		this.pinganodr_stnumber = pinganodr_stnumber;
	}
	public String getPinganodr_errorcode() {
		return pinganodr_errorcode;
	}
	public void setPinganodr_errorcode(String pinganodr_errorcode) {
		this.pinganodr_errorcode = pinganodr_errorcode;
	}
	public Long getPinganodr_status() {
		return pinganodr_status;
	}
	public void setPinganodr_status(Long pinganodr_status) {
		this.pinganodr_status = pinganodr_status;
	}
	public Date getPinganodr_createdate() {
		return pinganodr_createdate;
	}
	public void setPinganodr_createdate(Date pinganodr_createdate) {
		this.pinganodr_createdate = pinganodr_createdate;
	}
	
}
