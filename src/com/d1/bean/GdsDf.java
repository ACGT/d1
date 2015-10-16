package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
/**
 * 
 * @author jlgao
 *商户代发商品表
 */
@Entity
@Table(name="gdsdf",catalog="dba")
public class GdsDf extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsdf_gdsid")
	private String id;//done
	private String gdsdf_gdsname;
	private String gdsdf_shopcode;
	private String gdsdf_shopname;
	private String gdsdf_brand;
	private String gdsdf_brandname;
	private String gdsdf_rackcode;
	private Long   gdsdf_validflag;
	private float  gdsdf_price;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsdf_gdsname() {
		return gdsdf_gdsname;
	}
	public void setGdsdf_gdsname(String gdsdf_gdsname) {
		this.gdsdf_gdsname = gdsdf_gdsname;
	}
	public String getGdsdf_shopcode() {
		return gdsdf_shopcode;
	}
	public void setGdsdf_shopcode(String gdsdf_shopcode) {
		this.gdsdf_shopcode = gdsdf_shopcode;
	}
	public String getGdsdf_shopname() {
		return gdsdf_shopname;
	}
	public void setGdsdf_shopname(String gdsdf_shopname) {
		this.gdsdf_shopname = gdsdf_shopname;
	}
	public String getGdsdf_brand() {
		return gdsdf_brand;
	}
	public void setGdsdf_brand(String gdsdf_brand) {
		this.gdsdf_brand = gdsdf_brand;
	}
	public String getGdsdf_brandname() {
		return gdsdf_brandname;
	}
	public void setGdsdf_brandname(String gdsdf_brandname) {
		this.gdsdf_brandname = gdsdf_brandname;
	}
	public String getGdsdf_rackcode() {
		return gdsdf_rackcode;
	}
	public void setGdsdf_rackcode(String gdsdf_rackcode) {
		this.gdsdf_rackcode = gdsdf_rackcode;
	}
	public Long getGdsdf_validflag() {
		return gdsdf_validflag;
	}
	public void setGdsdf_validflag(Long gdsdf_validflag) {
		this.gdsdf_validflag = gdsdf_validflag;
	}
	public float getGdsdf_price() {
		return gdsdf_price;
	}
	public void setGdsdf_price(float gdsdf_price) {
		this.gdsdf_price = gdsdf_price;
	}
	
	//create table   gdsdf(gdsdf_gdsid char(8),gdsdf_shopcode char(8),gdsdf_shopname varchar(100),gdsdf_validflag smallint,gdsdf_price float,gdsdf_createdate datetime default(getdate()))
//gdsdf_brand char(10),gdsdf_brandname varchar(50),gdsdf_rackcode varchar(20)
}
