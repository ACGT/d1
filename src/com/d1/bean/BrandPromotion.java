package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 品牌减免主表，前台只读
 * @author kk
 */
@Entity
@Table(name="brdtktmst",catalog="dba")
public class BrandPromotion extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="brdtktmst_id")
	private String id ;//done

	private String brdtktmst_title;
	
	/**
	 * 满多少
	 */
	private Float brdtktmst_gdsvalue;
	
	/**
	 * 减多少
	 */
	private Float brdtktmst_value;
	
	private Float brdtktmst_gdsvalue2;
	private Float brdtktmst_value2;
	
	private Float brdtktmst_gdsvalue3;
	private Float brdtktmst_value3;
	

	private String brdtktmst_bktpic;
	private Date brdtktmst_startdate;
	private Date brdtktmst_enddate;
	/**
	 * 1有效，0无效
	 */
	private Long brdtktmst_validflag;
	private String brdtktmst_memo;
	private Date brdtktmst_createtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBrdtktmst_title() {
		return brdtktmst_title;
	}
	public void setBrdtktmst_title(String brdtktmst_title) {
		this.brdtktmst_title = brdtktmst_title;
	}
	public Float getBrdtktmst_gdsvalue() {
		return brdtktmst_gdsvalue;
	}
	public void setBrdtktmst_gdsvalue(Float brdtktmst_gdsvalue) {
		this.brdtktmst_gdsvalue = brdtktmst_gdsvalue;
	}
	public Float getBrdtktmst_value() {
		return brdtktmst_value;
	}
	public void setBrdtktmst_value(Float brdtktmst_value) {
		this.brdtktmst_value = brdtktmst_value;
	}
	
	public Float getBrdtktmst_gdsvalue2() {
		return brdtktmst_gdsvalue2;
	}
	public void setBrdtktmst_gdsvalue2(Float brdtktmst_gdsvalue2) {
		this.brdtktmst_gdsvalue2 = brdtktmst_gdsvalue2;
	}
	public Float getBrdtktmst_value2() {
		return brdtktmst_value2;
	}
	public void setBrdtktmst_value2(Float brdtktmst_value2) {
		this.brdtktmst_value2 = brdtktmst_value2;
	}
	public Float getBrdtktmst_gdsvalue3() {
		return brdtktmst_gdsvalue3;
	}
	public void setBrdtktmst_gdsvalue3(Float brdtktmst_gdsvalue3) {
		this.brdtktmst_gdsvalue3 = brdtktmst_gdsvalue3;
	}
	public Float getBrdtktmst_value3() {
		return brdtktmst_value3;
	}
	public void setBrdtktmst_value3(Float brdtktmst_value3) {
		this.brdtktmst_value3 = brdtktmst_value3;
	}
	
	public String getBrdtktmst_bktpic() {
		return brdtktmst_bktpic;
	}
	public void setBrdtktmst_bktpic(String brdtktmst_bktpic) {
		this.brdtktmst_bktpic = brdtktmst_bktpic;
	}
	public Date getBrdtktmst_startdate() {
		return brdtktmst_startdate;
	}
	public void setBrdtktmst_startdate(Date brdtktmst_startdate) {
		this.brdtktmst_startdate = brdtktmst_startdate;
	}
	public Date getBrdtktmst_enddate() {
		return brdtktmst_enddate;
	}
	public void setBrdtktmst_enddate(Date brdtktmst_enddate) {
		this.brdtktmst_enddate = brdtktmst_enddate;
	}
	public Long getBrdtktmst_validflag() {
		return brdtktmst_validflag;
	}
	public void setBrdtktmst_validflag(Long brdtktmst_validflag) {
		this.brdtktmst_validflag = brdtktmst_validflag;
	}
	public String getBrdtktmst_memo() {
		return brdtktmst_memo;
	}
	public void setBrdtktmst_memo(String brdtktmst_memo) {
		this.brdtktmst_memo = brdtktmst_memo;
	}
	public Date getBrdtktmst_createtime() {
		return brdtktmst_createtime;
	}
	public void setBrdtktmst_createtime(Date brdtktmst_createtime) {
		this.brdtktmst_createtime = brdtktmst_createtime;
	}
}
