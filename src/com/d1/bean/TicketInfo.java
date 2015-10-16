package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="yhmst")
public class TicketInfo extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="yhid")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private String yhtitle;
	private String yhhref;
	private String yhrackcodeid;
	private String yhbrandname;
	private Long seq;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getYhtitle() {
		return yhtitle;
	}
	public void setYhtitle(String yhtitle) {
		this.yhtitle = yhtitle;
	}
	public String getYhhref() {
		return yhhref;
	}
	public void setYhhref(String yhhref) {
		this.yhhref = yhhref;
	}
	public String getYhrackcodeid() {
		return yhrackcodeid;
	}
	public void setYhrackcodeid(String yhrackcodeid) {
		this.yhrackcodeid = yhrackcodeid;
	}
	public String getYhbrandname() {
		return yhbrandname;
	}
	public void setYhbrandname(String yhbrandname) {
		this.yhbrandname = yhbrandname;
	}
	public Long getSeq() {
		return seq;
	}
	public void setSeq(Long seq) {
		this.seq = seq;
	}
}
