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
 * 订单取消日志表
 * @author kk
 *
 */
@Entity
@Table(name="odrlog_cancel")
public class OrderCancel extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="odrlog_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private String odrlog_odrid;
	private Long odrlog_subodrid;
	private String odrlog_mngname;
	private Date odrlog_createtime;
	private Long odrlog_type;
	private String odrlog_memo;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrlog_odrid() {
		return odrlog_odrid;
	}
	public void setOdrlog_odrid(String odrlog_odrid) {
		this.odrlog_odrid = odrlog_odrid;
	}
	public Long getOdrlog_subodrid() {
		return odrlog_subodrid;
	}
	public void setOdrlog_subodrid(Long odrlog_subodrid) {
		this.odrlog_subodrid = odrlog_subodrid;
	}
	public String getOdrlog_mngname() {
		return odrlog_mngname;
	}
	public void setOdrlog_mngname(String odrlog_mngname) {
		this.odrlog_mngname = odrlog_mngname;
	}
	public Date getOdrlog_createtime() {
		return odrlog_createtime;
	}
	public void setOdrlog_createtime(Date odrlog_createtime) {
		this.odrlog_createtime = odrlog_createtime;
	}
	public Long getOdrlog_type() {
		return odrlog_type;
	}
	public void setOdrlog_type(Long odrlog_type) {
		this.odrlog_type = odrlog_type;
	}
	public String getOdrlog_memo() {
		return odrlog_memo;
	}
	public void setOdrlog_memo(String odrlog_memo) {
		this.odrlog_memo = odrlog_memo;
	}
	
}
