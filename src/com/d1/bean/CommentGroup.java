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
 * 评论商品组主表
 * @author wdx
 *
 */
@Entity
@Table(name="commentgroup")
public class CommentGroup extends BaseEntity implements java.io.Serializable{
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="commentgroup_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private String commentgroup_title;
	private String commentgroup_rackcode;
	private String commentgroup_content;
	private Long commentgroup_flag;
	private Date commentgroup_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommentgroup_title() {
		return commentgroup_title;
	}
	public void setCommentgroup_title(String commentgroup_title) {
		this.commentgroup_title = commentgroup_title;
	}
	public String getCommentgroup_rackcode() {
		return commentgroup_rackcode;
	}
	public void setCommentgroup_rackcode(String commentgroup_rackcode) {
		this.commentgroup_rackcode = commentgroup_rackcode;
	}
	public String getCommentgroup_content() {
		return commentgroup_content;
	}
	public void setCommentgroup_content(String commentgroup_content) {
		this.commentgroup_content = commentgroup_content;
	}
	public Long getCommentgroup_flag() {
		return commentgroup_flag;
	}
	public void setCommentgroup_flag(Long commentgroup_flag) {
		this.commentgroup_flag = commentgroup_flag;
	}
	public Date getCommentgroup_createtime() {
		return commentgroup_createtime;
	}
	public void setCommentgroup_createtime(Date commentgroup_createtime) {
		this.commentgroup_createtime = commentgroup_createtime;
	}
	
}
