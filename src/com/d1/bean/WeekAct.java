package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 周活动表
 * @author gjl
 *
 */
@Entity
@Table(name="weekact")
public class WeekAct extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="weekact_id")
	private String id;
	private String weekact_title;
	private String weekact_imgurl;
	private String weekact_url;
	private String weekact_plid;
	private Long weekact_flag=new Long(0);
	private Date weekact_createdate=new Date();
	private Long weekact_sort;
	
	public Long getWeekact_sort() {
		return weekact_sort;
	}
	public void setWeekact_sort(Long weekact_sort) {
		this.weekact_sort = weekact_sort;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWeekact_title() {
		return weekact_title;
	}
	public void setWeekact_title(String weekact_title) {
		this.weekact_title = weekact_title;
	}
	public String getWeekact_imgurl() {
		return weekact_imgurl;
	}
	public void setWeekact_imgurl(String weekact_imgurl) {
		this.weekact_imgurl = weekact_imgurl;
	}
	public String getWeekact_url() {
		return weekact_url;
	}
	public void setWeekact_url(String weekact_url) {
		this.weekact_url = weekact_url;
	}
	public String getWeekact_plid() {
		return weekact_plid;
	}
	public void setWeekact_plid(String weekact_plid) {
		this.weekact_plid = weekact_plid;
	}
	public Long getWeekact_flag() {
		return weekact_flag;
	}
	public void setWeekact_flag(Long weekact_flag) {
		this.weekact_flag = weekact_flag;
	}
	public Date getWeekact_createdate() {
		return weekact_createdate;
	}
	public void setWeekact_createdate(Date weekact_createdate) {
		this.weekact_createdate = weekact_createdate;
	}

}
