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
@Table(name="answerInfo",catalog="dba")
public class AYAnswer extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="answerId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private Long answer_qid;//问题号
	private String answer_mbrid;//会员ID
	private String answer_uid;//会员名
	private String answer_content;//答案
	private Date answer_createdate;//会员名
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getAnswer_qid() {
		return answer_qid;
	}
	public void setAnswer_qid(Long answer_qid) {
		this.answer_qid = answer_qid;
	}
	public String getAnswer_mbrid() {
		return answer_mbrid;
	}
	public void setAnswer_mbrid(String answer_mbrid) {
		this.answer_mbrid = answer_mbrid;
	}
	public String getAnswer_uid() {
		return answer_uid;
	}
	public void setAnswer_uid(String answer_uid) {
		this.answer_uid = answer_uid;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public Date getAnswer_createdate() {
		return answer_createdate;
	}
	public void setAnswer_createdate(Date answer_createdate) {
		this.answer_createdate = answer_createdate;
	}
}
