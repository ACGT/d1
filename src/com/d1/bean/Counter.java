package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="counter")
public class Counter extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="counter_id")
	private String id;//done
	private String counter_title;
	private String counter_rackcode;
	private String counter_brandname;
	private String counter_brandpic;
	private String counter_info;
	private String counter_pic;
	private String counter_pictong;
	private String counter_addusr;
	private Date counter_addtime;
	private Long counter_status;
	private String counter_description;
	private String counter_keyword;
	private Long counter_flagpg;
	private Long counter_sex;
	private String counter_titlepic;
	private String counter_story;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCounter_title() {
		return counter_title;
	}
	public void setCounter_title(String counter_title) {
		this.counter_title = counter_title;
	}
	public String getCounter_rackcode() {
		return counter_rackcode;
	}
	public void setCounter_rackcode(String counter_rackcode) {
		this.counter_rackcode = counter_rackcode;
	}
	public String getCounter_brandname() {
		return counter_brandname;
	}
	public void setCounter_brandname(String counter_brandname) {
		this.counter_brandname = counter_brandname;
	}
	public String getCounter_brandpic() {
		return counter_brandpic;
	}
	public void setCounter_brandpic(String counter_brandpic) {
		this.counter_brandpic = counter_brandpic;
	}
	public String getCounter_info() {
		return counter_info;
	}
	public void setCounter_info(String counter_info) {
		this.counter_info = counter_info;
	}
	public String getCounter_pic() {
		return counter_pic;
	}
	public void setCounter_pic(String counter_pic) {
		this.counter_pic = counter_pic;
	}
	public String getCounter_pictong() {
		return counter_pictong;
	}
	public void setCounter_pictong(String counter_pictong) {
		this.counter_pictong = counter_pictong;
	}
	public String getCounter_addusr() {
		return counter_addusr;
	}
	public void setCounter_addusr(String counter_addusr) {
		this.counter_addusr = counter_addusr;
	}
	public Date getCounter_addtime() {
		return counter_addtime;
	}
	public void setCounter_addtime(Date counter_addtime) {
		this.counter_addtime = counter_addtime;
	}
	public Long getCounter_status() {
		return counter_status;
	}
	public void setCounter_status(Long counter_status) {
		this.counter_status = counter_status;
	}
	public String getCounter_description() {
		return counter_description;
	}
	public void setCounter_description(String counter_description) {
		this.counter_description = counter_description;
	}
	public String getCounter_keyword() {
		return counter_keyword;
	}
	public void setCounter_keyword(String counter_keyword) {
		this.counter_keyword = counter_keyword;
	}
	public Long getCounter_flagpg() {
		return counter_flagpg;
	}
	public void setCounter_flagpg(Long counter_flagpg) {
		this.counter_flagpg = counter_flagpg;
	}
	public Long getCounter_sex() {
		return counter_sex;
	}
	public void setCounter_sex(Long counter_sex) {
		this.counter_sex = counter_sex;
	}
	public String getCounter_titlepic() {
		return counter_titlepic;
	}
	public void setCounter_titlepic(String counter_titlepic) {
		this.counter_titlepic = counter_titlepic;
	}
	public String getCounter_story() {
		return counter_story;
	}
	public void setCounter_story(String counter_story) {
		this.counter_story = counter_story;
	}
}
