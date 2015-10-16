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
 * 用户积分表
 * @author kk
 *
 */
@Entity
@Table(name="usrpoint",catalog="dba")
public class UsrPoint extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="usrpoint_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	
	private String usrpoint_odrid="";
	private String usrpoint_gdsid="";
	private Long usrpoint_mbrid;
	private Long usrpoint_score;
	private Long usrpoint_usescore;
	private Long usrpoint_type;
	private String usrpoint_shopcode;
	private Date usrpoint_createdate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsrpoint_odrid() {
		return usrpoint_odrid;
	}
	public void setUsrpoint_odrid(String usrpoint_odrid) {
		this.usrpoint_odrid = usrpoint_odrid;
	}
	public String getUsrpoint_gdsid() {
		return usrpoint_gdsid;
	}
	public void setUsrpoint_gdsid(String usrpoint_gdsid) {
		this.usrpoint_gdsid = usrpoint_gdsid;
	}
	public Long getUsrpoint_mbrid() {
		return usrpoint_mbrid;
	}
	public void setUsrpoint_mbrid(Long usrpoint_mbrid) {
		this.usrpoint_mbrid = usrpoint_mbrid;
	}
	public Long getUsrpoint_score() {
		return usrpoint_score;
	}
	public void setUsrpoint_score(Long usrpoint_score) {
		this.usrpoint_score = usrpoint_score;
	}
	public Long getUsrpoint_usescore() {
		return usrpoint_usescore;
	}
	public void setUsrpoint_usescore(Long usrpoint_usescore) {
		this.usrpoint_usescore = usrpoint_usescore;
	}
	public Long getUsrpoint_type() {
		return usrpoint_type;
	}
	public void setUsrpoint_type(Long usrpoint_type) {
		this.usrpoint_type = usrpoint_type;
	}
	public String getUsrpoint_shopcode() {
		return usrpoint_shopcode;
	}
	public void setUsrpoint_shopcode(String usrpoint_shopcode) {
		this.usrpoint_shopcode = usrpoint_shopcode;
	}
	public Date getUsrpoint_createdate() {
		return usrpoint_createdate;
	}
	public void setUsrpoint_createdate(Date usrpoint_createdate) {
		this.usrpoint_createdate = usrpoint_createdate;
	}
}
