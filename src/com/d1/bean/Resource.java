package com.d1.bean;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * js��css�ļ��İ汾����
 * @author kk
 *
 */
@Entity
@Table(name="f_resource")
public class Resource extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private String id ;
	private String currentVersion ;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCurrentVersion() {
		return currentVersion;
	}
	public void setCurrentVersion(String currentVersion) {
		this.currentVersion = currentVersion;
	}
	
}
