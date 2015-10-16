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
 * 搭配主表
 * @author wdx
 */
@Entity
@Table(name="gdscoll")
public class Gdscoll extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdscoll_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done	
	private Long gdscoll_serid;
	private String gdscoll_title;
	private String gdscoll_tail;
	private String gdscoll_bigimgurl;
	private String gdscoll_smallimgurl;
	private Long gdscoll_flag;
	private Long gdscoll_sort;
	private Date gdscoll_createdate;
	private String gdscoll_indextitle;   
    private String gdscoll_brandimg;
    private Long gdscoll_imgposition;
    private Long gdscoll_textposition;
    private Long gdscoll_cate;//1:男，2：女，3：情侣
    private String gdscoll_czimg;

    private Long gdscoll_bgid;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getGdscoll_serid() {
		return gdscoll_serid;
	}
	public void setGdscoll_serid(Long gdscoll_serid) {
		this.gdscoll_serid = gdscoll_serid;
	}
	public String getGdscoll_title() {
		return gdscoll_title;
	}
	public void setGdscoll_title(String gdscoll_title) {
		this.gdscoll_title = gdscoll_title;
	}
	public String getGdscoll_tail() {
		return gdscoll_tail;
	}
	public void setGdscoll_tail(String gdscoll_tail) {
		this.gdscoll_tail = gdscoll_tail;
	}
	public String getGdscoll_bigimgurl() {
		return gdscoll_bigimgurl;
	}
	public void setGdscoll_bigimgurl(String gdscoll_bigimgurl) {
		this.gdscoll_bigimgurl = gdscoll_bigimgurl;
	}
	public String getGdscoll_smallimgurl() {
		return gdscoll_smallimgurl;
	}
	public void setGdscoll_smallimgurl(String gdscoll_smallimgurl) {
		this.gdscoll_smallimgurl = gdscoll_smallimgurl;
	}
	public Long getGdscoll_flag() {
		return gdscoll_flag;
	}
	public void setGdscoll_flag(Long gdscoll_flag) {
		this.gdscoll_flag = gdscoll_flag;
	}
	public Long getGdscoll_sort() {
		return gdscoll_sort;
	}
	public void setGdscoll_sort(Long gdscoll_sort) {
		this.gdscoll_sort = gdscoll_sort;
	}
	public Date getGdscoll_createdate() {
		return gdscoll_createdate;
	}
	public void setGdscoll_createdate(Date gdscoll_createdate) {
		this.gdscoll_createdate = gdscoll_createdate;
	}
	public String getGdscoll_indextitle() {
		return gdscoll_indextitle;
	}
	public void setGdscoll_indextitle(String gdscoll_indextitle) {
		this.gdscoll_indextitle = gdscoll_indextitle;
	}
	public String getGdscoll_brandimg() {
		return gdscoll_brandimg;
	}
	public void setGdscoll_brandimg(String gdscoll_brandimg) {
		this.gdscoll_brandimg = gdscoll_brandimg;
	}
	public Long getGdscoll_imgposition() {
		return gdscoll_imgposition;
	}
	public void setGdscoll_imgposition(Long gdscoll_imgposition) {
		this.gdscoll_imgposition = gdscoll_imgposition;
	}
	public Long getGdscoll_textposition() {
		return gdscoll_textposition;
	}
	public void setGdscoll_textposition(Long gdscoll_textposition) {
		this.gdscoll_textposition = gdscoll_textposition;
	}
	public Long getGdscoll_cate() {
		return gdscoll_cate;
	}
	public void setGdscoll_cate(Long gdscoll_cate) {
		this.gdscoll_cate = gdscoll_cate;
	}
	public String getGdscoll_czimg() {
		return gdscoll_czimg;
	}
	public void setGdscoll_czimg(String gdscoll_czimg) {
		this.gdscoll_czimg = gdscoll_czimg;
	}

	public Long getGdscoll_bgid() {
		return gdscoll_bgid;
	}
	public void setGdscoll_bgid(Long gdscoll_bgid) {
		this.gdscoll_bgid = gdscoll_bgid;
	}
	

	
}
