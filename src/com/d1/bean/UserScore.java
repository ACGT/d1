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
 * 用户积分表
 * @author kk
 *
 */
@Entity
@Table(name="usrscore")
public class UserScore extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="usrscore_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	private Long usrscore_mbrid;
	private String usrscore_year;
	private String usrscore_month;
	private Long usrscore_lxmonth;
	private String usrscore_jlper;
	private Float usrscore_rcmscr;
	private Float usrscore_scr;
	private Date usrscore_createdate;
	private Float usrscore_buymoney;
	private Float usrscore_tktvalue;
	private Float usrscore_allscr;
	private Float usrscore_realscr;
	private Long usrscore_type;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getUsrscore_mbrid() {
		return usrscore_mbrid;
	}
	public void setUsrscore_mbrid(Long usrscore_mbrid) {
		this.usrscore_mbrid = usrscore_mbrid;
	}
	public String getUsrscore_year() {
		return usrscore_year;
	}
	public void setUsrscore_year(String usrscore_year) {
		this.usrscore_year = usrscore_year;
	}
	public String getUsrscore_month() {
		return usrscore_month;
	}
	public void setUsrscore_month(String usrscore_month) {
		this.usrscore_month = usrscore_month;
	}
	public Long getUsrscore_lxmonth() {
		return usrscore_lxmonth;
	}
	public void setUsrscore_lxmonth(Long usrscore_lxmonth) {
		this.usrscore_lxmonth = usrscore_lxmonth;
	}
	public String getUsrscore_jlper() {
		return usrscore_jlper;
	}
	public void setUsrscore_jlper(String usrscore_jlper) {
		this.usrscore_jlper = usrscore_jlper;
	}
	public Float getUsrscore_rcmscr() {
		return usrscore_rcmscr;
	}
	public void setUsrscore_rcmscr(Float usrscore_rcmscr) {
		this.usrscore_rcmscr = usrscore_rcmscr;
	}
	public Float getUsrscore_scr() {
		return usrscore_scr;
	}
	public void setUsrscore_scr(Float usrscore_scr) {
		this.usrscore_scr = usrscore_scr;
	}
	public Date getUsrscore_createdate() {
		return usrscore_createdate;
	}
	public void setUsrscore_createdate(Date usrscore_createdate) {
		this.usrscore_createdate = usrscore_createdate;
	}
	public Float getUsrscore_buymoney() {
		return usrscore_buymoney;
	}
	public void setUsrscore_buymoney(Float usrscore_buymoney) {
		this.usrscore_buymoney = usrscore_buymoney;
	}
	public Float getUsrscore_tktvalue() {
		return usrscore_tktvalue;
	}
	public void setUsrscore_tktvalue(Float usrscore_tktvalue) {
		this.usrscore_tktvalue = usrscore_tktvalue;
	}
	public Float getUsrscore_allscr() {
		return usrscore_allscr;
	}
	public void setUsrscore_allscr(Float usrscore_allscr) {
		this.usrscore_allscr = usrscore_allscr;
	}
	public Float getUsrscore_realscr() {
		return usrscore_realscr;
	}
	public void setUsrscore_realscr(Float usrscore_realscr) {
		this.usrscore_realscr = usrscore_realscr;
	}
	public Long getUsrscore_type() {
		return usrscore_type;
	}
	public void setUsrscore_type(Long usrscore_type) {
		this.usrscore_type = usrscore_type;
	}
	
}
