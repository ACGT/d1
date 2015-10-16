package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 商品独享价表
 * @author kk
 */
@Entity
@Table(name="rcmdusr")
public class ProductExpPrice extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="rcmdusr_id") 
	private String id ;//done
	
	private Long rcmdusr_rcmid;
	private Long rcmdusr_mbrid;
	private String rcmdusr_uid;
	private Long rcmdusr_sendcount;
	private Long rcmdusr_count;
	private Date rcmdusr_startdate;
	private Date rcmdusr_enddate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getRcmdusr_rcmid() {
		return rcmdusr_rcmid;
	}
	public void setRcmdusr_rcmid(Long rcmdusr_rcmid) {
		this.rcmdusr_rcmid = rcmdusr_rcmid;
	}
	public Long getRcmdusr_mbrid() {
		return rcmdusr_mbrid;
	}
	public void setRcmdusr_mbrid(Long rcmdusr_mbrid) {
		this.rcmdusr_mbrid = rcmdusr_mbrid;
	}
	public String getRcmdusr_uid() {
		return rcmdusr_uid;
	}
	public void setRcmdusr_uid(String rcmdusr_uid) {
		this.rcmdusr_uid = rcmdusr_uid;
	}
	public Long getRcmdusr_sendcount() {
		return rcmdusr_sendcount;
	}
	public void setRcmdusr_sendcount(Long rcmdusr_sendcount) {
		this.rcmdusr_sendcount = rcmdusr_sendcount;
	}
	public Long getRcmdusr_count() {
		return rcmdusr_count;
	}
	public void setRcmdusr_count(Long rcmdusr_count) {
		this.rcmdusr_count = rcmdusr_count;
	}
	public Date getRcmdusr_startdate() {
		return rcmdusr_startdate;
	}
	public void setRcmdusr_startdate(Date rcmdusr_startdate) {
		this.rcmdusr_startdate = rcmdusr_startdate;
	}
	public Date getRcmdusr_enddate() {
		return rcmdusr_enddate;
	}
	public void setRcmdusr_enddate(Date rcmdusr_enddate) {
		this.rcmdusr_enddate = rcmdusr_enddate;
	}
	
}
