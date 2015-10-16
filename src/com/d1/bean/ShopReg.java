package com.d1.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="shopreg")
public class ShopReg extends BaseEntity implements java.io.Serializable {
		/**
		 * v id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="shopreg_id")
		private String id;//done
        private String shopreg_name;
        private String shopreg_shopcode;
        private String shopreg_pwd;
        private String shopreg_sustr;
    	private String shopreg_adduser;
        private Date shopreg_createdate;
        private Date  shopreg_lastdate;
    	private String shopreg_key;
        private Long shopreg_type;
        
        public String getId() {
			return id;
		}
		
		public void setId(String id) {
			this.id = id;
		}
		public String getShopreg_name() {
			return shopreg_name;
		}
		public void setShopreg_name(String shopreg_name) {
			this.shopreg_name = shopreg_name;
		}
		public String getShopreg_shopcode() {
			return shopreg_shopcode;
		}
		public void setShopreg_shopcode(String shopreg_shopcode) {
			this.shopreg_shopcode = shopreg_shopcode;
		}
		public String getShopreg_pwd() {
			return shopreg_pwd;
		}
		public void setShopreg_pwd(String shopreg_pwd) {
			this.shopreg_pwd = shopreg_pwd;
		}
		public String getShopreg_sustr() {
			return shopreg_sustr;
		}
		public void setShopreg_sustr(String shopreg_sustr) {
			this.shopreg_sustr = shopreg_sustr;
		}
		public String getShopreg_adduser() {
			return shopreg_adduser;
		}
		public void setShopreg_adduser(String shopreg_adduser) {
			this.shopreg_adduser = shopreg_adduser;
		}
		public Date getShopreg_createdate() {
			return shopreg_createdate;
		}
		public void setShopreg_createdate(Date shopreg_createdate) {
			this.shopreg_createdate = shopreg_createdate;
		}
		
		public Date getShopreg_lastdate() {
			return shopreg_lastdate;
		}
		public void setShopreg_lastdate(Date shopreg_lastdate) {
			this.shopreg_lastdate = shopreg_lastdate;
		}

		public String getShopreg_key() {
			return shopreg_key;
		}

		public void setShopreg_key(String shopreg_key) {
			this.shopreg_key = shopreg_key;
		}

		public Long getShopreg_type() {
			return shopreg_type;
		}

		public void setShopreg_type(Long shopreg_type) {
			this.shopreg_type = shopreg_type;
		}
	

	
	/**
	 * create table shopreg(shopreg_id int,shopreg_name varchar(50),shopreg_shopcode char(8),shopreg_pwd varchar(50),shopreg_sustr varchar(300)
,shopreg_adduser varchar(50),shopreg_createdate datetime)
	 */
}
