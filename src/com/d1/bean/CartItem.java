package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 用于计算占用的库存，下单成功后记录不删除<br/>
 * 下单成功后往该表插入记录，表示占用库存，一个小时候删除。<br/>
 * @author kk
 *
 */
@Entity
@Table(name="f_cart_item")
public class CartItem extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	/**
	 * 主键id
	 */
	private String id ;//done
	
	/**
	 * 商品ID
	 */
	private String productId = "";
	
	/**
	 * 对应的sku id，或者型号
	 */
	private String skuId = "";
	
	/**
	 * 商品的数量，用于计算占用库存的数量
	 */
	private Long amount = new Long(1);
	
	/**
	 * 用户id
	 */
	private String userId = "";
	
	/**
	 * 该条订单创建时间
	 */
	private Date createDate = new Date();
	
	/**
	 * 订单id
	 */
	private String orderId ="";

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getSkuId() {
		return skuId;
	}

	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}

	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

}
