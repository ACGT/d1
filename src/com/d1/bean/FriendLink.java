package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

/**
 * ”—«È¡¥Ω”
 * @author gjl
 *
 */
@Entity
@Table(name="friendlink")
public class FriendLink extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="friendlink_id") 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String friendlink_keword;
	private String friendlink_website;
	private String friendlink_qq;
	private String friendlink_page;
	private Long friendlink_nofollow;
	private Long friendlink_type;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFriendlink_keword() {
		return friendlink_keword;
	}
	public void setFriendlink_keword(String friendlink_keword) {
		this.friendlink_keword = friendlink_keword;
	}
	public String getFriendlink_website() {
		return friendlink_website;
	}
	public void setFriendlink_website(String friendlink_website) {
		this.friendlink_website = friendlink_website;
	}
	public String getFriendlink_qq() {
		return friendlink_qq;
	}
	public void setFriendlink_qq(String friendlink_qq) {
		this.friendlink_qq = friendlink_qq;
	}
	public String getFriendlink_page() {
		return friendlink_page;
	}
	public void setFriendlink_page(String friendlink_page) {
		this.friendlink_page = friendlink_page;
	}
	public Long getFriendlink_nofollow() {
		return friendlink_nofollow;
	}
	public void setFriendlink_nofollow(Long friendlink_nofollow) {
		this.friendlink_nofollow = friendlink_nofollow;
	}
	public Long getFriendlink_type() {
		return friendlink_type;
	}
	public void setFriendlink_type(Long friendlink_type) {
		this.friendlink_type = friendlink_type;
	}
	



}
