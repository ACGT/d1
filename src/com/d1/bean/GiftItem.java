package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ÔùÆ·Ã÷Ï¸±í
 * @author kk
 *
 */
@Entity
@Table(name="GiftRckDtl")
public class GiftItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="giftrckdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private Long giftrckdtl_mstid;
	private Float giftrckdtl_limitmoney;
	private Float giftrckdtl_addmoney;
	private String giftrckdtl_gdsid;
	private Long giftrckdtl_usertype;
	private Long giftrckdtl_viewflag;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGiftrckdtl_mstid() {
		return giftrckdtl_mstid;
	}
	public void setGiftrckdtl_mstid(Long giftrckdtl_mstid) {
		this.giftrckdtl_mstid = giftrckdtl_mstid;
	}
	public Float getGiftrckdtl_limitmoney() {
		return giftrckdtl_limitmoney;
	}
	public void setGiftrckdtl_limitmoney(Float giftrckdtl_limitmoney) {
		this.giftrckdtl_limitmoney = giftrckdtl_limitmoney;
	}
	public Float getGiftrckdtl_addmoney() {
		return giftrckdtl_addmoney;
	}
	public void setGiftrckdtl_addmoney(Float giftrckdtl_addmoney) {
		this.giftrckdtl_addmoney = giftrckdtl_addmoney;
	}
	public String getGiftrckdtl_gdsid() {
		return giftrckdtl_gdsid;
	}
	public void setGiftrckdtl_gdsid(String giftrckdtl_gdsid) {
		this.giftrckdtl_gdsid = giftrckdtl_gdsid;
	}
	public Long getGiftrckdtl_usertype() {
		return giftrckdtl_usertype;
	}
	public void setGiftrckdtl_usertype(Long giftrckdtl_usertype) {
		this.giftrckdtl_usertype = giftrckdtl_usertype;
	}
	public Long getGiftrckdtl_viewflag() {
		return giftrckdtl_viewflag;
	}
	public void setGiftrckdtl_viewflag(Long giftrckdtl_viewflag) {
		this.giftrckdtl_viewflag = giftrckdtl_viewflag;
	}
}
