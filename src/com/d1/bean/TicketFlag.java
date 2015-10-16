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
 * tktflag	ȯʹ�����Ʊ�	

tktflag_id 	���	
tktflag_cardnot 	����ȯͷ	
tktflag_starttime 	��ʼʱ��	��������ʹ�ô���
tktflag_endtime 	����ʱ��	��������ʹ�ô���
tktflag_memo 	��ע	
tktflag_maxcount	���ʹ�ô���	��������ʹ�ô���
tktflag_validflag	1��������2�»�Ա��3ÿ��Ա�޼���	
tktflag_createtime 	����ʱ��	

 *
 */
@Entity
@Table(name="tktflag")
public class TicketFlag extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="tktflag_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String tktflag_cardnot;
	private String tktflag_memo;
	private Long tktflag_maxcount;
	private Long tktflag_validflag;
	private Date tktflag_createtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTktflag_cardnot() {
		return tktflag_cardnot;
	}
	public void setTktflag_cardnot(String tktflag_cardnot) {
		this.tktflag_cardnot = tktflag_cardnot;
	}
	public String getTktflag_memo() {
		return tktflag_memo;
	}
	public void setTktflag_memo(String tktflag_memo) {
		this.tktflag_memo = tktflag_memo;
	}
	public Long getTktflag_maxcount() {
		return tktflag_maxcount;
	}
	public void setTktflag_maxcount(Long tktflag_maxcount) {
		this.tktflag_maxcount = tktflag_maxcount;
	}
	public Long getTktflag_validflag() {
		return tktflag_validflag;
	}
	public void setTktflag_validflag(Long tktflag_validflag) {
		this.tktflag_validflag = tktflag_validflag;
	}
	public Date getTktflag_createtime() {
		return tktflag_createtime;
	}
	public void setTktflag_createtime(Date tktflag_createtime) {
		this.tktflag_createtime = tktflag_createtime;
	}
}
