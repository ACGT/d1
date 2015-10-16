package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="mbrspe")
public class LmMbrspe extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="mbrspe_mbrid")
	private String id;
	private String mbrspe_memo;
	private Long mbrspe_type;
	private Float mbrspe_rate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMbrspe_memo() {
		return mbrspe_memo;
	}
	public void setMbrspe_memo(String mbrspe_memo) {
		this.mbrspe_memo = mbrspe_memo;
	}
	public Long getMbrspe_type() {
		return mbrspe_type;
	}
	public void setMbrspe_type(Long mbrspe_type) {
		this.mbrspe_type = mbrspe_type;
	}
	public Float getMbrspe_rate() {
		return mbrspe_rate;
	}
	public void setMbrspe_rate(Float mbrspe_rate) {
		this.mbrspe_rate = mbrspe_rate;
	}
}
