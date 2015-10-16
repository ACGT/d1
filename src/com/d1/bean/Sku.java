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
 * 库存规格表
 * @author kk
 *
 */
@Entity
@Table(name="skumst")
public class Sku extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="sku_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id ;//done
	
	/**
	 * 商品id
	 */
	private String skumst_gdsid;
	
	/**
	 * 规格属性1
	 */
	private String skumst_sku1;
	
	/**
	 * 规格属性2，暂时没有用
	 */
	private String skumst_sku2;
	
	/**
	 * 1上架
	 */
	private Long skumst_validflag;
	
	/**
	 * 库存数
	 */
	private Long skumst_stock;
	
	/**
	 * 虚拟库存数
	 */
	private Long skumst_vstock;
	
	/**
	 * 创建日期
	 */
	private Date skumst_createdate;
	
	private String skumst_sizevalue1;
	private String skumst_sizevalue2;
	private String skumst_sizevalue3;
	private String skumst_sizevalue4;
	private String skumst_sizevalue5;
	private String skumst_sizevalue6;
	private String skumst_sizevalue7;
	private String skumst_sizevalue8;
	
	private Long skumst_outid=new Long(0);
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSkumst_gdsid() {
		return skumst_gdsid;
	}
	public void setSkumst_gdsid(String skumst_gdsid) {
		this.skumst_gdsid = skumst_gdsid;
	}
	public String getSkumst_sku1() {
		return skumst_sku1;
	}
	public void setSkumst_sku1(String skumst_sku1) {
		this.skumst_sku1 = skumst_sku1;
	}
	public String getSkumst_sku2() {
		return skumst_sku2;
	}
	public void setSkumst_sku2(String skumst_sku2) {
		this.skumst_sku2 = skumst_sku2;
	}
	public Long getSkumst_validflag() {
		return skumst_validflag;
	}
	public void setSkumst_validflag(Long skumst_validflag) {
		this.skumst_validflag = skumst_validflag;
	}
	public Long getSkumst_stock() {
		return skumst_stock;
	}
	public void setSkumst_stock(Long skumst_stock) {
		this.skumst_stock = skumst_stock;
	}
	public Long getSkumst_vstock() {
		return skumst_vstock;
	}
	public void setSkumst_vstock(Long skumst_vstock) {
		this.skumst_vstock = skumst_vstock;
	}
	public Date getSkumst_createdate() {
		return skumst_createdate;
	}
	public void setSkumst_createdate(Date skumst_createdate) {
		this.skumst_createdate = skumst_createdate;
	}
	public String getSkumst_sizevalue1() {
		return skumst_sizevalue1;
	}
	public void setSkumst_sizevalue1(String skumst_sizevalue1) {
		this.skumst_sizevalue1 = skumst_sizevalue1;
	}
	public String getSkumst_sizevalue2() {
		return skumst_sizevalue2;
	}
	public void setSkumst_sizevalue2(String skumst_sizevalue2) {
		this.skumst_sizevalue2 = skumst_sizevalue2;
	}
	public String getSkumst_sizevalue3() {
		return skumst_sizevalue3;
	}
	public void setSkumst_sizevalue3(String skumst_sizevalue3) {
		this.skumst_sizevalue3 = skumst_sizevalue3;
	}
	public String getSkumst_sizevalue4() {
		return skumst_sizevalue4;
	}
	public void setSkumst_sizevalue4(String skumst_sizevalue4) {
		this.skumst_sizevalue4 = skumst_sizevalue4;
	}
	public String getSkumst_sizevalue5() {
		return skumst_sizevalue5;
	}
	public void setSkumst_sizevalue5(String skumst_sizevalue5) {
		this.skumst_sizevalue5 = skumst_sizevalue5;
	}
	public String getSkumst_sizevalue6() {
		return skumst_sizevalue6;
	}
	public void setSkumst_sizevalue6(String skumst_sizevalue6) {
		this.skumst_sizevalue6 = skumst_sizevalue6;
	}
	public String getSkumst_sizevalue7() {
		return skumst_sizevalue7;
	}
	public void setSkumst_sizevalue7(String skumst_sizevalue7) {
		this.skumst_sizevalue7 = skumst_sizevalue7;
	}
	public String getSkumst_sizevalue8() {
		return skumst_sizevalue8;
	}
	public void setSkumst_sizevalue8(String skumst_sizevalue8) {
		this.skumst_sizevalue8 = skumst_sizevalue8;
	}
	public Long getSkumst_outid() {
		return skumst_outid;
	}
	public void setSkumst_outid(Long skumst_outid) {
		this.skumst_outid = skumst_outid;
	}
	
}
