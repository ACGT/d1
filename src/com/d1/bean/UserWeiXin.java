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
 * 微信用户表
 * @author 
 *
 */
@Entity
@Table(name="weixin")
public class UserWeiXin extends BaseEntity implements java.io.Serializable {

	/**
	 * serial version id
	 */
    private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY) 
	@Column(name="winxin_id")
	private String id;//done
	
	private Long weixin_mbrid;
	private String weixin_openid;
	private String weixin_name;
	private int weixin_sex;
	private String weixin_unionid;
	private Date weixin_createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getWeixin_mbrid() {
		return weixin_mbrid;
	}
	public void setWeixin_mbrid(Long weixin_mbrid) {
		this.weixin_mbrid = weixin_mbrid;
	}
	public String getWeixin_openid() {
		return weixin_openid;
	}
	public void setWeixin_openid(String weixin_openid) {
		this.weixin_openid = weixin_openid;
	}
	public String getWeixin_name() {
		return weixin_name;
	}
	public void setWeixin_name(String weixin_name) {
		this.weixin_name = weixin_name;
	}
	public int getWeixin_sex() {
		return weixin_sex;
	}
	public void setWeixin_sex(int weixin_sex) {
		this.weixin_sex = weixin_sex;
	}
	public String getWeixin_unionid() {
		return weixin_unionid;
	}
	public void setWeixin_unionid(String weixin_unionid) {
		this.weixin_unionid = weixin_unionid;
	}
	public Date getWeixin_createdate() {
		return weixin_createdate;
	}
	public void setWeixin_createdate(Date weixin_createdate) {
		this.weixin_createdate = weixin_createdate;
	}
	

}
