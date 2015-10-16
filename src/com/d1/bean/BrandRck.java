package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * @author Administrator
 *
 */
@Entity
@Table(name="brandrck")
public class BrandRck  extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="brandrck_id")
	private String id;//done
	private String brandrck_brand;
	private Long brandrck_count;
	private String brandrck_rackcode ;
	private Long brandrck_seq;
	private Long brandrck_southseq;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBrandrck_brand() {
		return brandrck_brand;
	}
	public void setBrandrck_brand(String brandrck_brand) {
		this.brandrck_brand = brandrck_brand;
	}
	public Long getBrandrck_count() {
		return brandrck_count;
	}
	public void setBrandrck_count(Long brandrck_count) {
		this.brandrck_count = brandrck_count;
	}
	public String getBrandrck_rackcode() {
		return brandrck_rackcode;
	}
	public void setBrandrck_rackcode(String brandrck_rackcode) {
		this.brandrck_rackcode = brandrck_rackcode;
	}
	public Long getBrandrck_seq() {
		return brandrck_seq;
	}
	public void setBrandrck_seq(Long brandrck_seq) {
		this.brandrck_seq = brandrck_seq;
	}
	public Long getBrandrck_southseq() {
		return brandrck_southseq;
	}
	public void setBrandrck_southseq(Long brandrck_southseq) {
		this.brandrck_southseq = brandrck_southseq;
	}
	
}
