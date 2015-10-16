package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品独享价明细表
 * @author kk
 */
@Entity
@Table(name="rcmdgds")
public class ProductExpPriceItem extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="rcmdgds_id")
	private String id ;//done
	
	private Long rcmdgds_rcmid;
	private String rcmdgds_gdsid;
	private Long rcmdgds_saletoday;
	private Long rcmdgds_saleall;
	private Long rcmdgds_buylimit;
	private Float rcmdgds_memberprice;
	private String rcmdgds_addgdsname;
	private String rcmdgds_title;
	private Date rcmdgds_addtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getRcmdgds_rcmid() {
		return rcmdgds_rcmid;
	}
	public void setRcmdgds_rcmid(Long rcmdgds_rcmid) {
		this.rcmdgds_rcmid = rcmdgds_rcmid;
	}
	public String getRcmdgds_gdsid() {
		return rcmdgds_gdsid;
	}
	public void setRcmdgds_gdsid(String rcmdgds_gdsid) {
		this.rcmdgds_gdsid = rcmdgds_gdsid;
	}
	public Long getRcmdgds_saletoday() {
		return rcmdgds_saletoday;
	}
	public void setRcmdgds_saletoday(Long rcmdgds_saletoday) {
		this.rcmdgds_saletoday = rcmdgds_saletoday;
	}
	public Long getRcmdgds_saleall() {
		return rcmdgds_saleall;
	}
	public void setRcmdgds_saleall(Long rcmdgds_saleall) {
		this.rcmdgds_saleall = rcmdgds_saleall;
	}
	public Long getRcmdgds_buylimit() {
		return rcmdgds_buylimit;
	}
	public void setRcmdgds_buylimit(Long rcmdgds_buylimit) {
		this.rcmdgds_buylimit = rcmdgds_buylimit;
	}
	public Float getRcmdgds_memberprice() {
		return rcmdgds_memberprice;
	}
	public void setRcmdgds_memberprice(Float rcmdgds_memberprice) {
		this.rcmdgds_memberprice = rcmdgds_memberprice;
	}
	public String getRcmdgds_addgdsname() {
		return rcmdgds_addgdsname;
	}
	public void setRcmdgds_addgdsname(String rcmdgds_addgdsname) {
		this.rcmdgds_addgdsname = rcmdgds_addgdsname;
	}
	public String getRcmdgds_title() {
		return rcmdgds_title;
	}
	public void setRcmdgds_title(String rcmdgds_title) {
		this.rcmdgds_title = rcmdgds_title;
	}
	public Date getRcmdgds_addtime() {
		return rcmdgds_addtime;
	}
	public void setRcmdgds_addtime(Date rcmdgds_addtime) {
		this.rcmdgds_addtime = rcmdgds_addtime;
	}
	
}
