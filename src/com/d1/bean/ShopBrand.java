package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;

@Entity
@Table(name="shopbrand")
public class ShopBrand extends BaseEntity implements java.io.Serializable {
		/**
		 * v id
		 */
		private static final long serialVersionUID = 1L;
		@Id
		@Column(name="shopbrand_id")
		private String id;//done
		private String shopbrand_shopcode;
		private String shopbrand_brand;
		private String shopbrand_brandname;
		private String shopbrand_memo;
		private String shopbrand_createdate;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}	
		public String getShopbrand_shopcode() {
			return shopbrand_shopcode;
		}
		public void setShopbrand_shopcode(String shopbrand_shopcode) {
			this.shopbrand_shopcode = shopbrand_shopcode;
		}
		public String getShopbrand_brand() {
			return shopbrand_brand;
		}
		public void setShopbrand_brand(String shopbrand_brand) {
			this.shopbrand_brand = shopbrand_brand;
		}
		public String getShopbrand_brandname() {
			return shopbrand_brandname;
		}
		public void setShopbrand_brandname(String shopbrand_brandname) {
			this.shopbrand_brandname = shopbrand_brandname;
		}
		public String getShopbrand_memo() {
			return shopbrand_memo;
		}
		public void setShopbrand_memo(String shopbrand_memo) {
			this.shopbrand_memo = shopbrand_memo;
		}
		public String getShopbrand_createdate() {
			return shopbrand_createdate;
		}
		public void setShopbrand_createdate(String shopbrand_createdate) {
			this.shopbrand_createdate = shopbrand_createdate;
		}
		
		
		
		/**
		 * create table shopbrand(shopbrand_id int,shopbrand_shopcode char(8),
		 * shopbrand_brand varchar(50),shopbrand_memo varchar(300),shopbrand_user varchar(50)
		 * ,shopbrand_createdate datetime)

		 */
}
