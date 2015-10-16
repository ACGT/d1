package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/*
 * ³¡¾°±í 
 */
@Entity
@Table(name="gdscutimg")
public class GdsCutImg extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdscutimg_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String gdsmst_gdsid;
	private String gdscutimg_bigimg;
	private String gdscutimg_300;
	private String gdscutimg_160;
	private String gdscutimg_200;
	private String gdscutimg_100;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsmst_gdsid() {
		return gdsmst_gdsid;
	}
	public void setGdsmst_gdsid(String gdsmst_gdsid) {
		this.gdsmst_gdsid = gdsmst_gdsid;
	}
	public String getGdscutimg_bigimg() {
		return gdscutimg_bigimg;
	}
	public void setGdscutimg_bigimg(String gdscutimg_bigimg) {
		this.gdscutimg_bigimg = gdscutimg_bigimg;
	}
	public String getGdscutimg_300() {
		return gdscutimg_300;
	}
	public void setGdscutimg_300(String gdscutimg_300) {
		this.gdscutimg_300 = gdscutimg_300;
	}
	public String getGdscutimg_160() {
		return gdscutimg_160;
	}
	public void setGdscutimg_160(String gdscutimg_160) {
		this.gdscutimg_160 = gdscutimg_160;
	}
	public String getGdscutimg_200() {
		return gdscutimg_200;
	}
	public void setGdscutimg_200(String gdscutimg_200) {
		this.gdscutimg_200 = gdscutimg_200;
	}
	public String getGdscutimg_100() {
		return gdscutimg_100;
	}
	public void setGdscutimg_100(String gdscutimg_100) {
		this.gdscutimg_100 = gdscutimg_100;
	}

}
