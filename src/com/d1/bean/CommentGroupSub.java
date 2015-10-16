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
 * 商品评论组从表
 * @author wdx
 *
 */
@Entity
@Table(name="commentgroupsub")
public class CommentGroupSub extends BaseEntity implements java.io.Serializable{
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="commentgroupsub_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	private String id;//done
	
	private Long commentgroupsub_cgid;
	private String commentgroupsub_gdsid;
	private Long commentgroupsub_flag;
	private Date commentgroupsub_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getCommentgroupsub_cgid() {
		return commentgroupsub_cgid;
	}
	public void setCommentgroupsub_cgid(Long commentgroupsub_cgid) {
		this.commentgroupsub_cgid = commentgroupsub_cgid;
	}
	public String getCommentgroupsub_gdsid() {
		return commentgroupsub_gdsid;
	}
	public void setCommentgroupsub_gdsid(String commentgroupsub_gdsid) {
		this.commentgroupsub_gdsid = commentgroupsub_gdsid;
	}
	
	public Long getCommentgroupsub_flag() {
		return commentgroupsub_flag;
	}
	public void setCommentgroupsub_flag(Long commentgroupsub_flag) {
		this.commentgroupsub_flag = commentgroupsub_flag;
	}
	public Date getCommentgroupsub_createtime() {
		return commentgroupsub_createtime;
	}
	public void setCommentgroupsub_createtime(Date commentgroupsub_createtime) {
		this.commentgroupsub_createtime = commentgroupsub_createtime;
	}
	
}
