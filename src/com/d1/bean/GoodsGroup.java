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
@Table(name="gdsgrpmst")
public class GoodsGroup extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsgrpmst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String gdsgrpmst_title;
	private String gdsgrpmst_stdname;
	private String gdsgrpmst_shopcode;
	private Date gdsgrpmst_createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsgrpmst_title() {
		return gdsgrpmst_title;
	}
	public void setGdsgrpmst_title(String gdsgrpmst_title) {
		this.gdsgrpmst_title = gdsgrpmst_title;
	}
	public String getGdsgrpmst_stdname() {
		return gdsgrpmst_stdname;
	}
	public void setGdsgrpmst_stdname(String gdsgrpmst_stdname) {
		this.gdsgrpmst_stdname = gdsgrpmst_stdname;
	}
	public Date getGdsgrpmst_createtime() {
		return gdsgrpmst_createtime;
	}
	public void setGdsgrpmst_createtime(Date gdsgrpmst_createtime) {
		this.gdsgrpmst_createtime = gdsgrpmst_createtime;
	}
	public void setGdsgrpmst_shopcode(String gdsgrpmst_shopcode) {
		this.gdsgrpmst_shopcode = gdsgrpmst_shopcode;
	}
	public String getGdsgrpmst_shopcode() {
		return gdsgrpmst_shopcode;
	}
	
}
