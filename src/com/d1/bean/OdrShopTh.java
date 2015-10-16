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
@Table(name="odrshopth",catalog="dba")
public class OdrShopTh extends BaseEntity implements java.io.Serializable  {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="odrshopth_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private String odrshopth_odrid;
	private Long odrshopth_subodrid;
	private Long odrshopth_mbrid;
	private String odrshopth_rname;
	private String odrshopth_phone;
	private String odrshopth_gdsid;
	private String odrshopth_gdsname;
	private Long odrshopth_gdscount;
	private Double odrshopth_money;
	private String odrshopth_shopcode;
	private Long odrshopth_thtype;	
	private Long odrshopth_paytype;
	private String odrshopth_thwhy;
	private String odrshopth_imgurl;
	private Long odrshopth_status;
	private Date odrshopth_shopcldate;
	private Date odrshopth_cldate;
	private String odrshopth_cluser;
	private String odrshopth_shipname;
	private String odrshopth_shipcode;
	private Date odrshopth_shipdate;
	private String odrshopth_memo;
	private Date odrshopth_createdate= new Date();
	private String odrshopth_usrkd;
	private String odrshopth_usrwl;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrshopth_odrid() {
		return odrshopth_odrid;
	}
	public void setOdrshopth_odrid(String odrshopth_odrid) {
		this.odrshopth_odrid = odrshopth_odrid;
	}
	public Long getOdrshopth_subodrid() {
		return odrshopth_subodrid;
	}
	public void setOdrshopth_subodrid(Long odrshopth_subodrid) {
		this.odrshopth_subodrid = odrshopth_subodrid;
	}
	public Long getOdrshopth_thtype() {
		return odrshopth_thtype;
	}
	public void setOdrshopth_thtype(Long odrshopth_thtype) {
		this.odrshopth_thtype = odrshopth_thtype;
	}
	public Long getOdrshopth_paytype() {
		return odrshopth_paytype;
	}
	public void setOdrshopth_paytype(Long odrshopth_paytype) {
		this.odrshopth_paytype = odrshopth_paytype;
	}
	public String getOdrshopth_thwhy() {
		return odrshopth_thwhy;
	}
	public void setOdrshopth_thwhy(String odrshopth_thwhy) {
		this.odrshopth_thwhy = odrshopth_thwhy;
	}
	public Long getOdrshopth_mbrid() {
		return odrshopth_mbrid;
	}
	public void setOdrshopth_mbrid(Long odrshopth_mbrid) {
		this.odrshopth_mbrid = odrshopth_mbrid;
	}
	public String getOdrshopth_rname() {
		return odrshopth_rname;
	}
	public void setOdrshopth_rname(String odrshopth_rname) {
		this.odrshopth_rname = odrshopth_rname;
	}
	public String getOdrshopth_phone() {
		return odrshopth_phone;
	}
	public void setOdrshopth_phone(String odrshopth_phone) {
		this.odrshopth_phone = odrshopth_phone;
	}
	public String getOdrshopth_gdsid() {
		return odrshopth_gdsid;
	}
	public void setOdrshopth_gdsid(String odrshopth_gdsid) {
		this.odrshopth_gdsid = odrshopth_gdsid;
	}
	public String getOdrshopth_gdsname() {
		return odrshopth_gdsname;
	}
	public void setOdrshopth_gdsname(String odrshopth_gdsname) {
		this.odrshopth_gdsname = odrshopth_gdsname;
	}
	public Long getOdrshopth_gdscount() {
		return odrshopth_gdscount;
	}
	public void setOdrshopth_gdscount(Long odrshopth_gdscount) {
		this.odrshopth_gdscount = odrshopth_gdscount;
	}
	public Double getOdrshopth_money() {
		return odrshopth_money;
	}
	public void setOdrshopth_money(Double odrshopth_money) {
		this.odrshopth_money = odrshopth_money;
	}
	public String getOdrshopth_imgurl() {
		return odrshopth_imgurl;
	}
	public String getOdrshopth_shopcode() {
		return odrshopth_shopcode;
	}
	public void setOdrshopth_shopcode(String odrshopth_shopcode) {
		this.odrshopth_shopcode = odrshopth_shopcode;
	}
	public void setOdrshopth_imgurl(String odrshopth_imgurl) {
		this.odrshopth_imgurl = odrshopth_imgurl;
	}
	public Long getOdrshopth_status() {
		return odrshopth_status;
	}
	public void setOdrshopth_status(Long odrshopth_status) {
		this.odrshopth_status = odrshopth_status;
	}
	public Date getOdrshopth_shopcldate() {
		return odrshopth_shopcldate;
	}
	public void setOdrshopth_shopcldate(Date odrshopth_shopcldate) {
		this.odrshopth_shopcldate = odrshopth_shopcldate;
	}
	public Date getOdrshopth_cldate() {
		return odrshopth_cldate;
	}
	public void setOdrshopth_cldate(Date odrshopth_cldate) {
		this.odrshopth_cldate = odrshopth_cldate;
	}
	public String getOdrshopth_cluser() {
		return odrshopth_cluser;
	}
	public void setOdrshopth_cluser(String odrshopth_cluser) {
		this.odrshopth_cluser = odrshopth_cluser;
	}
	public String getOdrshopth_shipname() {
		return odrshopth_shipname;
	}
	public void setOdrshopth_shipname(String odrshopth_shipname) {
		this.odrshopth_shipname = odrshopth_shipname;
	}
	public String getOdrshopth_shipcode() {
		return odrshopth_shipcode;
	}
	public void setOdrshopth_shipcode(String odrshopth_shipcode) {
		this.odrshopth_shipcode = odrshopth_shipcode;
	}
	public Date getOdrshopth_shipdate() {
		return odrshopth_shipdate;
	}
	public void setOdrshopth_shipdate(Date odrshopth_shipdate) {
		this.odrshopth_shipdate = odrshopth_shipdate;
	}
	public String getOdrshopth_memo() {
		return odrshopth_memo;
	}
	public void setOdrshopth_memo(String odrshopth_memo) {
		this.odrshopth_memo = odrshopth_memo;
	}
	public Date getOdrshopth_createdate() {
		return odrshopth_createdate;
	}
	public void setOdrshopth_createdate(Date odrshopth_createdate) {
		this.odrshopth_createdate = odrshopth_createdate;
	}
	public String getOdrshopth_usrkd() {
		return odrshopth_usrkd;
	}
	public void setOdrshopth_usrkd(String odrshopth_usrkd) {
		this.odrshopth_usrkd = odrshopth_usrkd;
	}
	public String getOdrshopth_usrwl() {
		return odrshopth_usrwl;
	}
	public void setOdrshopth_usrwl(String odrshopth_usrwl) {
		this.odrshopth_usrwl = odrshopth_usrwl;
	}
	
	
	/*create table odrshopth(odrshopth_id int identity(1,1),odrshopth_odrid char(12),odrshopth_subodrid int,odrshopth_thtype int,odrshopth_paytype int,
odrshopth_thwhy varchar(50),odrshopth_memo varchar(800),odrshopth_imrurl varchar(80),odrshopth_status int,
odrshopth_sqdate datetime,odrshopth_shopcldate datetime,odrshopth_cldate datetime,odrshopth_cluser varchar(50),odrshopth_shipcode varchar(50),odrshopth_shipdate datetime
,odrshopth_createdate datetime)
	 * */
	
	
	
}
