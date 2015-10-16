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
 * 记录当当订单状态（是否同步过库存，是否同步过订单等）
 * @author zpp
 *
 */
@Entity
@Table(name="odrdangd")
public class OrderDangD extends BaseEntity implements java.io.Serializable {

	/**
	 * searial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	/**
	 * 主键id
	 */
	@Column(name="odrdangd_id")
	private String id;//done
	
	private String odrdangd_dangdodrid;
	private String odrdangd_d1odrid;
	private Long odrdangd_mbrid;
	private String odrdangd_name;
	private String odrdangd_phone;
	private String odrdangd_mobile;
	private String odrdangd_email;
	private Long odrdangd_status;
	private Date odrdangd_createdate;
	private Double odrdangd_tktvalue;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrdangd_dangdodrid() {
		return odrdangd_dangdodrid;
	}
	public void setOdrdangd_dangdodrid(String odrdangd_dangdodrid) {
		this.odrdangd_dangdodrid = odrdangd_dangdodrid;
	}
	public Long getOdrdangd_mbrid() {
		return odrdangd_mbrid;
	}
	public void setOdrdangd_mbrid(Long odrdangd_mbrid) {
		this.odrdangd_mbrid = odrdangd_mbrid;
	}
	public String getOdrdangd_mobile() {
		return odrdangd_mobile;
	}
	public void setOdrdangd_mobile(String odrdangd_mobile) {
		this.odrdangd_mobile = odrdangd_mobile;
	}
	public String getOdrdangd_d1odrid() {
		return odrdangd_d1odrid;
	}
	public void setOdrdangd_d1odrid(String odrdangd_d1odrid) {
		this.odrdangd_d1odrid = odrdangd_d1odrid;
	}
	public String getOdrdangd_name() {
		return odrdangd_name;
	}
	public void setOdrdangd_name(String odrdangd_name) {
		this.odrdangd_name = odrdangd_name;
	}
	public String getOdrdangd_phone() {
		return odrdangd_phone;
	}
	public void setOdrdangd_phone(String odrdangd_phone) {
		this.odrdangd_phone = odrdangd_phone;
	}
	public String getOdrdangd_email() {
		return odrdangd_email;
	}
	public void setOdrdangd_email(String odrdangd_email) {
		this.odrdangd_email = odrdangd_email;
	}
	public Long getOdrdangd_status() {
		return odrdangd_status;
	}
	public void setOdrdangd_status(Long odrdangd_status) {
		this.odrdangd_status = odrdangd_status;
	}
	public Date getOdrdangd_createdate() {
		return odrdangd_createdate;
	}
	public void setOdrdangd_createdate(Date odrdangd_createdate) {
		this.odrdangd_createdate = odrdangd_createdate;
	}
	public Double getOdrdangd_tktvalue() {
		return odrdangd_tktvalue;
	}
	public void setOdrdangd_tktvalue(Double odrdangd_tktvalue) {
		this.odrdangd_tktvalue = odrdangd_tktvalue;
	}


}
