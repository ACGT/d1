package com.d1.bean;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * Â¥²ã±í
 * @author kk
 *
 */
@Entity
@Table(name="d1mall")
public class Floor extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	private String id ;//done
	
	private Long d1mall_id ;//PK
	private String d1mall_rackcode;//PK
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getD1mall_id() {
		return d1mall_id;
	}
	public void setD1mall_id(Long d1mall_id) {
		this.d1mall_id = d1mall_id;
	}
	public String getD1mall_rackcode() {
		return d1mall_rackcode;
	}
	public void setD1mall_rackcode(String d1mall_rackcode) {
		this.d1mall_rackcode = d1mall_rackcode;
	}


}
