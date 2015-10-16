package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="gdscomscore")
public class OrderScore extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long gdscomscore_mbrid;
	private String gdscomscore_orderid;
	private Long gdscomscore_score;
	private Date gdscomscore_createtime;
	private Long gdscomscore_status;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdscomscore_mbrid() {
		return gdscomscore_mbrid;
	}
	public void setGdscomscore_mbrid(Long gdscomscore_mbrid) {
		this.gdscomscore_mbrid = gdscomscore_mbrid;
	}
	public String getGdscomscore_orderid() {
		return gdscomscore_orderid;
	}
	public void setGdscomscore_orderid(String gdscomscore_orderid) {
		this.gdscomscore_orderid = gdscomscore_orderid;
	}
	public Long getGdscomscore_score() {
		return gdscomscore_score;
	}
	public void setGdscomscore_score(Long gdscomscore_score) {
		this.gdscomscore_score = gdscomscore_score;
	}
	public Date getGdscomscore_createtime() {
		return gdscomscore_createtime;
	}
	public void setGdscomscore_createtime(Date gdscomscore_createtime) {
		this.gdscomscore_createtime = gdscomscore_createtime;
	}
	public Long getGdscomscore_status() {
		return gdscomscore_status;
	}
	public void setGdscomscore_status(Long gdscomscore_status) {
		this.gdscomscore_status = gdscomscore_status;
	}
}
