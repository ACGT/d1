package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 组赠品分类表
 * @author kk
 *
 */
@Entity
@Table(name="giftgrpdtl")
public class GiftGroupItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="giftgrpdtl_id") 
	private String id;//done

	private Long giftgrpdtl_mstid;
	private Float giftgrpdtl_limitmoney;
	private Float giftgrpdtl_addmoney;
	private String giftgrpdtl_gdsid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGiftgrpdtl_mstid() {
		return giftgrpdtl_mstid;
	}
	public void setGiftgrpdtl_mstid(Long giftgrpdtl_mstid) {
		this.giftgrpdtl_mstid = giftgrpdtl_mstid;
	}
	public Float getGiftgrpdtl_limitmoney() {
		return giftgrpdtl_limitmoney;
	}
	public void setGiftgrpdtl_limitmoney(Float giftgrpdtl_limitmoney) {
		this.giftgrpdtl_limitmoney = giftgrpdtl_limitmoney;
	}
	public Float getGiftgrpdtl_addmoney() {
		return giftgrpdtl_addmoney;
	}
	public void setGiftgrpdtl_addmoney(Float giftgrpdtl_addmoney) {
		this.giftgrpdtl_addmoney = giftgrpdtl_addmoney;
	}
	public String getGiftgrpdtl_gdsid() {
		return giftgrpdtl_gdsid;
	}
	public void setGiftgrpdtl_gdsid(String giftgrpdtl_gdsid) {
		this.giftgrpdtl_gdsid = giftgrpdtl_gdsid;
	}
}
