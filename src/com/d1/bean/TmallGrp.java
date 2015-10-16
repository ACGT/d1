package com.d1.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.d1.dbcache.core.BaseEntity;


@Entity
@Table(name="tmallgrp")
public class TmallGrp  extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="tmallgrp_gdsid")
		private String id;//done
		private String tmallgrp_name;
		private String tmallgrp_items;
		private Long tmallgrp_status;
		private String tmallgrp_createdate;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getTmallgrp_name() {
			return tmallgrp_name;
		}
		public void setTmallgrp_name(String tmallgrp_name) {
			this.tmallgrp_name = tmallgrp_name;
		}
		public String getTmallgrp_items() {
			return tmallgrp_items;
		}
		public void setTmallgrp_items(String tmallgrp_items) {
			this.tmallgrp_items = tmallgrp_items;
		}
		public Long getTmallgrp_status() {
			return tmallgrp_status;
		}
		public void setTmallgrp_status(Long tmallgrp_status) {
			this.tmallgrp_status = tmallgrp_status;
		}
		public String getTmallgrp_createdate() {
			return tmallgrp_createdate;
		}
		public void setTmallgrp_createdate(String tmallgrp_createdate) {
			this.tmallgrp_createdate = tmallgrp_createdate;
		}
		
}
