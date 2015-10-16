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
@Table(name="lotodrwin")
public class LotOdrWin extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="lotodrwin_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done
		private String lotodrwin_uid;
		private String lotodrwin_odrid;
		private Double lotodrwin_price;
		private Long lotodrwin_flag;
		private Date lotodrwin_createtime;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getLotodrwin_uid() {
			return lotodrwin_uid;
		}
		public void setLotodrwin_uid(String lotodrwin_uid) {
			this.lotodrwin_uid = lotodrwin_uid;
		}
		public String getLotodrwin_odrid() {
			return lotodrwin_odrid;
		}
		public void setLotodrwin_odrid(String lotodrwin_odrid) {
			this.lotodrwin_odrid = lotodrwin_odrid;
		}
		public Double getLotodrwin_price() {
			return lotodrwin_price;
		}
		public void setLotodrwin_price(Double lotodrwin_price) {
			this.lotodrwin_price = lotodrwin_price;
		}
		public Long getLotodrwin_flag() {
			return lotodrwin_flag;
		}
		public void setLotodrwin_flag(Long lotodrwin_flag) {
			this.lotodrwin_flag = lotodrwin_flag;
		}
		public Date getLotodrwin_createtime() {
			return lotodrwin_createtime;
		}
		public void setLotodrwin_createtime(Date lotodrwin_createtime) {
			this.lotodrwin_createtime = lotodrwin_createtime;
		}
	
	
}
