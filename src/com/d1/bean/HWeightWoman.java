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
@Table(name="wheightwoman",catalog="dba")
public class HWeightWoman extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="wheightwoman_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String wheightwoman_title;
	private String wheightwoman_stu1;
	private String wheightwoman_stu2;
	private String wheightwoman_stu3;
	private String wheightwoman_stu4;
	private String wheightwoman_stu5;
	private String wheightwoman_stu6;
	private String wheightwoman_stu7;
	private String wheightwoman_memo;
	private Date wheightwoman_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getWheightwoman_title() {
		return wheightwoman_title;
	}
	public void setWheightwoman_title(String wheightwoman_title) {
		this.wheightwoman_title = wheightwoman_title;
	}
	public String getWheightwoman_stu1() {
		return wheightwoman_stu1;
	}
	public void setWheightwoman_stu1(String wheightwoman_stu1) {
		this.wheightwoman_stu1 = wheightwoman_stu1;
	}
	public String getWheightwoman_stu2() {
		return wheightwoman_stu2;
	}
	public void setWheightwoman_stu2(String wheightwoman_stu2) {
		this.wheightwoman_stu2 = wheightwoman_stu2;
	}
	public String getWheightwoman_stu3() {
		return wheightwoman_stu3;
	}
	public void setWheightwoman_stu3(String wheightwoman_stu3) {
		this.wheightwoman_stu3 = wheightwoman_stu3;
	}
	public String getWheightwoman_stu4() {
		return wheightwoman_stu4;
	}
	public void setWheightwoman_stu4(String wheightwoman_stu4) {
		this.wheightwoman_stu4 = wheightwoman_stu4;
	}
	public String getWheightwoman_stu5() {
		return wheightwoman_stu5;
	}
	public void setWheightwoman_stu5(String wheightwoman_stu5) {
		this.wheightwoman_stu5 = wheightwoman_stu5;
	}
	public String getWheightwoman_stu6() {
		return wheightwoman_stu6;
	}
	public void setWheightwoman_stu6(String wheightwoman_stu6) {
		this.wheightwoman_stu6 = wheightwoman_stu6;
	}
	public String getWheightwoman_stu7() {
		return wheightwoman_stu7;
	}
	public void setWheightwoman_stu7(String wheightwoman_stu7) {
		this.wheightwoman_stu7 = wheightwoman_stu7;
	}
	public String getWheightwoman_memo() {
		return wheightwoman_memo;
	}
	public void setWheightwoman_memo(String wheightwoman_memo) {
		this.wheightwoman_memo = wheightwoman_memo;
	}
	public Date getWheightwoman_createdate() {
		return wheightwoman_createdate;
	}
	public void setWheightwoman_createdate(Date wheightwoman_createdate) {
		this.wheightwoman_createdate = wheightwoman_createdate;
	}
	
}
