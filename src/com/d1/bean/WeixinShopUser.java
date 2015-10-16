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
@Table(name="weixin_shop_mbrmst")

public class WeixinShopUser extends BaseEntity implements java.io.Serializable {
	
	public static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	
	public String id;
	public String open_id;
	public String original_id;
	public int d1_id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public void setOpen_id(String open_id) {
		this.open_id = open_id;
	}
	
	public void setOriginal_id(String original_id) {
		this.original_id = original_id;
	}
	
	public void setD1_id(int d1_id){
		this.d1_id = d1_id;
	}
	
	public String getOpen_id(){
		return this.open_id;
	}
}
