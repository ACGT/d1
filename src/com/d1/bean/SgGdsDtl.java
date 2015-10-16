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
@Table(name="sggdsdtl")
public class SgGdsDtl extends BaseEntity implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="sggdsdtl_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String sggdsdtl_gdsid;    //…Ã∆∑ID
	private String sggdsdtl_gdsname; //…Ã∆∑√˚≥∆
	private Long   sggdsdtl_cls;      //…¡π∫∑÷¿‡
	private String sggdsdtl_imgurl;   //…¡π∫Õº∆¨
	private Long   sggdsdtl_mainflag=new Long(0);  // «∑Ò÷˜Õ∆ºˆ
	private Long   sggdsdtl_xsnum=new Long(100);    //…¡π∫«∞Ã®œ‘ æπ∫¬Ùœµ ˝
	private Long   sggdsdtl_maxnum=new Long(100);   //…¡π∫◊Ó¥Û ˝¡ø
	private Long   sggdsdtl_realbuynum=new Long(0);  //…¡π∫π∫¬Ú ˝¡ø
	private Long   sggdsdtl_status=new Long(0);      //…œº‹◊¥Ã¨
	private Long sggdsdtl_sort=new Long(0);           //…¡π∫≈≈–Ú
	private Date sggdsdtl_createdate=new Date();     //¥¥Ω® ±º‰
	private Long sggdsdtl_del=new Long(0);           //…¡π∫≈≈–Ú
	private String sggdsdtl_adduser;   //…¡π∫Õº∆¨
	private String sggdsdtl_modiuser;   //…¡π∫Õº∆¨
	private String sggdsdtl_memo;
	private String sggdsdtl_rackcode;

	private Long   sggdsdtl_vallnum=new Long(0);    
	private Long   sggdsdtl_vbuynum=new Long(0);   
	private Long   sggdsdtl_vusrnum=new Long(0);       
	private Long sggdsdtl_mailflag=new Long(0);          
	private Long sggdsdtl_mailsort=new Long(0);           //…¡π∫≈≈–Ú
	private Date sggdsdtl_modidate=new Date();   //…¡π∫Õº∆¨
	private Long sggdsdtl_limitgroup=new Long(0);
	private Long sggdsdtl_realnum=new Long(0);
	private Date sggdsdtl_sdate;
	private Date sggdsdtl_edate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSggdsdtl_gdsid() {
		return sggdsdtl_gdsid;
	}
	public void setSggdsdtl_gdsid(String sggdsdtl_gdsid) {
		this.sggdsdtl_gdsid = sggdsdtl_gdsid;
	}
	public String getSggdsdtl_gdsname() {
		return sggdsdtl_gdsname;
	}
	public void setSggdsdtl_gdsname(String sggdsdtl_gdsname) {
		this.sggdsdtl_gdsname = sggdsdtl_gdsname;
	}
	public Long getSggdsdtl_cls() {
		return sggdsdtl_cls;
	}
	public void setSggdsdtl_cls(Long sggdsdtl_cls) {
		this.sggdsdtl_cls = sggdsdtl_cls;
	}
	public String getSggdsdtl_imgurl() {
		return sggdsdtl_imgurl;
	}
	public void setSggdsdtl_imgurl(String sggdsdtl_imgurl) {
		this.sggdsdtl_imgurl = sggdsdtl_imgurl;
	}
	public Long getSggdsdtl_xsnum() {
		return sggdsdtl_xsnum;
	}
	public void setSggdsdtl_xsnum(Long sggdsdtl_xsnum) {
		this.sggdsdtl_xsnum = sggdsdtl_xsnum;
	}
	public Long getSggdsdtl_maxnum() {
		return sggdsdtl_maxnum;
	}
	public void setSggdsdtl_maxnum(Long sggdsdtl_maxnum) {
		this.sggdsdtl_maxnum = sggdsdtl_maxnum;
	}
	public Long getSggdsdtl_realbuynum() {
		return sggdsdtl_realbuynum;
	}
	public void setSggdsdtl_realbuynum(Long sggdsdtl_realbuynum) {
		this.sggdsdtl_realbuynum = sggdsdtl_realbuynum;
	}
	public Long getSggdsdtl_status() {
		return sggdsdtl_status;
	}
	public void setSggdsdtl_status(Long sggdsdtl_status) {
		this.sggdsdtl_status = sggdsdtl_status;
	}
	public Long getSggdsdtl_sort() {
		return sggdsdtl_sort;
	}
	public void setSggdsdtl_sort(Long sggdsdtl_sort) {
		this.sggdsdtl_sort = sggdsdtl_sort;
	}
	public Date getSggdsdtl_createdate() {
		return sggdsdtl_createdate;
	}
	public void setSggdsdtl_createdate(Date sggdsdtl_createdate) {
		this.sggdsdtl_createdate = sggdsdtl_createdate;
	}
	public Long getSggdsdtl_mainflag() {
		return sggdsdtl_mainflag;
	}
	public void setSggdsdtl_mainflag(Long sggdsdtl_mainflag) {
		this.sggdsdtl_mainflag = sggdsdtl_mainflag;
	}
	public Long getSggdsdtl_del() {
		return sggdsdtl_del;
	}
	public void setSggdsdtl_del(Long sggdsdtl_del) {
		this.sggdsdtl_del = sggdsdtl_del;
	}
	public String getSggdsdtl_adduser() {
		return sggdsdtl_adduser;
	}
	public void setSggdsdtl_adduser(String sggdsdtl_adduser) {
		this.sggdsdtl_adduser = sggdsdtl_adduser;
	}
	public String getSggdsdtl_modiuser() {
		return sggdsdtl_modiuser;
	}
	public void setSggdsdtl_modiuser(String sggdsdtl_modiuser) {
		this.sggdsdtl_modiuser = sggdsdtl_modiuser;
	}
	public String getSggdsdtl_memo() {
		return sggdsdtl_memo;
	}
	public void setSggdsdtl_memo(String sggdsdtl_memo) {
		this.sggdsdtl_memo = sggdsdtl_memo;
	}
	public String getSggdsdtl_rackcode() {
		return sggdsdtl_rackcode;
	}
	public void setSggdsdtl_rackcode(String sggdsdtl_rackcode) {
		this.sggdsdtl_rackcode = sggdsdtl_rackcode;
	}
	public Long getSggdsdtl_vallnum() {
		return sggdsdtl_vallnum;
	}
	public void setSggdsdtl_vallnum(Long sggdsdtl_vallnum) {
		this.sggdsdtl_vallnum = sggdsdtl_vallnum;
	}
	public Long getSggdsdtl_vbuynum() {
		return sggdsdtl_vbuynum;
	}
	public void setSggdsdtl_vbuynum(Long sggdsdtl_vbuynum) {
		this.sggdsdtl_vbuynum = sggdsdtl_vbuynum;
	}
	public Long getSggdsdtl_vusrnum() {
		return sggdsdtl_vusrnum;
	}
	public void setSggdsdtl_vusrnum(Long sggdsdtl_vusrnum) {
		this.sggdsdtl_vusrnum = sggdsdtl_vusrnum;
	}
	public Long getSggdsdtl_mailflag() {
		return sggdsdtl_mailflag;
	}
	public void setSggdsdtl_mailflag(Long sggdsdtl_mailflag) {
		this.sggdsdtl_mailflag = sggdsdtl_mailflag;
	}
	public Long getSggdsdtl_mailsort() {
		return sggdsdtl_mailsort;
	}
	public void setSggdsdtl_mailsort(Long sggdsdtl_mailsort) {
		this.sggdsdtl_mailsort = sggdsdtl_mailsort;
	}
	public Date getSggdsdtl_modidate() {
		return sggdsdtl_modidate;
	}
	public void setSggdsdtl_modidate(Date sggdsdtl_modidate) {
		this.sggdsdtl_modidate = sggdsdtl_modidate;
	}
	public Long getSggdsdtl_limitgroup() {
		return sggdsdtl_limitgroup;
	}
	public void setSggdsdtl_limitgroup(Long sggdsdtl_limitgroup) {
		this.sggdsdtl_limitgroup = sggdsdtl_limitgroup;
	}
	public Long getSggdsdtl_realnum() {
		return sggdsdtl_realnum;
	}
	public void setSggdsdtl_realnum(Long sggdsdtl_realnum) {
		this.sggdsdtl_realnum = sggdsdtl_realnum;
	}
	public Date getSggdsdtl_sdate() {
		return sggdsdtl_sdate;
	}
	public void setSggdsdtl_sdate(Date sggdsdtl_sdate) {
		this.sggdsdtl_sdate = sggdsdtl_sdate;
	}
	public Date getSggdsdtl_edate() {
		return sggdsdtl_edate;
	}
	public void setSggdsdtl_edate(Date sggdsdtl_edate) {
		this.sggdsdtl_edate = sggdsdtl_edate;
	}

	/*
	 * create table sggdsdtl (sggdsdtl_id int PRIMARY KEY identity(1,1)  ,sggdsdtl_gdsid char(8),sggdsdtl_gdsname varchar(300),sggdsdtl_cls smallint,
sggdsdtl_imgurl varchar(500),sggdsdtl_xsnum int,sggdsdtl_num int,sggdsdtl_maxnum int,sggdsdtl_realbuynum int,sggdsdtl_status smallint,
sggdsdtl_sort int,sggdsdtl_createdate datetime default(getdate()))
	 * */
}
