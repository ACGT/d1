package com.d1.bean;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="weixin_openid_mbrid_pair")

public class WeixinOpenIdMbrIdPair extends BaseEntity implements java.io.Serializable  {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	
	private String id;
	
	public String open_id = "";
	public String original_id = "";
	public int mbrmst_id = 0;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getOpenId() {
		return this.open_id;
	}
	
	public void setOpenId(String openId) {
		this.open_id = openId;
	}
	
	public String getOriginalId() {
		return this.original_id;
	}
	
	public void setOriginalId(String originalId) {
		this.original_id = originalId;
	}
	
	public int getMbrmstId() {
		return this.mbrmst_id;
	}
	
	public void setMbrmstId(int mbrmstId) {
		this.mbrmst_id = mbrmstId;
	}
	
	
}
