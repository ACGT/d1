package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 记录淘宝商城订单状态（是否同步过库存，是否同步过订单等）
 * @author kk
 *
 */
@Entity
@Table(name="f_order_taobao")
public class OrderTaobao extends BaseEntity implements java.io.Serializable {

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
	 * 淘宝订单id，若存在，说明订单已经同步，对应淘宝trade id
	 */
	private String taobaoOrderId ;
	
	/**
	 * 对应d1订单id
	 */
	private String d1OrderId ;
	
	/**
	 * 0=正常，1=d1发货状态已同步到淘宝，-1=同步发货状态出错，2=淘宝交易取消
	 */
	private Long status ;
	
	private Long mbrid;
	
	/**
	 * 发货状态失败原因
	 */
	private String reason ;
	
	/**
	 * 创建时间
	 */
	private Date createdate ;

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTaobaoOrderId() {
		return taobaoOrderId;
	}

	public void setTaobaoOrderId(String taobaoOrderId) {
		this.taobaoOrderId = taobaoOrderId;
	}

	public String getD1OrderId() {
		return d1OrderId;
	}

	public void setD1OrderId(String d1OrderId) {
		this.d1OrderId = d1OrderId;
	}
	public Long getMbrid() {
		return mbrid;
	}

	public void setMbrid(Long mbrid) {
		this.mbrid = mbrid;
	}
	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}
}
