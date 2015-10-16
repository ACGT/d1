package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ���ڼ���ռ�õĿ�棬�µ��ɹ����¼��ɾ��<br/>
 * �µ��ɹ������ñ�����¼����ʾռ�ÿ�棬һ��Сʱ��ɾ����<br/>
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
	 * ����id
	 */
	private String id ;//done
	
	/**
	 * ��ƷID
	 */
	private String productId = "";
	
	/**
	 * ��Ӧ��sku id�������ͺ�
	 */
	private String skuId = "";
	
	/**
	 * ��Ʒ�����������ڼ���ռ�ÿ�������
	 */
	private Long amount = new Long(1);
	
	/**
	 * �û�id
	 */
	private String userId = "";
	
	/**
	 * ������������ʱ��
	 */
	private Date createDate = new Date();
	
	/**
	 * ����id
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
