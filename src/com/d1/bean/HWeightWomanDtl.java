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
@Table(name="wheightwoman_dtl",catalog="dba")
public class HWeightWomanDtl extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wheightwoman_dtlid")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private Long wheightwoman_id;
	private String wheightwoman_dtlsize1;
	private String wheightwoman_dtlsize2;
	private String wheightwoman_dtlsize3;
	private String wheightwoman_dtlsize4;
	private String wheightwoman_dtlsize5;
	private String wheightwoman_dtlsize6;
	private String wheightwoman_dtlsize7;
	private Date wheightwoman_dtlcreatedate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getWheightwoman_id() {
		return wheightwoman_id;
	}
	public void setWheightwoman_id(Long wheightwoman_id) {
		this.wheightwoman_id = wheightwoman_id;
	}
	public String getWheightwoman_dtlsize1() {
		return wheightwoman_dtlsize1;
	}
	public void setWheightwoman_dtlsize1(String wheightwoman_dtlsize1) {
		this.wheightwoman_dtlsize1 = wheightwoman_dtlsize1;
	}
	public String getWheightwoman_dtlsize2() {
		return wheightwoman_dtlsize2;
	}
	public void setWheightwoman_dtlsize2(String wheightwoman_dtlsize2) {
		this.wheightwoman_dtlsize2 = wheightwoman_dtlsize2;
	}
	public String getWheightwoman_dtlsize3() {
		return wheightwoman_dtlsize3;
	}
	public void setWheightwoman_dtlsize3(String wheightwoman_dtlsize3) {
		this.wheightwoman_dtlsize3 = wheightwoman_dtlsize3;
	}
	public String getWheightwoman_dtlsize4() {
		return wheightwoman_dtlsize4;
	}
	public void setWheightwoman_dtlsize4(String wheightwoman_dtlsize4) {
		this.wheightwoman_dtlsize4 = wheightwoman_dtlsize4;
	}
	public String getWheightwoman_dtlsize5() {
		return wheightwoman_dtlsize5;
	}
	public void setWheightwoman_dtlsize5(String wheightwoman_dtlsize5) {
		this.wheightwoman_dtlsize5 = wheightwoman_dtlsize5;
	}
	public String getWheightwoman_dtlsize6() {
		return wheightwoman_dtlsize6;
	}
	public void setWheightwoman_dtlsize6(String wheightwoman_dtlsize6) {
		this.wheightwoman_dtlsize6 = wheightwoman_dtlsize6;
	}
	public String getWheightwoman_dtlsize7() {
		return wheightwoman_dtlsize7;
	}
	public void setWheightwoman_dtlsize7(String wheightwoman_dtlsize7) {
		this.wheightwoman_dtlsize7 = wheightwoman_dtlsize7;
	}
	public Date getWheightwoman_dtlcreatedate() {
		return wheightwoman_dtlcreatedate;
	}
	public void setWheightwoman_dtlcreatedate(Date wheightwoman_dtlcreatedate) {
		this.wheightwoman_dtlcreatedate = wheightwoman_dtlcreatedate;
	}
	

}
