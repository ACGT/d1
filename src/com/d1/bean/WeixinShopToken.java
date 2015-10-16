package com.d1.bean;

import javax.persistence.Column;

//import java.util.Date;

//import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

//import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="weixin_shop_token")

public class WeixinShopToken extends BaseEntity implements java.io.Serializable {
	
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	
	public String id;
	public String open_id;
	public String original_id;
	public long expire_date;
	public int status;
	public String token;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public void setExpire_date(long expireDate) {
		this.expire_date = expireDate;
	}
	public long getExpire_date() {	
		return this.expire_date;
	}
	public void setOpen_id(String openId) {	
		this.open_id = openId;		
	}	
	public String getOpen_id() {	
		return this.open_id;
	}
	public void setOriginal_id(String originalId) {	
		this.original_id = originalId;
	}
	public String getOriginal_id() {	
		return this.original_id;
	}
	public void setStatus(int status) {	
		this.status = status;
	}
	public int getStatus() {	
		return this.status;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getToken(){
		return this.token;
	}
	

}