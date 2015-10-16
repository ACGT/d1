package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="relatedgoods",catalog="dba")
public class ProductRelated extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="relatedgoods_gdsid")
	private String id;
	private String relatedgoods_relatedgdsid;
	private Float relatedgoods_relatedindex;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRelatedgoods_relatedgdsid() {
		return relatedgoods_relatedgdsid;
	}
	public void setRelatedgoods_relatedgdsid(String relatedgoods_relatedgdsid) {
		this.relatedgoods_relatedgdsid = relatedgoods_relatedgdsid;
	}
	public Float getRelatedgoods_relatedindex() {
		return relatedgoods_relatedindex;
	}
	public void setRelatedgoods_relatedindex(Float relatedgoods_relatedindex) {
		this.relatedgoods_relatedindex = relatedgoods_relatedindex;
	}
}
