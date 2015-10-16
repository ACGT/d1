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
 * 商品评价表，正式表
 * @author kk
 *
 */
@Entity
@Table(name="gdscom",catalog="dba")
public class Comment extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="gdscom_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String gdscom_odrid;
	private Long gdscom_mbrid;
	private String gdscom_uid;
	private String gdscom_gdsid;
	private String gdscom_gdsname;
	private Long gdscom_level;
	private String gdscom_content;
	private Long gdscom_status;
	private Date gdscom_createdate;
	private Long gdscom_replyStatus;
	private String gdscom_replyContent;
	private Date gdscom_replydate;
	private String gdscom_operator;
	private Long gdscom_checkStatue;
	private String gdscom_pic1;
	private String gdscom_pic2;
	private String gdscom_pic3;
	private String gdscom_sku1;//sku
	private String gdscom_height;//身高
	private String gdscom_weight;//体重
	private String gdscom_comp;//是否合适
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public Long getGdscom_replyStatus() {
		return gdscom_replyStatus;
	}
	public void setGdscom_replyStatus(Long gdscom_replyStatus) {
		this.gdscom_replyStatus = gdscom_replyStatus;
	}
	public String getGdscom_replyContent() {
		return gdscom_replyContent;
	}
	public void setGdscom_replyContent(String gdscom_replyContent) {
		this.gdscom_replyContent = gdscom_replyContent;
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
	public Long getGdscom_checkStatue() {
		return gdscom_checkStatue;
	}
	public void setGdscom_checkStatue(Long gdscom_checkStatue) {
		this.gdscom_checkStatue = gdscom_checkStatue;
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
	public String getGdscom_sku1() {
		return gdscom_sku1;
	}
	public void setGdscom_sku1(String gdscom_sku1) {
		this.gdscom_sku1 = gdscom_sku1;
	}
	public String getGdscom_height() {
		return gdscom_height;
	}
	public void setGdscom_height(String gdscom_height) {
		this.gdscom_height = gdscom_height;
	}
	public String getGdscom_weight() {
		return gdscom_weight;
	}
	public void setGdscom_weight(String gdscom_weight) {
		this.gdscom_weight = gdscom_weight;
	}
	public String getGdscom_comp() {
		return gdscom_comp;
	}
	public void setGdscom_comp(String gdscom_comp) {
		this.gdscom_comp = gdscom_comp;
	}
	
	
}
