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
@Table(name="shoprck",catalog="dba")
public class ShopRck extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="shoprck_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id ;//done
	private String shoprck_shopcode ;
	private String shoprck_name ;
	private Long shoprck_parentid;
	private Long shoprck_childflag ;
	private Long shoprck_seq ;
	private Date shoprck_createdate=new Date() ;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getShoprck_shopcode() {
		return shoprck_shopcode;
	}
	public void setShoprck_shopcode(String shoprck_shopcode) {
		this.shoprck_shopcode = shoprck_shopcode;
	}
	public String getShoprck_name() {
		return shoprck_name;
	}
	public void setShoprck_name(String shoprck_name) {
		this.shoprck_name = shoprck_name;
	}
	public Long getShoprck_parentid() {
		return shoprck_parentid;
	}
	public void setShoprck_parentid(Long shoprck_parentid) {
		this.shoprck_parentid = shoprck_parentid;
	}
	public Long getShoprck_childflag() {
		return shoprck_childflag;
	}
	public void setShoprck_childflag(Long shoprck_childflag) {
		this.shoprck_childflag = shoprck_childflag;
	}
	public Long getShoprck_seq() {
		return shoprck_seq;
	}
	public void setShoprck_seq(Long shoprck_seq) {
		this.shoprck_seq = shoprck_seq;
	}
	public Date getShoprck_createdate() {
		return shoprck_createdate;
	}
	public void setShoprck_createdate(Date shoprck_createdate) {
		this.shoprck_createdate = shoprck_createdate;
	}


	/*shoprck_id int identity(1,1),shoprck_shopcode char(8),shoprck_name varchar(200),shoprck_childflag int
,shoprck_seq int,shoprck_createdate datetime
	 * */
}
