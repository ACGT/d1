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
 * 晒单表
 * @author gjl
 *
 */
@Entity
@Table(name="myshow")
public class MyShow extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="myshow_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long   myshow_mbrid;
	private String myshow_subodrid;//订单明细id
	private String myshow_odrid;
	private String myshow_gdsid;
	private String myshow_img80100;//商品分类
	private String myshow_img120150;//400图
	private String myshow_img240300;//200图
	private String myshow_img400500;//原图
	private Long   myshow_status;
	private String myshow_content;
	private Long   myshow_show;
	private Date   myshow_createdate;
	private String myshow_mbruid;
	private String myshow_img100;//100图
	private Long myshow_score;
	private Long myshow_reasontype;
	private String  myshow_reason;
	private String  myshow_adduser;
	private String  myshow_checkuser;
	private Date   myshow_adddate;
	private Date   myshow_checkdate;
	
	public String getMyshow_adduser() {
		return myshow_adduser;
	}
	public void setMyshow_adduser(String myshow_adduser) {
		this.myshow_adduser = myshow_adduser;
	}
	public String getMyshow_checkuser() {
		return myshow_checkuser;
	}
	public void setMyshow_checkuser(String myshow_checkuser) {
		this.myshow_checkuser = myshow_checkuser;
	}
	public Date getMyshow_adddate() {
		return myshow_adddate;
	}
	public void setMyshow_adddate(Date myshow_adddate) {
		this.myshow_adddate = myshow_adddate;
	}
	public Date getMyshow_checkdate() {
		return myshow_checkdate;
	}
	public void setMyshow_checkdate(Date myshow_checkdate) {
		this.myshow_checkdate = myshow_checkdate;
	}
	public Long getMyshow_score() {
		return myshow_score;
	}
	public void setMyshow_score(Long myshow_score) {
		this.myshow_score = myshow_score;
	}
	public String getMyshow_mbruid() {
		return myshow_mbruid;
	}
	public void setMyshow_mbruid(String myshow_mbruid) {
		this.myshow_mbruid = myshow_mbruid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getMyshow_mbrid() {
		return myshow_mbrid;
	}
	public void setMyshow_mbrid(Long myshow_mbrid) {
		this.myshow_mbrid = myshow_mbrid;
	}
	public String getMyshow_odrid() {
		return myshow_odrid;
	}
	public void setMyshow_odrid(String myshow_odrid) {
		this.myshow_odrid = myshow_odrid;
	}
	public String getMyshow_gdsid() {
		return myshow_gdsid;
	}
	public void setMyshow_gdsid(String myshow_gdsid) {
		this.myshow_gdsid = myshow_gdsid;
	}
	public String getMyshow_subodrid() {
		return myshow_subodrid;
	}
	public void setMyshow_subodrid(String myshow_subodrid) {
		this.myshow_subodrid = myshow_subodrid;
	}
	public String getMyshow_img80100() {
		return myshow_img80100;
	}
	public void setMyshow_img80100(String myshow_img80100) {
		this.myshow_img80100 = myshow_img80100;
	}
	public String getMyshow_img120150() {
		return myshow_img120150;
	}
	public void setMyshow_img120150(String myshow_img120150) {
		this.myshow_img120150 = myshow_img120150;
	}
	public String getMyshow_img240300() {
		return myshow_img240300;
	}
	public void setMyshow_img240300(String myshow_img240300) {
		this.myshow_img240300 = myshow_img240300;
	}
	public String getMyshow_img400500() {
		return myshow_img400500;
	}
	public void setMyshow_img400500(String myshow_img400500) {
		this.myshow_img400500 = myshow_img400500;
	}
	public Long getMyshow_status() {
		return myshow_status;
	}
	public void setMyshow_status(Long myshow_status) {
		this.myshow_status = myshow_status;
	}
	public String getMyshow_content() {
		return myshow_content;
	}
	public void setMyshow_content(String myshow_content) {
		this.myshow_content = myshow_content;
	}
	public Long getMyshow_show() {
		return myshow_show;
	}
	public void setMyshow_show(Long myshow_show) {
		this.myshow_show = myshow_show;
	}
	public Date getMyshow_createdate() {
		return myshow_createdate;
	}
	public void setMyshow_createdate(Date myshow_createdate) {
		this.myshow_createdate = myshow_createdate;
	}

	public String getMyshow_img100() {
		return myshow_img100;
	}
	public void setMyshow_img100(String myshow_img100) {
		this.myshow_img100 = myshow_img100;
	}
	public Long getMyshow_reasontype() {
		return myshow_reasontype;
	}
	public void setMyshow_reasontype(Long myshow_reasontype) {
		this.myshow_reasontype = myshow_reasontype;
	}
	public String getMyshow_reason() {
		return myshow_reason;
	}
	public void setMyshow_reason(String myshow_reason) {
		this.myshow_reason = myshow_reason;
	}
}
