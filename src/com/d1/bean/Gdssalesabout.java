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
 * 商品相关表
 * @author wdx
 */
@Entity
@Table(name="gdssalesabout")
public class Gdssalesabout  extends BaseEntity implements java.io.Serializable {	
		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="id")
		@GeneratedValue(strategy=GenerationType.IDENTITY) 
		private String id;//done
		
		private String gdsid;
		private String gdsidabout;
		private Long salecount;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getGdsid() {
			return gdsid;
		}
		public void setGdsid(String gdsid) {
			this.gdsid = gdsid;
		}
		public String getGdsidabout() {
			return gdsidabout;
		}
		public void setGdsidabout(String gdsidabout) {
			this.gdsidabout = gdsidabout;
		}
		public Long getSalecount() {
			return salecount;
		}
		public void setSalecount(Long salecount) {
			this.salecount = salecount;
		}
		
}
