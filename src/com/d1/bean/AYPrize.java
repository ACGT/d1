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
@Table(name="prizeInfo",catalog="dba")
public class AYPrize extends BaseEntity implements java.io.Serializable {
	/**
	 * version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="prizeId")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;//done
	private String prize_muid;//会员名
	private String prize_content;//中奖信息
	private Date prize_createdate;//创建时间
	private int prize_type;// 中奖类型 
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPrize_muid() {
		return prize_muid;
	}
	public void setPrize_muid(String prize_muid) {
		this.prize_muid = prize_muid;
	}
	public String getPrize_content() {
		return prize_content;
	}
	public void setPrize_content(String prize_content) {
		this.prize_content = prize_content;
	}
	public Date getPrize_createdate() {
		return prize_createdate;
	}
	public void setPrize_createdate(Date prize_createdate) {
		this.prize_createdate = prize_createdate;
	}
	public int getPrize_type() {
		return prize_type;
	}
	public void setPrize_type(int prize_type) {
		this.prize_type = prize_type;
	}

}
