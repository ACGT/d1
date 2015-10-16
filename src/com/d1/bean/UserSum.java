package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="mbrsum")
public class UserSum extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbrsum_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long mbrsum_mbrid;
	private Long mbrsum_sumorder;
	private Float mbrsum_summoney;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMbrsum_mbrid() {
		return mbrsum_mbrid;
	}
	public void setMbrsum_mbrid(Long mbrsum_mbrid) {
		this.mbrsum_mbrid = mbrsum_mbrid;
	}
	public Long getMbrsum_sumorder() {
		return mbrsum_sumorder;
	}
	public void setMbrsum_sumorder(Long mbrsum_sumorder) {
		this.mbrsum_sumorder = mbrsum_sumorder;
	}
	public Float getMbrsum_summoney() {
		return mbrsum_summoney;
	}
	public void setMbrsum_summoney(Float mbrsum_summoney) {
		this.mbrsum_summoney = mbrsum_summoney;
	}
}
