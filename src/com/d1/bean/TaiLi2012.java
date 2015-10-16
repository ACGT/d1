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
	 * 抽奖活动--台历号表
	 * @author kk
	 *
	 */
	@Entity
	@Table(name="taili2012")
	public class TaiLi2012 extends BaseEntity implements java.io.Serializable {

		/**
		 * serial version id
		 */
		private static final long serialVersionUID = 1L;
		
		@Id
		@Column(name="taili2012_id")
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private String id;//done

		/**
		 * 减多少
		 */

		private String 	taili2012_cardno;
		private Long taili2012_status;
		private Long taili2012_mbrid;
		private Date taili2012_update;
		
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getTaili2012_cardno() {
			return taili2012_cardno;
		}
		public void setTaili2012_cardno(String taili2012_cardno) {
			this.taili2012_cardno = taili2012_cardno;
		}
		public Long getTaili2012_status() {
			return taili2012_status;
		}
		public void setTaili2012_status(Long taili2012_status) {
			this.taili2012_status = taili2012_status;
		}
		public Long getTaili2012_mbrid() {
			return taili2012_mbrid;
		}
		public void setTaili2012_mbrid(Long taili2012_mbrid) {
			this.taili2012_mbrid = taili2012_mbrid;
		}
		public Date getTaili2012_update() {
			return taili2012_update;
		}
		public void setTaili2012_update(Date taili2012_update) {
			this.taili2012_update = taili2012_update;
		}



}
