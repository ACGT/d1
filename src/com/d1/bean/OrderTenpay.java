package com.d1.bean;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 记录财付通订单状态（是否同步过库存，是否同步过订单等）
 * @author kk
 *
 */
@Entity
@Table(name="f_order_tenpay")
public class OrderTenpay extends BaseEntity implements java.io.Serializable {

	/**
	 * searial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	/**
	 * 主键id
	 */
	private String id ;//done
	
	/**
	 * 财付通订单id，若存在，说明订单已经同步，对应财付通trade id
	 */
	private String tenpayOrderId ;
	
	/**
	 * 对应d1订单id
	 */
	private String d1OrderId ;
	private String productid;
	/**
	 * 0=正常，1=d1发货状态已同步到财付通，-1=同步发货状态出错
	 */
	private Long status ;
	private Double ordermoney;
	private Double total_fee= new Double(0);
	private Double transport_fee= new Double(0);
	private String include_transport="";
	/**
	 * 发货状态失败原因
	 */
	private String reason ;



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTenpayOrderId() {
		return tenpayOrderId;
	}

	public void setTenpayOrderId(String tenpayOrderId) {
		this.tenpayOrderId = tenpayOrderId;
	}

	public String getD1OrderId() {
		return d1OrderId;
	}

	public void setD1OrderId(String d1OrderId) {
		this.d1OrderId = d1OrderId;
	}
	public String getProductid() {
		return productid;
	}

	public void setProductid(String productid) {
		this.productid = productid;
	}
	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}
	public Double getOrdermoney() {
		return ordermoney;
	}

	public void setOrdermoney(Double ordermoney) {
		this.ordermoney = ordermoney;
	}
	public Double getTotal_fee() {
		return total_fee;
	}

	public void setTotal_fee(Double total_fee) {
		this.total_fee = total_fee;
	}

	public Double getTransport_fee() {
		return transport_fee;
	}

	public void setTransport_fee(Double transport_fee) {
		this.transport_fee = transport_fee;
	}

	public String getInclude_transport() {
		return include_transport;
	}

	public void setInclude_transport(String include_transport) {
		this.include_transport = include_transport;
	}
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
}
