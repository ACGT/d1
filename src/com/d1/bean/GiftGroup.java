package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 组赠品分类表
 * @author kk
 *
 */
@Entity
@Table(name="giftgrpmst")
public class GiftGroup extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="giftgrpmst_id") 
	private String id;//done
	
	private String giftgrpmst_sprckcodeStr;
	
	/**
	 * 0单选 1多选
	 */
	private Long giftgrpmst_selecttype;
	private String giftgrpmst_title;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGiftgrpmst_sprckcodeStr() {
		return giftgrpmst_sprckcodeStr;
	}
	public void setGiftgrpmst_sprckcodeStr(String giftgrpmst_sprckcodeStr) {
		this.giftgrpmst_sprckcodeStr = giftgrpmst_sprckcodeStr;
	}
	public Long getGiftgrpmst_selecttype() {
		return giftgrpmst_selecttype;
	}
	public void setGiftgrpmst_selecttype(Long giftgrpmst_selecttype) {
		this.giftgrpmst_selecttype = giftgrpmst_selecttype;
	}
	public String getGiftgrpmst_title() {
		return giftgrpmst_title;
	}
	public void setGiftgrpmst_title(String giftgrpmst_title) {
		this.giftgrpmst_title = giftgrpmst_title;
	}
	
	
}
