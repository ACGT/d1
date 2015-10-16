package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;
/***
 * 聚会返点比例
 * @author 高军亮
 *
 * 2013-3-15
 */
@Entity
@Table(name="tenpaygds")
	public class TenpayGds extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="tenpaygds_id")
		private String id;//done
		private String tenpaygds_gdsid;
		private Float  tenpaygds_bl;
		private String tenpaygds_memo;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getTenpaygds_gdsid() {
			return tenpaygds_gdsid;
		}
		public void setTenpaygds_gdsid(String tenpaygds_gdsid) {
			this.tenpaygds_gdsid = tenpaygds_gdsid;
		}
		public Float getTenpaygds_bl() {
			return tenpaygds_bl;
		}
		public void setTenpaygds_bl(Float tenpaygds_bl) {
			this.tenpaygds_bl = tenpaygds_bl;
		}
		public String getTenpaygds_memo() {
			return tenpaygds_memo;
		}
		public void setTenpaygds_memo(String tenpaygds_memo) {
			this.tenpaygds_memo = tenpaygds_memo;
		}
		
}
