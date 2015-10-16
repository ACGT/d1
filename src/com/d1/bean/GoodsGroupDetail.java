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
@Table(name="gdsgrpdtl")
public class GoodsGroupDetail extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsgrpdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long gdsgrpdtl_mstid;
	private String gdsgrpdtl_gdsid;
	private String gdsgrpdtl_stdvalue;
	private Date gdsgrpdtl_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdsgrpdtl_mstid() {
		return gdsgrpdtl_mstid;
	}
	public void setGdsgrpdtl_mstid(Long gdsgrpdtl_mstid) {
		this.gdsgrpdtl_mstid = gdsgrpdtl_mstid;
	}
	public String getGdsgrpdtl_gdsid() {
		return gdsgrpdtl_gdsid;
	}
	public void setGdsgrpdtl_gdsid(String gdsgrpdtl_gdsid) {
		this.gdsgrpdtl_gdsid = gdsgrpdtl_gdsid;
	}
	public String getGdsgrpdtl_stdvalue() {
		return gdsgrpdtl_stdvalue;
	}
	public void setGdsgrpdtl_stdvalue(String gdsgrpdtl_stdvalue) {
		this.gdsgrpdtl_stdvalue = gdsgrpdtl_stdvalue;
	}
	public Date getGdsgrpdtl_createtime() {
		return gdsgrpdtl_createtime;
	}
	public void setGdsgrpdtl_createtime(Date gdsgrpdtl_createtime) {
		this.gdsgrpdtl_createtime = gdsgrpdtl_createtime;
	}
	
}
