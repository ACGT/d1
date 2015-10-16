package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * É¹µ¥ÆÀÂÛ±í
 * @author gjl
 *
 */
@Entity
@Table(name="myshowcom")
public class MyShowCom extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="myshowcom_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long   myshowcom_mbrid;
	private String myshowcom_odrid;
	private String myshowcom_gdsid;
	private String myshowcom_content;
	private Date   myshowcom_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMyshowcom_mbrid() {
		return myshowcom_mbrid;
	}
	public void setMyshowcom_mbrid(Long myshowcom_mbrid) {
		this.myshowcom_mbrid = myshowcom_mbrid;
	}
	public String getMyshowcom_odrid() {
		return myshowcom_odrid;
	}
	public void setMyshowcom_odrid(String myshowcom_odrid) {
		this.myshowcom_odrid = myshowcom_odrid;
	}
	public String getMyshowcom_gdsid() {
		return myshowcom_gdsid;
	}
	public void setMyshowcom_gdsid(String myshowcom_gdsid) {
		this.myshowcom_gdsid = myshowcom_gdsid;
	}
	public String getMyshowcom_content() {
		return myshowcom_content;
	}
	public void setMyshowcom_content(String myshowcom_content) {
		this.myshowcom_content = myshowcom_content;
	}
	public Date getMyshowcom_createdate() {
		return myshowcom_createdate;
	}
	public void setMyshowcom_createdate(Date myshowcom_createdate) {
		this.myshowcom_createdate = myshowcom_createdate;
	}



}
