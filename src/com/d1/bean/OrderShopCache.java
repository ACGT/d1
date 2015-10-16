package com.d1.bean;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 订单商户表，主表
 * @author kk
 *
 */
@Entity
@Table(name="odrshp_cache")
public class OrderShopCache extends OrderShopBase implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Transient
	private String id;//done

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
