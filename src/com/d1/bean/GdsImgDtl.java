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
@Table(name="gdsimgdtl")
public class GdsImgDtl extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsimgdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String gdsimgdtl_gdsid;
	private String gdsimgdtl_bigimg;
	private String gdsimgdtl_midimg;
	private String gdsimgdtl_smallimg;
	private Long gdsimgdtl_sort;
	private Date gdsimgdtl_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsimgdtl_gdsid() {
		return gdsimgdtl_gdsid;
	}
	public void setGdsimgdtl_gdsid(String gdsimgdtl_gdsid) {
		this.gdsimgdtl_gdsid = gdsimgdtl_gdsid;
	}
	public String getGdsimgdtl_bigimg() {
		return gdsimgdtl_bigimg;
	}
	public void setGdsimgdtl_bigimg(String gdsimgdtl_bigimg) {
		this.gdsimgdtl_bigimg = gdsimgdtl_bigimg;
	}
	public String getGdsimgdtl_midimg() {
		return gdsimgdtl_midimg;
	}
	public void setGdsimgdtl_midimg(String gdsimgdtl_midimg) {
		this.gdsimgdtl_midimg = gdsimgdtl_midimg;
	}
	public String getGdsimgdtl_smallimg() {
		return gdsimgdtl_smallimg;
	}
	public void setGdsimgdtl_smallimg(String gdsimgdtl_smallimg) {
		this.gdsimgdtl_smallimg = gdsimgdtl_smallimg;
	}
	public Long getGdsimgdtl_sort() {
		return gdsimgdtl_sort;
	}
	public void setGdsimgdtl_sort(Long gdsimgdtl_sort) {
		this.gdsimgdtl_sort = gdsimgdtl_sort;
	}
	public Date getGdsimgdtl_createdate() {
		return gdsimgdtl_createdate;
	}
	public void setGdsimgdtl_createdate(Date gdsimgdtl_createdate) {
		this.gdsimgdtl_createdate = gdsimgdtl_createdate;
	}


}
