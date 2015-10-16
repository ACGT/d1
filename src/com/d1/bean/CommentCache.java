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
 * 商品评价表，缓存表，评价先发到这个表
 * @author kk
 *
 */
@Entity
@Table(name="gdscom_cache",catalog="dba")
public class CommentCache extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdscom_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String sessionid;
	private String gdscom_odrid;
	private Long gdscom_mbrid;
	private String gdscom_uid;
	private String gdscom_gdsid;
	private String gdscom_gdsname;
	private Long gdscom_level;
	private String gdscom_content;
	private Long gdscom_status;
	private Date gdscom_createdate;
	private Date gdscom_replydate;
	private String gdscom_operator;
	private String gdscom_pic1;
	private String gdscom_pic2;
	private String gdscom_pic3;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getGdscom_odrid() {
		return gdscom_odrid;
	}
	public void setGdscom_odrid(String gdscom_odrid) {
		this.gdscom_odrid = gdscom_odrid;
	}
	public Long getGdscom_mbrid() {
		return gdscom_mbrid;
	}
	public void setGdscom_mbrid(Long gdscom_mbrid) {
		this.gdscom_mbrid = gdscom_mbrid;
	}
	public String getGdscom_uid() {
		return gdscom_uid;
	}
	public void setGdscom_uid(String gdscom_uid) {
		this.gdscom_uid = gdscom_uid;
	}
	public String getGdscom_gdsid() {
		return gdscom_gdsid;
	}
	public void setGdscom_gdsid(String gdscom_gdsid) {
		this.gdscom_gdsid = gdscom_gdsid;
	}
	public String getGdscom_gdsname() {
		return gdscom_gdsname;
	}
	public void setGdscom_gdsname(String gdscom_gdsname) {
		this.gdscom_gdsname = gdscom_gdsname;
	}
	public Long getGdscom_level() {
		return gdscom_level;
	}
	public void setGdscom_level(Long gdscom_level) {
		this.gdscom_level = gdscom_level;
	}
	public String getGdscom_content() {
		return gdscom_content;
	}
	public void setGdscom_content(String gdscom_content) {
		this.gdscom_content = gdscom_content;
	}
	public Long getGdscom_status() {
		return gdscom_status;
	}
	public void setGdscom_status(Long gdscom_status) {
		this.gdscom_status = gdscom_status;
	}
	public Date getGdscom_createdate() {
		return gdscom_createdate;
	}
	public void setGdscom_createdate(Date gdscom_createdate) {
		this.gdscom_createdate = gdscom_createdate;
	}
	public Date getGdscom_replydate() {
		return gdscom_replydate;
	}
	public void setGdscom_replydate(Date gdscom_replydate) {
		this.gdscom_replydate = gdscom_replydate;
	}
	public String getGdscom_operator() {
		return gdscom_operator;
	}
	public void setGdscom_operator(String gdscom_operator) {
		this.gdscom_operator = gdscom_operator;
	}
	public String getGdscom_pic1() {
		return gdscom_pic1;
	}
	public void setGdscom_pic1(String gdscom_pic1) {
		this.gdscom_pic1 = gdscom_pic1;
	}
	public String getGdscom_pic2() {
		return gdscom_pic2;
	}
	public void setGdscom_pic2(String gdscom_pic2) {
		this.gdscom_pic2 = gdscom_pic2;
	}
	public String getGdscom_pic3() {
		return gdscom_pic3;
	}
	public void setGdscom_pic3(String gdscom_pic3) {
		this.gdscom_pic3 = gdscom_pic3;
	}
	
	
}
