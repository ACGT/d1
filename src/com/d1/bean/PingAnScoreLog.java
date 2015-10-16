package com.d1.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 平安现金返积分表
 * @author kk
 *
 */
@Entity
@Table(name="pauplog")
public class PingAnScoreLog extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String transnum ;//PK
	private String membercode;
	private Long memcodetype;
	private Float basepoints;
	private String partnercode;
	private String productnum;
	private Date transdate;
	private String orderid;
	private Float attchamount;
	private Long status;
	private Date senddate;
	private Date tuihuodate;
	private Date createdate;
	private Long ifchk;
	private Date chkdate;
	private String palog;
	
	public String getTransnum() {
		return transnum;
	}
	public void setTransnum(String transnum) {
		this.transnum = transnum;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMembercode() {
		return membercode;
	}
	public void setMembercode(String membercode) {
		this.membercode = membercode;
	}
	public Long getMemcodetype() {
		return memcodetype;
	}
	public void setMemcodetype(Long memcodetype) {
		this.memcodetype = memcodetype;
	}
	public Float getBasepoints() {
		return basepoints;
	}
	public void setBasepoints(Float basepoints) {
		this.basepoints = basepoints;
	}
	public String getPartnercode() {
		return partnercode;
	}
	public void setPartnercode(String partnercode) {
		this.partnercode = partnercode;
	}
	public String getProductnum() {
		return productnum;
	}
	public void setProductnum(String productnum) {
		this.productnum = productnum;
	}
	public Date getTransdate() {
		return transdate;
	}
	public void setTransdate(Date transdate) {
		this.transdate = transdate;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public Float getAttchamount() {
		return attchamount;
	}
	public void setAttchamount(Float attchamount) {
		this.attchamount = attchamount;
	}
	public Long getStatus() {
		return status;
	}
	public void setStatus(Long status) {
		this.status = status;
	}
	public Date getSenddate() {
		return senddate;
	}
	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	public Date getTuihuodate() {
		return tuihuodate;
	}
	public void setTuihuodate(Date tuihuodate) {
		this.tuihuodate = tuihuodate;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getIfchk() {
		return ifchk;
	}
	public void setIfchk(Long ifchk) {
		this.ifchk = ifchk;
	}
	public Date getChkdate() {
		return chkdate;
	}
	public void setChkdate(Date chkdate) {
		this.chkdate = chkdate;
	}
	public String getPalog() {
		return palog;
	}
	public void setPalog(String palog) {
		this.palog = palog;
	}
	
}
