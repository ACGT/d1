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
 * 商品系列
 * @author wdx
 */
@Entity
@Table(name="gdsser")
public class Gdsser extends BaseEntity implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsser_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private String gdsser_brandid;
	private String gdsser_title;
	private String gdsser_tail;
	private Long gdsser_sort;
	private Long gdsser_flag;
	private Date gdsser_createdate;
	private String gdsser_timg;
	private String gdsser_img;
	private String gdsser_imgbg;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getGdsser_brandid() {
		return gdsser_brandid;
	}
	public void setGdsser_brandid(String gdsser_brandid) {
		this.gdsser_brandid = gdsser_brandid;
	}
	public String getGdsser_title() {
		return gdsser_title;
	}
	public void setGdsser_title(String gdsser_title) {
		this.gdsser_title = gdsser_title;
	}
	public String getGdsser_tail() {
		return gdsser_tail;
	}
	public void setGdsser_tail(String gdsser_tail) {
		this.gdsser_tail = gdsser_tail;
	}
	public Long getGdsser_sort() {
		return gdsser_sort;
	}
	public void setGdsser_sort(Long gdsser_sort) {
		this.gdsser_sort = gdsser_sort;
	}
	public Long getGdsser_flag() {
		return gdsser_flag;
	}
	public void setGdsser_flag(Long gdsser_flag) {
		this.gdsser_flag = gdsser_flag;
	}
	public Date getGdsser_createdate() {
		return gdsser_createdate;
	}
	public void setGdsser_createdate(Date gdsser_createdate) {
		this.gdsser_createdate = gdsser_createdate;
	}
	public String getGdsser_timg() {
		return gdsser_timg;
	}
	public void setGdsser_timg(String gdsser_timg) {
		this.gdsser_timg = gdsser_timg;
	}
	public String getGdsser_img() {
		return gdsser_img;
	}
	public void setGdsser_img(String gdsser_img) {
		this.gdsser_img = gdsser_img;
	}
	public String getGdsser_imgbg() {
		return gdsser_imgbg;
	}
	public void setGdsser_imgbg(String gdsser_imgbg) {
		this.gdsser_imgbg = gdsser_imgbg;
	}
	
	
	
}
