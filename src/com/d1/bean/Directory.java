package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品分类表，前台只读
 * @author kk
 *
 */
@Entity
@Table(name="rckmst")
public class Directory extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="rakmst_rackcode") 
	private String id;//done
	
	private Long rakmst_typeid;
	private String rakmst_rackname;
	private String rakmst_rackname1;
	private String rakmst_parentrackcode;
	private String rakmst_rackename;
	private Long rakmst_childflag;
	private String rakmst_stdid;
	private String rakmst_explain;
	private Date rakmst_dtcrt;
	private Date rakmst_dtupd;
	private String rakmst_handworkur;
	private Long rakmst_showflag;
	private Long rakmst_seq;
	private String rakmst_oldcode;
	private Long rakmst_gdscount;
	private Long rakmst_viewtype;
	private String rakmst_tktdesc;
	private String rakmst_promotionword;
	private String rakmst_titledesc;
	private String rakmst_linkgds;
	private String rakmst_linkrck;
	private Long rakmst_alllink;
	private String rakmst_speciallink;
	private String rakmst_defgdsinfo;
	private Long rakmst_sex;
	private String rakmst_gdsprompt;
	private Long rakmst_rootflg;
	private Long rakmst_airflg;
	private Long rakmst_sounthseq;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getRakmst_typeid() {
		return rakmst_typeid;
	}
	public void setRakmst_typeid(Long rakmst_typeid) {
		this.rakmst_typeid = rakmst_typeid;
	}
	public String getRakmst_rackname() {
		return rakmst_rackname;
	}
	public void setRakmst_rackname(String rakmst_rackname) {
		this.rakmst_rackname = rakmst_rackname;
	}
	public String getRakmst_rackname1() {
		return rakmst_rackname1;
	}
	public void setRakmst_rackname1(String rakmst_rackname1) {
		this.rakmst_rackname1 = rakmst_rackname1;
	}
	public String getRakmst_parentrackcode() {
		return rakmst_parentrackcode;
	}
	public void setRakmst_parentrackcode(String rakmst_parentrackcode) {
		this.rakmst_parentrackcode = rakmst_parentrackcode;
	}
	public String getRakmst_rackename() {
		return rakmst_rackename;
	}
	public void setRakmst_rackename(String rakmst_rackename) {
		this.rakmst_rackename = rakmst_rackename;
	}
	public Long getRakmst_childflag() {
		return rakmst_childflag;
	}
	public void setRakmst_childflag(Long rakmst_childflag) {
		this.rakmst_childflag = rakmst_childflag;
	}
	public String getRakmst_stdid() {
		return rakmst_stdid;
	}
	public void setRakmst_stdid(String rakmst_stdid) {
		this.rakmst_stdid = rakmst_stdid;
	}
	public String getRakmst_explain() {
		return rakmst_explain;
	}
	public void setRakmst_explain(String rakmst_explain) {
		this.rakmst_explain = rakmst_explain;
	}
	public Date getRakmst_dtcrt() {
		return rakmst_dtcrt;
	}
	public void setRakmst_dtcrt(Date rakmst_dtcrt) {
		this.rakmst_dtcrt = rakmst_dtcrt;
	}
	public Date getRakmst_dtupd() {
		return rakmst_dtupd;
	}
	public void setRakmst_dtupd(Date rakmst_dtupd) {
		this.rakmst_dtupd = rakmst_dtupd;
	}
	public String getRakmst_handworkur() {
		return rakmst_handworkur;
	}
	public void setRakmst_handworkur(String rakmst_handworkur) {
		this.rakmst_handworkur = rakmst_handworkur;
	}
	public Long getRakmst_showflag() {
		return rakmst_showflag;
	}
	public void setRakmst_showflag(Long rakmst_showflag) {
		this.rakmst_showflag = rakmst_showflag;
	}
	public Long getRakmst_seq() {
		return rakmst_seq;
	}
	public void setRakmst_seq(Long rakmst_seq) {
		this.rakmst_seq = rakmst_seq;
	}
	public String getRakmst_oldcode() {
		return rakmst_oldcode;
	}
	public void setRakmst_oldcode(String rakmst_oldcode) {
		this.rakmst_oldcode = rakmst_oldcode;
	}
	public Long getRakmst_gdscount() {
		return rakmst_gdscount;
	}
	public void setRakmst_gdscount(Long rakmst_gdscount) {
		this.rakmst_gdscount = rakmst_gdscount;
	}
	public Long getRakmst_viewtype() {
		return rakmst_viewtype;
	}
	public void setRakmst_viewtype(Long rakmst_viewtype) {
		this.rakmst_viewtype = rakmst_viewtype;
	}
	public String getRakmst_tktdesc() {
		return rakmst_tktdesc;
	}
	public void setRakmst_tktdesc(String rakmst_tktdesc) {
		this.rakmst_tktdesc = rakmst_tktdesc;
	}
	public String getRakmst_promotionword() {
		return rakmst_promotionword;
	}
	public void setRakmst_promotionword(String rakmst_promotionword) {
		this.rakmst_promotionword = rakmst_promotionword;
	}
	public String getRakmst_titledesc() {
		return rakmst_titledesc;
	}
	public void setRakmst_titledesc(String rakmst_titledesc) {
		this.rakmst_titledesc = rakmst_titledesc;
	}
	public String getRakmst_linkgds() {
		return rakmst_linkgds;
	}
	public void setRakmst_linkgds(String rakmst_linkgds) {
		this.rakmst_linkgds = rakmst_linkgds;
	}
	public String getRakmst_linkrck() {
		return rakmst_linkrck;
	}
	public void setRakmst_linkrck(String rakmst_linkrck) {
		this.rakmst_linkrck = rakmst_linkrck;
	}
	public Long getRakmst_alllink() {
		return rakmst_alllink;
	}
	public void setRakmst_alllink(Long rakmst_alllink) {
		this.rakmst_alllink = rakmst_alllink;
	}
	public String getRakmst_speciallink() {
		return rakmst_speciallink;
	}
	public void setRakmst_speciallink(String rakmst_speciallink) {
		this.rakmst_speciallink = rakmst_speciallink;
	}
	public String getRakmst_defgdsinfo() {
		return rakmst_defgdsinfo;
	}
	public void setRakmst_defgdsinfo(String rakmst_defgdsinfo) {
		this.rakmst_defgdsinfo = rakmst_defgdsinfo;
	}
	public Long getRakmst_sex() {
		return rakmst_sex;
	}
	public void setRakmst_sex(Long rakmst_sex) {
		this.rakmst_sex = rakmst_sex;
	}
	public String getRakmst_gdsprompt() {
		return rakmst_gdsprompt;
	}
	public void setRakmst_gdsprompt(String rakmst_gdsprompt) {
		this.rakmst_gdsprompt = rakmst_gdsprompt;
	}
	public Long getRakmst_rootflg() {
		return rakmst_rootflg;
	}
	public void setRakmst_rootflg(Long rakmst_rootflg) {
		this.rakmst_rootflg = rakmst_rootflg;
	}
	public Long getRakmst_airflg() {
		return rakmst_airflg;
	}
	public void setRakmst_airflg(Long rakmst_airflg) {
		this.rakmst_airflg = rakmst_airflg;
	}
	public Long getRakmst_sounthseq() {
		return rakmst_sounthseq;
	}
	public void setRakmst_sounthseq(Long rakmst_sounthseq) {
		this.rakmst_sounthseq = rakmst_sounthseq;
	}
	
}
