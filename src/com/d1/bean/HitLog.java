package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="hitlog")
public class HitLog extends BaseEntity implements java.io.Serializable {
	/**
	 * serial version id
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="id")
	private String id;//done
	private String logdate;
	private String ip;
	private String first_referer_url;
	private String session_id;
	private String login_user_id;
	private String last_user_order_date;
	private String subad;
	private String user_create_date;
	private String request_uri;
	private String user_agent;
	private String refer_url;
	private String request_parameters;
	private String rackcode;
	private String brandname;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLogdate() {
		return logdate;
	}
	public void setLogdate(String logdate) {
		this.logdate = logdate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFirst_referer_url() {
		return first_referer_url;
	}
	public void setFirst_referer_url(String first_referer_url) {
		this.first_referer_url = first_referer_url;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	public String getLogin_user_id() {
		return login_user_id;
	}
	public void setLogin_user_id(String login_user_id) {
		this.login_user_id = login_user_id;
	}
	public String getLast_user_order_date() {
		return last_user_order_date;
	}
	public void setLast_user_order_date(String last_user_order_date) {
		this.last_user_order_date = last_user_order_date;
	}
	public String getSubad() {
		return subad;
	}
	public void setSubad(String subad) {
		this.subad = subad;
	}
	public String getUser_create_date() {
		return user_create_date;
	}
	public void setUser_create_date(String user_create_date) {
		this.user_create_date = user_create_date;
	}
	public String getRequest_uri() {
		return request_uri;
	}
	public void setRequest_uri(String request_uri) {
		this.request_uri = request_uri;
	}
	public String getUser_agent() {
		return user_agent;
	}
	public void setUser_agent(String user_agent) {
		this.user_agent = user_agent;
	}
	public String getRefer_url() {
		return refer_url;
	}
	public void setRefer_url(String refer_url) {
		this.refer_url = refer_url;
	}
	public String getRequest_parameters() {
		return request_parameters;
	}
	public void setRequest_parameters(String request_parameters) {
		this.request_parameters = request_parameters;
	}
	public String getRackcode() {
		return rackcode;
	}
	public void setRackcode(String rackcode) {
		this.rackcode = rackcode;
	}
	public String getBrandname() {
		return brandname;
	}
	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	
	
}
