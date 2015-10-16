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
 * 成果网联合登陆会员表
 * @author kk
 *
 */
@Entity
@Table(name="cgmbr")
public class ChanetUser extends BaseEntity implements java.io.Serializable {
		/**
		 * version id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="id")
		@GeneratedValue(strategy=GenerationType.IDENTITY) 
		private String id;
		private String  cgmbr_aid;
		private String  cgmbr_aname;
		private String cgmbr_auser;
		private String cgmbr_uname;
		private String cgmbr_url;
		private String cgmbr_furl;
		private Long cgmbr_mbrid;
		private Date cgmbr_timestamp;
		private Date cbmbr_createtime;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getCgmbr_aid() {
			return cgmbr_aid;
		}
		public void setCgmbr_aid(String cgmbr_aid) {
			this.cgmbr_aid = cgmbr_aid;
		}
		public String getCgmbr_aname() {
			return cgmbr_aname;
		}
		public void setCgmbr_aname(String cgmbr_aname) {
			this.cgmbr_aname = cgmbr_aname;
		}
		public String getCgmbr_auser() {
			return cgmbr_auser;
		}
		public void setCgmbr_auser(String cgmbr_auser) {
			this.cgmbr_auser = cgmbr_auser;
		}
		public String getCgmbr_uname() {
			return cgmbr_uname;
		}
		public void setCgmbr_uname(String cgmbr_uname) {
			this.cgmbr_uname = cgmbr_uname;
		}
		public String getCgmbr_url() {
			return cgmbr_url;
		}
		public void setCgmbr_url(String cgmbr_url) {
			this.cgmbr_url = cgmbr_url;
		}
		public String getCgmbr_furl() {
			return cgmbr_furl;
		}
		public void setCgmbr_furl(String cgmbr_furl) {
			this.cgmbr_furl = cgmbr_furl;
		}
		public Long getCgmbr_mbrid() {
			return cgmbr_mbrid;
		}
		public void setCgmbr_mbrid(Long cgmbr_mbrid) {
			this.cgmbr_mbrid = cgmbr_mbrid;
		}
		public Date getCgmbr_timestamp() {
			return cgmbr_timestamp;
		}
		public void setCgmbr_timestamp(Date cgmbr_timestamp) {
			this.cgmbr_timestamp = cgmbr_timestamp;
		}
		public Date getCbmbr_createtime() {
			return cbmbr_createtime;
		}
		public void setCbmbr_createtime(Date cbmbr_createtime) {
			this.cbmbr_createtime = cbmbr_createtime;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
		}

}
