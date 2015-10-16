package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * Tag标签用于SEO优化
 * @author gjl
 *
 */
@Entity
@Table(name="tag")
public class Tag extends BaseEntity implements java.io.Serializable {

	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="tag_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String tag_key;
	private String tag_title;
	private String tag_description;
	private String tag_tag;
	private String tag_letters;
	private Long tag_counts;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTag_key() {
		return tag_key;
	}
	public void setTag_key(String tag_key) {
		this.tag_key = tag_key;
	}
	public String getTag_title() {
		return tag_title;
	}
	public void setTag_title(String tag_title) {
		this.tag_title = tag_title;
	}
	public String getTag_description() {
		return tag_description;
	}
	public void setTag_description(String tag_description) {
		this.tag_description = tag_description;
	}
	public String getTag_tag() {
		return tag_tag;
	}
	public void setTag_tag(String tag_tag) {
		this.tag_tag = tag_tag;
	}
	public String getTag_letters() {
		return tag_letters;
	}
	public void setTag_letters(String tag_letters) {
		this.tag_letters = tag_letters;
	}
	public Long getTag_counts() {
		return tag_counts;
	}
	public void setTag_counts(Long tag_counts) {
		this.tag_counts = tag_counts;
	}

}
