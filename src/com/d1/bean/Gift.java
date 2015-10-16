package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 赠品，前台只有读操作
 * @author kk
 *
 */
@Entity
@Table(name="GiftRckMst")
public class Gift extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="giftrckmst_id") 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private String giftrckmst_rackcode;
	private String giftrckmst_brandname;
	
	/**
	 * 0单选 1多选
	 */
	private Long giftrckmst_selecttype;
	private String giftrckmst_title;
	private Long giftrckmst_validflag;
	private String giftrckmst_shopcode;
	private Long giftrckmst_seq;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGiftrckmst_rackcode() {
		return giftrckmst_rackcode;
	}
	public void setGiftrckmst_rackcode(String giftrckmst_rackcode) {
		this.giftrckmst_rackcode = giftrckmst_rackcode;
	}
	public String getGiftrckmst_brandname() {
		return giftrckmst_brandname;
	}
	public void setGiftrckmst_brandname(String giftrckmst_brandname) {
		this.giftrckmst_brandname = giftrckmst_brandname;
	}
	public Long getGiftrckmst_selecttype() {
		return giftrckmst_selecttype;
	}
	public void setGiftrckmst_selecttype(Long giftrckmst_selecttype) {
		this.giftrckmst_selecttype = giftrckmst_selecttype;
	}
	public String getGiftrckmst_title() {
		return giftrckmst_title;
	}
	public void setGiftrckmst_title(String giftrckmst_title) {
		this.giftrckmst_title = giftrckmst_title;
	}
	public Long getGiftrckmst_validflag() {
		return giftrckmst_validflag;
	}
	public void setGiftrckmst_validflag(Long giftrckmst_validflag) {
		this.giftrckmst_validflag = giftrckmst_validflag;
	}
	public String getGiftrckmst_shopcode() {
		return giftrckmst_shopcode;
	}
	public void setGiftrckmst_shopcode(String giftrckmst_shopcode) {
		this.giftrckmst_shopcode = giftrckmst_shopcode;
	}
	public Long getGiftrckmst_seq() {
		return giftrckmst_seq;
	}
	public void setGiftrckmst_seq(Long giftrckmst_seq) {
		this.giftrckmst_seq = giftrckmst_seq;
	}


}
