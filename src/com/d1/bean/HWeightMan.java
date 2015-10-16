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
@Table(name="wheightman",catalog="dba")
public class HWeightMan extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wheightman_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String wheightman_title;
	private Long wheightman_height1;
	private Long wheightman_height2;
	private Long wheightman_height3;
	private Long wheightman_height4;
	private Long wheightman_height5;
	private Long wheightman_height6;
	private Long wheightman_height7;
	private Long wheightman_height8;
	private String wheightman_memo;
	private Date wheightman_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWheightman_title() {
		return wheightman_title;
	}
	public void setWheightman_title(String wheightman_title) {
		this.wheightman_title = wheightman_title;
	}
	public Long getWheightman_height1() {
		return wheightman_height1;
	}
	public void setWheightman_height1(Long wheightman_height1) {
		this.wheightman_height1 = wheightman_height1;
	}
	public Long getWheightman_height2() {
		return wheightman_height2;
	}
	public void setWheightman_height2(Long wheightman_height2) {
		this.wheightman_height2 = wheightman_height2;
	}
	public Long getWheightman_height3() {
		return wheightman_height3;
	}
	public void setWheightman_height3(Long wheightman_height3) {
		this.wheightman_height3 = wheightman_height3;
	}
	public Long getWheightman_height4() {
		return wheightman_height4;
	}
	public void setWheightman_height4(Long wheightman_height4) {
		this.wheightman_height4 = wheightman_height4;
	}
	public Long getWheightman_height5() {
		return wheightman_height5;
	}
	public void setWheightman_height5(Long wheightman_height5) {
		this.wheightman_height5 = wheightman_height5;
	}
	public Long getWheightman_height6() {
		return wheightman_height6;
	}
	public void setWheightman_height6(Long wheightman_height6) {
		this.wheightman_height6 = wheightman_height6;
	}
	public Long getWheightman_height7() {
		return wheightman_height7;
	}
	public void setWheightman_height7(Long wheightman_height7) {
		this.wheightman_height7 = wheightman_height7;
	}
	public Long getWheightman_height8() {
		return wheightman_height8;
	}
	public void setWheightman_height8(Long wheightman_height8) {
		this.wheightman_height8 = wheightman_height8;
	}
	public String getWheightman_memo() {
		return wheightman_memo;
	}
	public void setWheightman_memo(String wheightman_memo) {
		this.wheightman_memo = wheightman_memo;
	}
	public Date getWheightman_createdate() {
		return wheightman_createdate;
	}
	public void setWheightman_createdate(Date wheightman_createdate) {
		this.wheightman_createdate = wheightman_createdate;
	}

}
