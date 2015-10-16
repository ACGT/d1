package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 团购商品表
 * @author kk
 *
 */
@Entity
@Table(name="tgrpmst")
public class ProductGroup extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tgrpmst_id")
	private String id;//done
	private String tgrpmst_gdsid;
	private String tgrpmst_gdname;
	private String tgrpmst_oldpic;
	private String tgrpmst_pic;
	private String tgrpmst_info;
	private Date tgrpmst_starttime;
	private Date tgrpmst_endtime;
	private Long tgrpmst_maxcount;
	private Float tgrpmst_nprice;
	private String tgrpmst_kprice;
	private Float tgrpmst_sprice;
	private Long tgrpmst_hotmodulus;
	private Long tgrpmst_relcount;
	private Long tgrpmst_relpeoplecount;
	private Long tgrpmst_supreme;
	private Date tgrpmst_addtime;
	private Long tgrpmst_priority;
	private Long tgrpmst_state;
	private String tgrpmst_360img;
	private String tgrpmst_indeximg;
	private String tgrpmst_actimg;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTgrpmst_gdsid() {
		return tgrpmst_gdsid;
	}
	public void setTgrpmst_gdsid(String tgrpmst_gdsid) {
		this.tgrpmst_gdsid = tgrpmst_gdsid;
	}
	public String getTgrpmst_gdname() {
		return tgrpmst_gdname;
	}
	public void setTgrpmst_gdname(String tgrpmst_gdname) {
		this.tgrpmst_gdname = tgrpmst_gdname;
	}
	public String getTgrpmst_oldpic() {
		return tgrpmst_oldpic;
	}
	public void setTgrpmst_oldpic(String tgrpmst_oldpic) {
		this.tgrpmst_oldpic = tgrpmst_oldpic;
	}
	public String getTgrpmst_pic() {
		return tgrpmst_pic;
	}
	public void setTgrpmst_pic(String tgrpmst_pic) {
		this.tgrpmst_pic = tgrpmst_pic;
	}
	public String getTgrpmst_info() {
		return tgrpmst_info;
	}
	public void setTgrpmst_info(String tgrpmst_info) {
		this.tgrpmst_info = tgrpmst_info;
	}
	public Date getTgrpmst_starttime() {
		return tgrpmst_starttime;
	}
	public void setTgrpmst_starttime(Date tgrpmst_starttime) {
		this.tgrpmst_starttime = tgrpmst_starttime;
	}
	public Date getTgrpmst_endtime() {
		return tgrpmst_endtime;
	}
	public void setTgrpmst_endtime(Date tgrpmst_endtime) {
		this.tgrpmst_endtime = tgrpmst_endtime;
	}
	public Long getTgrpmst_maxcount() {
		return tgrpmst_maxcount;
	}
	public void setTgrpmst_maxcount(Long tgrpmst_maxcount) {
		this.tgrpmst_maxcount = tgrpmst_maxcount;
	}
	public Float getTgrpmst_nprice() {
		return tgrpmst_nprice;
	}
	public void setTgrpmst_nprice(Float tgrpmst_nprice) {
		this.tgrpmst_nprice = tgrpmst_nprice;
	}
	public String getTgrpmst_kprice() {
		return tgrpmst_kprice;
	}
	public void setTgrpmst_kprice(String tgrpmst_kprice) {
		this.tgrpmst_kprice = tgrpmst_kprice;
	}
	public Float getTgrpmst_sprice() {
		return tgrpmst_sprice;
	}
	public void setTgrpmst_sprice(Float tgrpmst_sprice) {
		this.tgrpmst_sprice = tgrpmst_sprice;
	}
	public Long getTgrpmst_hotmodulus() {
		return tgrpmst_hotmodulus;
	}
	public void setTgrpmst_hotmodulus(Long tgrpmst_hotmodulus) {
		this.tgrpmst_hotmodulus = tgrpmst_hotmodulus;
	}
	public Long getTgrpmst_relcount() {
		return tgrpmst_relcount;
	}
	public void setTgrpmst_relcount(Long tgrpmst_relcount) {
		this.tgrpmst_relcount = tgrpmst_relcount;
	}
	public Long getTgrpmst_relpeoplecount() {
		return tgrpmst_relpeoplecount;
	}
	public void setTgrpmst_relpeoplecount(Long tgrpmst_relpeoplecount) {
		this.tgrpmst_relpeoplecount = tgrpmst_relpeoplecount;
	}
	public Long getTgrpmst_supreme() {
		return tgrpmst_supreme;
	}
	public void setTgrpmst_supreme(Long tgrpmst_supreme) {
		this.tgrpmst_supreme = tgrpmst_supreme;
	}
	public Date getTgrpmst_addtime() {
		return tgrpmst_addtime;
	}
	public void setTgrpmst_addtime(Date tgrpmst_addtime) {
		this.tgrpmst_addtime = tgrpmst_addtime;
	}
	public Long getTgrpmst_priority() {
		return tgrpmst_priority;
	}
	public void setTgrpmst_priority(Long tgrpmst_priority) {
		this.tgrpmst_priority = tgrpmst_priority;
	}
	public Long getTgrpmst_state() {
		return tgrpmst_state;
	}
	public void setTgrpmst_state(Long tgrpmst_state) {
		this.tgrpmst_state = tgrpmst_state;
	}
	public String getTgrpmst_360img() {
		return tgrpmst_360img;
	}
	public void setTgrpmst_360img(String tgrpmst_360img) {
		this.tgrpmst_360img = tgrpmst_360img;
	}
	public String getTgrpmst_indeximg() {
		return tgrpmst_indeximg;
	}
	public void setTgrpmst_indeximg(String tgrpmst_indeximg) {
		this.tgrpmst_indeximg = tgrpmst_indeximg;
	}
	public String getTgrpmst_actimg() {
		return tgrpmst_actimg;
	}
	public void setTgrpmst_actimg(String tgrpmst_actimg) {
		this.tgrpmst_actimg = tgrpmst_actimg;
	}
	
}
