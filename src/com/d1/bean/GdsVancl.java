package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="gdsvancl",catalog="dba")
public class GdsVancl extends BaseEntity implements java.io.Serializable {
		/**
		 * version id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="gdsvancl_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		
		
		/*create table gdsvancl(gdsvancl_id int identity(1,1),gdsvancl_gdsid char(8),gdsvancl_barcode varchar(50),
		gdsvancl_sku varchar(50),gdsvancl_productcode varchar(50),gdsvancl_developid varchar(50),
		gdsvancl_productname varchar(300),
		gdsvancl_color varchar(50),gdsvancl_size varchar(50),gdsvancl_fororder int,gdsvancl_onsale char(10),
		gdsvancl_createdate datetime  default(getdate()))*/
		private String id;
		private String gdsvancl_gdsid;
		private String gdsvancl_barcode;
		private String gdsvancl_sku;
		private String gdsvancl_productcode;
		private String gdsvancl_developid;
		private String gdsvancl_productname;
		private String gdsvancl_color;
		private String gdsvancl_size;
		private Long gdsvancl_fororder;
		private String gdsvancl_onsale;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getGdsvancl_gdsid() {
			return gdsvancl_gdsid;
		}
		public void setGdsvancl_gdsid(String gdsvancl_gdsid) {
			this.gdsvancl_gdsid = gdsvancl_gdsid;
		}
		public String getGdsvancl_barcode() {
			return gdsvancl_barcode;
		}
		public void setGdsvancl_barcode(String gdsvancl_barcode) {
			this.gdsvancl_barcode = gdsvancl_barcode;
		}
		public String getGdsvancl_sku() {
			return gdsvancl_sku;
		}
		public void setGdsvancl_sku(String gdsvancl_sku) {
			this.gdsvancl_sku = gdsvancl_sku;
		}
		public String getGdsvancl_productcode() {
			return gdsvancl_productcode;
		}
		public void setGdsvancl_productcode(String gdsvancl_productcode) {
			this.gdsvancl_productcode = gdsvancl_productcode;
		}
		public String getGdsvancl_developid() {
			return gdsvancl_developid;
		}
		public void setGdsvancl_developid(String gdsvancl_developid) {
			this.gdsvancl_developid = gdsvancl_developid;
		}
		public String getGdsvancl_productname() {
			return gdsvancl_productname;
		}
		public void setGdsvancl_productname(String gdsvancl_productname) {
			this.gdsvancl_productname = gdsvancl_productname;
		}
		public String getGdsvancl_color() {
			return gdsvancl_color;
		}
		public void setGdsvancl_color(String gdsvancl_color) {
			this.gdsvancl_color = gdsvancl_color;
		}
		public String getGdsvancl_size() {
			return gdsvancl_size;
		}
		public void setGdsvancl_size(String gdsvancl_size) {
			this.gdsvancl_size = gdsvancl_size;
		}
		public Long getGdsvancl_fororder() {
			return gdsvancl_fororder;
		}
		public void setGdsvancl_fororder(Long gdsvancl_fororder) {
			this.gdsvancl_fororder = gdsvancl_fororder;
		}
		public String getGdsvancl_onsale() {
			return gdsvancl_onsale;
		}
		public void setGdsvancl_onsale(String gdsvancl_onsale) {
			this.gdsvancl_onsale = gdsvancl_onsale;
		}
	
	
	
}
