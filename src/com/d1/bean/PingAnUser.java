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
 * 平安用户表
 * @author kk
 *
 */
@Entity
@Table(name="mbrmstpingan")
public class PingAnUser extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbrmstpingan_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private String mbrmstpingan_memberid ;
	private String mbrmstpingan_mbrmstuid;
	private Long mbrmstpingan_mbrid;
	private String mbrmstpingan_empflg;
	private String mbrmstpingan_username;
	private Long mbrmstpingan_ifsendmail;
	private Date mbrmstPingAn_createdate ;
	
	public Date getMbrmstPingAn_createdate() {
		return mbrmstPingAn_createdate;
	}
	public void setMbrmstPingAn_createdate(Date mbrmstPingAn_createdate) {
		this.mbrmstPingAn_createdate = mbrmstPingAn_createdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbrmstpingan_memberid() {
		return mbrmstpingan_memberid;
	}
	public void setMbrmstpingan_memberid(String mbrmstpingan_memberid) {
		this.mbrmstpingan_memberid = mbrmstpingan_memberid;
	}
	public String getMbrmstpingan_mbrmstuid() {
		return mbrmstpingan_mbrmstuid;
	}
	public void setMbrmstpingan_mbrmstuid(String mbrmstpingan_mbrmstuid) {
		this.mbrmstpingan_mbrmstuid = mbrmstpingan_mbrmstuid;
	}
	public Long getMbrmstpingan_mbrid() {
		return mbrmstpingan_mbrid;
	}
	public void setMbrmstpingan_mbrid(Long mbrmstpingan_mbrid) {
		this.mbrmstpingan_mbrid = mbrmstpingan_mbrid;
	}
	public String getMbrmstpingan_empflg() {
		return mbrmstpingan_empflg;
	}
	public void setMbrmstpingan_empflg(String mbrmstpingan_empflg) {
		this.mbrmstpingan_empflg = mbrmstpingan_empflg;
	}
	public String getMbrmstpingan_username() {
		return mbrmstpingan_username;
	}
	public void setMbrmstpingan_username(String mbrmstpingan_username) {
		this.mbrmstpingan_username = mbrmstpingan_username;
	}
	public Long getMbrmstpingan_ifsendmail() {
		return mbrmstpingan_ifsendmail;
	}
	public void setMbrmstpingan_ifsendmail(Long mbrmstpingan_ifsendmail) {
		this.mbrmstpingan_ifsendmail = mbrmstpingan_ifsendmail;
	}
	
}
