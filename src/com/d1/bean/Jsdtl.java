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
@Table(name="jsdtl",catalog="dba")
public class Jsdtl extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="jsdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String jsdtl_jsmstcode;//结算单号
	private String jsdtl_odrid;//订单号
	private Double jsdtl_gdsprice;//商品金额
	private Long jsdtl_jmprice;//减免金额
	private Long jsdtl_gwjprice;//购物卷
	private Long jsdtl_gwjshare;//购物卷分摊
	private Double jsdtl_giftfee;//运费补贴
	private Double jsdtl_lmcommision;//佣金
	private Date jsdtl_createdate=new Date();//创建时间
	private Double jsdtl_shipfee;
	private Long jsdtl_flag;
	private String jsdtl_odrname;
	private Date jsdtl_shipdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getJsdtl_jsmstcode() {
		return jsdtl_jsmstcode;
	}
	public void setJsdtl_jsmstcode(String jsdtl_jsmstcode) {
		this.jsdtl_jsmstcode = jsdtl_jsmstcode;
	}
	public String getJsdtl_odrid() {
		return jsdtl_odrid;
	}
	public void setJsdtl_odrid(String jsdtl_odrid) {
		this.jsdtl_odrid = jsdtl_odrid;
	}
	public Double getJsdtl_gdsprice() {
		return jsdtl_gdsprice;
	}
	public void setJsdtl_gdsprice(Double jsdtl_gdsprice) {
		this.jsdtl_gdsprice = jsdtl_gdsprice;
	}
	public Long getJsdtl_jmprice() {
		return jsdtl_jmprice;
	}
	public void setJsdtl_jmprice(Long jsdtl_jmprice) {
		this.jsdtl_jmprice = jsdtl_jmprice;
	}
	public Long getJsdtl_gwjprice() {
		return jsdtl_gwjprice;
	}
	public void setJsdtl_gwjprice(Long jsdtl_gwjprice) {
		this.jsdtl_gwjprice = jsdtl_gwjprice;
	}
	public Long getJsdtl_gwjshare() {
		return jsdtl_gwjshare;
	}
	public void setJsdtl_gwjshare(Long jsdtl_gwjshare) {
		this.jsdtl_gwjshare = jsdtl_gwjshare;
	}
	public Double getJsdtl_giftfee() {
		return jsdtl_giftfee;
	}
	public void setJsdtl_giftfee(Double jsdtl_giftfee) {
		this.jsdtl_giftfee = jsdtl_giftfee;
	}
	public Double getJsdtl_lmcommision() {
		return jsdtl_lmcommision;
	}
	public void setJsdtl_lmcommision(Double jsdtl_lmcommision) {
		this.jsdtl_lmcommision = jsdtl_lmcommision;
	}
	public Date getJsdtl_createdate() {
		return jsdtl_createdate;
	}
	public void setJsdtl_createdate(Date jsdtl_createdate) {
		this.jsdtl_createdate = jsdtl_createdate;
	}
	public Double getJsdtl_shipfee() {
		return jsdtl_shipfee;
	}
	public void setJsdtl_shipfee(Double jsdtl_shipfee) {
		this.jsdtl_shipfee = jsdtl_shipfee;
	}
	public Long getJsdtl_flag() {
		return jsdtl_flag;
	}
	public void setJsdtl_flag(Long jsdtl_flag) {
		this.jsdtl_flag = jsdtl_flag;
	}
	public String getJsdtl_odrname() {
		return jsdtl_odrname;
	}
	public void setJsdtl_odrname(String jsdtl_odrname) {
		this.jsdtl_odrname = jsdtl_odrname;
	}
	public Date getJsdtl_shipdate() {
		return jsdtl_shipdate;
	}
	public void setJsdtl_shipdate(Date jsdtl_shipdate) {
		this.jsdtl_shipdate = jsdtl_shipdate;
	}
}
