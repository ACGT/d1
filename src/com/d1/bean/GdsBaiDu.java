package com.d1.bean;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 百度微购商品
 * @author gjl
 *
 */
@Entity
@Table(name="gdsbaidu",catalog="dba")
public class GdsBaiDu extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsbaidu_skuid")
	private String id;//done
/*gdsbaidu_gdsid char(8),gdsbaidu_skuid varchar(50),gdsbaidu_line char(10),gdsbaidu_price float,gdsbaidu_brand varchar(50),
gdsbaidu_stock int,gdsbaidu_cid int,gdsbaidu_description varchar(3000),gdsbaidu_image varchar(400),gdsbaidu_psotpay int,gdsbaidu_update datetime
,gdsbaidu_promotion int,gdsbaidu_major int,gdsbaidu_barcode varchar(50),gdsbaidu_createdate datetime default(getdate())
 * */
   private String gdsbaidu_gdsid;
   private String gdsbaidu_line;
   private Double gdsbaidu_price;
   private String gdsbaidu_brand;
   private Long gdsbaidu_stock;
   private Long gdsbaidu_cid;
   private String gdsbaidu_description;
   private String gdsbaidu_image;
   private String gdsbaidu_postpay;
   private Date gdsbaidu_update=new Date();
   private Long gdsbaidu_promotion;
   private Long gdsbaidu_major;
   private String gdsbaidu_barcode;
   private Date gdsbaidu_createdate=new Date();

public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getGdsbaidu_gdsid() {
	return gdsbaidu_gdsid;
}
public void setGdsbaidu_gdsid(String gdsbaidu_gdsid) {
	this.gdsbaidu_gdsid = gdsbaidu_gdsid;
}
public String getGdsbaidu_line() {
	return gdsbaidu_line;
}
public void setGdsbaidu_line(String gdsbaidu_line) {
	this.gdsbaidu_line = gdsbaidu_line;
}
public Double getGdsbaidu_price() {
	return gdsbaidu_price;
}
public void setGdsbaidu_price(Double gdsbaidu_price) {
	this.gdsbaidu_price = gdsbaidu_price;
}
public String getGdsbaidu_brand() {
	return gdsbaidu_brand;
}
public void setGdsbaidu_brand(String gdsbaidu_brand) {
	this.gdsbaidu_brand = gdsbaidu_brand;
}
public Long getGdsbaidu_stock() {
	return gdsbaidu_stock;
}
public void setGdsbaidu_stock(Long gdsbaidu_stock) {
	this.gdsbaidu_stock = gdsbaidu_stock;
}
public Long getGdsbaidu_cid() {
	return gdsbaidu_cid;
}
public void setGdsbaidu_cid(Long gdsbaidu_cid) {
	this.gdsbaidu_cid = gdsbaidu_cid;
}
public String getGdsbaidu_description() {
	return gdsbaidu_description;
}
public void setGdsbaidu_description(String gdsbaidu_description) {
	this.gdsbaidu_description = gdsbaidu_description;
}
public String getGdsbaidu_image() {
	return gdsbaidu_image;
}
public void setGdsbaidu_image(String gdsbaidu_image) {
	this.gdsbaidu_image = gdsbaidu_image;
}
public String getGdsbaidu_postpay() {
	return gdsbaidu_postpay;
}
public void setGdsbaidu_postpay(String gdsbaidu_postpay) {
	this.gdsbaidu_postpay = gdsbaidu_postpay;
}
public Date getGdsbaidu_update() {
	return gdsbaidu_update;
}
public void setGdsbaidu_update(Date gdsbaidu_update) {
	this.gdsbaidu_update = gdsbaidu_update;
}
public Long getGdsbaidu_promotion() {
	return gdsbaidu_promotion;
}
public void setGdsbaidu_promotion(Long gdsbaidu_promotion) {
	this.gdsbaidu_promotion = gdsbaidu_promotion;
}
public Long getGdsbaidu_major() {
	return gdsbaidu_major;
}
public void setGdsbaidu_major(Long gdsbaidu_major) {
	this.gdsbaidu_major = gdsbaidu_major;
}
public String getGdsbaidu_barcode() {
	return gdsbaidu_barcode;
}
public void setGdsbaidu_barcode(String gdsbaidu_barcode) {
	this.gdsbaidu_barcode = gdsbaidu_barcode;
}
public Date getGdsbaidu_createdate() {
	return gdsbaidu_createdate;
}
public void setGdsbaidu_createdate(Date gdsbaidu_createdate) {
	this.gdsbaidu_createdate = gdsbaidu_createdate;
}
}
