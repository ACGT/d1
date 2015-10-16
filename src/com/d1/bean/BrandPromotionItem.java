package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 品牌减免明细表，前台只读
 * @author kk
 */
@Entity
@Table(name="brdtktdtl",catalog="dba")
public class BrandPromotionItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="brdtktdtl_id")
	private String id ;//done

	private Long brdtktdtl_mstid;
	private String brdtktdtl_brand;
	private String brdtktdtl_brandname;
	private Long brdtktdtl_validflag;
	private Date brdtktdtl_createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getBrdtktdtl_mstid() {
		return brdtktdtl_mstid;
	}
	public void setBrdtktdtl_mstid(Long brdtktdtl_mstid) {
		this.brdtktdtl_mstid = brdtktdtl_mstid;
	}
	public String getBrdtktdtl_brand() {
		return brdtktdtl_brand;
	}
	public void setBrdtktdtl_brand(String brdtktdtl_brand) {
		this.brdtktdtl_brand = brdtktdtl_brand;
	}
	public String getBrdtktdtl_brandname() {
		return brdtktdtl_brandname;
	}
	public void setBrdtktdtl_brandname(String brdtktdtl_brandname) {
		this.brdtktdtl_brandname = brdtktdtl_brandname;
	}
	public Long getBrdtktdtl_validflag() {
		return brdtktdtl_validflag;
	}
	public void setBrdtktdtl_validflag(Long brdtktdtl_validflag) {
		this.brdtktdtl_validflag = brdtktdtl_validflag;
	}
	public Date getBrdtktdtl_createtime() {
		return brdtktdtl_createtime;
	}
	public void setBrdtktdtl_createtime(Date brdtktdtl_createtime) {
		this.brdtktdtl_createtime = brdtktdtl_createtime;
	}
}
