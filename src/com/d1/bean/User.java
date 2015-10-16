package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 用户表
 * @author kk
 */
@Entity
@Table(name="mbrmst")
public class User extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="mbrmst_id")
	private String id;//done
	
	private String mbrmst_uid;
	private String mbrmst_pwd;
	/**
	 * 新版Java用到的密码，32位md5加密
	 */
	private String mbrmst_passwd;
	private String mbrmst_question="";
	private String mbrmst_answer="";
	private Date mbrmst_createdate;
	private Date mbrmst_modidate;
	private Date mbrmst_lastdate;
	private String mbrmst_name;
	private Long mbrmst_visittimes=new Long(1);
	private Long mbrmst_sex=new Long(0);
	private String mbrmst_email;
	private String mbrmst_hphone="";
	private String mbrmst_ophone="";
	private String mbrmst_bp="";
	private String mbrmst_mphone="";
	private String mbrmst_usephone="";
	private String mbrmst_haddr="";
	private String mbrmst_oaddr="";
	private Long mbrmst_countryid=new Long(1);
	private Long mbrmst_provinceid=new Long(0);
	private Long mbrmst_cityid=new Long(0);
	private String mbrmst_postcode="";
	private Date mbrmst_birthday;
	private Long mbrmst_edulevel;
	private Long mbrmst_occupation;
	private String mbrmst_hobby;
	private Long mbrmst_Salary;
	private String mbrmst_position;
	private Long mbrmst_certifiertype=new Long(0);
	private String mbrmst_certifierno="";
	private Long mbrmst_specialtype=new Long(0);
	private Long mbrmst_magazineflag=new Long(0);
	private Long mbrmst_myd1type=new Long(0);
	private Long mbrmst_myd1count=new Long(10);
	private String mbrmst_myd1codes="";
	private Date mbrmst_vipbegindate;
	private Date mbrmst_vipenddate;
	private String mbrmst_srcurl="";
	private Long mbrmst_rcmcount=new Long(0);
	private String mbrmst_peoplercm="";
	private Long mbrmst_downflag=new Long(0);
	private String mbrmst_buyquestionid="";
	private Long mbrmst_buyerrcount=new Long(0);
	private Long mbrmst_validflag=new Long(0);
	private Date mbrmst_finishdate;
	private String mbrmst_temp;
	private String mbrmst_ip="";
	private Long mbrmst_bookletflag=new Long(0);
	private Date mbrmst_lastpltime;
	private Long mbrmst_bktstep=new Long(0);
	private Long mbrmst_ifgetcatalog;
	private String mbrmst_aliasname="";
	private Long mbrmst_src=new Long(0);
	private Long mbrmst_sendcount=new Long(0);
	private Long mbrmst_replycount=new Long(0);
	private String mbrmst_userface;
	private Long mbrmst_width;
	private Long mbrmst_height;
	private String mbrmst_sign;
	private Long mbrmst_kicktype;
	private String mbrmst_kicklog;
	private Long mbrmst_bbsAlllogintimes=new Long(0);
	private Long mbrmst_bbsDaylogintimes=new Long(0);
	private Date mbrmst_lastsendtime;
	private Long mbrmst_allsrc=new Long(0);
	private Long mbrmst_jcsrc=new Long(0);
	private Long mbrmst_goldsrc=new Long(0);
	private Long mbrmst_goldallsrc=new Long(0);
	private Long mbrmst_birthflag=new Long(0);
	private String mbrmst_note;
	private String mbrmst_subad;
	private Long mbrmst_tktmail=new Long(0);
	
	/**
	 * 记录用户唯一标示的字符串（随机数、加密），用于记录在客户端浏览器里，实现自动登录
	 */
	private String mbrmst_cookie;
	private Long mbrmst_phoneflag;
	private Long mbrmst_mailflag;
	
	public String getMbrmst_passwd() {
		return mbrmst_passwd;
	}
	public void setMbrmst_passwd(String mbrmst_passwd) {
		this.mbrmst_passwd = mbrmst_passwd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbrmst_uid() {
		return mbrmst_uid;
	}
	public void setMbrmst_uid(String mbrmst_uid) {
		this.mbrmst_uid = mbrmst_uid;
	}
	public String getMbrmst_pwd() {
		return mbrmst_pwd;
	}
	public void setMbrmst_pwd(String mbrmst_pwd) {
		this.mbrmst_pwd = mbrmst_pwd;
	}
	public String getMbrmst_question() {
		return mbrmst_question;
	}
	public void setMbrmst_question(String mbrmst_question) {
		this.mbrmst_question = mbrmst_question;
	}
	public String getMbrmst_answer() {
		return mbrmst_answer;
	}
	public void setMbrmst_answer(String mbrmst_answer) {
		this.mbrmst_answer = mbrmst_answer;
	}
	public Date getMbrmst_createdate() {
		return mbrmst_createdate;
	}
	public void setMbrmst_createdate(Date mbrmst_createdate) {
		this.mbrmst_createdate = mbrmst_createdate;
	}
	public Date getMbrmst_modidate() {
		return mbrmst_modidate;
	}
	public void setMbrmst_modidate(Date mbrmst_modidate) {
		this.mbrmst_modidate = mbrmst_modidate;
	}
	public Date getMbrmst_lastdate() {
		return mbrmst_lastdate;
	}
	public void setMbrmst_lastdate(Date mbrmst_lastdate) {
		this.mbrmst_lastdate = mbrmst_lastdate;
	}
	public String getMbrmst_name() {
		return mbrmst_name;
	}
	public void setMbrmst_name(String mbrmst_name) {
		this.mbrmst_name = mbrmst_name;
	}
	public Long getMbrmst_visittimes() {
		return mbrmst_visittimes;
	}
	public void setMbrmst_visittimes(Long mbrmst_visittimes) {
		this.mbrmst_visittimes = mbrmst_visittimes;
	}
	public Long getMbrmst_sex() {
		return mbrmst_sex;
	}
	public void setMbrmst_sex(Long mbrmst_sex) {
		this.mbrmst_sex = mbrmst_sex;
	}
	public String getMbrmst_email() {
		return mbrmst_email;
	}
	public void setMbrmst_email(String mbrmst_email) {
		this.mbrmst_email = mbrmst_email;
	}
	public String getMbrmst_hphone() {
		return mbrmst_hphone;
	}
	public void setMbrmst_hphone(String mbrmst_hphone) {
		this.mbrmst_hphone = mbrmst_hphone;
	}
	public String getMbrmst_ophone() {
		return mbrmst_ophone;
	}
	public void setMbrmst_ophone(String mbrmst_ophone) {
		this.mbrmst_ophone = mbrmst_ophone;
	}
	public String getMbrmst_bp() {
		return mbrmst_bp;
	}
	public void setMbrmst_bp(String mbrmst_bp) {
		this.mbrmst_bp = mbrmst_bp;
	}
	public String getMbrmst_mphone() {
		return mbrmst_mphone;
	}
	public void setMbrmst_mphone(String mbrmst_mphone) {
		this.mbrmst_mphone = mbrmst_mphone;
	}
	public String getMbrmst_usephone() {
		return mbrmst_usephone;
	}
	public void setMbrmst_usephone(String mbrmst_usephone) {
		this.mbrmst_usephone = mbrmst_usephone;
	}
	public String getMbrmst_haddr() {
		return mbrmst_haddr;
	}
	public void setMbrmst_haddr(String mbrmst_haddr) {
		this.mbrmst_haddr = mbrmst_haddr;
	}
	public String getMbrmst_oaddr() {
		return mbrmst_oaddr;
	}
	public void setMbrmst_oaddr(String mbrmst_oaddr) {
		this.mbrmst_oaddr = mbrmst_oaddr;
	}
	public Long getMbrmst_countryid() {
		return mbrmst_countryid;
	}
	public void setMbrmst_countryid(Long mbrmst_countryid) {
		this.mbrmst_countryid = mbrmst_countryid;
	}
	public Long getMbrmst_provinceid() {
		return mbrmst_provinceid;
	}
	public void setMbrmst_provinceid(Long mbrmst_provinceid) {
		this.mbrmst_provinceid = mbrmst_provinceid;
	}
	public Long getMbrmst_cityid() {
		return mbrmst_cityid;
	}
	public void setMbrmst_cityid(Long mbrmst_cityid) {
		this.mbrmst_cityid = mbrmst_cityid;
	}
	public String getMbrmst_postcode() {
		return mbrmst_postcode;
	}
	public void setMbrmst_postcode(String mbrmst_postcode) {
		this.mbrmst_postcode = mbrmst_postcode;
	}
	public Date getMbrmst_birthday() {
		return mbrmst_birthday;
	}
	public void setMbrmst_birthday(Date mbrmst_birthday) {
		this.mbrmst_birthday = mbrmst_birthday;
	}
	public Long getMbrmst_edulevel() {
		return mbrmst_edulevel;
	}
	public void setMbrmst_edulevel(Long mbrmst_edulevel) {
		this.mbrmst_edulevel = mbrmst_edulevel;
	}
	public Long getMbrmst_occupation() {
		return mbrmst_occupation;
	}
	public void setMbrmst_occupation(Long mbrmst_occupation) {
		this.mbrmst_occupation = mbrmst_occupation;
	}
	public String getMbrmst_hobby() {
		return mbrmst_hobby;
	}
	public void setMbrmst_hobby(String mbrmst_hobby) {
		this.mbrmst_hobby = mbrmst_hobby;
	}
	public Long getMbrmst_Salary() {
		return mbrmst_Salary;
	}
	public void setMbrmst_Salary(Long mbrmst_Salary) {
		this.mbrmst_Salary = mbrmst_Salary;
	}
	public String getMbrmst_position() {
		return mbrmst_position;
	}
	public void setMbrmst_position(String mbrmst_position) {
		this.mbrmst_position = mbrmst_position;
	}
	public Long getMbrmst_certifiertype() {
		return mbrmst_certifiertype;
	}
	public void setMbrmst_certifiertype(Long mbrmst_certifiertype) {
		this.mbrmst_certifiertype = mbrmst_certifiertype;
	}
	public String getMbrmst_certifierno() {
		return mbrmst_certifierno;
	}
	public void setMbrmst_certifierno(String mbrmst_certifierno) {
		this.mbrmst_certifierno = mbrmst_certifierno;
	}
	public Long getMbrmst_specialtype() {
		return mbrmst_specialtype;
	}
	public void setMbrmst_specialtype(Long mbrmst_specialtype) {
		this.mbrmst_specialtype = mbrmst_specialtype;
	}
	public Long getMbrmst_magazineflag() {
		return mbrmst_magazineflag;
	}
	public void setMbrmst_magazineflag(Long mbrmst_magazineflag) {
		this.mbrmst_magazineflag = mbrmst_magazineflag;
	}
	public Long getMbrmst_myd1type() {
		return mbrmst_myd1type;
	}
	public void setMbrmst_myd1type(Long mbrmst_myd1type) {
		this.mbrmst_myd1type = mbrmst_myd1type;
	}
	public Long getMbrmst_myd1count() {
		return mbrmst_myd1count;
	}
	public void setMbrmst_myd1count(Long mbrmst_myd1count) {
		this.mbrmst_myd1count = mbrmst_myd1count;
	}
	public String getMbrmst_myd1codes() {
		return mbrmst_myd1codes;
	}
	public void setMbrmst_myd1codes(String mbrmst_myd1codes) {
		this.mbrmst_myd1codes = mbrmst_myd1codes;
	}
	public Date getMbrmst_vipbegindate() {
		return mbrmst_vipbegindate;
	}
	public void setMbrmst_vipbegindate(Date mbrmst_vipbegindate) {
		this.mbrmst_vipbegindate = mbrmst_vipbegindate;
	}
	public Date getMbrmst_vipenddate() {
		return mbrmst_vipenddate;
	}
	public void setMbrmst_vipenddate(Date mbrmst_vipenddate) {
		this.mbrmst_vipenddate = mbrmst_vipenddate;
	}
	public String getMbrmst_srcurl() {
		return mbrmst_srcurl;
	}
	public void setMbrmst_srcurl(String mbrmst_srcurl) {
		this.mbrmst_srcurl = mbrmst_srcurl;
	}
	public Long getMbrmst_rcmcount() {
		return mbrmst_rcmcount;
	}
	public void setMbrmst_rcmcount(Long mbrmst_rcmcount) {
		this.mbrmst_rcmcount = mbrmst_rcmcount;
	}
	public String getMbrmst_peoplercm() {
		return mbrmst_peoplercm;
	}
	public void setMbrmst_peoplercm(String mbrmst_peoplercm) {
		this.mbrmst_peoplercm = mbrmst_peoplercm;
	}
	public Long getMbrmst_downflag() {
		return mbrmst_downflag;
	}
	public void setMbrmst_downflag(Long mbrmst_downflag) {
		this.mbrmst_downflag = mbrmst_downflag;
	}
	public String getMbrmst_buyquestionid() {
		return mbrmst_buyquestionid;
	}
	public void setMbrmst_buyquestionid(String mbrmst_buyquestionid) {
		this.mbrmst_buyquestionid = mbrmst_buyquestionid;
	}
	public Long getMbrmst_buyerrcount() {
		return mbrmst_buyerrcount;
	}
	public void setMbrmst_buyerrcount(Long mbrmst_buyerrcount) {
		this.mbrmst_buyerrcount = mbrmst_buyerrcount;
	}
	public Long getMbrmst_validflag() {
		return mbrmst_validflag;
	}
	public void setMbrmst_validflag(Long mbrmst_validflag) {
		this.mbrmst_validflag = mbrmst_validflag;
	}
	public Date getMbrmst_finishdate() {
		return mbrmst_finishdate;
	}
	public void setMbrmst_finishdate(Date mbrmst_finishdate) {
		this.mbrmst_finishdate = mbrmst_finishdate;
	}
	public String getMbrmst_temp() {
		return mbrmst_temp;
	}
	public void setMbrmst_temp(String mbrmst_temp) {
		this.mbrmst_temp = mbrmst_temp;
	}
	public String getMbrmst_ip() {
		return mbrmst_ip;
	}
	public void setMbrmst_ip(String mbrmst_ip) {
		this.mbrmst_ip = mbrmst_ip;
	}
	public Long getMbrmst_bookletflag() {
		return mbrmst_bookletflag;
	}
	public void setMbrmst_bookletflag(Long mbrmst_bookletflag) {
		this.mbrmst_bookletflag = mbrmst_bookletflag;
	}
	public Date getMbrmst_lastpltime() {
		return mbrmst_lastpltime;
	}
	public void setMbrmst_lastpltime(Date mbrmst_lastpltime) {
		this.mbrmst_lastpltime = mbrmst_lastpltime;
	}
	public Long getMbrmst_bktstep() {
		return mbrmst_bktstep;
	}
	public void setMbrmst_bktstep(Long mbrmst_bktstep) {
		this.mbrmst_bktstep = mbrmst_bktstep;
	}
	public Long getMbrmst_ifgetcatalog() {
		return mbrmst_ifgetcatalog;
	}
	public void setMbrmst_ifgetcatalog(Long mbrmst_ifgetcatalog) {
		this.mbrmst_ifgetcatalog = mbrmst_ifgetcatalog;
	}
	public String getMbrmst_aliasname() {
		return mbrmst_aliasname;
	}
	public void setMbrmst_aliasname(String mbrmst_aliasname) {
		this.mbrmst_aliasname = mbrmst_aliasname;
	}
	public Long getMbrmst_src() {
		return mbrmst_src;
	}
	public void setMbrmst_src(Long mbrmst_src) {
		this.mbrmst_src = mbrmst_src;
	}
	public Long getMbrmst_sendcount() {
		return mbrmst_sendcount;
	}
	public void setMbrmst_sendcount(Long mbrmst_sendcount) {
		this.mbrmst_sendcount = mbrmst_sendcount;
	}
	public Long getMbrmst_replycount() {
		return mbrmst_replycount;
	}
	public void setMbrmst_replycount(Long mbrmst_replycount) {
		this.mbrmst_replycount = mbrmst_replycount;
	}
	public String getMbrmst_userface() {
		return mbrmst_userface;
	}
	public void setMbrmst_userface(String mbrmst_userface) {
		this.mbrmst_userface = mbrmst_userface;
	}
	public Long getMbrmst_width() {
		return mbrmst_width;
	}
	public void setMbrmst_width(Long mbrmst_width) {
		this.mbrmst_width = mbrmst_width;
	}
	public Long getMbrmst_height() {
		return mbrmst_height;
	}
	public void setMbrmst_height(Long mbrmst_height) {
		this.mbrmst_height = mbrmst_height;
	}
	public String getMbrmst_sign() {
		return mbrmst_sign;
	}
	public void setMbrmst_sign(String mbrmst_sign) {
		this.mbrmst_sign = mbrmst_sign;
	}
	public Long getMbrmst_kicktype() {
		return mbrmst_kicktype;
	}
	public void setMbrmst_kicktype(Long mbrmst_kicktype) {
		this.mbrmst_kicktype = mbrmst_kicktype;
	}
	public String getMbrmst_kicklog() {
		return mbrmst_kicklog;
	}
	public void setMbrmst_kicklog(String mbrmst_kicklog) {
		this.mbrmst_kicklog = mbrmst_kicklog;
	}
	public Long getMbrmst_bbsAlllogintimes() {
		return mbrmst_bbsAlllogintimes;
	}
	public void setMbrmst_bbsAlllogintimes(Long mbrmst_bbsAlllogintimes) {
		this.mbrmst_bbsAlllogintimes = mbrmst_bbsAlllogintimes;
	}
	public Long getMbrmst_bbsDaylogintimes() {
		return mbrmst_bbsDaylogintimes;
	}
	public void setMbrmst_bbsDaylogintimes(Long mbrmst_bbsDaylogintimes) {
		this.mbrmst_bbsDaylogintimes = mbrmst_bbsDaylogintimes;
	}
	public Date getMbrmst_lastsendtime() {
		return mbrmst_lastsendtime;
	}
	public void setMbrmst_lastsendtime(Date mbrmst_lastsendtime) {
		this.mbrmst_lastsendtime = mbrmst_lastsendtime;
	}
	public Long getMbrmst_allsrc() {
		return mbrmst_allsrc;
	}
	public void setMbrmst_allsrc(Long mbrmst_allsrc) {
		this.mbrmst_allsrc = mbrmst_allsrc;
	}
	public Long getMbrmst_jcsrc() {
		return mbrmst_jcsrc;
	}
	public void setMbrmst_jcsrc(Long mbrmst_jcsrc) {
		this.mbrmst_jcsrc = mbrmst_jcsrc;
	}
	public Long getMbrmst_goldsrc() {
		return mbrmst_goldsrc;
	}
	public void setMbrmst_goldsrc(Long mbrmst_goldsrc) {
		this.mbrmst_goldsrc = mbrmst_goldsrc;
	}
	public Long getMbrmst_goldallsrc() {
		return mbrmst_goldallsrc;
	}
	public void setMbrmst_goldallsrc(Long mbrmst_goldallsrc) {
		this.mbrmst_goldallsrc = mbrmst_goldallsrc;
	}
	public Long getMbrmst_birthflag() {
		return mbrmst_birthflag;
	}
	public void setMbrmst_birthflag(Long mbrmst_birthflag) {
		this.mbrmst_birthflag = mbrmst_birthflag;
	}
	public String getMbrmst_note() {
		return mbrmst_note;
	}
	public void setMbrmst_note(String mbrmst_note) {
		this.mbrmst_note = mbrmst_note;
	}
	public String getMbrmst_subad() {
		return mbrmst_subad;
	}
	public void setMbrmst_subad(String mbrmst_subad) {
		this.mbrmst_subad = mbrmst_subad;
	}
	public Long getMbrmst_tktmail() {
		return mbrmst_tktmail;
	}
	public void setMbrmst_tktmail(Long mbrmst_tktmail) {
		this.mbrmst_tktmail = mbrmst_tktmail;
	}
	public String getMbrmst_cookie() {
		return mbrmst_cookie;
	}
	public void setMbrmst_cookie(String mbrmst_cookie) {
		this.mbrmst_cookie = mbrmst_cookie;
	}
	public Long getMbrmst_phoneflag() {
		return mbrmst_phoneflag;
	}
	public void setMbrmst_phoneflag(Long mbrmst_phoneflag) {
		this.mbrmst_phoneflag = mbrmst_phoneflag;
	}
	public Long getMbrmst_mailflag() {
		return mbrmst_mailflag;
	}
	public void setMbrmst_mailflag(Long mbrmst_mailflag) {
		this.mbrmst_mailflag = mbrmst_mailflag;
	}

}
