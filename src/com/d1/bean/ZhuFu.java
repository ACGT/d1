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
 * ÖÜÄê×£¸£
 * @author jlgao
 *
 */
@Entity
@Table(name="znzhufu")
public class ZhuFu extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="znzhufu_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private Long znzhufu_mbrid;
	private String znzhufu_mbruid;
	private String znzhufu_content;
	private Date znzhufu_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getZnzhufu_mbrid() {
		return znzhufu_mbrid;
	}
	public void setZnzhufu_mbrid(Long znzhufu_mbrid) {
		this.znzhufu_mbrid = znzhufu_mbrid;
	}
	public String getZnzhufu_mbruid() {
		return znzhufu_mbruid;
	}
	public void setZnzhufu_mbruid(String znzhufu_mbruid) {
		this.znzhufu_mbruid = znzhufu_mbruid;
	}
	public String getZnzhufu_content() {
		return znzhufu_content;
	}
	public void setZnzhufu_content(String znzhufu_content) {
		this.znzhufu_content = znzhufu_content;
	}
	public Date getZnzhufu_createdate() {
		return znzhufu_createdate;
	}
	public void setZnzhufu_createdate(Date znzhufu_createdate) {
		this.znzhufu_createdate = znzhufu_createdate;
	}
	
	
}
