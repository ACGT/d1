package com.d1.bean;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.d1.dbcache.core.BaseEntity;

/**
 *  ◊“≥∑√Œ ¡ø
 * @author wdx
 *
 */
@Entity
@Table(name="hitindex",catalog="dba")
public class Hitindex extends BaseEntity implements java.io.Serializable  {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String hitindex_uri;
	private Long hitindex_count;
	private Long hitindex_ipcount;
	private Long hitindex_djcount;
	private Date hitindex_createdate;
	private Long hitindex_allcount;
	private Long hitindex_allcountip;
	private Long hitindex_allcountsession;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHitindex_uri() {
		return hitindex_uri;
	}
	public void setHitindex_uri(String hitindex_uri) {
		this.hitindex_uri = hitindex_uri;
	}
	public Long getHitindex_count() {
		return hitindex_count;
	}
	public void setHitindex_count(Long hitindex_count) {
		this.hitindex_count = hitindex_count;
	}
	public Long getHitindex_ipcount() {
		return hitindex_ipcount;
	}
	public void setHitindex_ipcount(Long hitindex_ipcount) {
		this.hitindex_ipcount = hitindex_ipcount;
	}
	public Long getHitindex_djcount() {
		return hitindex_djcount;
	}
	public void setHitindex_djcount(Long hitindex_djcount) {
		this.hitindex_djcount = hitindex_djcount;
	}
	public Date getHitindex_createdate() {
		return hitindex_createdate;
	}
	public void setHitindex_createdate(Date hitindex_createdate) {
		this.hitindex_createdate = hitindex_createdate;
	}
	public Long getHitindex_allcount() {
		return hitindex_allcount;
	}
	public void setHitindex_allcount(Long hitindex_allcount) {
		this.hitindex_allcount = hitindex_allcount;
	}
	public Long getHitindex_allcountip() {
		return hitindex_allcountip;
	}
	public void setHitindex_allcountip(Long hitindex_allcountip) {
		this.hitindex_allcountip = hitindex_allcountip;
	}
	public Long getHitindex_allcountsession() {
		return hitindex_allcountsession;
	}
	public void setHitindex_allcountsession(Long hitindex_allcountsession) {
		this.hitindex_allcountsession = hitindex_allcountsession;
	}
	
	

}
