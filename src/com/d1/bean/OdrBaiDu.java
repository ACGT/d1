package com.d1.bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 百度微购订单表
 * @author gjl
 *
 */
@Entity
@Table(name="odrbaidu",catalog="dba")
public class OdrBaiDu extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="odrbaidu_id")
	private String id;//done
	private String odrbaidu_bdodrid;
	private String odrbaidu_d1odrid;
	private Long odrbaidu_status=new Long(0);
	private String odrbaidu_memo;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOdrbaidu_bdodrid() {
		return odrbaidu_bdodrid;
	}
	public void setOdrbaidu_bdodrid(String odrbaidu_bdodrid) {
		this.odrbaidu_bdodrid = odrbaidu_bdodrid;
	}
	public String getOdrbaidu_d1odrid() {
		return odrbaidu_d1odrid;
	}
	public void setOdrbaidu_d1odrid(String odrbaidu_d1odrid) {
		this.odrbaidu_d1odrid = odrbaidu_d1odrid;
	}
	public Long getOdrbaidu_status() {
		return odrbaidu_status;
	}
	public void setOdrbaidu_status(Long odrbaidu_status) {
		this.odrbaidu_status = odrbaidu_status;
	}
	public String getOdrbaidu_memo() {
		return odrbaidu_memo;
	}
	public void setOdrbaidu_memo(String odrbaidu_memo) {
		this.odrbaidu_memo = odrbaidu_memo;
	}
	


}