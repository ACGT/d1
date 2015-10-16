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
@Table(name="userlove",catalog="dba")
public class Userlove extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="loveid")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done	
	private String userid;
	private Long loveno;
	private String productid;

	private String lovecontent;
	private Date createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Long getLoveno() {
		return loveno;
	}
	public void setLoveno(Long loveno) {
		this.loveno = loveno;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getLovecontent() {
		return lovecontent;
	}
	public void setLovecontent(String lovecontent) {
		this.lovecontent = lovecontent;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
}
