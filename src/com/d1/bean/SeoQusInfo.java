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
@Table(name="seoqusinfo")
public class SeoQusInfo extends BaseEntity implements java.io.Serializable {
	/**
	 * searial version id
	 */
	
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String qus_title;
	private String qus_content;
	private String bigimg;
	private String smallimg;
	private String onlinetime;
	private String brand;
	private String keyword;
	private String category;
	private Long  flag;
	private Date createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQus_title() {
		return qus_title;
	}
	public void setQus_title(String qus_title) {
		this.qus_title = qus_title;
	}
	public String getQus_content() {
		return qus_content;
	}
	public void setQus_content(String qus_content) {
		this.qus_content = qus_content;
	}
	public String getBigimg() {
		return bigimg;
	}
	public void setBigimg(String bigimg) {
		this.bigimg = bigimg;
	}
	public String getSmallimg() {
		return smallimg;
	}
	public void setSmallimg(String smallimg) {
		this.smallimg = smallimg;
	}
	public String getOnlinetime() {
		return onlinetime;
	}
	public void setOnlinetime(String onlinetime) {
		this.onlinetime = onlinetime;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Long getFlag() {
		return flag;
	}
	public void setFlag(Long flag) {
		this.flag = flag;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
/**
 * qus_title nvarchar(200) not null,
   qus_content ntext not null,
   bigimg nvarchar(200),
   smallimg nvarchar(200),
   onlinetime datetime default(getdate()),
   brand nvarchar(100) not null,
   keyword nvarchar(500) not null,
   category nvarchar(20) not null,
   flag int default(0),
   createtime datetime default(getdate())   
 */
	
}
