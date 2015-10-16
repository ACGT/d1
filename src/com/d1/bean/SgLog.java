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
@Table(name="sglog")
public class SgLog extends BaseEntity implements java.io.Serializable {

		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="sglog_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done
		private String sglog_gdsid;    //…Ã∆∑ID
		private String sglog_ip;     
		private Date sglog_createdate;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getSglog_gdsid() {
			return sglog_gdsid;
		}
		public void setSglog_gdsid(String sglog_gdsid) {
			this.sglog_gdsid = sglog_gdsid;
		}
		public String getSglog_ip() {
			return sglog_ip;
		}
		public void setSglog_ip(String sglog_ip) {
			this.sglog_ip = sglog_ip;
		}
		public Date getSglog_createdate() {
			return sglog_createdate;
		}
		public void setSglog_createdate(Date sglog_createdate) {
			this.sglog_createdate = sglog_createdate;
		}

}
