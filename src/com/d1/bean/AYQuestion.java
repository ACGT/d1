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
@Table(name="Question",catalog="dba")
public class AYQuestion extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="questionId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String questionTitle;//����
	private String questionAn;//��ʵ��
	private Date qviewTime;//��ʾ����
	private Long questionFlag;//�Ƿ���Ч
	private String questiontktend;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public String getQuestionAn() {
		return questionAn;
	}
	public void setQuestionAn(String questionAn) {
		this.questionAn = questionAn;
	}
	public Date getQviewTime() {
		return qviewTime;
	}
	public void setQviewTime(Date qviewTime) {
		this.qviewTime = qviewTime;
	}
	public Long getQuestionFlag() {
		return questionFlag;
	}
	public void setQuestionFlag(Long questionFlag) {
		this.questionFlag = questionFlag;
	}
	public String getQuestiontktend() {
		return questiontktend;
	}
	public void setQuestiontktend(String questiontktend) {
		this.questiontktend = questiontktend;
	}
}
