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
 * 优惠券。这个是虚拟券。刮开规则，如刮“mqwyjfc196969527940”，拆开后是<br/>
 * “mqwyjfc19 69695279 40”，对应“mqwyjfc19”的数据库记录tktgroup_checkcode字段的值为87.<br/>
 * 69695279之和6+9+6+9+5+2+7+9=53，53+之前的87=140,140取后两位刚好是40.即满足条件
 * @author kk
 *
 */
@Entity
@Table(name="tktgroup")
public class TicketGroup extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tktgroup_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done

	/**
	 * 券头
	 */
	private String tktgroup_title;
	
	/**
	 * 0百分比减免券，1对应直减券
	 */
	private Long tktgroup_flag;
	private Long tktgroup_checkcode;
	private Long tktgroup_value;
	private Float tktgroup_discount;
	private String tktgroup_type;
	private Date tktgroup_createdate;
	private Date tktgroup_validates;
	private Date tktgroup_validatee;
	private String tktgroup_memo;
	private Long tktgroup_gdsvalue;
	private String tktgroup_rackcode;
	private String tktgroup_sprckcodestr;
	private Long tktgroup_ifvip;
	private Long tktgroup_num;
	private Long tktgroup_payid;
	private String tktgroup_brandname;
	private String tktgroup_shopcode;
	
	public String getTktgroup_brandname() {
		return tktgroup_brandname;
	}
	public void setTktgroup_brandname(String tktgroup_brandname) {
		this.tktgroup_brandname = tktgroup_brandname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTktgroup_title() {
		return tktgroup_title;
	}
	public void setTktgroup_title(String tktgroup_title) {
		this.tktgroup_title = tktgroup_title;
	}
	public Long getTktgroup_flag() {
		return tktgroup_flag;
	}
	public void setTktgroup_flag(Long tktgroup_flag) {
		this.tktgroup_flag = tktgroup_flag;
	}
	public Long getTktgroup_checkcode() {
		return tktgroup_checkcode;
	}
	public void setTktgroup_checkcode(Long tktgroup_checkcode) {
		this.tktgroup_checkcode = tktgroup_checkcode;
	}
	public Long getTktgroup_value() {
		return tktgroup_value;
	}
	public void setTktgroup_value(Long tktgroup_value) {
		this.tktgroup_value = tktgroup_value;
	}
	public Float getTktgroup_discount() {
		return tktgroup_discount;
	}
	public void setTktgroup_discount(Float tktgroup_discount) {
		this.tktgroup_discount = tktgroup_discount;
	}
	public String getTktgroup_type() {
		return tktgroup_type;
	}
	public void setTktgroup_type(String tktgroup_type) {
		this.tktgroup_type = tktgroup_type;
	}
	public Date getTktgroup_createdate() {
		return tktgroup_createdate;
	}
	public void setTktgroup_createdate(Date tktgroup_createdate) {
		this.tktgroup_createdate = tktgroup_createdate;
	}
	public Date getTktgroup_validates() {
		return tktgroup_validates;
	}
	public void setTktgroup_validates(Date tktgroup_validates) {
		this.tktgroup_validates = tktgroup_validates;
	}
	public Date getTktgroup_validatee() {
		return tktgroup_validatee;
	}
	public void setTktgroup_validatee(Date tktgroup_validatee) {
		this.tktgroup_validatee = tktgroup_validatee;
	}
	public String getTktgroup_memo() {
		return tktgroup_memo;
	}
	public void setTktgroup_memo(String tktgroup_memo) {
		this.tktgroup_memo = tktgroup_memo;
	}
	public Long getTktgroup_gdsvalue() {
		return tktgroup_gdsvalue;
	}
	public void setTktgroup_gdsvalue(Long tktgroup_gdsvalue) {
		this.tktgroup_gdsvalue = tktgroup_gdsvalue;
	}
	public String getTktgroup_rackcode() {
		return tktgroup_rackcode;
	}
	public void setTktgroup_rackcode(String tktgroup_rackcode) {
		this.tktgroup_rackcode = tktgroup_rackcode;
	}
	public String getTktgroup_sprckcodestr() {
		return tktgroup_sprckcodestr;
	}
	public void setTktgroup_sprckcodestr(String tktgroup_sprckcodestr) {
		this.tktgroup_sprckcodestr = tktgroup_sprckcodestr;
	}
	public Long getTktgroup_ifvip() {
		return tktgroup_ifvip;
	}
	public void setTktgroup_ifvip(Long tktgroup_ifvip) {
		this.tktgroup_ifvip = tktgroup_ifvip;
	}
	public Long getTktgroup_num() {
		return tktgroup_num;
	}
	public void setTktgroup_num(Long tktgroup_num) {
		this.tktgroup_num = tktgroup_num;
	}
	public Long getTktgroup_payid() {
		return tktgroup_payid;
	}
	public void setTktgroup_payid(Long tktgroup_payid) {
		this.tktgroup_payid = tktgroup_payid;
	}
	public String getTktgroup_shopcode() {
		return tktgroup_shopcode;
	}
	public void setTktgroup_shopcode(String tktgroup_shopcode) {
		this.tktgroup_shopcode = tktgroup_shopcode;
	}
	
}
