package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品销量表
 * @author kk
 *
 */
@Entity
@Table(name="gdssale")
public class ProductSaleCount extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdssale_id")
	private String id ;//done
	
	private String gdssale_gdsid;
	private String gdssale_sku1;
	private String gdssale_sku2;
	private Long gdssale_salecount;
	private Long gdssale_sendcount;
	private Long gdssale_weeksalecount;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdssale_gdsid() {
		return gdssale_gdsid;
	}
	public void setGdssale_gdsid(String gdssale_gdsid) {
		this.gdssale_gdsid = gdssale_gdsid;
	}
	public String getGdssale_sku1() {
		return gdssale_sku1;
	}
	public void setGdssale_sku1(String gdssale_sku1) {
		this.gdssale_sku1 = gdssale_sku1;
	}
	public String getGdssale_sku2() {
		return gdssale_sku2;
	}
	public void setGdssale_sku2(String gdssale_sku2) {
		this.gdssale_sku2 = gdssale_sku2;
	}
	public Long getGdssale_salecount() {
		return gdssale_salecount;
	}
	public void setGdssale_salecount(Long gdssale_salecount) {
		this.gdssale_salecount = gdssale_salecount;
	}
	public Long getGdssale_sendcount() {
		return gdssale_sendcount;
	}
	public void setGdssale_sendcount(Long gdssale_sendcount) {
		this.gdssale_sendcount = gdssale_sendcount;
	}
	public Long getGdssale_weeksalecount() {
		return gdssale_weeksalecount;
	}
	public void setGdssale_weeksalecount(Long gdssale_weeksalecount) {
		this.gdssale_weeksalecount = gdssale_weeksalecount;
	}
	
	
}
