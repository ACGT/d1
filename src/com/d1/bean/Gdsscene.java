package com.d1.bean;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/*
 * ³¡¾°±í
 */
@Entity
@Table(name="gdsscene")
public class Gdsscene extends BaseEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="gdsscene_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
    private Long gdsscene_gdserid;
	private String gdsscene_gdscollid;
	
	private String gdsscene_title;
	private String gdsscene_tail;
	private String gdsscene_imgurl;
	private Long gdsscene_flag;
	private Long gdsscene_sort;
	private Date gdsscene_createdate;
	private String gdsscene_url;
	private String gdsscene_imgbg;
	private String gdscene_gdscode;
	private String gdsscene_color;
	private Long gdsscene_status;
	private String gdsscene_scalimg;
	private String gdsscene_scaldes;
	private Long gdsscene_logo;
	private String gdsscene_bgcolor;
	private String gdsscene_gdscolor;
	private String gdsscene_overcolor;
	private String gdsscene_dpbgimg;
	private Long gdsscene_mode;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getGdsscene_bgcolor() {
		return gdsscene_bgcolor;
	}
	public void setGdsscene_bgcolor(String gdsscene_bgcolor) {
		this.gdsscene_bgcolor = gdsscene_bgcolor;
	}
	public String getGdsscene_gdscolor() {
		return gdsscene_gdscolor;
	}
	public void setGdsscene_gdscolor(String gdsscene_gdscolor) {
		this.gdsscene_gdscolor = gdsscene_gdscolor;
	}
	public String getGdsscene_overcolor() {
		return gdsscene_overcolor;
	}
	public void setGdsscene_overcolor(String gdsscene_overcolor) {
		this.gdsscene_overcolor = gdsscene_overcolor;
	}
	public String getGdsscene_dpbgimg() {
		return gdsscene_dpbgimg;
	}
	public void setGdsscene_dpbgimg(String gdsscene_dpbgimg) {
		this.gdsscene_dpbgimg = gdsscene_dpbgimg;
	}
	public String getGdsscene_title() {
		return gdsscene_title;
	}
	public void setGdsscene_title(String gdsscene_title) {
		this.gdsscene_title = gdsscene_title;
	}
	public String getGdsscene_tail() {
		return gdsscene_tail;
	}
	public void setGdsscene_tail(String gdsscene_tail) {
		this.gdsscene_tail = gdsscene_tail;
	}
	public String getGdsscene_imgurl() {
		return gdsscene_imgurl;
	}
	public void setGdsscene_imgurl(String gdsscene_imgurl) {
		this.gdsscene_imgurl = gdsscene_imgurl;
	}
	public Long getGdsscene_flag() {
		return gdsscene_flag;
	}
	public void setGdsscene_flag(Long gdsscene_flag) {
		this.gdsscene_flag = gdsscene_flag;
	}
	public Long getGdsscene_sort() {
		return gdsscene_sort;
	}
	
	public Date getGdsscene_createdate() {
		return gdsscene_createdate;
	}
	public void setGdsscene_createdate(Date gdsscene_createdate) {
		this.gdsscene_createdate = gdsscene_createdate;
	}
	public String getGdsscene_url() {
		return gdsscene_url;
	}
	public void setGdsscene_url(String gdsscene_url) {
		this.gdsscene_url = gdsscene_url;
	}
	
	public String getGdscene_gdscode() {
		return gdscene_gdscode;
	}
	public void setGdscene_gdscode(String gdscene_gdscode) {
		this.gdscene_gdscode = gdscene_gdscode;
	}
	public String getGdsscene_gdscollid() {
		return gdsscene_gdscollid;
	}
	public void setGdsscene_gdscollid(String gdsscene_gdscollid) {
		this.gdsscene_gdscollid = gdsscene_gdscollid;
	}
	public void setGdsscene_sort(Long gdsscene_sort) {
		this.gdsscene_sort = gdsscene_sort;
	}
	public Long getGdsscene_gdserid() {
		return gdsscene_gdserid;
	}
	public void setGdsscene_gdserid(Long gdsscene_gdserid) {
		this.gdsscene_gdserid = gdsscene_gdserid;
	}
	public String getGdsscene_imgbg() {
		return gdsscene_imgbg;
	}
	public void setGdsscene_imgbg(String gdsscene_imgbg) {
		this.gdsscene_imgbg = gdsscene_imgbg;
	}
	public String getGdsscene_color() {
		return gdsscene_color;
	}
	public void setGdsscene_color(String gdsscene_color) {
		this.gdsscene_color = gdsscene_color;
	}
	public Long getGdsscene_status() {
		return gdsscene_status;
	}
	public void setGdsscene_status(Long gdsscene_status) {
		this.gdsscene_status = gdsscene_status;
	}
	public String getGdsscene_scalimg() {
		return gdsscene_scalimg;
	}
	public void setGdsscene_scalimg(String gdsscene_scalimg) {
		this.gdsscene_scalimg = gdsscene_scalimg;
	}
	public String getGdsscene_scaldes() {
		return gdsscene_scaldes;
	}
	public void setGdsscene_scaldes(String gdsscene_scaldes) {
		this.gdsscene_scaldes = gdsscene_scaldes;
	}
	public Long getGdsscene_logo() {
		return gdsscene_logo;
	}
	public void setGdsscene_logo(Long gdsscene_logo) {
		this.gdsscene_logo = gdsscene_logo;
	}
	public Long getGdsscene_mode() {
		return gdsscene_mode;
	}
	public void setGdsscene_mode(Long gdsscene_mode) {
		this.gdsscene_mode = gdsscene_mode;
	}
	

	

}
