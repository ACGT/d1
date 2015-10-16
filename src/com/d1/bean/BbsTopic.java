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
@Table(name="bbsmst",catalog="dba")
public class BbsTopic extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="bbsmst_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	private Long bbsmst_rid;
	private String bbsmst_title;
	private String bbsmst_content;
	private Date bbsmst_time;
	private Date bbsmst_lasttime;
	private String bbsmst_lastname;
	private Long bbsmst_clickcount;
	private Long bbsmst_mbrid;
	private Long bbsmst_applycount;
	private String bbsmst_ip;
	private String bbsmst_aliasname;
	private Long bbsmst_ifdel;
	private Long bbsmst_iflock;
	private Long bbsmst_ifgood;
	private Long bbsmst_iftop;
	private Long bbsmst_ifreplytoread;
	private String bbsmst_replyListId;
	private Long bbsmst_ifalltop;
	private String bbsmst_gdsid;
	private Long bbsmst_ifsrc;
	private Long bbsmst_ifredb;
	private Long bbsmst_getsrc;
	private Long bbsmst_ifhome;
	private String bbsmst_d1apply;
	private Long bbsmst_ifhavegoodapply;
	private Long bbsmst_ifaddGoldDou;
	private String bbsmst_rackcode;
	private String bbsmst_brandname;
	private Long bbsmst_howshow;
	private Long bbsmst_comtxtid;
	private Long bbsmst_ifaddGoldDouAgain;
	private String bbsmst_applyUser;
	private String bbsmst_srcurl;
	private Long bbsmst_ifgds;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getBbsmst_rid() {
		return bbsmst_rid;
	}
	public void setBbsmst_rid(Long bbsmst_rid) {
		this.bbsmst_rid = bbsmst_rid;
	}
	public String getBbsmst_title() {
		return bbsmst_title;
	}
	public void setBbsmst_title(String bbsmst_title) {
		this.bbsmst_title = bbsmst_title;
	}
	public String getBbsmst_content() {
		return bbsmst_content;
	}
	public void setBbsmst_content(String bbsmst_content) {
		this.bbsmst_content = bbsmst_content;
	}
	public Date getBbsmst_time() {
		return bbsmst_time;
	}
	public void setBbsmst_time(Date bbsmst_time) {
		this.bbsmst_time = bbsmst_time;
	}
	public Date getBbsmst_lasttime() {
		return bbsmst_lasttime;
	}
	public void setBbsmst_lasttime(Date bbsmst_lasttime) {
		this.bbsmst_lasttime = bbsmst_lasttime;
	}
	public String getBbsmst_lastname() {
		return bbsmst_lastname;
	}
	public void setBbsmst_lastname(String bbsmst_lastname) {
		this.bbsmst_lastname = bbsmst_lastname;
	}
	public Long getBbsmst_clickcount() {
		return bbsmst_clickcount;
	}
	public void setBbsmst_clickcount(Long bbsmst_clickcount) {
		this.bbsmst_clickcount = bbsmst_clickcount;
	}
	public Long getBbsmst_mbrid() {
		return bbsmst_mbrid;
	}
	public void setBbsmst_mbrid(Long bbsmst_mbrid) {
		this.bbsmst_mbrid = bbsmst_mbrid;
	}
	public Long getBbsmst_applycount() {
		return bbsmst_applycount;
	}
	public void setBbsmst_applycount(Long bbsmst_applycount) {
		this.bbsmst_applycount = bbsmst_applycount;
	}
	public String getBbsmst_ip() {
		return bbsmst_ip;
	}
	public void setBbsmst_ip(String bbsmst_ip) {
		this.bbsmst_ip = bbsmst_ip;
	}
	public String getBbsmst_aliasname() {
		return bbsmst_aliasname;
	}
	public void setBbsmst_aliasname(String bbsmst_aliasname) {
		this.bbsmst_aliasname = bbsmst_aliasname;
	}
	public Long getBbsmst_ifdel() {
		return bbsmst_ifdel;
	}
	public void setBbsmst_ifdel(Long bbsmst_ifdel) {
		this.bbsmst_ifdel = bbsmst_ifdel;
	}
	public Long getBbsmst_iflock() {
		return bbsmst_iflock;
	}
	public void setBbsmst_iflock(Long bbsmst_iflock) {
		this.bbsmst_iflock = bbsmst_iflock;
	}
	public Long getBbsmst_ifgood() {
		return bbsmst_ifgood;
	}
	public void setBbsmst_ifgood(Long bbsmst_ifgood) {
		this.bbsmst_ifgood = bbsmst_ifgood;
	}
	public Long getBbsmst_iftop() {
		return bbsmst_iftop;
	}
	public void setBbsmst_iftop(Long bbsmst_iftop) {
		this.bbsmst_iftop = bbsmst_iftop;
	}
	public Long getBbsmst_ifreplytoread() {
		return bbsmst_ifreplytoread;
	}
	public void setBbsmst_ifreplytoread(Long bbsmst_ifreplytoread) {
		this.bbsmst_ifreplytoread = bbsmst_ifreplytoread;
	}
	public String getBbsmst_replyListId() {
		return bbsmst_replyListId;
	}
	public void setBbsmst_replyListId(String bbsmst_replyListId) {
		this.bbsmst_replyListId = bbsmst_replyListId;
	}
	public Long getBbsmst_ifalltop() {
		return bbsmst_ifalltop;
	}
	public void setBbsmst_ifalltop(Long bbsmst_ifalltop) {
		this.bbsmst_ifalltop = bbsmst_ifalltop;
	}
	public String getBbsmst_gdsid() {
		return bbsmst_gdsid;
	}
	public void setBbsmst_gdsid(String bbsmst_gdsid) {
		this.bbsmst_gdsid = bbsmst_gdsid;
	}
	public Long getBbsmst_ifsrc() {
		return bbsmst_ifsrc;
	}
	public void setBbsmst_ifsrc(Long bbsmst_ifsrc) {
		this.bbsmst_ifsrc = bbsmst_ifsrc;
	}
	public Long getBbsmst_ifredb() {
		return bbsmst_ifredb;
	}
	public void setBbsmst_ifredb(Long bbsmst_ifredb) {
		this.bbsmst_ifredb = bbsmst_ifredb;
	}
	public Long getBbsmst_getsrc() {
		return bbsmst_getsrc;
	}
	public void setBbsmst_getsrc(Long bbsmst_getsrc) {
		this.bbsmst_getsrc = bbsmst_getsrc;
	}
	public Long getBbsmst_ifhome() {
		return bbsmst_ifhome;
	}
	public void setBbsmst_ifhome(Long bbsmst_ifhome) {
		this.bbsmst_ifhome = bbsmst_ifhome;
	}
	public String getBbsmst_d1apply() {
		return bbsmst_d1apply;
	}
	public void setBbsmst_d1apply(String bbsmst_d1apply) {
		this.bbsmst_d1apply = bbsmst_d1apply;
	}
	public Long getBbsmst_ifhavegoodapply() {
		return bbsmst_ifhavegoodapply;
	}
	public void setBbsmst_ifhavegoodapply(Long bbsmst_ifhavegoodapply) {
		this.bbsmst_ifhavegoodapply = bbsmst_ifhavegoodapply;
	}
	public Long getBbsmst_ifaddGoldDou() {
		return bbsmst_ifaddGoldDou;
	}
	public void setBbsmst_ifaddGoldDou(Long bbsmst_ifaddGoldDou) {
		this.bbsmst_ifaddGoldDou = bbsmst_ifaddGoldDou;
	}
	public String getBbsmst_rackcode() {
		return bbsmst_rackcode;
	}
	public void setBbsmst_rackcode(String bbsmst_rackcode) {
		this.bbsmst_rackcode = bbsmst_rackcode;
	}
	public String getBbsmst_brandname() {
		return bbsmst_brandname;
	}
	public void setBbsmst_brandname(String bbsmst_brandname) {
		this.bbsmst_brandname = bbsmst_brandname;
	}
	public Long getBbsmst_howshow() {
		return bbsmst_howshow;
	}
	public void setBbsmst_howshow(Long bbsmst_howshow) {
		this.bbsmst_howshow = bbsmst_howshow;
	}
	public Long getBbsmst_comtxtid() {
		return bbsmst_comtxtid;
	}
	public void setBbsmst_comtxtid(Long bbsmst_comtxtid) {
		this.bbsmst_comtxtid = bbsmst_comtxtid;
	}
	public Long getBbsmst_ifaddGoldDouAgain() {
		return bbsmst_ifaddGoldDouAgain;
	}
	public void setBbsmst_ifaddGoldDouAgain(Long bbsmst_ifaddGoldDouAgain) {
		this.bbsmst_ifaddGoldDouAgain = bbsmst_ifaddGoldDouAgain;
	}
	public String getBbsmst_applyUser() {
		return bbsmst_applyUser;
	}
	public void setBbsmst_applyUser(String bbsmst_applyUser) {
		this.bbsmst_applyUser = bbsmst_applyUser;
	}
	public String getBbsmst_srcurl() {
		return bbsmst_srcurl;
	}
	public void setBbsmst_srcurl(String bbsmst_srcurl) {
		this.bbsmst_srcurl = bbsmst_srcurl;
	}
	public Long getBbsmst_ifgds() {
		return bbsmst_ifgds;
	}
	public void setBbsmst_ifgds(Long bbsmst_ifgds) {
		this.bbsmst_ifgds = bbsmst_ifgds;
	}
}
