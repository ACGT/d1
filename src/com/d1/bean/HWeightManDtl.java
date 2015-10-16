package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="wheightman_dtl",catalog="dba")
public class HWeightManDtl extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wheightman_dtlid")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String wheightman_gdsid;
	private Long wheightman_dtlweight;
	private String wheightman_dtlsize1;
	private String wheightman_dtlsize2;
	private String wheightman_dtlsize3;
	private String wheightman_dtlsize4;
	private String wheightman_dtlsize5;
	private String wheightman_dtlsize6;
	private String wheightman_dtlsize7;
	private String wheightman_dtlsize8;
	private Date wheightman_dtlcreatedate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getWheightman_gdsid() {
		return wheightman_gdsid;
	}
	public void setWheightman_gdsid(String wheightman_gdsid) {
		this.wheightman_gdsid = wheightman_gdsid;
	}
	public Long getWheightman_dtlweight() {
		return wheightman_dtlweight;
	}
	public void setWheightman_dtlweight(Long wheightman_dtlweight) {
		this.wheightman_dtlweight = wheightman_dtlweight;
	}
	public String getWheightman_dtlsize1() {
		return wheightman_dtlsize1;
	}
	public void setWheightman_dtlsize1(String wheightman_dtlsize1) {
		this.wheightman_dtlsize1 = wheightman_dtlsize1;
	}
	public String getWheightman_dtlsize2() {
		return wheightman_dtlsize2;
	}
	public void setWheightman_dtlsize2(String wheightman_dtlsize2) {
		this.wheightman_dtlsize2 = wheightman_dtlsize2;
	}
	public String getWheightman_dtlsize3() {
		return wheightman_dtlsize3;
	}
	public void setWheightman_dtlsize3(String wheightman_dtlsize3) {
		this.wheightman_dtlsize3 = wheightman_dtlsize3;
	}
	public String getWheightman_dtlsize4() {
		return wheightman_dtlsize4;
	}
	public void setWheightman_dtlsize4(String wheightman_dtlsize4) {
		this.wheightman_dtlsize4 = wheightman_dtlsize4;
	}
	public String getWheightman_dtlsize5() {
		return wheightman_dtlsize5;
	}
	public void setWheightman_dtlsize5(String wheightman_dtlsize5) {
		this.wheightman_dtlsize5 = wheightman_dtlsize5;
	}
	public String getWheightman_dtlsize6() {
		return wheightman_dtlsize6;
	}
	public void setWheightman_dtlsize6(String wheightman_dtlsize6) {
		this.wheightman_dtlsize6 = wheightman_dtlsize6;
	}
	public String getWheightman_dtlsize7() {
		return wheightman_dtlsize7;
	}
	public void setWheightman_dtlsize7(String wheightman_dtlsize7) {
		this.wheightman_dtlsize7 = wheightman_dtlsize7;
	}
	public String getWheightman_dtlsize8() {
		return wheightman_dtlsize8;
	}
	public void setWheightman_dtlsize8(String wheightman_dtlsize8) {
		this.wheightman_dtlsize8 = wheightman_dtlsize8;
	}
	public Date getWheightman_dtlcreatedate() {
		return wheightman_dtlcreatedate;
	}
	public void setWheightman_dtlcreatedate(Date wheightman_dtlcreatedate) {
		this.wheightman_dtlcreatedate = wheightman_dtlcreatedate;
	}
	
}
