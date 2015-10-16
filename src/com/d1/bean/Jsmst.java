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
 * 积分换购商品表，前台没有写操作
 * @author kk
 */
@Entity
@Table(name="jsmst",catalog="dba")
public class Jsmst extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="jsmst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String jsmst_code;
	private String jsmst_shpcode;//商户号
	private String jsmst_shpname;//商户名称
	private Double jsmst_sumprice=new Double(0);//结算金额
	private Date jsmst_createdate;//结算提交日期
	private Date jsmst_auditdate;//结算审核日期
	private Date jsmst_jsdate;//实际结算日期
	private String jsmst_jspicpath;//结算凭证路径
	private Long jsmst_status;//结算状态
	private String jsmst_period;//结算周期
	private String jsmst_createuser;//生成人
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getJsmst_code() {
		return jsmst_code;
	}
	public void setJsmst_code(String jsmst_code) {
		this.jsmst_code = jsmst_code;
	}
	public String getJsmst_shpcode() {
		return jsmst_shpcode;
	}
	public void setJsmst_shpcode(String jsmst_shpcode) {
		this.jsmst_shpcode = jsmst_shpcode;
	}
	public String getJsmst_shpname() {
		return jsmst_shpname;
	}
	public void setJsmst_shpname(String jsmst_shpname) {
		this.jsmst_shpname = jsmst_shpname;
	}
	public Double getJsmst_sumprice() {
		return jsmst_sumprice;
	}
	public void setJsmst_sumprice(Double jsmst_sumprice) {
		this.jsmst_sumprice = jsmst_sumprice;
	}
	public Date getJsmst_createdate() {
		return jsmst_createdate;
	}
	public void setJsmst_createdate(Date jsmst_createdate) {
		this.jsmst_createdate = jsmst_createdate;
	}
	public Date getJsmst_auditdate() {
		return jsmst_auditdate;
	}
	public void setJsmst_auditdate(Date jsmst_auditdate) {
		this.jsmst_auditdate = jsmst_auditdate;
	}
	public Date getJsmst_jsdate() {
		return jsmst_jsdate;
	}
	public void setJsmst_jsdate(Date jsmst_jsdate) {
		this.jsmst_jsdate = jsmst_jsdate;
	}
	public String getJsmst_jspicpath() {
		return jsmst_jspicpath;
	}
	public void setJsmst_jspicpath(String jsmst_jspicpath) {
		this.jsmst_jspicpath = jsmst_jspicpath;
	}
	public Long getJsmst_status() {
		return jsmst_status;
	}
	public void setJsmst_status(Long jsmst_status) {
		this.jsmst_status = jsmst_status;
	}
	public String getJsmst_period() {
		return jsmst_period;
	}
	public void setJsmst_period(String jsmst_period) {
		this.jsmst_period = jsmst_period;
	}
	public String getJsmst_createuser() {
		return jsmst_createuser;
	}
	public void setJsmst_createuser(String jsmst_createuser) {
		this.jsmst_createuser = jsmst_createuser;
	}
}
