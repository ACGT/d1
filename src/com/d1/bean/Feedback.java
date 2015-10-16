package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="feedback",catalog="dba")
public class Feedback extends BaseEntity implements java.io.Serializable {
	/**
	 *version id 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="feedback_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String feedback_mbrid;
	private String feedback_uid;
	private String feedback_orderid;
	private String feedback_phone;
	private String feedback_email;
	private Long feedback_type;
	private String feedback_content;
	private String feedback_attach;
	private Long feedback_isceo;
	private Date feedback_createdtime;
	private Long feedback_replaystatus;
	
	private String feedback_operater;
	private String feedback_replaycontent;
	private Date feedback_replaydate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFeedback_mbrid() {
		return feedback_mbrid;
	}
	public void setFeedback_mbrid(String feedback_mbrid) {
		this.feedback_mbrid = feedback_mbrid;
	}
	public String getFeedback_uid() {
		return feedback_uid;
	}
	public void setFeedback_uid(String feedback_uid) {
		this.feedback_uid = feedback_uid;
	}
	public String getFeedback_orderid() {
		return feedback_orderid;
	}
	public void setFeedback_orderid(String feedback_orderid) {
		this.feedback_orderid = feedback_orderid;
	}
	public String getFeedback_phone() {
		return feedback_phone;
	}
	public void setFeedback_phone(String feedback_phone) {
		this.feedback_phone = feedback_phone;
	}
	public String getFeedback_email() {
		return feedback_email;
	}
	public void setFeedback_email(String feedback_email) {
		this.feedback_email = feedback_email;
	}
	public Long getFeedback_type() {
		return feedback_type;
	}
	public void setFeedback_type(Long feedback_type) {
		this.feedback_type = feedback_type;
	}
	public String getFeedback_content() {
		return feedback_content;
	}
	public void setFeedback_content(String feedback_content) {
		this.feedback_content = feedback_content;
	}
	public String getFeedback_attach() {
		return feedback_attach;
	}
	public void setFeedback_attach(String feedback_attach) {
		this.feedback_attach = feedback_attach;
	}
	public Long getFeedback_isceo() {
		return feedback_isceo;
	}
	public void setFeedback_isceo(Long feedback_isceo) {
		this.feedback_isceo = feedback_isceo;
	}
	public Date getFeedback_createdtime() {
		return feedback_createdtime;
	}
	public void setFeedback_createdtime(Date feedback_createdtime) {
		this.feedback_createdtime = feedback_createdtime;
	}
	public Long getFeedback_replaystatus() {
		return feedback_replaystatus;
	}
	public void setFeedback_replaystatus(Long feedback_replaystatus) {
		this.feedback_replaystatus = feedback_replaystatus;
	}
	public String getFeedback_operater() {
		return feedback_operater;
	}
	public void setFeedback_operater(String feedback_operater) {
		this.feedback_operater = feedback_operater;
	}
	public String getFeedback_replaycontent() {
		return feedback_replaycontent;
	}
	public void setFeedback_replaycontent(String feedback_replaycontent) {
		this.feedback_replaycontent = feedback_replaycontent;
	}
	public Date getFeedback_replaydate() {
		return feedback_replaydate;
	}
	public void setFeedback_replaydate(Date feedback_replaydate) {
		this.feedback_replaydate = feedback_replaydate;
	}
	
}
