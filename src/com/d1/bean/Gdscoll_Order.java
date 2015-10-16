package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.*;
import com.d1.dbcache.core.BaseEntity;
/**
 * 订单搭配对应表
 * @author wdx
 *
 */
@Entity
@Table(name="Gdscoll_Order")
public class Gdscoll_Order  extends BaseEntity implements java.io.Serializable{
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;	
	@Id
	@Column(name="id") 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String id;
	private String go_odrid;
	private String go_gdsid;
	private Long go_box;
	private Long go_order;
	private Date go_createtime;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGo_odrid() {
		return go_odrid;
	}
	public void setGo_odrid(String go_odrid) {
		this.go_odrid = go_odrid;
	}
	public String getGo_gdsid() {
		return go_gdsid;
	}
	public void setGo_gdsid(String go_gdsid) {
		this.go_gdsid = go_gdsid;
	}
	public Long getGo_box() {
		return go_box;
	}
	public void setGo_box(Long go_box) {
		this.go_box = go_box;
	}
	public Long getGo_order() {
		return go_order;
	}
	public void setGo_order(Long go_order) {
		this.go_order = go_order;
	}
	public Date getGo_createtime() {
		return go_createtime;
	}
	public void setGo_createtime(Date go_createtime) {
		this.go_createtime = go_createtime;
	}
	
}
