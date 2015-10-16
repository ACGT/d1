package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 单品赠品表。单品赠品在Cart中是对应Cart记录的一个子节点。
 * @author kk
 *
 */
@Entity
@Table(name="giftgds")
public class GiftProduct extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="giftgds_id")
	private String id;//done

	private String giftgds_mastergdsid;
	private String giftgds_gdsid;
	private Float giftgds_price;
	private Date giftgds_creatdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGiftgds_mastergdsid() {
		return giftgds_mastergdsid;
	}
	public void setGiftgds_mastergdsid(String giftgds_mastergdsid) {
		this.giftgds_mastergdsid = giftgds_mastergdsid;
	}
	public String getGiftgds_gdsid() {
		return giftgds_gdsid;
	}
	public void setGiftgds_gdsid(String giftgds_gdsid) {
		this.giftgds_gdsid = giftgds_gdsid;
	}
	public Float getGiftgds_price() {
		return giftgds_price;
	}
	public void setGiftgds_price(Float giftgds_price) {
		this.giftgds_price = giftgds_price;
	}
	public Date getGiftgds_creatdate() {
		return giftgds_creatdate;
	}
	public void setGiftgds_creatdate(Date giftgds_creatdate) {
		this.giftgds_creatdate = giftgds_creatdate;
	}
	
	
}
