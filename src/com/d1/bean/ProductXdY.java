package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * x¼þ´òyÕÛ
 * @author kk
 *
 */
@Entity
@Table(name="gdsdisc")
public class ProductXdY extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="gdsdisc_id")
	private String id;//done
	
	private String gdsdisc_title;
	private String gdsdisc_content;
	private Long gdsdisc_rangesta1;
	private Long gdsdisc_rangeend1;
	private Float gdsdisc_percen1;
	private Long gdsdisc_rangesta2;
	private Long gdsdisc_rangeend2;
	private Float gdsdisc_percen2;
	private Long gdsdisc_rangesta3;
	private Long gdsdisc_rangeend3;
	private Float gdsdisc_percen3;
	private Date gdsdisc_starttime;
	private Date gdsdisc_endtime;
	private Long gdsdisc_validflag;
	private Long gdsdisc_sex;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGdsdisc_title() {
		return gdsdisc_title;
	}
	public void setGdsdisc_title(String gdsdisc_title) {
		this.gdsdisc_title = gdsdisc_title;
	}
	public String getGdsdisc_content() {
		return gdsdisc_content;
	}
	public void setGdsdisc_content(String gdsdisc_content) {
		this.gdsdisc_content = gdsdisc_content;
	}
	public Long getGdsdisc_rangesta1() {
		return gdsdisc_rangesta1;
	}
	public void setGdsdisc_rangesta1(Long gdsdisc_rangesta1) {
		this.gdsdisc_rangesta1 = gdsdisc_rangesta1;
	}
	public Long getGdsdisc_rangeend1() {
		return gdsdisc_rangeend1;
	}
	public void setGdsdisc_rangeend1(Long gdsdisc_rangeend1) {
		this.gdsdisc_rangeend1 = gdsdisc_rangeend1;
	}
	public Float getGdsdisc_percen1() {
		return gdsdisc_percen1;
	}
	public void setGdsdisc_percen1(Float gdsdisc_percen1) {
		this.gdsdisc_percen1 = gdsdisc_percen1;
	}
	public Long getGdsdisc_rangesta2() {
		return gdsdisc_rangesta2;
	}
	public void setGdsdisc_rangesta2(Long gdsdisc_rangesta2) {
		this.gdsdisc_rangesta2 = gdsdisc_rangesta2;
	}
	public Long getGdsdisc_rangeend2() {
		return gdsdisc_rangeend2;
	}
	public void setGdsdisc_rangeend2(Long gdsdisc_rangeend2) {
		this.gdsdisc_rangeend2 = gdsdisc_rangeend2;
	}
	public Float getGdsdisc_percen2() {
		return gdsdisc_percen2;
	}
	public void setGdsdisc_percen2(Float gdsdisc_percen2) {
		this.gdsdisc_percen2 = gdsdisc_percen2;
	}
	public Long getGdsdisc_rangesta3() {
		return gdsdisc_rangesta3;
	}
	public void setGdsdisc_rangesta3(Long gdsdisc_rangesta3) {
		this.gdsdisc_rangesta3 = gdsdisc_rangesta3;
	}
	public Long getGdsdisc_rangeend3() {
		return gdsdisc_rangeend3;
	}
	public void setGdsdisc_rangeend3(Long gdsdisc_rangeend3) {
		this.gdsdisc_rangeend3 = gdsdisc_rangeend3;
	}
	public Float getGdsdisc_percen3() {
		return gdsdisc_percen3;
	}
	public void setGdsdisc_percen3(Float gdsdisc_percen3) {
		this.gdsdisc_percen3 = gdsdisc_percen3;
	}
	public Date getGdsdisc_starttime() {
		return gdsdisc_starttime;
	}
	public void setGdsdisc_starttime(Date gdsdisc_starttime) {
		this.gdsdisc_starttime = gdsdisc_starttime;
	}
	public Date getGdsdisc_endtime() {
		return gdsdisc_endtime;
	}
	public void setGdsdisc_endtime(Date gdsdisc_endtime) {
		this.gdsdisc_endtime = gdsdisc_endtime;
	}
	public Long getGdsdisc_validflag() {
		return gdsdisc_validflag;
	}
	public void setGdsdisc_validflag(Long gdsdisc_validflag) {
		this.gdsdisc_validflag = gdsdisc_validflag;
	}
	public Long getGdsdisc_sex() {
		return gdsdisc_sex;
	}
	public void setGdsdisc_sex(Long gdsdisc_sex) {
		this.gdsdisc_sex = gdsdisc_sex;
	}
}
