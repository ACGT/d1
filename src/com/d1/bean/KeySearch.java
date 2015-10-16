package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * 后台在数据库定义某个特定关键词跳转到某个页面，而不是执行搜索
 * @author kk
 *
 */
@Entity
@Table(name="keysearch")
public class KeySearch extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="keysearch_id")
	private String id;
	private String keysearch_txt;
	private String keysearch_link;
	private Date keysearch_addtime;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getKeysearch_txt() {
		return keysearch_txt;
	}
	public void setKeysearch_txt(String keysearch_txt) {
		this.keysearch_txt = keysearch_txt;
	}
	public String getKeysearch_link() {
		return keysearch_link;
	}
	public void setKeysearch_link(String keysearch_link) {
		this.keysearch_link = keysearch_link;
	}
	public Date getKeysearch_addtime() {
		return keysearch_addtime;
	}
	public void setKeysearch_addtime(Date keysearch_addtime) {
		this.keysearch_addtime = keysearch_addtime;
	}
}
