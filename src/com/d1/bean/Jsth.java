package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 积分换购商品表，前台没有写操作
 * @author kk
 */
@Entity
@Table(name="view_jsth",catalog="dba")
public class Jsth extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="odrshopth_subodrid",insertable=false,updatable=false)
	private String id;//done
	@Column(insertable=false,updatable=false)
	private Long odrshopth_id;
	@Column(insertable=false,updatable=false)
	private String odrshopth_odrid;
	@Column(insertable=false,updatable=false)
	private String odrshopth_subodrid;
	@Column(insertable=false,updatable=false)
	private Date odrshopth_cldate;
	@Column(insertable=false,updatable=false)
	private Double odrshopth_money;
	@Column(insertable=false,updatable=false)
	private String shpMst_shopcode;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getOdrshopth_id() {
		return odrshopth_id;
	}
	public void setOdrshopth_id(Long odrshopth_id) {
		this.odrshopth_id = odrshopth_id;
	}
	public String getOdrshopth_odrid() {
		return odrshopth_odrid;
	}
	public void setOdrshopth_odrid(String odrshopth_odrid) {
		this.odrshopth_odrid = odrshopth_odrid;
	}
	public String getOdrshopth_subodrid() {
		return odrshopth_subodrid;
	}
	public void setOdrshopth_subodrid(String odrshopth_subodrid) {
		this.odrshopth_subodrid = odrshopth_subodrid;
	}
	public Date getOdrshopth_cldate() {
		return odrshopth_cldate;
	}
	public void setOdrshopth_cldate(Date odrshopth_cldate) {
		this.odrshopth_cldate = odrshopth_cldate;
	}
	public Double getOdrshopth_money() {
		return odrshopth_money;
	}
	public void setOdrshopth_money(Double odrshopth_money) {
		this.odrshopth_money = odrshopth_money;
	}
	public String getShpMst_shopcode() {
		return shpMst_shopcode;
	}
	public void setShpMst_shopcode(String shpMst_shopcode) {
		this.shpMst_shopcode = shpMst_shopcode;
	}
}
