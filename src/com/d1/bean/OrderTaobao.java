package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ��¼�Ա��̳Ƕ���״̬���Ƿ�ͬ������棬�Ƿ�ͬ���������ȣ�
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
	 * ����id
	 */
	private String id ;//done
	
	/**
	 * �Ա�����id�������ڣ�˵�������Ѿ�ͬ������Ӧ�Ա�trade id
	 */
	private String taobaoOrderId ;
	
	/**
	 * ��Ӧd1����id
	 */
	private String d1OrderId ;
	
	/**
	 * 0=������1=d1����״̬��ͬ�����Ա���-1=ͬ������״̬����2=�Ա�����ȡ��
	 */
	private Long status ;
	
	private Long mbrid;
	
	/**
	 * ����״̬ʧ��ԭ��
	 */
	private String reason ;
	
	/**
	 * ����ʱ��
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
