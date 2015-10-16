package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="shpmst")
public class ShpMst extends BaseEntity implements java.io.Serializable {
	/**
	 * v id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="shpmst_shopcode")
	private String id;//done
	private String shpmst_shopname;
	private Long   shpmst_status;
	private Long shpmst_incometype;
	private String shpmst_bulletin;
    private String shpmst_afterSaleservice;
    private String shpmst_intro;
    private String shpmst_postaddr;
  	private String shpmst_email2;
	private float shpmst_incomevalue;
	private Long shpmst_index;

	private String shpmst_rck;
	private String shpmst_bp;
	private String shpmst_fax;
	private Long shpmst_sendtype;
	private String shpmst_shopsname;//商户缩写名
	
	private String shpmst_address;
	private String shpmst_mp;//商家手机号
	
	private Float shpmst_24hsend;
	private Float shpmst_last24hsend;
	
	public String getShpmst_address() {
		return shpmst_address;
	}

	public void setShpmst_address(String shpmst_address) {
		this.shpmst_address = shpmst_address;
	}

	public String getShpmst_mp() {
		return shpmst_mp;
	}

	public void setShpmst_mp(String shpmst_mp) {
		this.shpmst_mp = shpmst_mp;
	}

	public String getShpmst_shopsname() {
		return shpmst_shopsname;
	}

	public void setShpmst_shopsname(String shpmst_shopsname) {
		this.shpmst_shopsname = shpmst_shopsname;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getShpmst_shopname() {
		return shpmst_shopname;
	}
	public void setShpmst_shopname(String shpmst_shopname) {
		this.shpmst_shopname = shpmst_shopname;
	}
	public Long getShpmst_status() {
		return shpmst_status;
	}
	public void setShpmst_status(Long shpmst_status) {
		this.shpmst_status = shpmst_status;
	}
	public Long getShpmst_incometype() {
		return shpmst_incometype;
	}
	public void setShpmst_incometype(Long shpmst_incometype) {
		this.shpmst_incometype = shpmst_incometype;
	}
	public float getShpmst_incomevalue() {
		return shpmst_incomevalue;
	}
	public void setShpmst_incomevalue(float shpmst_incomevalue) {
		this.shpmst_incomevalue = shpmst_incomevalue;
	}
	public String getShpmst_bulletin() {
		return shpmst_bulletin;
	}
	public void setShpmst_bulletin(String shpmst_bulletin) {
		this.shpmst_bulletin = shpmst_bulletin;
	}
	public String getShpmst_rck() {
		return shpmst_rck;
	}
	public void setShpmst_rck(String shpmst_rck) {
		this.shpmst_rck = shpmst_rck;
	}
	public String getShpmst_afterSaleservice() {
		return shpmst_afterSaleservice;
	}

	public void setShpmst_afterSaleservice(String shpmst_afterSaleservice) {
		this.shpmst_afterSaleservice = shpmst_afterSaleservice;
	}
	public String getShpmst_postaddr() {
			return shpmst_postaddr;
		}

    public void setShpmst_postaddr(String shpmst_postaddr) {
			this.shpmst_postaddr = shpmst_postaddr;
		}
	public String getShpmst_intro() {
		return shpmst_intro;
	}

	public void setShpmst_intro(String shpmst_intro) {
		this.shpmst_intro = shpmst_intro;
	}
	public String getShpmst_email2() {
		return shpmst_email2;
	}

	public void setShpmst_email2(String shpmst_email2) {
		this.shpmst_email2 = shpmst_email2;
	}

	public String getShpmst_bp() {
		return shpmst_bp;
	}

	public void setShpmst_bp(String shpmst_bp) {
		this.shpmst_bp = shpmst_bp;
	}

	public String getShpmst_fax() {
		return shpmst_fax;
	}

	public void setShpmst_fax(String shpmst_fax) {
		this.shpmst_fax = shpmst_fax;
	}
	public Long getShpmst_index() {
		return shpmst_index;
	}

	public void setShpmst_index(Long shpmst_index) {
		this.shpmst_index = shpmst_index;
	}

	public Long getShpmst_sendtype() {
		return shpmst_sendtype;
	}

	public void setShpmst_sendtype(Long shpmst_sendtype) {
		this.shpmst_sendtype = shpmst_sendtype;
	}

	public Float getShpmst_24hsend() {
		return shpmst_24hsend;
	}

	public void setShpmst_24hsend(Float shpmst_24hsend) {
		this.shpmst_24hsend = shpmst_24hsend;
	}

	public Float getShpmst_last24hsend() {
		return shpmst_last24hsend;
	}

	public void setShpmst_last24hsend(Float shpmst_last24hsend) {
		this.shpmst_last24hsend = shpmst_last24hsend;
	}
	
}
