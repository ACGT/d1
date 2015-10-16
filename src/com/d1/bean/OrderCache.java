package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 订单缓存表，最开始下单下到这个表里。注意订单id的创建方式！
 * @author kk
 *
 */
@Entity
@Table(name="odrmst_cache")
public class OrderCache extends OrderBase implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * order的id是通过OrderIdGenerator创建出来的，必须set进去
	 */
	@Id
	@Column(name="odrmst_odrid")
	private String id;//done

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
