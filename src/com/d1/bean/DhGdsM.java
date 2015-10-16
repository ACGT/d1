package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 兑换码，一个对应多个商品可选择表
 * @author gjl
 *
 */
@Entity
@Table(name="dhgdsm")
public class DhGdsM extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="dhgdsm_id") 
	private String id;//done
	private String dhgdsm_card;
	private String dhgdsm_gdsid;
	private String dhgdsm_title;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDhgdsm_card() {
		return dhgdsm_card;
	}
	public void setDhgdsm_card(String dhgdsm_card) {
		this.dhgdsm_card = dhgdsm_card;
	}
	public String getDhgdsm_gdsid() {
		return dhgdsm_gdsid;
	}
	public void setDhgdsm_gdsid(String dhgdsm_gdsid) {
		this.dhgdsm_gdsid = dhgdsm_gdsid;
	}
	public String getDhgdsm_title() {
		return dhgdsm_title;
	}
	public void setDhgdsm_title(String dhgdsm_title) {
		this.dhgdsm_title = dhgdsm_title;
	}
 


}
