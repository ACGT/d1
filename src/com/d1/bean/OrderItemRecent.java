package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 最近的订单明细记录
 * @author kk
 *
 */
@Entity
@Table(name="odrdtl_recent")
public class OrderItemRecent extends OrderItemBase implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="odrdtl_subodrid")
	private String id;//done

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
