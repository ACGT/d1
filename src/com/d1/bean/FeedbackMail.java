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
@Table(name="feedbackemail")
public class FeedbackMail extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="feedbackemail_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String feedbackemail_from;
	private String feedbackemail_title;
	private String feedbackemail_content;
	private String feedbackemail_fromattach;
	private Date feedbackemail_createdtime;
	private Date feedbackemail_replaydate;
	private Long feedbackemail_type = new Long(0);//0系统收的邮件
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFeedbackemail_from() {
		return feedbackemail_from;
	}
	public void setFeedbackemail_from(String feedbackemail_from) {
		this.feedbackemail_from = feedbackemail_from;
	}
	public String getFeedbackemail_title() {
		return feedbackemail_title;
	}
	public void setFeedbackemail_title(String feedbackemail_title) {
		this.feedbackemail_title = feedbackemail_title;
	}
	public String getFeedbackemail_content() {
		return feedbackemail_content;
	}
	public void setFeedbackemail_content(String feedbackemail_content) {
		this.feedbackemail_content = feedbackemail_content;
	}
	public String getFeedbackemail_fromattach() {
		return feedbackemail_fromattach;
	}
	public void setFeedbackemail_fromattach(String feedbackemail_fromattach) {
		this.feedbackemail_fromattach = feedbackemail_fromattach;
	}
	public Date getFeedbackemail_createdtime() {
		return feedbackemail_createdtime;
	}
	public void setFeedbackemail_createdtime(Date feedbackemail_createdtime) {
		this.feedbackemail_createdtime = feedbackemail_createdtime;
	}
	public Date getFeedbackemail_replaydate() {
		return feedbackemail_replaydate;
	}
	public void setFeedbackemail_replaydate(Date feedbackemail_replaydate) {
		this.feedbackemail_replaydate = feedbackemail_replaydate;
	}
	public Long getFeedbackemail_type() {
		return feedbackemail_type;
	}
	public void setFeedbackemail_type(Long feedbackemail_type) {
		this.feedbackemail_type = feedbackemail_type;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
